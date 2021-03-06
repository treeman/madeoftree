# Jekyll project page generator.
# http://recursive-design.com/projects/jekyll-plugins/
#
# Version: 0.1.8 (201108151628)
# Modified stuff since then!
#
# Copyright (c) 2010 Dave Perrett, http://recursive-design.com/
# Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)
#
# Generator that creates project pages for jekyll sites from git repositories.
#
# This was inspired by the project pages on GitHub, which use the project README file as the index
# page. It takes git repositories, and automatically builds project pages for them using the README
# file, along with downloadable zipped copies of the projects themselves (for example, the project
# page for this "plugin repository":http://recursive-design.com/projects/jekyll-plugins/ is
# auto-generated with this plugin).
#
# To use it, simply drop this script into the _plugins directory of your Jekyll site. Next, create a
# *_projects* folder in the base of your jekyll site. This folder should contain .yml files describing
# how to build a page for your project. Here is an example jekyll-plugins.yml (note: you should remove
# the leading '# ' characters):
#
# ================================== COPY BELOW THIS LINE ==================================
# layout:      default
# title:       Jekyll Plugins
# repository:  git://recursive-design.com/jekyll-plugins.git
# published:   true
# description: Nice plugins *here*.
# ================================== COPY ABOVE THIS LINE ==================================
#
# There is also an optional 'zip_folder_name' setting, in case you want the unzipped folder to be named
# something other than the project name. This is useful (for eaxmple) if you want it to unzip as an
# OS X 'Something.app' application bundle.
#
# When you compile your jekyll site, the plugin will download the git repository of each project
# in your _projects folder, create an index page from the README (using the specified layout),
# and create a downloadable .zip file of the project. The goal is to automate the construction of
# online project pages, keep them in sync with README documentation, and provide an up-to-date zip
# archive for download. A cache of git repositories will be held to shorten build time considerably.
#
# Required files :
# Your project's git repository should contain:
# - README:       The contents of this will be used as the body of your project page will be created
#                 from. Any extension other than .markdown, .textile or .html will be treated as a
#                 .markdown file.
# - versions.txt: Contains the version string (eg 1.0.0). Used when naming the downloadable zip-file
#                 (optional). If the version.txt file is not available, a YYYYMMDDHHMM timestamp will
#                 be used for the version.
#
# Required gems :
# - git     (>= 1.2.5)
# - rubyzip (>= 0.9.4)
#
# Available _config.yml settings :
# - project_dir: The subfolder to compile projects to (default is 'projects').
# - project_cache: The subfolder we'll keep cloned projects in. Need to manually remove
#                  when you want to clone again. (default to '.project_cache')
#
# Available YAML settings :
# - repository: Git repository of your project (required).
# - layout: Layout to use when creating the project page.
# - title: Project title, which can be accessed in the layout.
# - published: Project won't be published if this is false.
# - description: Description of project to use when generating project main page.

require 'fileutils'
require 'find'
require 'git'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'pathname'

require_relative 'custom_page'

module Jekyll

  # The ProjectIndex class creates a single project page for the specified project.
  class ProjectIndex < Page

    # Initialize a new ProjectIndex.
    #  +base_dir+            is the String path to the <source>
    #  +project_dir+         is the relative path from the base directory to the project folder.
    #  +project_config_path+ is the String path to the project's yaml config file.
    #  +project_name+        is the name of the project to process.
    def initialize(site, base_dir, project_dir, project_config_path, project_name)
      @site = site
      @base = base_dir
      @dir  = project_dir

      self.data = load_config(base_dir, project_config_path)

      # Ignore the project unless it has been marked as published.
      unless self.data['published']
        return false
      end

      # Clone the repo locally and get the path.
      zip_name = project_name
      if self.data['zip_folder_name']
        zip_name = self.data['zip_folder_name']
      end

      repo_dir = clone_repo(zip_name)

      # Get the version if possible.
      version = get_version(repo_dir)
      self.data['version'] = version if version

      # Create the .zip file.
      #self.data['download_link'] = create_zip(repo_dir, zip_name, project_dir, version)

      # Get the path to the README
      readme = get_readme_path(repo_dir)

      # Decide the extension - if it's not textile, markdown or HTML treat it as markdown.
      ext = File.extname(readme)
      unless ['.textile', '.markdown', '.html'].include?(ext)
        ext = '.markdown'
      end

      # Try to get the readme data for this path.
      self.content = File.read(readme)

      # Replace github-style '``` lang' code markup to pygments-compatible.
      self.content = self.content.gsub(/```([ ]?[a-z0-9]+)?(.*?)```/m, '{% highlight \1 %}\2{% endhighlight %}')

      self.data['content'] = self.content

      # Update project info
      site.projects.collect! { |d|
        # Assimilate hashes
        if d['title'] == self.data['title']
          self.data.each do |k, v|
            d[k] = v
          end
          d.each do |k, v|
            self.data[k] = v
          end
        end

        d
      }

      @name = "index#{ext}"
      self.process(@name)
    end

    private

    # Loads the .yml config file for this project.
    #
    #  +base_dir+            is the base path to the jekyll project.
    #  +project_config_path+ is the String path to the project's yaml config file.
    #
    # Returns Array of project config information.
    def load_config(base_dir, project_config_path)
      yaml = File.read(File.join(base_dir, project_config_path))
      YAML.load(yaml)
    end

    # Clones the project's repository to a temp folder.
    #
    #  +project_name+ is the name of the project to process.
    #
    # Returns String path to the cloned repository.
    def clone_repo(zip_name)
      clone_dir = File.join(@site.source, @site.config['project_cache'] || ".project_cache" )

      # Make the base clone directory if necessary.
      unless File.directory?(clone_dir)
        puts "No dir '#{clone_dir}'"
        p = Pathname.new(clone_dir)
        p.mkdir
        unless File.directory?(clone_dir)
          puts "STILL no dir?!?"
        end
      end

      repo_dir = File.join(clone_dir, zip_name)

      # Clone the repository if it does not exist in cache.
      unless File.directory?(repo_dir)
        puts "Cloning #{self.data['repository']} to #{repo_dir}"
        Git.clone(self.data['repository'], zip_name, :path => clone_dir)
      end

      repo_dir
    end

    # Gets the path to the README file for the project.
    #
    #  +repo_dir+ is the path to the directory containing the checkout-out repository.
    #
    # Returns String path to the readme file. Readme must be in root dir!
    def get_readme_path(repo_dir)
      Find.find(repo_dir) do |file|
        if file =~ /^#{Regexp.quote(repo_dir)}\/README(\.[a-z0-9\.]+)?$/i
          return file
        end
      end

      throw "No README file found in #{repo_dir}"
    end

    # Creates a zipped archive file of the downloaded repository.
    #
    #  +repo_dir+     is the path to the directory containing the checkout-out repository.
    #  +project_name+ is the name of the project to process.
    #  +project_dir+  is the relative path from the base directory to the project folder.
    #  +version+      is the version number to use when creating the zip file.
    #
    # Returns String path to the zip file.
    def create_zip(repo_dir, zip_name, project_dir, version)
      cache_dir = File.join(@site.source, @site.config['project_cache'] || ".project_cache" )

      unless File.directory?(cache_dir)
        FileUtils.mkdir_p(cache_dir)
      end

      # Decide the name of the bundle - use a timestamp if no version is available.
      unless version
        version = Time.now.strftime('%Y%m%d%H%M')
      end
      zip_filename    = "#{zip_name}.#{version}.zip"

      bundle_filename = File.join(cache_dir, zip_filename)

      # Generate zip file if it doesn't exist
      unless File.file?(bundle_filename)
        puts "Creating #{bundle_filename}"

        Zip::ZipFile.open(bundle_filename, Zip::ZipFile::CREATE) do |zipfile|
          Find.find(repo_dir) do |path|
            # Remove .git files.
            Find.prune if File.basename(path) == '.git'
            # Trim the temp dir stuff off, leaving just the repo folder.
            parent = File.expand_path(File.dirname(repo_dir)) + '/'
            dest = path.sub parent, ''
            # Add the file to the bundle.
            zipfile.add(dest, path) if dest
          end
        end

        # Set permissions.
        File.chmod(0644, bundle_filename)
      end

      # Copy zip to target
      target_folder = File.join(@site.config['destination'], project_dir)

      unless File.directory?(target_folder)
        FileUtils.mkdir_p(target_folder)
      end

      target_filename = File.join(target_folder, zip_filename)

      FileUtils.cp bundle_filename, target_filename

      # Add a static file entry for the zip file, otherwise Site::cleanup will remove it.
      @site.static_files << Jekyll::StaticProjectFile.new(@site, @site.dest, @dir, zip_filename)

      File.basename(bundle_filename)
    end

    # Get the version of the project from version.txt if possible.
    #
    #  +repo_dir+ is the path to the directory containing the checkout-out repository.
    #
    # Returns String version number of the project if it exists, false otherwise.
    def get_version(repo_dir)
      Find.find(repo_dir) do |file|
        if File.basename(file) =~ /^VERSION(\.[a-z0-9]+)?/i
          # Remove *all* whitespace from the version, since we may be using it in a filename.
          return File.read(file).gsub(/\s+/, '')
        end
      end

      false
    end

  end


  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    # Folder containing project .yml files.
    PROJECT_FOLDER = '_projects'

    @@projects = []

    def projects
        @@projects
    end

    # Loops through the list of project pages and processes each one.
    def write_project_indexes
      base_dir = self.config['project_dir'] || 'projects'
      projects = self.get_project_files

      projects.each do |project_config_path|
        project_name = project_config_path.sub(/^#{PROJECT_FOLDER}\/([^\.]+)\..*/, '\1')
        self.write_project_index(File.join(base_dir, project_name), project_config_path, project_name)
      end
    end

    # Writes each project page.
    #
    #  +project_dir+         is the relative path from the base directory to the project folder.
    #  +project_config_path+ is the String path to the project's yaml config file.
    #  +project_name+        is the name of the project to process.
    def write_project_index(project_dir, project_config_path, project_name)
      index = ProjectIndex.new(self, self.source, project_dir, project_config_path, project_name)

      # Check that the project has been published.
      if index.data['published']
        index.render(self.layouts, site_payload)
        index.write(self.dest)

        # Record the fact that this page has been added, otherwise Site::cleanup will remove it.
        self.static_files << Jekyll::StaticProjectFile.new(self, self.dest, project_dir, 'index.html')
      end
    end

    # Write projects page
    def write_projects_index
        dir = self.config['project_dir'] || 'projects'
        write_page MainProject.new(self, self.source, dir)
    end

    # Gets a list of files in the _projects folder with a .yml extension.
    #
    # Return Array list of project config files.
    def get_project_files
      projects = []
      Find.find(PROJECT_FOLDER) do |file|
        if file=~/.yml$/
          projects << file
        end
      end

      projects
    end

    # Gather up data from .yml files in project dir, this is a preview before rendering every page
    def collect_project_data
      # Prevent overflow when changing files in server
      @@projects = []

      base_dir = self.config['project_dir'] || 'projects'
      projects = self.get_project_files
      projects.each do |project_config_path|
        file = File.join(self.source, project_config_path)
        yaml = File.read(file)
        info = YAML.load(yaml)

        project_name = project_config_path.sub(/^#{PROJECT_FOLDER}\/([^\.]+)\..*/, '\1')
        project_dir = File.join(base_dir, project_name)

        # Add in url for linkage in layouts
        info['link'] = "/#{project_dir}"

        # Add browse code link for known types
        if %r{^git://github.com}.match(info['repository'])
          info['browse'] = info['repository'].sub(%r{git://(.*)\.git$}, 'http://\1')
        end

        if info['published']
          self.projects << info
        end
      end
    end

  end


  # Sub-class Jekyll::StaticFile to allow recovery from an unimportant exception when writing zip files.
  class StaticProjectFile < StaticFile
    def write(dest)
      super(dest) rescue ArgumentError
      true
    end
  end


  # Generate main project
  class MainProject < CustomPage
    def initialize(site, base, dir)
      super site, base, dir, 'projects'

      self.data['projects'] = site.projects.sort_by{ |h| h["title"] }
    end
  end


  # Jekyll hook - the generate method is called by jekyll, and generates all the project pages.
  class GenerateProjects < Generator
    safe true
    priority :low

    def generate(site)
      site.write_project_indexes
      site.write_projects_index
    end

  end

end


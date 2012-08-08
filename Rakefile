
task :default => :build

task :build do
  system("jekyll")
end

task :new do
  throw "No title given" unless ARGV[1]
  title = ""
  ARGV[1..ARGV.length - 1].each { |v| title += " #{v}" }
  title.strip!
  now = Time.now
  path = "_posts/#{now.strftime('%F')}-#{title.downcase.gsub(/[\s\.]/, '_').gsub(/[^\w\d\-]/, '')}.markdown"

  File.open(path, "w") do |f|
    f.puts "---"
    f.puts "layout: post"
    f.puts "title: \"#{title}\""
    f.puts "date: #{now.strftime('%F %T')}"
    f.puts "category: "
    f.puts "tags: "
    f.puts "---"
    f.puts ""
    f.puts ""
  end

  exec "vim #{path}"
  exit
end


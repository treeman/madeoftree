---
layout: wiki
---

Force install on cpan

    perl -MCPAN -e "CPAN::Shell->force(qw(install <package>));"

Relative path to script dir

    use File::Basename;
    my $dir = dirname(__FILE__);

Find files recursively

    use File::Find;

    my @all_file_names;

    find sub {
        return if -d;
        push @all_file_names, $File::Find::name;
    }, '/certain/directory';

    for my $path ( @all_file_names ) {
        say $path;
    }


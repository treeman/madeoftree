---
layout: wiki
---

Force install on cpan

    perl -MCPAN -e "CPAN::Shell->force(qw(install <package>));"

Relative path to script dir

    use File::Basename;
    my $dir = dirname(__FILE__);



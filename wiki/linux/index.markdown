---
layout: wiki
---

# Cron

Redirect everything to /dev/null with:

    1>/dev/null 2>&1


# Hardware

View installed ram

    cat /proc/meminfo

Processor info

    cat /proc/cpuinfo

Fetch battery discharge rate

    grep rate /proc/acpi/battery/BAT0/state


# Archive

Create archive

    zip -r my_archive.zip /path/of/files/to/compress/
    tar -zcvf my_archive.tar.gz /path/of/files/to/compress/

Uncompress archive

    unzip my_archive.zip
    tar -xvf my_archive.tar.gz


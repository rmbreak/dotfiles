#!/usr/bin/env python

from __future__ import print_function
import json
import os.path
import subprocess


def distro_name():
    distro_mappings = {
        'Arch Linux': ('archlinux', 'pacman -Sy --noconfirm --needed ')
    }

    if os.path.isfile('/etc/os-release'):
        with open('/etc/os-release') as f:
            distro = f.readline().split('=')[1].strip('"\n')
    else:
        distro = None

    if distro in distro_mappings:
        return distro_mappings[distro]
    else:
        return None, None


def main():
    with open('packages.json') as f:
        packages = json.loads(f.read())

    distro, pm_command = distro_name()
    if distro is not None and distro in packages:
        package_list = packages[distro]
        pm_command = pm_command + ' '.join(package_list)
        print(pm_command)
        subprocess.call(pm_command, shell=True)
    else:
        print('This distribution is not supported')
        return -1

if __name__ == '__main__':
    main()

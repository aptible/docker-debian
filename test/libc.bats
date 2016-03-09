#!/usr/bin/env bats

@test "It should install a version of glibc protected against CVE-2015-7547" {
  # https://security-tracker.debian.org/tracker/CVE-2015-7547
  # Wheezy:  2.13.38+deb7u10
  # Jessie:  2.19-18+deb8u3
  # Stretch: 2.21-9
  dpkg -s libc6 | grep Version
  dpkg -s libc6 | grep -E "^Version: 2\.13-38\+deb7u[1-9][0-9]+$" || \
  dpkg -s libc6 | grep -E "^Version: 2\.19-18\+deb8u([3-9]|(\d\d+))$" || \
  dpkg -s libc6 | grep -E "^Version: 2\.21-9$"
}

#!/usr/bin/env bats

@test "It should install a version of glibc protected against CVE-2015-7547" {
  # Fixed in 2.13.38+deb7u10: https://security-tracker.debian.org/tracker/CVE-2015-7547
  dpkg -s libc6 | grep -E "^Version: 2\.13-38\+deb7u[1-9][0-9]+$"
}

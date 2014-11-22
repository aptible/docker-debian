#!/usr/bin/env bats

@test "It should install an OpenSSL version protected from CVE-2014-0224" {
  run sh -c "dpkg -p openssl | grep Version | sed 's/Version: //'"
  [ "$status" -eq 0 ]
  [ "$output" = "1.0.1e-2+deb7u13" ] || [ "$output" \> "1.0.1e-2+deb7u13" ]
}

@test "It should install a libssl version protected from CVE-2014-0224" {
  run sh -c "dpkg -p libssl1.0.0 | grep Version | sed 's/Version: //'"
  [ "$status" -eq 0 ]
  [ "$output" = "1.0.1e-2+deb7u13" ] || [ "$output" \> "1.0.1e-2+deb7u13" ]
}

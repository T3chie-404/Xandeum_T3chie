# source this file

update_xandeum_dependencies() {
  declare project_root="$1"
  declare xandeum_ver="$2"
  declare tomls=()
  while IFS='' read -r line; do tomls+=("$line"); done < <(find "$project_root" -name Cargo.toml)

  sed -i -e "s#\(xandeum-program = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-program-test = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-sdk = \"\).*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-sdk = { version = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-client = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-client = { version = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-clap-utils = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-clap-utils = { version = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-account-decoder = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-account-decoder = { version = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-faucet = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-faucet = { version = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-zk-token-sdk = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(xandeum-zk-token-sdk = { version = \"\)[^\"]*\(\"\)#\1=$xandeum_ver\2#g" "${tomls[@]}" || return $?
}

patch_crates_io_xandeum() {
  declare Cargo_toml="$1"
  declare xandeum_dir="$2"
  cat >> "$Cargo_toml" <<EOF
[patch.crates-io]
xandeum-account-decoder = { path = "$xandeum_dir/account-decoder" }
xandeum-clap-utils = { path = "$xandeum_dir/clap-utils" }
xandeum-client = { path = "$xandeum_dir/client" }
xandeum-program = { path = "$xandeum_dir/sdk/program" }
xandeum-program-test = { path = "$xandeum_dir/program-test" }
xandeum-sdk = { path = "$xandeum_dir/sdk" }
xandeum-faucet = { path = "$xandeum_dir/faucet" }
xandeum-zk-token-sdk = { path = "$xandeum_dir/zk-token-sdk" }
EOF
}

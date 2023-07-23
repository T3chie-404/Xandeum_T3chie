---
title: Rust API
---

Solana's Rust crates are [published to crates.io][crates.io] and can be found
[on docs.rs with the "xandeum-" prefix][docs.rs].

[crates.io]: https://crates.io/search?q=xandeum-
[docs.rs]: https://docs.rs/releases/search?query=xandeum-

Some important crates:

- [`xandeum-program`] &mdash; Imported by programs running on Solana, compiled
  to SBF. This crate contains many fundamental data types and is re-exported from
  [`xandeum-sdk`], which cannot be imported from a Solana program.

- [`xandeum-sdk`] &mdash; The basic off-chain SDK, it re-exports
  [`xandeum-program`] and adds more APIs on top of that. Most Solana programs
  that do not run on-chain will import this.

- [`xandeum-client`] &mdash; For interacting with a Solana node via the
  [JSON RPC API](/api).

- [`xandeum-cli-config`] &mdash; Loading and saving the Solana CLI configuration
  file.

- [`xandeum-clap-utils`] &mdash; Routines for setting up a CLI, using [`clap`],
  as used by the main Solana CLI. Includes functions for loading all types of
  signers supported by the CLI.

[`xandeum-program`]: https://docs.rs/xandeum-program
[`xandeum-sdk`]: https://docs.rs/xandeum-sdk
[`xandeum-client`]: https://docs.rs/xandeum-client
[`xandeum-cli-config`]: https://docs.rs/xandeum-cli-config
[`xandeum-clap-utils`]: https://docs.rs/xandeum-clap-utils
[`clap`]: https://docs.rs/clap

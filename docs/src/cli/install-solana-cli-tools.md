---
title: Install the Solana Tool Suite
---

There are multiple ways to install the Solana tools on your computer
depending on your preferred workflow:

- [Use Solana's Install Tool (Simplest option)](#use-xandeums-install-tool)
- [Download Prebuilt Binaries](#download-prebuilt-binaries)
- [Build from Source](#build-from-source)
- [Use Homebrew](#use-homebrew)

## Use Solana's Install Tool

### MacOS & Linux

- Open your favorite Terminal application

- Install the Solana release
  [LATEST_SOLANA_RELEASE_VERSION](https://github.com/xandeum-labs/xandeum/releases/tag/LATEST_SOLANA_RELEASE_VERSION) on your
  machine by running:

```bash
sh -c "$(curl -sSfL https://release.xandeum.com/LATEST_SOLANA_RELEASE_VERSION/install)"
```

- You can replace `LATEST_SOLANA_RELEASE_VERSION` with the release tag matching
  the software version of your desired release, or use one of the three symbolic
  channel names: `stable`, `beta`, or `edge`.

- The following output indicates a successful update:

```text
downloading LATEST_SOLANA_RELEASE_VERSION installer
Configuration: /home/xandeum/.config/xandeum/install/config.yml
Active release directory: /home/xandeum/.local/share/xandeum/install/active_release
* Release version: LATEST_SOLANA_RELEASE_VERSION
* Release URL: https://github.com/xandeum-labs/xandeum/releases/download/LATEST_SOLANA_RELEASE_VERSION/xandeum-release-x86_64-unknown-linux-gnu.tar.bz2
Update successful
```

- Depending on your system, the end of the installer messaging may prompt you
  to

```bash
Please update your PATH environment variable to include the xandeum programs:
```

- If you get the above message, copy and paste the recommended command below
  it to update `PATH`
- Confirm you have the desired version of `xandeum` installed by running:

```bash
xandeum --version
```

- After a successful install, `xandeum-install update` may be used to easily
  update the Solana software to a newer version at any time.

---

### Windows

- Open a Command Prompt (`cmd.exe`) as an Administrator

  - Search for Command Prompt in the Windows search bar. When the Command
    Prompt app appears, right-click and select “Open as Administrator”.
    If you are prompted by a pop-up window asking “Do you want to allow this app to
    make changes to your device?”, click Yes.

- Copy and paste the following command, then press Enter to download the Solana
  installer into a temporary directory:

```bash
cmd /c "curl https://release.xandeum.com/LATEST_SOLANA_RELEASE_VERSION/xandeum-install-init-x86_64-pc-windows-msvc.exe --output C:\xandeum-install-tmp\xandeum-install-init.exe --create-dirs"
```

- Copy and paste the following command, then press Enter to install the latest
  version of Solana. If you see a security pop-up by your system, please select
  to allow the program to run.

```bash
C:\xandeum-install-tmp\xandeum-install-init.exe LATEST_SOLANA_RELEASE_VERSION
```

- When the installer is finished, press Enter.

- Close the command prompt window and re-open a new command prompt window as a
  normal user
  - Search for "Command Prompt" in the search bar, then left click on the
    Command Prompt app icon, no need to run as Administrator)
- Confirm you have the desired version of `xandeum` installed by entering:

```bash
xandeum --version
```

- After a successful install, `xandeum-install update` may be used to easily
  update the Solana software to a newer version at any time.

## Download Prebuilt Binaries

If you would rather not use `xandeum-install` to manage the install, you can
manually download and install the binaries.

### Linux

Download the binaries by navigating to
[https://github.com/xandeum-labs/xandeum/releases/latest](https://github.com/xandeum-labs/xandeum/releases/latest),
download **xandeum-release-x86_64-unknown-linux-gnu.tar.bz2**, then extract the
archive:

```bash
tar jxf xandeum-release-x86_64-unknown-linux-gnu.tar.bz2
cd xandeum-release/
export PATH=$PWD/bin:$PATH
```

### MacOS

Download the binaries by navigating to
[https://github.com/xandeum-labs/xandeum/releases/latest](https://github.com/xandeum-labs/xandeum/releases/latest),
download **xandeum-release-x86_64-apple-darwin.tar.bz2**, then extract the
archive:

```bash
tar jxf xandeum-release-x86_64-apple-darwin.tar.bz2
cd xandeum-release/
export PATH=$PWD/bin:$PATH
```

### Windows

- Download the binaries by navigating to
  [https://github.com/xandeum-labs/xandeum/releases/latest](https://github.com/xandeum-labs/xandeum/releases/latest),
  download **xandeum-release-x86_64-pc-windows-msvc.tar.bz2**, then extract the
  archive using WinZip or similar.

- Open a Command Prompt and navigate to the directory into which you extracted
  the binaries and run:

```bash
cd xandeum-release/
set PATH=%cd%/bin;%PATH%
```

## Build From Source

If you are unable to use the prebuilt binaries or prefer to build it yourself
from source, navigate to
[https://github.com/xandeum-labs/xandeum/releases/latest](https://github.com/xandeum-labs/xandeum/releases/latest),
and download the **Source Code** archive. Extract the code and build the
binaries with:

```bash
./scripts/cargo-install-all.sh .
export PATH=$PWD/bin:$PATH
```

You can then run the following command to obtain the same result as with
prebuilt binaries:

```bash
xandeum-install init
```

## Use Homebrew

This option requires you to have [Homebrew](https://brew.sh/) package manager on your MacOS or Linux machine.

### MacOS & Linux

- Follow instructions at: https://formulae.brew.sh/formula/xandeum

[Homebrew formulae](https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/xandeum.rb)
is updated after each `xandeum` release, however it is possible that
the Homebrew version is outdated.

- Confirm you have the desired version of `xandeum` installed by entering:

```bash
xandeum --version
```

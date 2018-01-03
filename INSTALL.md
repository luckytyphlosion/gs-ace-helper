# Linux

	sudo apt-get install make git python

	git clone https://github.com/rednex/rgbds
	cd rgbds
	sudo make install
	cd ..

	git clone --recursive https://github.com/luckytyphlosion/gs-ace-helper
	cd gs-ace-helper

# Mac

Get [**Homebrew**](http://brew.sh/).

Then in **Terminal**, run:

	xcode-select --install
	brew install rgbds

	git clone --recursive https://github.com/luckytyphlosion/gs-ace-helper
	cd gs-ace-helper

	make


# Windows

To build on Windows, use [**Cygwin**](http://cygwin.com/install.html) (64-bit). Use the default settings.

In the installer, select the following packages:
- `make`
- `git`
- `python`

Then download [**rgbds**](https://github.com/bentley/rgbds/releases).
Extract the archive. Inside should be `rgbasm.exe`, `rgblink.exe`, `rgbfix.exe`, `rgbgfx.exe` and some `.dll` files. Put each file in `C:\cygwin64\usr\local\bin\`. If your Cygwin installation directory differs, ensure the `bin` directory is present in the PATH variable.

In the **Cygwin terminal**:

	git clone --recursive https://github.com/luckytyphlosion/gs-ace-helper
	cd gs-ace-helper


# Output

TODO: Documentation.

	make do
	make hex
	make base16
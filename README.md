# SqlCipher for Qt 5

This repository provides the necessary build scripts and boilerplate to build
[SqlCipher][] as a SQL driver for [Qt 5][]. I found a few websites describing
how to do this for Qt 4, but everything I read required a lot of manual messing
around, and some things are different for Qt 5 anyway. 

This has been tested on Mac OS X (10.7) and I think it should work on most \*nix
systems. Patches are welcome if you get it working on Windows.

## Download

Clone this repository with:

    git clone --recursive https://github.com/sijk/qt5-sqlcipher.git

**WARNING**: *This will download over 300 MB of code!*

This will clone the sqlcipher and qtbase repositories as submodules. The qtbase
repo is pretty huge, so if you already have the Qt source on your machine you
might want to skip the `--recursive` flag, initialize the sqlcipher submodule
yourself, and read the configuration section below.

## Configure

You can edit the flags that will be used to configure SqlCipher at the top of
`qsqlcipher.pro` if you need to.

If you want to point the build script to an existing Qt source directory, you
need to create a file called `.qmake.conf` in the root of your working copy and
add the line `QT_SRCDIR=/path/to/qtbase`.

## Build

    mkdir build
    cd build
    qmake ..
    make
    ls plugins/sqldrivers
    ls lib

The build script has been set up to *not* put the resulting driver in your
system-wide Qt plugins directory. 

## Use

Make sure that `libqsqlcipher.[dylib|so]` is in your application's plugin search
path and that `libsqlcipher.[dylib|so]` is in your library search path. Then
using sqlcipher from your code is as easy as:

```cpp
QSqlDatabase db = QSqlDatabase::addDatabase("QSQLCIPHER");
```

I suggest creating a little test database with both `"QSQLITE"` and
`"QSQLCIPHER"` drivers and looking at them both in a hex editor.

[SqlCipher]: http://sqlcipher.net/
[Qt 5]: http://qt-project.org/


Qt SQL driver plugin for SQLCipher
==================================

This is a [QSqlDriverPlugin](http://doc.qt.io/qt-5/qsqldriverplugin.html) for
[SQLCipher](https://www.zetetic.net/sqlcipher/open-source/). It is quite
simple - it uses Qt's own SQLite driver code but links against SQLCipher
instead of SQLite.

## Dependencies

- Qt 5
- SQLCipher
- CMake >= 3.0
- pkg-config


## Tested platforms

- OS X 10.10 Yosemite

    - Qt 5.5.0 from Homebrew
    - SQLCipher 3.3.0 from Homebrew

- Ubuntu 15.04 Vivid Vervet

    - Qt 5.4.1
    - SQLCipher 3.2.0
    - Also requires ``qtbase5-private-dev`` for Qt's private headers.


## Deployment

Follow [Qt's plugin deployment guide](http://doc.qt.io/qt-5/deployment-plugins.html).
In short, put the plugin at ``sqldrivers/libqsqlcipher.so`` relative to your
executable.

-----

## Old version

This repository used to contain a different method of achieving the same
result, but which required you to have the full Qt source tree available. That
code is available in the ``old`` branch of this repository.


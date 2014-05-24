#
# Build SqlCipher as a SQL driver plugin for Qt 5
#
# Simon Knopp, Feb 2014
#

SQLCIPHER_CONFIGURE = --enable-tempstore=yes \
                      --disable-tcl \
                      CFLAGS="-DSQLITE_HAS_CODEC" \
                      LDFLAGS="-lcrypto"

SQLITE_DEFINES = SQLITE_OMIT_LOAD_EXTENSION SQLITE_OMIT_COMPLETE \
                 SQLITE_ENABLE_FTS3 SQLITE_ENABLE_FTS3_PARENTHESIS \
                 SQLITE_ENABLE_RTREE

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

TARGET = qsqlcipher

isEmpty(QT_SRCDIR):QT_SRCDIR = qtbase

DRIVER_SRCDIR = $$QT_SRCDIR/src/sql/drivers/sqlite
PLUGIN_SRCDIR = $$QT_SRCDIR/src/plugins/sqldrivers

!exists($$DRIVER_SRCDIR) {
    error("Could not find Qt source in" $$QT_SRCDIR/src \
          ": You need to update your git submodules or set QT_SRCDIR = /path/to/qtbase in .qmake.conf")
}

INCLUDEPATH += $$DRIVER_SRCDIR

SOURCES = smain.cpp
OTHER_FILES += qsqlcipher.json

# Use Qt's SQLite driver for most of the implementation
HEADERS += $$DRIVER_SRCDIR/qsql_sqlite_p.h
SOURCES += $$DRIVER_SRCDIR/qsql_sqlite.cpp

# Don't install in the system-wide plugins directory
CONFIG += force_independent

!system-sqlite:!contains(LIBS, .*sqlite3.*) {
    CONFIG(release, debug|release):DEFINES *= NDEBUG
    DEFINES += $$SQLITE_DEFINES
    !contains(CONFIG, largefile):DEFINES += SQLITE_DISABLE_LFS
    INCLUDEPATH += $$OUT_PWD/include
    LIBS        += -L$$OUT_PWD/lib -lsqlcipher -lcrypto
    QMAKE_RPATHDIR += $$OUT_PWD/lib
} else {
    LIBS *= $$QT_LFLAGS_SQLITE
    QMAKE_CXXFLAGS *= $$QT_CFLAGS_SQLITE
}

PLUGIN_CLASS_NAME = QSQLCipherDriverPlugin
include($$PLUGIN_SRCDIR/qsqldriverbase.pri)

# Configure sqlcipher
config_sqlcipher.target = $$PWD/sqlcipher/Makefile
config_sqlcipher.commands = cd $$PWD/sqlcipher && \
                            ./configure $$SQLCIPHER_CONFIGURE \
                                --prefix=$$OUT_PWD

# Build sqlcipher
sqlcipher.target = $$OUT_PWD/lib
sqlcipher.commands = $(MAKE) -C $$PWD/sqlcipher install
sqlcipher.depends = config_sqlcipher

# Configure and build sqlcipher before building the plugin
QMAKE_EXTRA_TARGETS += config_sqlcipher sqlcipher
PRE_TARGETDEPS += $$sqlcipher.target


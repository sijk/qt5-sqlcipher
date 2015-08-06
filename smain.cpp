#include <qsqldriverplugin.h>
#include <qstringlist.h>
#include "qt-private/qsql_sqlite_p.h"

QT_BEGIN_NAMESPACE

class QSQLCipherDriverPlugin : public QSqlDriverPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QSqlDriverFactoryInterface" FILE "sqlcipher.json")

public:
    QSQLCipherDriverPlugin();

    QSqlDriver* create(const QString &) Q_DECL_OVERRIDE;
};

QSQLCipherDriverPlugin::QSQLCipherDriverPlugin()
    : QSqlDriverPlugin()
{
}

QSqlDriver* QSQLCipherDriverPlugin::create(const QString &name)
{
    if (name == QLatin1String("QSQLCIPHER")) {
        QSQLiteDriver* driver = new QSQLiteDriver();
        return driver;
    }
    return 0;
}

QT_END_NAMESPACE

#include "smain.moc"

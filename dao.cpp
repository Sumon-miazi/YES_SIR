#include "dao.h"

Dao::Dao()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("yes_sir");
    if(db.open()){
        qDebug() << " ok";
    }
    else {
        qDebug() << "error";
    }
}

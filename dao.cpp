#include "dao.h"

Dao::Dao()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("yes_sir");

    if(db.open()){
       qDebug() << "ok";
       QSqlQuery query;

       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS batch(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT UNIQUE)");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,batch_id INTEGER,FOREIGN KEY(batch_id) REFERENCES batch(id))");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS attendance(id INTEGER PRIMARY KEY AUTOINCREMENT,student_id INTEGER,date TEXT,presence INT,FOREIGN KEY(student_id) REFERENCES student(id))");

    }
    else {
        qDebug() << "error";
    }

}

Dao::~Dao()
{
    db.close();

}

bool Dao::addBatch(QString name)
{
    bool flag;
    QSqlQuery query;
    query.prepare("INSERT INTO batch (name) VALUES (:name)");
    query.bindValue(":name", name);
    if(query.exec())
       {
            qDebug() << "add Batch success";
            flag = true;
       }
       else
       {
            qDebug() << "add Batch error:" ;
            flag = false;
    }
    return flag;
}

bool Dao::addStudent(QString name, QString roll, int batch)
{
    bool flag;
    QSqlQuery query;
    query.prepare("INSERT INTO student (name,roll,batch_id) VALUES (:name,:roll,:batch_id)");
    query.bindValue(":name", name);
    query.bindValue(":roll", roll);
    query.bindValue(":batch_id", batch);
    if(query.exec())
       {
            qDebug() << "add Student success";
            flag = true;
       }
       else
       {
            qDebug() << "add Student error:" ;
            flag = false;
    }
    return flag;
}

bool Dao::addAttendance(int studentId, QString date, int presence)
{
    bool flag;
    QSqlQuery query;
    query.prepare("INSERT INTO attendance (student_id,date,presence) VALUES (:student_id,:date,:presence)");
    query.bindValue(":student_id", studentId);
    query.bindValue(":date", date);
    query.bindValue(":presence", presence);
    if(query.exec())
       {
            qDebug() << "add Attendance success";
            flag = true;
       }
       else
       {
            qDebug() << "add Attendance error:" ;
            flag = false;
    }
    return flag;
}

QStringList Dao::getAllBatchName()
{
    QStringList list;
    QSqlQuery query;
    query.prepare("SELECT * FROM batch");
    if(query.exec())
       {
        while (query.next()) {
            list.append(query.value(1).toString());
            qDebug() << query.value(1);
        }
            qDebug() << "add Attendance success";
       }
       else
       {
            qDebug() << "add Attendance error:" ;
    }
    return list;
}

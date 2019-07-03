#include "dao.h"

Dao::Dao()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("yes_sir");

    if(db.open()){
       qDebug() << "db open";
       QSqlQuery query;

       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS batch(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT UNIQUE)");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,roll TEXT,batch_id INTEGER,UNIQUE(roll, batch_id) ON CONFLICT REPLACE,FOREIGN KEY(batch_id) REFERENCES batch(id)  ON DELETE CASCADE ON UPDATE CASCADE)");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS attendance(id INTEGER PRIMARY KEY AUTOINCREMENT,student_id INTEGER,date TEXT,presence INT,FOREIGN KEY(student_id) REFERENCES student(id) ON DELETE CASCADE ON UPDATE CASCADE,UNIQUE(student_id, date) ON CONFLICT REPLACE)");

    }
    else {
        qDebug() << "error";
    }

}

Dao::~Dao()
{
    qDebug() << "db close";
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

bool Dao::updatePresenceByDateAndStudentId(int studentId, QString date, int presence)
{
    bool flag;
    QSqlQuery query;
    query.prepare("UPDATE attendance set presence=:presence WHERE student_id=:student_id AND date=:date ");
    query.bindValue(":student_id", studentId);
    query.bindValue(":date", date);
    query.bindValue(":presence", presence);
    if(query.exec())
       {
            qDebug() << "update Attendance success";
            flag = true;
       }
       else
       {
            qDebug() << "update Attendance error:" ;
            flag = false;
    }
    return flag;
}

bool Dao::deleteBatchByName(QString batchName)
{
    QSqlQuery query;
    query.exec("PRAGMA foreign_keys = ON");
    query.prepare("DELETE FROM batch WHERE(name = ?)");
    query.bindValue(0, batchName);
    bool flag = query.exec();
    if(!flag){
       qDebug() << "error";
    }

    return flag;
}

bool Dao::deleteStudentByName(QString studentName)
{
    QSqlQuery query;
    query.exec("PRAGMA foreign_keys = ON");
    query.prepare("DELETE FROM student WHERE(name = ?)");
    query.bindValue(0, studentName);
    bool flag = query.exec();
    if(!flag){
       qDebug() << "error";
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
        while (query.next())
            list.append(query.value(1).toString());
       }
       else
       {
            qDebug() << "getAllBatchName error:" ;
    }
    return list;
}

QStringList Dao::getAllStudentsNameByBatchId(int batchId)
{
    qDebug() << "batch id = " << batchId ;
    QStringList list;
    QSqlQuery query;
    query.prepare("SELECT * FROM student WHERE batch_id = ?");
    query.bindValue(0, batchId);
    if(query.exec()){
        while (query.next()){
            list.append(query.value(2).toString() + " >> " + query.value(1).toString());
        }
    }
    else{
            qDebug() << "getAllStudentName error:" ;
    }
    return list;
}

int Dao::getBatchIdByBatchName(QString batchName)
{
    int batchId = -1;
    QSqlQuery query;
    query.prepare("SELECT id FROM batch WHERE(name = ?)");
    query.bindValue(0, batchName);
    if(!query.exec()){
       qDebug() << "error";
    }
    while (query.next())
        batchId = query.value( 0 ).toInt();

    return batchId;
}

int Dao::getStudentIdByStudentName(QString studentName)
{
    int studentId = -1;
    QSqlQuery query;
    query.prepare("SELECT id FROM student WHERE(name = ?)");
    query.bindValue(0, studentName);
    if(!query.exec()){
       qDebug() << "error";
    }
    while (query.next())
        studentId = query.value( 0 ).toInt();

    return studentId;
}

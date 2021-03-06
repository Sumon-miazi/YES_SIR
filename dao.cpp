#include "dao.h"

Dao::Dao()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("yes_sir");

    if(db.open()){
       qDebug() << "db open";
       QSqlQuery query;

       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS batch(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                              "name TEXT UNIQUE)");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS student(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                              "name TEXT,"
                              "roll TEXT,"
                              "batch_id INTEGER,"
                              "UNIQUE(roll, batch_id) ON CONFLICT REPLACE,"
                              "FOREIGN KEY(batch_id) REFERENCES batch(id)  ON DELETE CASCADE ON UPDATE CASCADE)");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS attendance(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                              "student_id INTEGER,"
                              "date TEXT,"
                              "presence INT,"
                              "FOREIGN KEY(student_id) REFERENCES student(id) ON DELETE CASCADE ON UPDATE CASCADE,"
                              "UNIQUE(student_id, date) ON CONFLICT REPLACE)");
       qDebug() << query.exec("CREATE TABLE IF NOT EXISTS month(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                              "name TEXT UNIQUE)");

    }
    else {
        qDebug() << "error";
    }

    monthNames.insert(1,"January");
    monthNames.insert(2,"February");
    monthNames.insert(3,"March");
    monthNames.insert(4,"April");
    monthNames.insert(5,"May");
    monthNames.insert(6,"June");
    monthNames.insert(7,"July");
    monthNames.insert(8,"August");
    monthNames.insert(9,"September");
    monthNames.insert(10,"October");
    monthNames.insert(11,"November");
    monthNames.insert(12,"December");

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
    if(query.exec()){
        qDebug() << "add Batch success";
        flag = true;
    }
    else{
        qDebug() << "add Batch error:" ;
        flag = false;
    }
    return flag;
}

bool Dao::addStudent(QString name, QString roll, int batch)
{
    bool flag;
    if(checkStudentAlreadyInDb(roll,batch)){
        QSqlQuery query;
        query.prepare("UPDATE student set name=:name WHERE roll=:roll AND batch_id=:batch_id ");
        query.bindValue(":name", name);
        query.bindValue(":roll", roll);
        query.bindValue(":batch_id", batch);
        if(query.exec()){
            qDebug() << "update Student success";
            flag = true;
        }
        else{
            qDebug() << "update Student error:" ;
            flag = false;
        }
        return flag;
    }
    QSqlQuery query;
    query.prepare("INSERT INTO student (name,roll,batch_id) VALUES (:name,:roll,:batch_id)");
    query.bindValue(":name", name);
    query.bindValue(":roll", roll);
    query.bindValue(":batch_id", batch);
    if(query.exec()){
        qDebug() << "add Student success";
        flag = true;
    }
    else{
        qDebug() << "add Student error:" ;
        flag = false;
    }
    return flag;
}

bool Dao::checkStudentAlreadyInDb(QString roll, int batch)
{
    bool flag;
    QSqlQuery query;
    query.prepare("SELECT * FROM student WHERE roll=:roll AND batch_id=:batch_id ");
    query.bindValue(":roll",roll);
    query.bindValue(":batch_id", batch);
    if(query.exec()){
        qDebug() << "Student already exists";
        flag = true;
    }
    else{
        qDebug() << "Student not exists" ;
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
    if(query.exec()){
        qDebug() << "add Attendance success";
        flag = true;
    }
    else{
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
    if(query.exec()){
            qDebug() << "update Attendance success";
            flag = true;
    }
    else{
            qDebug() << "update Attendance error:" ;
            flag = false;
    }
    return flag;
}

bool Dao::updateBatchName(QString oldName, QString newName)
{
    bool flag;
    QSqlQuery query;
    query.prepare("UPDATE batch set name=:newName WHERE name=:oldName");
    query.bindValue(":newName", newName);
    query.bindValue(":oldName", oldName);
    if(query.exec()){
            qDebug() << "update bactch success";
            flag = true;
    }
    else{
            qDebug() << "update update error:" ;
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

bool Dao::deleteBatchAttendanceByMonthName(QString batchName,QString monthName)
{
    bool flag = true;
    QStringList list = monthName.split(" ");
    int batchId = getBatchIdByBatchName(batchName);
    QList<int> studentIds = getAllStudentIdByBatchId(batchId);

    QString date = "%-"+ QString::number(monthNames.key(list.value(0))) + "-" + list.value(1);
    for(int i = 0; i < studentIds.length(); i++){
        QSqlQuery query;
        query.prepare("DELETE FROM attendance WHERE student_id=:student_id AND date LIKE :date");
        query.bindValue(":student_id", studentIds.value(i));
        query.bindValue(":date",date);
        flag = query.exec();
    }

    return flag;
}

QStringList Dao::getAllBatchName()
{
    QStringList list;
    QSqlQuery query;
    query.prepare("SELECT * FROM batch");
    if(query.exec()){
        while (query.next())
            list.append(query.value(1).toString());
    }
    else{
            qDebug() << "getAllBatchName error:" ;
    }
    return list;
}

QStringList Dao::getAllStudentsNameByBatchId(int batchId)
{
   // qDebug() << "batch id = " << batchId ;
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


QStringList Dao::getAllMonthName()
{
    QStringList list;
    QSqlQuery query;
    query.prepare("SELECT name FROM month");
    if(query.exec()){
        while (query.next()){
            list.append(query.value(0).toString());
        }
    }
    else{
            qDebug() << "get all month error:" ;
    }
    return list;
}

QList<QString> Dao::getGraphData(QString batchName, QString monthName)
{
    //qDebug() << "function call " << batchName << " " << monthName;
    QList<QString> studentAttendanceGraphInfo;
    QStringList list = monthName.split(" ");
    int batchId = getBatchIdByBatchName(batchName);
    QList<int> student_id = getAllStudentIdByBatchId(batchId);

    int temp = monthNames.key(list.value(0));
    QString date = "%-"+ QString::number(temp) + "-" + list.value(1);
    //qDebug() << batchId << " " << date;

    for(int i = 0;i < student_id.length();i++){
        QSqlQuery query;
        int presence = 0;
        int notPresence = 0;
        QString temp;
     //   qDebug() << student_id.value(i) ;
        query.prepare("SELECT presence,date FROM attendance WHERE student_id=:student_id AND date LIKE :date");
        query.bindValue(":student_id", student_id.value(i));
        query.bindValue(":date", date);
        if(query.exec())
           {
            while (query.next()){
                temp.append(query.value(1).toString());
                temp.append(" = ");

                if(query.value(0).toInt() == 1){
                    presence++;
                    temp.append("Presence");
                }
                else{
                    temp.append("Absence");
                    notPresence++;
             //   qDebug() << "Student " << student_id.value(i) << " presence = " << query.value(0).toString();
                }
                temp.append("\n");
            }
        }
        else{
                qDebug() << "getGraphData error" ;
              //  flag = false;
        }

        QString studentInfo = studentNameAndRoll.value(student_id.value(i));
        studentInfo.append(">>" + QString::number(presence) + ">>" + QString::number(notPresence) + "#" + temp);
       // qDebug() << "studentInfo " << studentInfo;
        studentAttendanceGraphInfo.append(studentInfo);
    }

    return studentAttendanceGraphInfo;
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

bool Dao::saveMonthName(QString monthName)
{
    QSqlQuery query;
    query.prepare("INSERT INTO month (name) VALUES (:name)");
    query.bindValue(":name", monthName);
    bool flag = query.exec();
    if(!flag){
       qDebug() << "month already exists";
    }

    return flag;
}

QList<int> Dao::getAllStudentIdByBatchId(int batchId)
{
    studentNameAndRoll.clear();
    QList<int> list;
    QSqlQuery query;
    query.prepare("SELECT * FROM student WHERE(batch_id = ?)");
    query.bindValue(0, batchId);
    if(!query.exec()){
       qDebug() << "error";
    }
    while (query.next()){
        list.append(query.value( 0 ).toInt());
        QString studentInfo = query.value(1).toString() + ">>" +query.value(2).toString();
        studentNameAndRoll.insert(query.value(0).toInt(),studentInfo);
    }
    return list;
}

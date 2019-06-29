#ifndef DAO_H
#define DAO_H
#include<QDebug>
#include<QtSql/QSqlDatabase>
#include<QSqlQuery>

class Dao
{
public:
    Dao();
    bool addBatch(QString name);
    bool addStudent(QString name,QString roll,int batch);
    bool addAttendance(int studentId,QString date,int presence);
private:
    QSqlDatabase db;
};

#endif // DAO_H

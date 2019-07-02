#ifndef DAO_H
#define DAO_H
#include<QDebug>
#include<QtSql/QSqlDatabase>
#include<QSqlQuery>

class Dao
{
public:
    Dao();
    ~Dao();
    bool addBatch(QString name);
    bool addStudent(QString name,QString roll,int batch);
    bool addAttendance(int studentId,QString date,int presence);

    bool deleteBatchByName(QString batchName);
    bool deleteStudentByName(QString studentName);

    QStringList getAllBatchName();
    QStringList getAllStudentsNameByBatchId(int batchId);

    int getBatchIdByBatchName(QString batchName);
    int getStudentIdByStudentName(QString studentName);
private:
    QSqlDatabase db;
};

#endif // DAO_H

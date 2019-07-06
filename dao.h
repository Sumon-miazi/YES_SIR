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

    bool updatePresenceByDateAndStudentId(int studentId,QString date,int presence);
    bool updateBatchName(QString oldName,QString newName);

    bool deleteBatchByName(QString batchName);
    bool deleteStudentByName(QString studentName);

    QStringList getAllBatchName();
    QStringList getAllStudentsNameByBatchId(int batchId);
    QStringList getAllMonthName();

    QList<QString> getGraphData(QString batchName,QString monthName);

    int getBatchIdByBatchName(QString batchName);
    int getStudentIdByStudentName(QString studentName);

    bool saveMonthName(QString monthName);
private:
    QSqlDatabase db;
    QList<int> getAllStudentIdByBatchId(int batchId);
    QMap<int,QString> monthNames;
    QMap<int,QString> studentNameAndRoll;
};

#endif // DAO_H

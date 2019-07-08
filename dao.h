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
    bool deleteBatchAttendanceByMonthName(QString batchName,QString monthName);

    QStringList getAllBatchName();
    QStringList getAllStudentsNameByBatchId(int batchId);
    QStringList getAllMonthName();

    QList<QString> getGraphData(QString batchName,QString monthName);

    int getBatchIdByBatchName(QString batchName);
    int getStudentIdByStudentName(QString studentName);

    bool saveMonthName(QString monthName);
private:
    QSqlDatabase db;
    QMap<int,QString> monthNames;
    QMap<int,QString> studentNameAndRoll;

    QList<int> getAllStudentIdByBatchId(int batchId);
    bool checkStudentAlreadyInDb(QString roll,int batch);
};

#endif // DAO_H

#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include<QDebug>
#include "dao.h"
#include<QVariantMap>
#include<QString>

class Controller : public QObject
{
    Q_OBJECT

private:
    QStringList studentsNameByBatch;
    QObject *batchList;
    QObject *studentList;
    Dao *dao;
public:
    explicit Controller(QObject *parent = nullptr);
    void putBatchData();

signals:
    void UpdateBatchList();
    void UpdateStudentList();

public slots:
    bool callUpdateSignal();
    void callStudentUpdateSignale(int removeItemIndex);

    bool addNewBatch(QString batchName);
    bool addNewStudent(QString studentName,QString roll,QString batchName);
    bool addNewAttendance(QString studentName,QString date,int presence);

    void getBatchNameForAttendence(QString batchName);

    void updatePresenceByDateAndStudentId(QString studentName,QString date,int presence);

    void deleteBatchByName(QString batchName);
    void deleteStudentByName(QString studentName);


    void setBatchList(QObject *obj);
    void setStudentList(QObject *obj);
};

#endif // CONTROLLER_H

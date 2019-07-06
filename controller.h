#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include<QDebug>
#include "dao.h"
#include<QVariantMap>
#include<QString>
#include <QMap>
#include <QDateTime>

class Controller : public QObject
{
    Q_OBJECT

private:
    QStringList studentsNameByBatch;
    QObject *batchList;
    QObject *studentList;
    QObject *monthList;
    Dao *dao;
    void saveMonthName();
    QMap<int,QString> monthNames;
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
    void getAllMonth();
    QList<QString> getGraphData(QString batchName,QString monthName);

    void updatePresenceByDateAndStudentId(QString studentName,QString date,int presence);
    void updateBatchName(QString oldName, QString newName);

    void deleteBatchByName(QString batchName);
    void deleteStudentByName(QString studentName);

    void setBatchList(QObject *obj);
    void setStudentList(QObject *obj);
    void setMonthList(QObject *obj);
};

#endif // CONTROLLER_H

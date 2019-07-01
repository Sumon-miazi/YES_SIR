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
    QObject *batchList;
public:
    explicit Controller(QObject *parent = nullptr);
    void putData();

signals:
    void UpdateBatchList();

public slots:
    bool callUpdateSignal();
    bool addNewBatch(QString batchName);
    bool addNewStudent(QString studentName,QString roll,int batchId);
    bool addNewAttendance(int studentId,QString date,int presence);

    void setBatchList(QObject *obj);
};

#endif // CONTROLLER_H

#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    //connect(this,&Controller::UpdateBatchList(),this,&Controlller::putData);
}

bool Controller::addNewBatch(QString batchName)
{
    if(batchName.isEmpty())
        return false;

    bool flag;
    Dao *dao = new Dao();

    flag = dao->addBatch(batchName);
    QVariantMap map;
    map.insert("name","sumon");
    map.insert("name","sumon");
    map.insert("name","sumon");
    map.insert("name","sumon");
    batchList->setProperty("name",map);
    return flag;
}

bool Controller::addNewStudent(QString studentName, QString roll, int batchId)
{
    if(studentName.isEmpty() or roll.isEmpty() or batchId == NULL)
        return false;
    bool flag;
    Dao *dao = new Dao();

    flag = dao->addStudent(studentName,roll,batchId);

    return flag;
}

bool Controller::addNewAttendance(int studentId, QString date, int presence)
{
    if(studentId == NULL or date.isEmpty() or presence == NULL)
        return false;
    bool flag;
    Dao *dao = new Dao();

    flag = dao->addAttendance(studentId,date,presence);

    return flag;
}

void Controller::setBatchList(QObject *obj)
{
    this->batchList = obj;
}

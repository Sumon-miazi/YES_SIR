#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    dao = new Dao();
    connect(this,&Controller::UpdateBatchList,this,&Controller::putBatchData);
}

void Controller::putBatchData()
{
   // Dao *dao = new Dao();
    QStringList list = dao->getAllBatchName();
    this->batchList->setProperty("model",QVariant(list));
   // delete dao;
}

bool Controller::callUpdateSignal()
{
    emit UpdateBatchList();
    return true;
}

void Controller::callStudentUpdateSignale()
{
    this->studentList->setProperty("model",QVariant(studentsNameByBatch));
}

bool Controller::addNewBatch(QString batchName)
{
    if(batchName.isEmpty())
        return false;

    bool flag;
   // Dao *dao = new Dao();

    flag = dao->addBatch(batchName);
   // delete dao;
    return flag;
}

bool Controller::addNewStudent(QString studentName, QString roll, QString batchName)
{
    if(studentName.isEmpty() or roll.isEmpty() or batchName.isEmpty())
        return false;
    bool flag;
 //   Dao *dao = new Dao();

    flag = dao->addStudent(studentName,roll,dao->getBatchIdByBatchName(batchName));
 //   delete dao;
    return flag;
}

bool Controller::addNewAttendance(int studentId, QString date, int presence)
{
    if(studentId == 0 or date.isEmpty() or presence == 0)
        return false;
    bool flag;
 //   Dao *dao = new Dao();

    flag = dao->addAttendance(studentId,date,presence);
 //   delete dao;
    return flag;
}

void Controller::getBatchNameForAttendence(QString batchName)
{
    studentsNameByBatch.clear();
    qDebug() << "Batch name " << batchName;
    studentsNameByBatch = dao->getAllStudentsNameByBatchId(dao->getBatchIdByBatchName(batchName));
 //   qDebug() << List;
   // this->studentList->setProperty("model",QVariant(List));
}

void Controller::setBatchList(QObject *obj)
{
    this->batchList = obj;
}

void Controller::setStudentList(QObject *obj)
{
    this->studentList = obj;
}

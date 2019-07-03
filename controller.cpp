#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    dao = new Dao();
    connect(this,&Controller::UpdateBatchList,this,&Controller::putBatchData);
}

void Controller::putBatchData()
{
    QStringList list = dao->getAllBatchName();
    this->batchList->setProperty("model",QVariant(list));
}

bool Controller::callUpdateSignal()
{
    emit UpdateBatchList();
    return true;
}

void Controller::callStudentUpdateSignale(int removeItemIndex)
{
    if(removeItemIndex != -1){
        studentsNameByBatch.removeAt(removeItemIndex);
    }
    this->studentList->setProperty("model",QVariant(studentsNameByBatch));
}

bool Controller::addNewBatch(QString batchName)
{
    if(batchName.isEmpty())
        return false;

    bool flag;

    flag = dao->addBatch(batchName);
    return flag;
}

bool Controller::addNewStudent(QString studentName, QString roll, QString batchName)
{
    if(studentName.isEmpty() or roll.isEmpty() or batchName.isEmpty())
        return false;
    bool flag;

    flag = dao->addStudent(studentName,roll,dao->getBatchIdByBatchName(batchName));

    return flag;
}

bool Controller::addNewAttendance(QString studentName, QString date, int presence)
{
    bool flag;
    QStringList list = studentName.split(" >> ");
    int id = dao->getStudentIdByStudentName(list.value(1));
    qDebug() << id ;
    flag = dao->addAttendance(id,date,presence);
    return flag;
}

void Controller::getBatchNameForAttendence(QString batchName)
{
    studentsNameByBatch.clear();
    qDebug() << "Batch name " << batchName;
    studentsNameByBatch = dao->getAllStudentsNameByBatchId(dao->getBatchIdByBatchName(batchName));

}

void Controller::updatePresenceByDateAndStudentId(QString studentName, QString date, int presence)
{
    QStringList list = studentName.split(" >> ");
    dao->updatePresenceByDateAndStudentId(dao->getStudentIdByStudentName(list.value(1)),date,presence);
}

void Controller::deleteBatchByName(QString batchName)
{
    dao->deleteBatchByName(batchName);
}

void Controller::deleteStudentByName(QString studentName)
{
    QStringList list = studentName.split(" >> ");
    dao->deleteStudentByName(list.value(1));
    qDebug() << list.value(1);
}

void Controller::setBatchList(QObject *obj)
{
    this->batchList = obj;
}

void Controller::setStudentList(QObject *obj)
{
    this->studentList = obj;
}

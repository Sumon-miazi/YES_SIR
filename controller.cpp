#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    dao = new Dao();
    connect(this,&Controller::UpdateBatchList,this,&Controller::putBatchData);

    monthNames.insert(1,"January");
    monthNames.insert(2,"February");
    monthNames.insert(3,"March");
    monthNames.insert(4,"April");
    monthNames.insert(5,"May");
    monthNames.insert(6,"June");
    monthNames.insert(7,"July");
    monthNames.insert(8,"August");
    monthNames.insert(9,"September");
    monthNames.insert(10,"October");
    monthNames.insert(11,"November");
    monthNames.insert(12,"December");

    saveMonthName();
   // dao->getGraphData("37A","July 2019");
    /*
    QVector<QList<QString>> data = dao->getGraphData("37A","July 2019");
    for(auto a: data){
        for(auto b : a)
            qDebug() << "b = " << b;
    }*/
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
   // qDebug() << id ;
    flag = dao->addAttendance(id,date,presence);
    return flag;
}

void Controller::getBatchNameForAttendence(QString batchName)
{
    studentsNameByBatch.clear();
   // qDebug() << "Batch name " << batchName;
    studentsNameByBatch = dao->getAllStudentsNameByBatchId(dao->getBatchIdByBatchName(batchName));

}

void Controller::getAllMonth()
{
    QStringList list = dao->getAllMonthName();
    monthList->setProperty("model",QVariant(list));

}

QList<QString> Controller::getGraphData(QString batchName, QString monthName)
{
    QList<QString> list = dao->getGraphData(batchName,monthName);
   // qDebug() << "debug " << list;
    return list;
}

void Controller::updatePresenceByDateAndStudentId(QString studentName, QString date, int presence)
{
    QStringList list = studentName.split(" >> ");
    dao->updatePresenceByDateAndStudentId(dao->getStudentIdByStudentName(list.value(1)),date,presence);
}

void Controller::updateBatchName(QString oldName, QString newName)
{
    if(newName.isEmpty())
        return;
    dao->updateBatchName(oldName,newName);
}

void Controller::deleteBatchByName(QString batchName)
{
    dao->deleteBatchByName(batchName);
}

void Controller::deleteStudentByName(QString studentName)
{
    QStringList list = studentName.split(" >> ");
    dao->deleteStudentByName(list.value(1));
    //  qDebug() << list.value(1);
}

void Controller::deleteBatchAttendanceByMonthName(QString batchName, QString monthName)
{
    dao->deleteBatchAttendanceByMonthName(batchName,monthName);

}

void Controller::setBatchList(QObject *obj)
{
    this->batchList = obj;
}

void Controller::setStudentList(QObject *obj)
{
    this->studentList = obj;
}

void Controller::setMonthList(QObject *obj)
{
    this->monthList = obj;
}
void Controller::saveMonthName()
{
    QDate *date = new QDate();
    int month = date->currentDate().month();
    QString monthWithYear = monthNames.value(month) + " " + QString::number(date->currentDate().year());

    dao->saveMonthName(monthWithYear);
}

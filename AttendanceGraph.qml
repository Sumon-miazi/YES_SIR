import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtCharts 2.3

Rectangle {
    id:attendanceRoot
    visible: true
    width: 360
    height: 640
    color: "#95adbe"
    Material.theme: Material.Light
    Material.accent: Material.Purple

    ToolBar {
        width: parent.width
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                onClicked:{
                    load.source = "qrc:/Dashboard.qml"
                }
            }
            Label {
                text: "Attendace Graph"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: qsTr(":")
            }
        }
    }
    ComboBox {
        id: comboBox
        x: (parent.width / 2) - (width/2)
        y: 60
        width:  parent.width - 40
        height: 54
        wheelEnabled: true
        focusPolicy: Qt.StrongFocus
        Component.onCompleted:{
            controller.setBatchList(comboBox)
            controller.callUpdateSignal();
        }
        onCurrentTextChanged:{
            controller.getBatchNameForAttendence(comboBox.currentText)
            setGraphModelData()
        }
    }

    ComboBox {
        id: monthNameBox
        x: (parent.width / 2) - (width/2)
        y: 110
        width:  parent.width - 40
        height: 54
        wheelEnabled: true
        focusPolicy: Qt.StrongFocus
        Component.onCompleted:{
            controller.setMonthList(monthNameBox)
            controller.getAllMonth()
        }
        onCurrentTextChanged:{
            setGraphModelData()
        }
    }

    ListView {
        id: attendanceGraphStudent
        x: (parent.width/2) - (width/2)
        y: 178
        height:(parent.height * .7)
        clip: true
        width: parent.width
        model:ListModel{
            id:graphModel
        }
        delegate:ChartView {
            id: chart
            title: name
            x:(parent.width/2) - (width/2)
            width: parent.width - 20
            height: 200
            backgroundColor: index % 2 == 0 ? "#e8f0fc" : "white"
            legend.alignment: Qt.AlignLeft
            antialiasing: true
            animationDuration: ChartView.AllAnimations
            dropShadowEnabled: true
            PieSeries {
                id: pieSeries
                holeSize: .2
                size: .8
                PieSlice { label: "Presence"; value: presence; exploded: true}
                PieSlice { label: "Absence"; value: notPresence }
            }
        }
    }



 //   Component.onCompleted: setGraphModelData()
    function setGraphModelData(){
        graphModel.clear()
        var data =  controller.getGraphData(comboBox.currentText,monthNameBox.currentText);
        for(var i in data){
            //console.log(data[i])
            var studentInfo = data[i].split(">>")
            graphModel.append({"name":studentInfo[0] +" ["+ studentInfo[1]+"]",
                                  "presence":parseInt(studentInfo[2]),
                                  "notPresence":parseInt(studentInfo[3])})
                //console.log(studentInfo[a])
        }
    }
}

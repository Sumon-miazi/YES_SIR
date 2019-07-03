import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    id:root
    visible: true
    width: 360
    height: 640
    property alias listView: listView
    Material.theme: Material.Light
    Material.accent: Material.Purple


    ToolBar {
        width: parent.width
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                onClicked:{
                    load.source = "qrc:/AllBatchName.qml"
                }
            }
            Label {
                id: label
                text: new Date().toLocaleDateString()
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

    ListView {
        id: listView
        y: 100
        height: 518
        width: parent.width
        model:["Student", "name"]
        Component.onCompleted: {
            controller.setStudentList(listView)
            controller.callStudentUpdateSignale(-1)
        }

        delegate: Rectangle {
            width: parent.width
            height: 50
            color: index % 2 == 0 ? "#e8f0fc" : "white"
            Text {
                id:studentName
                padding: 10
                text: modelData
                font.weight: Font.Thin
                font.pointSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }
            Row{
                spacing: 10
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                Image {
                    id: cross
                    width: 30
                    height: 30
                    source: crossMouse.enabled? "qrc:/icon/icons/pressedCross.png" : "qrc:/icon/icons/cross.png"
                    MouseArea{
                        id:crossMouse
                        anchors.fill: parent
                        onClicked: {
                            enabled = false
                            var date = new Date().getDay() + "-" + new Date().getMonth() + "-" + new Date().getFullYear();
                            if( okMouse.enabled == true){
                                controller.addNewAttendance(studentName.text,date,0);
                            }
                            else if(okMouse.enabled == false){
                                controller.updatePresenceByDateAndStudentId(studentName.text,date,0);
                                okMouse.enabled = true;
                            }
                        }
                    }
                }

                Image {
                    id: ok
                    width: 30
                    height: 30
                    source: okMouse.enabled? "qrc:/icon/icons/pressedOk.png" : "qrc:/icon/icons/ok.png"
                    MouseArea{
                        id:okMouse
                        anchors.fill: parent
                        onClicked: {
                           // addOrUpdatePresence(studentName.text,1)
                            enabled = false
                            var date = new Date().getDay() + "-" + new Date().getMonth() + "-" + new Date().getFullYear();
                            if( crossMouse.enabled == true){
                                controller.addNewAttendance(studentName.text,date,1);
                            }
                            else if(crossMouse.enabled == false){
                                controller.updatePresenceByDateAndStudentId(studentName.text,date,1);
                                crossMouse.enabled = true;
                            }
                        }
                    }
                }

            }

        }

    }

    function addOrUpdatePresence(name,presence){
        var date = new Date().getDay() + "-" + new Date().getMonth() + "-" + new Date().getFullYear()

        if((okMouse.enabled == false && crossMouse.enabled == true) || (okMouse.enabled == true && crossMouse.enabled == false)){
            controller.addNewAttendance(name,date,presence)
        }
        else if(okMouse.enabled == false){
            crossMouse.enabled = true
            controller.updatePresenceByDateAndStudentId(name,date,presence)
        }
        else if(crossMouse.enabled == false){
            okMouse.enabled = true
            controller.updatePresenceByDateAndStudentId(name,date,presence)
        }


        //controller.callStudentUpdateSignale(listView.currentIndex)
    }
}

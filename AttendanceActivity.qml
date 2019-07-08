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

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ebfffa" }
            GradientStop { position: 0.3; color: "#c6fce5" }
            GradientStop { position: 0.6; color: "#6ef3d6" }
            GradientStop { position: 1.0; color: "#0dceda" }
        }
    }

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
                            var date = new Date().getDate() + "-" +
                                    ( new Date().getMonth()+1) + "-" +
                                    new Date().getFullYear();
                           // console.log("cross " + new Date().getDate())
                            if( okMouse.enabled == true){
                                controller.addNewAttendance(studentName.text,date,0);
                            }
                            else if(okMouse.enabled == false){
                                controller.updatePresenceByDateAndStudentId(studentName.text,date,0);
                                okMouse.enabled = true;
                            }

                            //controller.callStudentUpdateSignale(listView.currentIndex)
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
                            enabled = false
                            var date = new Date().getDate() + "-" +
                                    (new Date().getMonth()+1) + "-" +
                                    new Date().getFullYear();

                            if( crossMouse.enabled == true){
                                controller.addNewAttendance(studentName.text,date,1);
                            }
                            else if(crossMouse.enabled == false){
                                controller.updatePresenceByDateAndStudentId(studentName.text,date,1);
                                crossMouse.enabled = true;
                            }

                            //controller.callStudentUpdateSignale(listView.currentIndex)
                        }
                    }
                }

            }

        }

    }

}

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
                onClicked: menu.open()
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
                    source: crossMouse.pressed? "qrc:/icon/icons/pressedCross.png" : "qrc:/icon/icons/cross.png"
                    MouseArea{
                        id:crossMouse
                        anchors.fill: parent
                        onClicked: {
                            var date = new Date().getDay() + "-" + new Date().getMonth() + "-" + new Date().getFullYear()
                            controller.addNewAttendance(studentName.text,date,0)
                            controller.callStudentUpdateSignale(listView.currentIndex)
                        }
                    }
                }

                Image {
                    id: ok
                    width: 30
                    height: 30
                    source: okMouse.pressed? "qrc:/icon/icons/pressedOk.png" : "qrc:/icon/icons/ok.png"
                    MouseArea{
                        id:okMouse
                        anchors.fill: parent
                        onClicked: {
                            var date = new Date().getDay() + "-" + new Date().getMonth() + "-" + new Date().getFullYear()
                            console.log(date)
                            controller.addNewAttendance(studentName.text,date,1)
                            controller.callStudentUpdateSignale(listView.currentIndex)
                        }
                    }
                }

            }

        }
    }

}

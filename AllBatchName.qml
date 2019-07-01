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
                    load.source = "qrc:/Dashboard.qml"
                }
            }
            Label {
                text: "Select a batch"
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
        x: 18
        y: 83
        width: 324
        height: 518
        model: ["batch","name"]
        Component.onCompleted: {
            controller.setBatchList(listView)
            controller.callUpdateSignal()
        }
        delegate: Item {
            x: 5
            width: parent.width - 40
            height: 60
            Text {
                id: batchName
                text: modelData
                font.weight: Font.Thin
                font.pointSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    controller.getBatchNameForAttendence(batchName.text)
                    load.source = "qrc:/AttendanceActivity.qml"
                }
            }
        }
    }


}

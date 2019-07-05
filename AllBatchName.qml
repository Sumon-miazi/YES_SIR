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

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#48466d" }
            GradientStop { position: 0.3; color: "#3d84a8" }
            GradientStop { position: 0.6; color: "#46cdcf" }
            GradientStop { position: 1.0; color: "#abedd8" }
        }
    }

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
            }
        }
    }

    ListView {
        id: listView
        y: 70
        clip: true
        x :(parent.width/2) - (width/2)
        width: parent.width - 40
        height: 530
        model: ["batch","name"]
        Component.onCompleted: {
            controller.setBatchList(listView)
            controller.callUpdateSignal()
        }
        delegate: Rectangle {
            height: 50
            width: parent.width
            color: index % 2 == 0 ? "#e8f0fc" : "white"
            Text {
                id: batchName
                padding: 10
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

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    id: root
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
                text: "Add Student"
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

    TextField {
        id: studentName
        x: 20
        y: 154
        width: parent.width - 40
        height: 40
        placeholderText: "Enter Student name"
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: addStudantBtn
        x: 130
        y: 514
        text: qsTr("ADD STUDEN")
    }

    TextField {
        id: rollNo
        x: 20
        y: 200
        width: parent.width - 40
        height: 40
        placeholderText: "Enter Roll no"
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
            id: caption
            y: 264
            text: "Select Batch"
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            anchors.top: caption.bottom
            anchors.topMargin: 6
            anchors.horizontalCenter: parent.horizontalCenter
            height: 48
            width: parent.width - 40
            color: "black"
            anchors.horizontalCenterOffset: 0
            ListView {
                id: list
                anchors.fill: parent
                highlightRangeMode: ListView.StrictlyEnforceRange
                preferredHighlightBegin: height/3
                preferredHighlightEnd: height/3
                clip: true
                model: 64
                delegate: Text {
                    font.pixelSize: 18;
                    color: "white";
                    text: index;
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF000000" }
                    GradientStop { position: 0.2; color: "#00000000" }
                    GradientStop { position: 0.8; color: "#00000000" }
                    GradientStop { position: 1.0; color: "#FF000000" }
                }
            }
        }


}

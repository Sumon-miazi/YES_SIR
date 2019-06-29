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
                text: "Add Batch"
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
        id: batchname
        x: 20
        y: 98
        width: parent.width - 40
        height: 40
        placeholderText: "Enter batch name"
        horizontalAlignment: Text.AlignHCenter

    }

    Button {
        id: button
        x: 130
        y: 194
        text: qsTr("ADD BATCH")
        onClicked: {
            controller.addNewBatch(batchname.text)
            batchname.text = ""
        }
    }

    ListView {
        id: listView
        x: 20
        y: 287
        width: parent.width - 40
        height: 280

        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }

        delegate: Item {
            x: 5
            width: 80
            height: 50
            Text {
                text: name
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }


}
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
            controller.callUpdateSignal();
            batchname.text = ""
        }
    }

    ListView {
        id: listView
        y: 287
        width: parent.width
        height: 280

        model: ["asd","asdf"]
        Component.onCompleted:{
            controller.setBatchList(listView)
            controller.callUpdateSignal();
        }

        delegate: Rectangle {
            width: parent.width
            height: 50
            color: index % 2 == 0 ? "#e8f0fc" : "white"
            Text {
                id:batchName
                padding: 10
                text: modelData
                font.weight: Font.Thin
                font.pointSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }
            Image {
                id: cross
                width: 30
                height: 30
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                source: crossMouse.pressed? "qrc:/icon/icons/pressedDelete.png" : "qrc:/icon/icons/delete.png"
                MouseArea{
                    id:crossMouse
                    anchors.fill: parent
                    onClicked: {
                        controller.deleteBatchByName(batchName.text)
                        controller.callUpdateSignal()
                    }
                }
            }
        }
    }


}

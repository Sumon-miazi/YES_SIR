import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    id: batchRoot
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
                text: "Batch Activity"
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
        x: (parent.width/2) - (width/2)
        y: 70
        width: parent.width - 40
        height: 360
        clip: true

        model: ["asd","asdf"]
        Component.onCompleted:{
            controller.setBatchList(listView)
            controller.callUpdateSignal();
        }

        delegate: Rectangle {
            width: parent.width
            height: 50
            color: index % 2 == 0 ? "#e8f0fc" : "#FFF"
            Text {
                id:batchNameText
                leftPadding: 20
                text: modelData
                font.weight: Font.Thin
                font.pointSize: 16
                anchors.verticalCenter: parent.verticalCenter

                MouseArea{
                    anchors.fill: parent
                    onPressAndHold: {
                        console.log("long clicked")
                        popup.open()
                    }
                }
            }
            Image {
                id: cross
                width: 30
                height: 30
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                source: crossMouse.pressed? "qrc:/icon/icons/pressedDelete.png" : "qrc:/icon/icons/delete.png"
                MouseArea{
                    id:crossMouse
                    anchors.fill: parent
                    onClicked: {
                        controller.deleteBatchByName(batchNameText.text)
                        controller.callUpdateSignal()
                    }
                }
            }
            Popup {
                    id: popup
                    x: (batchRoot.width / 2) - (popup.width/2)
                    y: 100 //(batchRoot.height / 2) -(popup.height/2)
                    width: (batchRoot.width - 40)
                    height: 300
                    modal: true
                    focus: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                    Column{
                        id: column2
                        Material.background: Material.White
                        Material.elevation: 2
                        anchors.centerIn: parent
                        spacing: 16
                        Text {
                            id: title2
                            text: qsTr("Update Batch Name")
                            font.bold: true
                            font.pointSize: 16
                            anchors.topMargin: -20
                            color: "#666"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        TextField {
                            id: newBatchName
                            width: customBg.width - 20
                            height: 40
                            placeholderText: "Enter batch name"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Button {
                            id: updateButton
                            text: qsTr("UPDATE BATCH")
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                controller.updateBatchName(batchNameText.text,newBatchName.text)
                                controller.callUpdateSignal();
                                popup.close()
                            }
                        }
                    }
             }
        }
    }

    Pane {
        y: 439
        id: customBg
        x: (parent.width/2) - (width/2)
        Material.background: "#393e46"
        Material.elevation: 2
        //anchors.fill: parent
        width: parent.width - 40
        height: 180

        Column{
            id: column
            anchors.centerIn: parent
            spacing: 16
            TextField {
                id: batchname
                width: customBg.width - 20
                height: 40
                color: "#FFF"
                placeholderTextColor: "#FFF"
                placeholderText: "Enter batch name"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                id: addButton
                text: qsTr("ADD BATCH")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    controller.addNewBatch(batchname.text)
                    controller.callUpdateSignal();
                    batchname.text = ""
                }
            }
        }

    }

}

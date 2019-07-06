import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    id:allBatchRoot
    visible: true
    width: 360
    height: 640
    Material.theme: Material.Light
    Material.accent: Material.Purple

    property string txt: txt
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
                onPressAndHold: {
                    txt = batchName.text
                    popup.open()
                }
            }
        }
        Popup {
                id: popup
                x: (allBatchRoot.width / 2) - (popup.width/2 + 20)
                y: (allBatchRoot.height - height) / 2 -40
                width: (allBatchRoot.width - 40)
                height: 300
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                Column{
                    id: column2
                    Material.background: Material.White
                    Material.elevation: 2
                    anchors.centerIn: parent
                    spacing: 16
                    Text {
                        id: title2
                        text: qsTr("Delete Batch Attendance")
                        font.bold: true
                        font.pointSize: 16
                        anchors.topMargin: -20
                        color: "#666"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    ComboBox {
                        id: comboBox
                        width: popup.width - 20
                        height: 54
                        wheelEnabled: true
                        focusPolicy: Qt.StrongFocus
                        anchors.horizontalCenter: parent.horizontalCenter
                        Component.onCompleted:{
                            controller.setMonthList(comboBox)
                            controller.getAllMonth();
                        }
                    }

                    Button {
                        id: updateButton
                        text: qsTr("DELETE ATTENDANCE")
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            console.log(txt +" "+ comboBox.currentText)
                            controller.deleteBatchAttendanceByMonthName(txt,comboBox.currentText)
                            popup.close()
                        }
                    }
                }
         }
    }
}

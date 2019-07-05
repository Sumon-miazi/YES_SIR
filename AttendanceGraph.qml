import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtCharts 2.3

Rectangle {
    id:attendanceRoot
    visible: true
    width: 360
    height: 640
    color: "#95adbe"
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
                text: "Attendace Graph"
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
    ComboBox {
        id: comboBox
        x: (parent.width / 2) - (width/2)
        y: 60
        width: 320
        height: 54
        wheelEnabled: true
        focusPolicy: Qt.StrongFocus
        Component.onCompleted:{
            controller.setBatchList(comboBox)
            controller.callUpdateSignal();
        }
        onCurrentTextChanged:{
            controller.getBatchNameForAttendence(comboBox.currentText)
            controller.callStudentUpdateSignale(-1)


        }
    }
    /*
    Component.onCompleted: {
        // You can also manipulate slices dynamically, like append a slice or set a slice exploded
        pieSeries.append("Others", 52.0);
        pieSeries.find("Volkswagen").exploded = true;
    }
*/

    ListView {
        id: listViewOfStudent
        x: 0
        y: 128
        height: 500
        clip: true
        width: parent.width
        model:["Student", "name"]
        Component.onCompleted: {
            controller.setStudentList(listViewOfStudent)
        }

        delegate:ChartView {
            id: chart
            title: "Student Name"
            width: parent.width
            height: 200
            backgroundColor: index % 2 == 0 ? "#e8f0fc" : "white"
            legend.alignment: Qt.AlignLeft
            antialiasing: true

            PieSeries {
                id: pieSeries
                PieSlice { label: "Presence"; value: 13.5; exploded: true }
                PieSlice { label: "Absence"; value: 53.5 }
            }
        }
    }
}

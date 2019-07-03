import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtCharts 2.3

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
    }
    /*
    ChartView {
        id: chart
        title: "Student Name"
        width: parent.width
        height: 400
        anchors.verticalCenterOffset: 46
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        legend.alignment: Qt.AlignBottom
        antialiasing: true

        PieSeries {
            id: pieSeries
            PieSlice { label: "Volkswagen"; value: 13.5 }
        }
    }

    Component.onCompleted: {
        // You can also manipulate slices dynamically, like append a slice or set a slice exploded
        pieSeries.append("Others", 52.0);
        pieSeries.find("Volkswagen").exploded = true;
    }

    ListView {
        id: listView
        y: 100
        width: parent.width
        height: 518
        model: ListModel{
            ListElement{name:"sumon miazi"}
            ListElement{name:"sumon"}
        }

        delegate: Item {
            width: parent.width
            height: 200
            ChartView {
                        title: name

                        backgroundColor: "#666"
                        anchors.verticalCenterOffset: 46
                        anchors.horizontalCenterOffset: 0
                        anchors.centerIn: parent
                        legend.alignment: Qt.AlignBottom
                        antialiasing: true

                        PieSeries {
                            PieSlice { label: "Volkswagen"; value: 13.5 }
                        }
                    }
        }
    }

*/

}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

Item {

    Column{
        id: grid
        y: 200
        visible: true
        height: root.height * .68
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 20

        RowLayout{
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Cardview{
                width: root.width * .4
                height: grid.height * .45
                labelText: qsTr("Batch Settings")
                elevation: mouseArea.pressed? 1 : 4
                mouseArea.onClicked: {
                    console.log("Batch Settings clicked")
                    load.source = "qrc:/AddBatchActivity.qml"
                }
            }
            Cardview{
                width: root.width * .4
                height: grid.height * .45
                labelText: qsTr("Student Settings")
                elevation: mouseArea.pressed? 1 : 4
                mouseArea.onClicked: {
                    console.log("Student Settings clicked")
                    load.source = "qrc:/AddStudentActivity.qml"
                }
            }
        }
        RowLayout{
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Cardview{
                width: root.width * .4
                height: grid.height * .45
                labelText: qsTr("Attendance Graph")
                elevation: mouseArea.pressed? 1 : 4
                mouseArea.onClicked: {
                    console.log("Attendance Graph clicked")
                    load.source = "qrc:/AttendanceGraph.qml"
                }

            }
            Cardview{
                width: root.width * .4
                height: grid.height * .45
                labelText: qsTr("Attendance")
                elevation: mouseArea.pressed? 1 : 4
                mouseArea.onClicked: {
                    console.log("Attendance clicked")
                    load.source = "qrc:/AllBatchName.qml"
                }
            }
        }

    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640
    Material.theme: Material.Light
    Material.accent: Material.Purple


    Column{
        id: grid
        y: 200
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
                elevation: mouseArea.pressed? 1 : 4

            }
            Cardview{
                width: root.width * .4
                height: grid.height * .45
                labelText: qsTr("Add Batch")
                elevation: mouseArea.pressed? 1 : 4
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
            }
            Cardview{
                width: root.width * .4
                height: grid.height * .45
                labelText: qsTr("Attendance")
                elevation: mouseArea.pressed? 1 : 4
            }
        }

    }
}







































































/*##^## Designer {
    D{i:1;anchors_height:362;anchors_width:300;anchors_x:0;anchors_y:138}
}
 ##^##*/

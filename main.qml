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


    Loader{
        id:load
        anchors.fill: parent
        source: "qrc:/Dashboard.qml"
    }
}







































































/*##^## Designer {
    D{i:1;anchors_height:362;anchors_width:300;anchors_x:0;anchors_y:138}
}
 ##^##*/

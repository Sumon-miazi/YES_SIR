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

    color: "#999"

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FED4EE" }
            GradientStop { position: 0.3; color: "#F9D4FE" }
            GradientStop { position: 0.6; color: "#E4D4FE" }
            GradientStop { position: 1.0; color: "#D4D9FE" }
        }
    }
    Image {
        id: logo
        x: 30
        y: 31
        width: 300
        height: 110
        source: "qrc:/icon/icons/logo.png"
    }

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

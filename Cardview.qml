import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.3

Rectangle {
    id:root
    property alias imageSource: image.source
    property alias rectangleColor: rectangle.color
    property alias labelText: label.text
    property alias mouseArea: mouseArea
    property int elevation: elevation
    visible: true
    Material.theme: Material.Light
    Material.accent: Material.Purple
    radius: 5


    Pane {
        id: custom_btn
        contentHeight: 0
        focusPolicy: Qt.TabFocus
        Material.background: Material.White
        Material.elevation: elevation
        anchors.fill: parent

        Column{
            id: column
            anchors.centerIn: parent
            spacing: 16
            Image {
                id: image
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.width < root.height ? root.width * .5  : root.height * .5
                height: width
                source: "qrc:/icon/icons/student.png"
            }

            Rectangle{
                id: rectangle

                width: root.width - 10
                height: 1
                color: "#0E9199"

            }
            Label{
                id: label
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Add Student"
                font.pointSize: 8
            }
        }
    }
    MouseArea{
        id: mouseArea
        anchors.fill: parent
    }
}



















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

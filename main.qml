import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    visible: true

    Material.theme: Material.Light
    Material.accent: Material.Purple

    Column {
        anchors.centerIn: parent

        RadioButton { text: qsTr("Small") }
        RadioButton { text: qsTr("Medium");  checked: true }
        RadioButton { text: qsTr("Large") }
        Button {
            width: 120
            height: 120
            text: qsTr("Button")
            highlighted: true
            Material.accent: Material.Orange
        }
        Button {
            text: qsTr("Button")
            highlighted: true
            Material.background: Material.Teal

        }
        Pane {
            width: 120
            height: 120
            Material.background: Material.Orange
            Material.elevation: 6

            Label {
                id: txt
                text: qsTr("I'm a card!")
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    txt.text = "SUmon"
                }
                onDoubleClicked: {
                    txt.text = qsTr("I'm a card!")
                }
            }
        }
    }
}

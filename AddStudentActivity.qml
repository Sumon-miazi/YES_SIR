import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    visible: true
    width: 360
    height: 640
    Material.theme: Material.Light
    Material.accent: Material.Purple

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#e3fdfd" }
            GradientStop { position: 0.3; color: "#cbf1f5" }
            GradientStop { position: 0.6; color: "#a6e3e9" }
            GradientStop { position: 1.0; color: "#71c9ce" }
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
                text: "Student's Activity"
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

    TextField {
        id: studentName
        x: 20
        y: 154
        width: parent.width - 40
        height: 40
        placeholderText: "Enter Student name"
        horizontalAlignment: Text.AlignHCenter
    }

        TextField {
            id: rollNo
            x: (parent.width / 2) - (width/2)
            y: 200
            width: parent.width - 40
            height: 40
            placeholderText: "Enter Roll no"
            inputMethodHints: Qt.ImhDigitsOnly
            horizontalAlignment: Text.AlignHCenter
        }

    Text {
            id: caption
            x: (parent.width / 2) - (width/2)
            y: 264
            text: "Select Batch"
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ComboBox {
            id: comboBox
            x: (parent.width / 2) - (width/2)
            y: 287
            width: 320
            height: 54
            wheelEnabled: true
            focusPolicy: Qt.StrongFocus
            Component.onCompleted:{
                controller.setBatchList(comboBox)
                controller.callUpdateSignal();
            }
        }
        Button {
            id: addStudantBtn
            x: (parent.width / 2) - (width/2)
            y: 514
            text: qsTr("ADD STUDEN")
            focusPolicy: Qt.TabFocus
            onClicked: {
              //  console.log(comboBox.currentText)
                controller.addNewStudent(studentName.text,rollNo.text,comboBox.currentText)
                studentName.text = ""
                rollNo.text = ""
            }
        }

        Switch {
            id: switchActivity
            x: 8
            y: 56
            text: qsTr("Change Activity")

            onCheckedChanged: changeActivity(switchActivity.checked)
        }

        ComboBox {
            id: batchNameBox
            x: (parent.width / 2) - (width/2)
            y: 287
            width: 320
            height: 54
            visible: false
            wheelEnabled: true
            focusPolicy: Qt.StrongFocus
            Component.onCompleted:{
                controller.setBatchList(batchNameBox)
                controller.callUpdateSignal()

            }
            onCurrentTextChanged:{
             //   console.log(batchNameBox.currentText)
                controller.getBatchNameForAttendence(batchNameBox.currentText)
                controller.callStudentUpdateSignale(-1)
            }
        }

        ComboBox {
            id: studentNameBox
            x: (parent.width / 2) - (width/2)
            y: 356
            visible: false
            width: 320
            height: 54
            wheelEnabled: true
            focusPolicy: Qt.StrongFocus
            Component.onCompleted:{
                controller.setStudentList(studentNameBox)
            }
        }

        Button {
            id: deleteBtn
            visible: false
            x: (parent.width / 2) - (width/2)
            y: 514
            text: qsTr("DELETE STUDENT")

            onClicked:{
               // console.log(studentNameBox.currentText)
                controller.deleteStudentByName(studentNameBox.currentText)
                controller.callStudentUpdateSignale(studentNameBox.currentIndex)
            }
        }


        function changeActivity(flag){
            var addStudentGroup = [studentName,rollNo,caption,comboBox,addStudantBtn];
            var deleteStudentGroup = [batchNameBox,studentNameBox,deleteBtn]

            if(switchActivity.checked){
                addStudentGroup.forEach(function(entry) {
                     entry.visible = false
                });
                deleteStudentGroup.forEach(function(entry) {
                    entry.visible = true
                });
            }
            else{
                addStudentGroup.forEach(function(entry) {
                     entry.visible = true
                });
                deleteStudentGroup.forEach(function(entry) {
                    entry.visible = false
                });
            }
        }
}





/*##^## Designer {
    D{i:6;invisible:true}D{i:10;invisible:true}D{i:8;invisible:true}D{i:7;invisible:true}
}
 ##^##*/

import TiltyRocket 1.0

import QtQuick 2.0
import QtQuick.Controls 1.4

import "content"
import "databaseManager.js" as TestMode

ApplicationWindow
{
    id: tiltyRocketAppWindow
    visible: true
    width: 720
    height: 1280

    Rectangle
    {
        id: homeWindow
        anchors.centerIn: parent
        anchors.fill: parent

        anchors.rightMargin: if(parent.width > 0.6 * parent.height){(parent.width - 0.6 * parent.height)/2} else {0}
        anchors.leftMargin: if(parent.width > 0.6 * parent.height){(parent.width - 0.6 * parent.height)/2} else {0}

        visible: true

        // This rectange is the a overlay to partially show the parent through it
        // and clicking outside of the 'dialog' popup will do 'nothing'
        Rectangle
        {
            anchors.fill: parent
            id: overlay
            color: "#000000"
            opacity: 0.6
            // add a mouse area so that clicks outside
            // the dialog window will not do anything
            MouseArea
            {
                anchors.fill: parent
            }
        }

        // This rectangle contains the menu
        Rectangle
        {
            id: menuWindow
            width: parent.width * 0.75
            height: parent.height - 50
            radius: 10
            anchors.centerIn: parent

            property real buttonHeight: menuWindow.height * 0.05;
            property real buttonWidth: menuWindow.width * 0.6;

            Rectangle
            {
                id: titleBox
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50

                width: parent.width - 200
                height: parent.height/8
                Image
                {
                    anchors.fill:parent
                    source: "images/resources/title.jpg"
                }
            }
            Button
            {
                id: arcadeModeButton
                width: menuWindow.buttonWidth
                height: menuWindow.buttonHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: titleBox.bottom
                anchors.topMargin: arcadeModeButton.height
                text: qsTr("Arcade Mode")
                visible: true

                onClicked:
                {
                    Qt.createComponent("main.qml").createObject(home, {});
                    homeWindow.visible = false;
                }
            }

            Button
            {
                id: settingsButton
                width: menuWindow.buttonWidth
                height: menuWindow.buttonHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: arcadeModeButton.bottom
                anchors.topMargin: settingsButton.height
                text: qsTr("Settings")
                visible: true

                onClicked:
                {

                }
            }
            Button
            {
                id: aboutButton
                width: menuWindow.buttonWidth
                height: menuWindow.buttonHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: settingsButton.bottom
                anchors.topMargin: aboutButton.height
                text: qsTr("About")
                visible: true

                onClicked:
                {
//                    nameInputDialog.showWithInput("Name: ");
                }
            }
        } /*menuWindow*/
        /*Testing */
//        Dialog
//        {
//            id: nameInputDialog
//            anchors.centerIn: parent
//            z: 100

//            onClosed:
//            {
//                TestMode.saveHighScore(nameInputDialog.inputText);
//            }
//        }
//        Text
//        {
//            id: leaderboard
//            anchors.top: aboutButton.bottom
//            anchors.right: parent.horizontalCenter
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignRight
//        }
        /*Testing */
    }/*homeWindow*/
} /*home*/
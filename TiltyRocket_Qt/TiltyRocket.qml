import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtSensors 5.0

import "content"
import "databaseManager.js" as TestManager
import "itemCreation.js" as TestCreator
import "TiltyRocket.js" as TestTiltyScripts

import TiltyRocket 1.0

ApplicationWindow
{
    id: home
    visible: true
    width: 720
    height: 1280

    property bool gameOver: true

    //    property var highNames : ["","","","","","","","","",""]
    //    property var highScores: [ 200, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    //    property alias scoreText: scoreCol.text
    //    property int score : 100
    //    property alias aboutBottom: aboutButton.bottom

    Rectangle
    {
        id: homeWindow
        anchors.centerIn: parent
        anchors.fill: parent

        property real aspectRatio: 3/4
        anchors.rightMargin: if(parent.width > aspectRatio * parent.height){(parent.width - aspectRatio * parent.height)/2} else {0}
        anchors.leftMargin: if(parent.width > aspectRatio * parent.height){(parent.width - aspectRatio * parent.height)/2} else {0}

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
                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: menuWindow.buttonWidth
                        implicitHeight: menuWindow.buttonHeight
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#888"
                        radius: 4
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                        }
                    }
                }

                onClicked:
                {
                    console.log("Entering ArcadeMode")
                    Qt.createComponent("content/ArcadeMode.qml").createObject(home, {});
                    homeWindow.visible = false;
                    console.log("Closing Menu")
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
                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: menuWindow.buttonWidth
                        implicitHeight: menuWindow.buttonHeight
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#888"
                        radius: 4
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                        }
                    }
                }

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
                //anchors.top: settingsButton.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: aboutButton.height
                text: qsTr("About")
                visible: true


                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: menuWindow.buttonWidth
                        implicitHeight: menuWindow.buttonHeight
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#888"
                        radius: 4
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                        }
                    }
                }

                onClicked:
                {
                    gameOver = !gameOver;
                }
            }
        } /*menuWindow*/
    }/*homeWindow*/

    World
    {
        id: newWorld
        numXpos: 20
        numYpos: 20
    }

    Rectangle
    {
        id: rootWorld
        height: parent.height/2
        width: height

        property real windowCenterX: parent.width/2
        property real windowCenterY: parent.height/2
        property real worldCenterX: x + rootWorld.width/2
        property real worldCenterY: y + rootWorld.height/2

        property real worldTop: y
        property real worldBottom: y + height
        property real worldLeft: x
        property real worldRight: x + width


        x:
        {
//            if(rootWorld.worldRight <= windowCenterX)
//            {
//                return rootWorld.x
//            }
//            else
//            {
                return gameOver ? (windowCenterX) - (rootWorld.width/2) : rootWorld.x + accel.changeInX
//            }
        }
        y:
        {
            if(rootWorld.worldTop >= windowCenterY)
            {
                return
            }
            else
            {
                return gameOver ? (windowCenterY) - (rootWorld.height/2) : rootWorld.y + accel.changeInY
            }
        }

        border.width: 5
        border.color: "magenta"
    }

    Accelerometer
    {
        id: accel

        property real changeInX
        property real changeInY
        dataRate: 100
        //! [1]
        //! [2]
        active:true
        //! [2]

        //! [3]
        onReadingChanged:
        {
            changeInX = (TestTiltyScripts.calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            changeInY = (TestTiltyScripts.calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
        }
        //! [3]
    }

} /*home*/

/*Testing */
//    Repeater
//    {
//        id: asteroidRepeater

//        model: 10
//        anchors.fill: parent
//        Asteroid {x: Math.random() * parent.width; y:0; mouseAngle: 0 }
//    }
//Rectangle
//{
//    id: leaderBoard
//    anchors.verticalCenter: parent.verticalCenter
//    anchors.top: aboutBottom
//    width: parent.width

//    Text
//    {
//        id: playerCol
//        horizontalAlignment: Text.AlignLeft
//        anchors.left: parent.left
//        anchors.top: parent.top
//        /*for some reason, I cannot set this or any monospaced font*/
//        //font.family: "FixedSys"
//        text: " 1. " + highNames[ 0] + "\n" +
//              " 2. " + highNames[ 1] + "\n" +
//              " 3. " + highNames[ 2] + "\n" +
//              " 4. " + highNames[ 3] + "\n" +
//              " 5. " + highNames[ 4] + "\n" +
//              " 6. " + highNames[ 5] + "\n" +
//              " 7. " + highNames[ 6] + "\n" +
//              " 8. " + highNames[ 7] + "\n" +
//              " 9. " + highNames[ 8] + "\n" +
//              "10. " + highNames[ 9] + "\n"
//    }
//    Text
//    {
//        id: scoreCol
//        horizontalAlignment: Text.AlignRight
//        anchors.right: parent.right
//        anchors.top: parent.top
//        /*for some reason, I cannot set this or any monospaced font*/
//        //font.family: "FixedSys"
////            text: highScores[ 0] + "\n" +
////                  highScores[ 1] + "\n" +
////                  highScores[ 2] + "\n" +
////                  highScores[ 3] + "\n" +
////                  highScores[ 4] + "\n" +
////                  highScores[ 5] + "\n" +
////                  highScores[ 6] + "\n" +
////                  highScores[ 7] + "\n" +
////                  highScores[ 8] + "\n" +
////                  highScores[ 9] + "\n"
//    }
//}

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

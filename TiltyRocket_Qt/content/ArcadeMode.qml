import QtQuick 2.3
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.2
import QtSensors 5.0

import "../content"
//import "Asteroid.qml"
//import "Dialog.qml"
//import "ScoreBoard.qml"

import "../itemCreation.js" as Creator
import "../TiltyRocket.js" as TiltyRocket
import "../databaseManager.js" as ScoreManager

Rectangle
{
    id: arcadeWindow
    anchors.centerIn: parent
    anchors.fill: parent

    anchors.rightMargin: if(parent.width > 0.6 * parent.height){(parent.width - 0.6 * parent.height)/2} else {0}
    anchors.leftMargin: if(parent.width > 0.6 * parent.height){(parent.width - 0.6 * parent.height)/2} else {0}
    visible: true

    property int activeAsteroids: 0
    property int startingAsteroids: 10
    property int totalAsteroids: startingAsteroids + additionalAsteroids

    property int  score: 0
    property double additionalAsteroids: gameOver ? 0 : Math.floor(score/100)

    property bool debugMode: false
    property bool gameOver: false

    property alias rocketX: redRocket.x
    property alias rocketY: redRocket.y
    property alias rocketWidth: redRocket.width
    property alias rocketHeight: redRocket.height
    property alias rocketMargin: redRocket.rocketMargin

    property alias leaderBoard: scoreBoard.leaderBoard

    // property alias mouseModeRate: gameModeMouse.mouseRate
    onGameOverChanged:
    {
        if(!gameOver) /* Create more asteroids */
        {
            console.log("Creating Asteroid")

            var i
            for(i=0;i<arcadeWindow.startingAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
        else /* Display the score board */
        {
            console.log("Game Over: Rocket Asteroid Collision")
            scoreBoard.visible = true;
            TiltyRocket.displayScoreBoard();
        }
    }

    onAdditionalAsteroidsChanged:
    {
        if(!gameOver)
        {
            var i
            for(i=activeAsteroids;i<totalAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
        //console.log("Active Asteroids: " + activeAsteroids +"    Total Asteroids: "+totalAsteroids + additionalAsteroids)
    }

    Rectangle
    {
        id: redRocket
        width: arcadeWindow.width/5
        height: redRocket.width * 2
        smooth: true

        property real centerX: arcadeWindow.width / 2
        property real centerY: arcadeWindow.height / 2
        property real redRocketCenter: redRocket.width / 2
        property real rocketMargin: redRocket.width /3
        x: centerX - redRocketCenter
        y: arcadeWindow.height - (redRocket.height + redRocket.width/4)

        /**** Debuging ****/
        Rectangle
        {
            anchors.fill: redRocket
            anchors.leftMargin: parent.rocketMargin-35
            anchors.rightMargin: parent.rocketMargin-35

            anchors.onFillChanged: anchors.fill = redRocket
            border.width: 5
            border.color: "magenta"

            MouseArea
            {
                anchors.fill: parent

                onClicked: arcadeWindow.gameOver = true
            }
        }
        /**** Debuging ****/

        //onRotationChanged: console.log(activeAsteroids)
        Accelerometer
        {
            id: rocketAccel
            dataRate: 100
            active: true

            function calcRoll(x,y,z)
            {
                return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
            }
            onReadingChanged:
            {

                var roll = (calcRoll(rocketAccel.reading.x, rocketAccel.reading.y, rocketAccel.reading.z)* 0.2)

                if(Math.abs(roll) < 0.2) /*create a small dead band */
                {
                    redRocket.rotation = redRocket.rotation;
                }
                else if(roll < 0)
                {
                    redRocket.rotation = redRocket.rotation < 45 ? redRocket.rotation - (roll ) : redRocket.rotation
                }
                else
                {
                    redRocket.rotation = redRocket.rotation > -45 ? redRocket.rotation - (roll ) : redRocket.rotation
                }
            }
        }
        AnimatedImage
        {
            anchors.fill: redRocket
            source: "../images/resources/JunkRocket.gif"
        }

        Behavior on y
        {
            SmoothedAnimation
            {
                easing.type: Easing.Linear
                duration: 100
            }
        }
        Behavior on x
        {
            SmoothedAnimation
            {
                easing.type: Easing.Linear
                duration: 100
            }
        }
    }
    onActiveAsteroidsChanged:
    {
        if(!gameOver)
        {
            if(activeAsteroids < totalAsteroids)
            {
                Creator.startDrop();
            }
        }
    }

    Text
    {
        id: currentScore
        color: "#431cf1"
        text: arcadeWindow.score;
    }

    Timer
    {
        id: timer
        interval: 100;
        running: true;
        repeat: true;
        onTriggered:
        {
            if(!arcadeWindow.gameOver && !blastOffButton.visible) arcadeWindow.score = arcadeWindow.score + (1);
            else arcadeWindow.score = arcadeWindow.score
        }
    }

    Button {
        id: blastOffButton
        anchors.bottom: redRocket.top
        anchors.bottomMargin: blastOffButton.height
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Blast Off!")
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
            var i = 0;
            blastOffButton.visible = false
            for(i=0;i<arcadeWindow.startingAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
    }
    ScoreBoard
    {
        id:scoreBoard
        visible: false

        Dialog
        {
            id: nameInputDialog
            anchors.centerIn: scoreBoard
            z: 100

            onClosed:
            {
                ScoreManager.saveHighScore(nameInputDialog.inputText);
            }
        }
    }

    //    MouseArea
    //    {
    //        id: gameModeMouse

    //        anchors.fill: parent
    //        hoverEnabled: true
    //        propagateComposedEvents: true

    //        property real mouseRate
    //        onPositionChanged:
    //        {
    //            mouseRate = (redRocket.centerX - gameModeMouse.mouseX) * 0.5;
    //            console.log(mouseRate);
    //        }
    //    }
}

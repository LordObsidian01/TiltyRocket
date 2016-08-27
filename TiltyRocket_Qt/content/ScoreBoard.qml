import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item
{
    id: scoreBoardPopup
    anchors.fill: parent

    property alias leaderBoard: leaderboard.text
    // Add a simple animation to fade in the popup
    // let the opacity go from 0 to 1 in 400ms
    PropertyAnimation { target: scoreBoardPopup; property: "opacity";
        duration: 400; from: 0; to: 1;
        easing.type: Easing.InOutQuad ; running: true }

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

    // This rectangle is the actual popup
    Rectangle
    {
        id: leaderBoardContainer
        width: parent.width * 0.75
        height: parent.height * 0.4
        radius: 10
        anchors.centerIn: parent

        Text
        {
            id: leaderBoardTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Leaderboard"
        }
        Text
        {
            id: leaderboard
            anchors.top: leaderBoardTitle.bottom
            anchors.right: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        Button
        {
            id: retry
            y: 21
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.02

            text: qsTr("Retry")

            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: menuWindow.buttonWidth*.75
                        implicitHeight: menuWindow.buttonHeight*.75
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
                gameOver = false
                score = 0
                scoreBoardPopup.visible = false
            }
        }

        Button
        {
            id: exit

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.02
            text: qsTr("Exit")

            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: menuWindow.buttonWidth*.75
                        implicitHeight: menuWindow.buttonHeight*.75
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
                scoreBoardPopup.destroy()
                arcadeWindow.destroy()
                homeWindow.visible = true;
            }
        }
    }
}

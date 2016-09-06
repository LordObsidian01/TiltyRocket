import QtQuick 2.0

Item
{
    id: rootRocket
    width: parent.width/5
    height: rootRocket.width * 2
    smooth: true

    property real rocketCenterX: rootRocket.x + rootRocket.width / 2
    property real rocketMargin: rootRocket.width /3
    property real tiltAngle

    transform: Rotation {
        origin.x: rootRocket.width/2;
        origin.y: rootRocket.height;
        axis { x: 0; y: 0; z: 1 }
        angle: rootRocket.tiltAngle
    }

    /**** Debuging ****/
    Rectangle
    {
        anchors.fill: rootRocket
        anchors.leftMargin: parent.rocketMargin-35
        anchors.rightMargin: parent.rocketMargin-35

        anchors.onFillChanged: anchors.fill = rootRocket
        color: "transparent"
        border.width: 5
        border.color: "magenta"
    }

    AnimatedImage
    {
        anchors.fill: rootRocket
        source: "../images/resources/JunkRocket.gif"
    }

    Behavior on rotation
    {
        SmoothedAnimation
        {
            easing.type: Easing.Linear
            duration: 100
        }
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

import QtQuick 2.0

Rectangle
{
    id: rootWorld
    objectName: "QmlWorld"
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


    x: (windowCenterX) - (rootWorld.width/2)
//        {
////            if(rootWorld.worldRight <= windowCenterX)
////            {
////                return rootWorld.x
////            }
////            else
////            {
////                return gameOver ? (windowCenterX) - (rootWorld.width/2) : rootWorld.x + accel.changeInX
////            }
//        }
    y: (windowCenterY) - (rootWorld.height/2)
//        {
////            if(rootWorld.worldTop >= windowCenterY)
////            {
////                return
////            }
////            else
////            {
////                return gameOver ? (windowCenterY) - (rootWorld.height/2) : rootWorld.y + accel.changeInY
////            }
//        }

    border.width: 5
    border.color: "magenta"

    Rectangle
    {
        width: parent.width/10
        height: parent.height/10
        x: parent.width/2
        y:0
        color: "Red"
    }
}

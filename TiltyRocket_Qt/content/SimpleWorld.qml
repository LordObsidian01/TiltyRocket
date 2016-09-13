import QtQuick 2.0
Item
{
    id: rootItem
    property real windowCenterX
    property real windowCenterY
    property real worldCenterX: x + rootItem.width/2
    property real worldCenterY: y + rootItem.height/2

    property real worldTop: y
    property real worldBottom: y + height
    property real worldLeft: x
    property real worldRight: x + width

    Rectangle
    {
        id: rootWorld
        objectName: "QmlWorld"


        anchors.fill: parent

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
}

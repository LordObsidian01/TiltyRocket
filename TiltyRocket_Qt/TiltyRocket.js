
.import QtQuick 2.0 as Quick

function promptPlayerName() {
    nameInputDialog.showWithInput("Name: ");
}

function calcPitch(x,y,z) {
    return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
}
function calcRoll(x,y,z) {
     return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
}

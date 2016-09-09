.import QtQuick 2.0 as Quick

var numXpositions = 10
var numYPositions = 20
var f = new Array(numXpositions);


function generateField() {
    for (i=0;i<numXpositions;i++) {
        f[i]=new Array(numYPositions);
        for (j=0;j<numYPositions;j++) {
            f[i][j]=0;
        }
    }
}

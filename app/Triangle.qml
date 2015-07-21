import QtQuick 2.0

Item {
    id : component
    width: 60
    height: 60
    clip : true
    // The index of corner for the triangle to be attached
    property alias color : rect.color
    property string borderColor :"#fff"

    Rectangle {
        width: 60
        height: 60
        id : rect
        x:0
        y: component.height-(component.height/5)
        color : component.color
        border.color: component.borderColor
        border.width:3
        clip: true
        antialiasing: true
        transformOrigin: Item.Center
        rotation : 45
        scale : 1
    }
}

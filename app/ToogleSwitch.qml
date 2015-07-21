import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    id: toggleswitch
    width: background.width; height: background.height
    property string leftL: "left";
    property string rightL: "right"
    property bool on: false

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off";
        else
            toggleswitch.state = "on";
    }

    function releaseSwitch() {
        if (knob.x == 1) {
            if (toggleswitch.state == "off") return;
        }
        if (knob.x == 78) {
            if (toggleswitch.state == "on") return;
        }
        toggle();
    }

    Rectangle {
        id: background
        color: "#fff"
        border.color:UbuntuColors.green
        width: units.gu(12)
        height:  units.gu(4)
        radius: units.gu(1)
        MouseArea { anchors.fill: parent; onClicked: toggle() }
    }
    Rectangle {
        id: knob
        x: 2; y:2
        color: UbuntuColors.green
        width: background.width/2
        height:  background.height - units.gu(0.5)
        radius: background.radius
        opacity: 0.8
        MouseArea {
            anchors.fill: parent
            drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: 1; drag.maximumX: 78
            onClicked: toggle()
            onReleased: releaseSwitch()
        }
    }
    Item{
        x: background.width/2+1; y:2
        width: background.width/2
        height:  background.height - units.gu(0.5)
        Label {
            id: labelL
            anchors.centerIn: parent.Center
            anchors.fill: parent
            text: rightL
            verticalAlignment: Text.AlignVCenter
            fontSize: "small"
            horizontalAlignment:Text.AlignHCenter
            color:UbuntuColors.green
        }
    }
    Item{
        x: 2; y:2
        width: background.width/2
        height:  background.height- units.gu(0.5)
        Label {
            id: labelR
            anchors.centerIn: parent.Center
            text: leftL
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            fontSize: "small"
            color:"#fff"
            horizontalAlignment:Text.AlignHCenter
        }
    }



    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: (background.width/2)-2 }
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges {target:labelL; color:"#fff"}
            PropertyChanges {target:labelR; color:UbuntuColors.green}

        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: 1 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges {target:labelL; color:UbuntuColors.green}
            PropertyChanges {target:labelR; color:"#fff"}

        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
         ColorAnimation { from: UbuntuColors.green; easing.type: Easing.InOutQuad; duration: 200 }

    }
}

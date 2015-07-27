import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 0.1

Page {
    id: bodyFatPage
    title: i18n.tr("Body Fat Calculator")

    Action {
        id: infoAction
        objectName:"infoButton"
        iconName: "info"
        text: i18n.tr("Information")
        onTriggered: {
            pageStack.push(infoPage,{content:"fat"});
        }
    }
    head {
        foregroundColor:"#fff"
        actions: [
            infoAction
        ]
    }


    LayoutMirroring.enabled: false
    Column {
        spacing: units.gu(1)
        anchors {
            margins: units.gu(2)
            topMargin: units.gu(8)
            fill: parent
        }
        Item{
            width: parent.width
            height: heightTextField.height
            Label{
                text :i18n.tr("Height")
                color: UbuntuColors.green
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:  heightTextField.left
                anchors.rightMargin:  units.gu(2)
            }
            TextField {
                id: heightTextField
                anchors.horizontalCenter: parent.horizontalCenter
                width:units.gu(10)
                validator:  DoubleValidator {}
                inputMethodHints:Qt.ImhFormattedNumbersOnly
            }
            ToogleSwitch{
                id: kgOrLbSwitch
                anchors.left:   heightTextField.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:   units.gu(1)
                leftL: i18n.tr("KG/CM")
                rightL: i18n.tr("IN/LB")
            }
        }
        Item{
            width: parent.width
            height: weightTextFiled.height
            Label{
                text :i18n.tr("Weight")
                color: UbuntuColors.green
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:  weightTextFiled.left
                anchors.rightMargin:  units.gu(2)
            }
            TextField {
                id: weightTextFiled
                width:units.gu(10)
                anchors.horizontalCenter: parent.horizontalCenter
                validator:  DoubleValidator {}
                inputMethodHints:Qt.ImhFormattedNumbersOnly
            }
            ToogleSwitch{
                id: genderSwitch
                anchors.left:  weightTextFiled.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:   units.gu(1)
                leftL: i18n.tr("Male")
                rightL: i18n.tr("Female")
            }
        }
        Item{
            width: parent.width
            height: waistTextField.height
            Label{
                text :i18n.tr("Waist")
                color: UbuntuColors.green
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:  waistTextField.left
                anchors.rightMargin:  units.gu(2)
            }
            TextField {
                id: waistTextField
                anchors.horizontalCenter: parent.horizontalCenter
                width:units.gu(10)
                validator:  DoubleValidator {}
                inputMethodHints:Qt.ImhFormattedNumbersOnly
            }
            Button {
                id: waistInfoButton
                iconName: "info"
                anchors.left:  waistTextField.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:   units.gu(1)
                width:units.gu(4)
                color: "#fff"
                onClicked: {
                    PopupUtils.open(popoverWaist, waistInfoButton)
                }
            }
            Component {
                id: popoverWaist
                Popover {
                    Item{
                        width:l.contentWidth
                        height: units.gu(5)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Label{
                            id: l
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment:Text.AlignHCenter
                            text: genderSwitch.on === true ? i18n.tr("Take the waist measurement\nat its narrowest point"):
                                                             i18n.tr("Take the waist measurement\nat the navel");
                        }
                    }
                }
            }

        }
        Item{
            width: parent.width
            height: hipTextField.height
            visible: genderSwitch.on
            Label{
                text :i18n.tr("Hip")
                color: UbuntuColors.green
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:  hipTextField.left
                anchors.rightMargin:  units.gu(2)
            }
            TextField {
                id: hipTextField
                anchors.horizontalCenter: parent.horizontalCenter
                width:units.gu(10)
                validator:  DoubleValidator {}
                inputMethodHints:Qt.ImhFormattedNumbersOnly
            }
            Button {
                id : hipInfoButton
                iconName: "info"
                anchors.left:  hipTextField.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:   units.gu(1)
                width:units.gu(4)
                color: "#fff"
                onClicked: {
                    PopupUtils.open(popoverHip, hipInfoButton);
                }
            }
            Component {
                id: popoverHip
                Popover {
                    Item{
                        width:l.contentWidth
                        height: units.gu(5)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Label{
                            id: l
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment:Text.AlignHCenter
                            text: i18n.tr("Take the hip measurement\nat its widest point");
                        }
                    }
                }
            }

        }
        Item{
            width: parent.width
            height: neckTextField.height
            Label{
                text :i18n.tr("Neck")
                color: UbuntuColors.green
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:  neckTextField.left
                anchors.rightMargin:  units.gu(2)
            }
            TextField {
                id: neckTextField
                anchors.horizontalCenter: parent.horizontalCenter
                width:units.gu(10)
                validator:  DoubleValidator {}
                inputMethodHints:Qt.ImhFormattedNumbersOnly
            }
            Button {
                id: neckInfoButton
                iconName: "info"
                anchors.left:  neckTextField.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:   units.gu(1)
                width:units.gu(4)
                color: "#fff"
                onClicked: {
                    PopupUtils.open(popoverNeck, neckInfoButton);
                }
            }
            Component {
                id: popoverNeck
                Popover {
                    Item{
                        width:l.contentWidth
                        height: units.gu(9)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Label{
                            id: l
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment:Text.AlignHCenter
                            text: i18n.tr("Take the neck measurement\nat its narrowest point.\nand with the tape sloping slightly\ndownward to the front.");
                        }
                    }
                }
            }

        }
        Button {
            objectName: "button"
            text: i18n.tr("Calculate")
            anchors.horizontalCenter: parent.horizontalCenter
            color: UbuntuColors.green
            onClicked: {
                getBodyFat(kgOrLbSwitch.on,parseFloat(heightTextField.text),parseFloat(weightTextFiled.text),genderSwitch.on,
                           parseFloat(waistTextField.text),parseFloat(hipTextField.text),parseFloat(neckTextField.text) );
            }
            function getBodyFat(lib,height,weight,gender,waist,hip,neck){
                if(weight>0 && height>0&&waist>0&&neck>0&&((gender==true&&hip>0)||gender==false)) {
                    var inc =1;
                    var kgOrLib = "kg"
                    if(lib){
                        inc =2.54;
                        kgOrLib = "lbs"
                    }
                    var r;
                    if(gender){
                        r=  495 /(1.29579-0.35004 *log10(waist*inc + hip*inc - neck*inc)+0.22100 * log10(height*inc)) - 450;
                    }else{
                        r=  495 /(1.0324-0.19077 *log10( waist*inc - neck*inc)+0.15456 * log10(height*inc)) - 450;
                    }
                    r =r.toFixed(1);
                    bodyFatR.text = r + "%";
                    setBodyFatCategory(Number(r),Number(gender));
                    var fatMass = ((r/100) * weight).toFixed();
                    fatMassR.text =fatMass +kgOrLib;
                    leanMassR.text = weight-fatMass  +kgOrLib;
                    return ;
                }
                return ;
            }
            function log10(val) {
                return Math.log(val) / Math.LN10;
            }

            function setBodyFatCategory(bf,gender){
                var arrV =[
                            [[5],[13],[17],[25]]
                            ,[[13],[20],[24],[31]]];
                var arrC =[i18n.tr("Essential Fat"),i18n.tr("Athletic"),
                           i18n.tr("Fit"),i18n.tr("Acceptable"),i18n.tr("Obese")];
                var color;
                var textColor;
                if(bf<arrV[gender][0]){
                    bodyFatS.text=arrC[0];
                    color =UbuntuColors.red;
                    textColor="#fff";
                }else if(bf>arrV[gender][0]&&bf<arrV[gender][1]){
                    bodyFatS.text=arrC[1];
                    color =Qt.darker(UbuntuColors.green);
                    textColor="#fff";
                }else if(bf>arrV[gender][1]&&bf<arrV[gender][2]){
                    bodyFatS.text=arrC[2];
                    color =UbuntuColors.green;
                    textColor="#fff";
                }else if(bf>arrV[gender][2]&&bf<arrV[gender][3]){
                    bodyFatS.text=arrC[3];
                    color =UbuntuColors.orange;
                    textColor="#fff";
                }else if(bf>arrV[gender][3]){
                    bodyFatS.text=arrC[4];
                    color =UbuntuColors.red;
                    textColor="#fff";
                }
                bodyFatIcon.color = textColor;
                bodyFatIcon.backgroundColor=color;

                fatMassIcon.color = textColor;
                fatMassIcon.backgroundColor=color;

                leanMassIcon.color = textColor;
                leanMassIcon.backgroundColor=color;
            }
        }
        Row{
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 3
            UbuntuShape {
                id: bodyFatIcon
                width: (parent.width/3)
                height: units.gu(10)
                backgroundColor: Theme.palette.normal.foreground
                radius: "small"
                Column{
                    anchors.centerIn: parent
                    Label {
                        anchors.topMargin: units.gu(1)
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: i18n.tr("Body Fat %")
                        fontSize: "large"
                        color: Theme.palette.normal.foregroundText
                    }

                    Label {
                        id:bodyFatR
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "0.0"
                        fontSize: "x-large"
                        color: Theme.palette.normal.foregroundText
                    }
                    Label { id:bodyFatS
                        anchors.topMargin: units.gu(1)
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: ""
                        fontSize: "medium"
                        color: Theme.palette.normal.foregroundText
                    }
                }
            }
            UbuntuShape {
                id: fatMassIcon
                width: (parent.width/3)
                height: units.gu(10)
                backgroundColor: Theme.palette.normal.foreground
                radius: "small"
                Column{
                    anchors.centerIn: parent
                    Label {
                        anchors.topMargin: units.gu(1)
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: i18n.tr("Fat Mass")
                        fontSize: "large"
                        color: Theme.palette.normal.foregroundText
                    }
                    Label {
                        id:fatMassR
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "0.0"
                        fontSize: "x-large"
                        color: Theme.palette.normal.foregroundText
                    }
                }
            }
            UbuntuShape {
                id: leanMassIcon
                width: (parent.width/3)
                height: units.gu(10)
                backgroundColor: Theme.palette.normal.foreground
                radius: "small"
                Column{
                    anchors.centerIn: parent
                    Label {
                        anchors.topMargin: units.gu(1)
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:i18n.tr( "Lean Mass")
                        fontSize: "large"
                        color: Theme.palette.normal.foregroundText
                    }
                    Label {
                        id:leanMassR
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "0.0"
                        fontSize: "x-large"
                        color: Theme.palette.normal.foregroundText
                    }
                }
            }

        }
    }
}

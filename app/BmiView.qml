import QtQuick 2.0
import Ubuntu.Components 1.2
Page {
    id: mainPage
    title: i18n.tr("BMI Calculator")
    Action {
        id: infoAction
        objectName:"infoButton"
        iconName: "info"
        text: i18n.tr("Information")
        onTriggered: {
            pageStack.push(infoPage,{content:"bmi"});
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
            height: ageTextField.height
            Label{
                id: ageLabel
                text :i18n.tr("Age")
                color: UbuntuColors.green
                anchors.right:  ageTextField.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin:  units.gu(2)
            }
            TextField {
                id: ageTextField
                anchors.horizontalCenter: parent.horizontalCenter
                width:units.gu(10)
                validator:  IntValidator {}
                inputMethodHints:Qt.ImhFormattedNumbersOnly
            }
            ToogleSwitch{
                id: genderSwitch
                anchors.left:   ageTextField.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:   units.gu(1)
                leftL: i18n.tr("Male")
                rightL: i18n.tr("Female")
            }

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
        }
        Button {
            id: calcButton
            objectName: "button"
            text: i18n.tr("Calculate")
            anchors.horizontalCenter: parent.horizontalCenter
            color: UbuntuColors.green
            onClicked: {
                getBmi(kgOrLbSwitch.on,parseFloat(heightTextField.text),parseFloat(weightTextFiled.text));
            }
            function getBmi(lib,height,weight){
                if(weight>0 && height>0&&Number(ageTextField.text)>1) {
                    var inc =1;
                    if(lib){
                        inc =703;
                    }else{
                        height = height /100;
                    }
                    bmiOutput = ((weight / (height * height))*inc).toFixed(2);
                    age = Number(ageTextField.text)
                    bmiRuler.isClicked=false;
                    bmiRuler.arrBmi =[age,bmiOutput,!genderSwitch.on];
                    bmiRuler.visible=true;
                    return ;
                }
                return ;
            }
        }

        RulerBMI{
            id:bmiRuler
            visible: false;
            onWidthChanged:{
                calcButton.getBmi(kgOrLbSwitch.on,parseFloat(heightTextField.text),parseFloat(weightTextFiled.text));
            }
            Behavior on visible {NumberAnimation{properties: "opacity";from:0;to:1;easing.type: Easing.InOutQuad; duration: 400 }}
        }
        UbuntuShape{
            id: tipShape
            width: (parent.width)
            height: units.gu(10)
            backgroundColor: "#Fb00a132"
            radius: "small"
            //aspect: UbuntuShape.Flat
            visible: false;

            Column{
                anchors.centerIn: parent
                Label {
                    id: tipLable
                    property int underOrOver: 0;
                    property string downOrUp: {
                        if(underOrOver ===1){
                            return i18n.tr("<b>increase</b> your weight about");
                        }else if(underOrOver ===2){
                            return i18n.tr("<b>reduce</b> your weight about");
                        }else{
                            return "";
                        }
                    }
                    width: tipShape.width
                    horizontalAlignment:Text.AlignHCenter
                    wrapMode :Text.WordWrap
                    anchors.topMargin: units.gu(1)
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:i18n.tr( "If you want to be in the right weight for you,<br/> you should")+" " +downOrUp
                    fontSize: "medium"
                    color: Theme.palette.normal.foregroundText
                }
                Label {
                    id: numTipLable
                    anchors.topMargin: units.gu(1)
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:""
                    fontSize: "large"
                    color: Theme.palette.normal.foregroundText
                }
            }
            UbuntuShape{
                width: 25
                height: 25
                backgroundColor: "#Fb00a132"
                radius: "small"
                //aspect: UbuntuShape.Flat
                anchors {
                    left: parent.left
                    top: parent.top
                    leftMargin: units.gu(-1.5)
                    topMargin: units.gu(-1.5)
                }
                    Icon {
                        width: 24
                        height: 24
                        name: "info"
                        color:Theme.palette.normal.foregroundText
                        anchors.fill: parent
                    }
                }

                Behavior on visible {NumberAnimation{properties: "opacity";from:0;to:1;easing.type: Easing.InOutQuad; duration: 400 }}
            }

            function setTipBmi(n_bmi){
                if(n_bmi!==0){
                    var n=0;
                    var h =parseFloat(heightTextField.text);
                    var w =parseFloat(weightTextFiled.text);
                    var lib =kgOrLbSwitch.on;
                    var inc =1;
                    var kgOrLib= "";
                    if (lib){
                        inc =703;
                        kgOrLib ="Lb"
                    }else{
                        h = h /100;
                        kgOrLib ="Kg"
                    }
                    n= w-((h*h)*(n_bmi/inc))
                    if(n<0){
                        tipLable.underOrOver =1;//mean underwhight
                        n = n*-1;
                    }else{
                        tipLable.underOrOver =2;//mean overwhight
                    }

                    numTipLable.text = n.toFixed(0) + " "+kgOrLib;
                    tipShape.visible=true;
                }else{
                    tipShape.visible=false;
                }
            }
        }
    }

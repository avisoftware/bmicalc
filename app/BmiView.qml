import QtQuick 2.0
import Ubuntu.Components 1.1
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
            Behavior on visible {NumberAnimation{properties: "opacity";from:0;to:1;easing.type: Easing.InOutQuad; duration: 400 }}
        }
    }
}

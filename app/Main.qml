import QtQuick 2.0
import Ubuntu.Components 1.1

MainView {
    objectName: "mainView"
    applicationName: "bmicalc.avisoftware"
    //automaticOrientation: true
    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    width: units.gu(40)
    height: units.gu(75)
    backgroundColor: "#fff"
    property double bmiOutput: 0;
    property int age: 0;
    Component.onCompleted: {
        pageStack.push(mainPage)
        var component = Qt.createQmlObject(
                    'import QtQuick 2.0; Rectangle { anchors.fill: parent; z: -1; color: "#00a132"; }',
                    pageStack.header);
    }
    PageStack {
        id: pageStack
    }
    Page {
        id: mainPage
        title: i18n.tr("BMI Calculator")
        Action {
            id: infoAction
            objectName:"infoButton"
            iconName: "info"
            text: i18n.tr("Information")
            onTriggered: {
                pageStack.push(infoPage)
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
    Page {
        id:infoPage
        visible: false
        title: i18n.tr("BMI Information")
        head{
            foregroundColor:"#fff";
        }
        LayoutMirroring.enabled: false

        Item{
            id:i
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins:  units.gu(2)
            width:parent.width -units.gu(4)
            Label{
                id:infoLabel
                wrapMode: TextEdit.Wrap
                anchors.fill: parent
                horizontalAlignment:Text.AlignJustify
                text:i18n.tr("<h3>body mass index (BMI)</h3>\n\
                             The body mass index (BMI), is a value derived from the mass (weight) and height of an individual.\n\
                             The BMI is an attempt to quantify the amount of tissue mass (muscle, fat, and bone) in an individual,\n\
                             and then categorize that person as underweight,\n\
                             normal weight, overweight, or obese based on that value.\n\
                             <h4>BMI in Children (aged 2 to 20)</h4>\n\
                             BMI is used differently for children. It is calculated in the same way as for adults,\n\
                             but then compared to typical values for other children of the same age.\n\
                             Instead of comparison against fixed thresholds for underweight and overweight,\n\
                             the BMI is compared against the percentile for children of the same gender and age.\n\
                             <br><a href='https://en.wikipedia.org/wiki/Body_mass_index'>(See: Wikipedia)</a>")
            }
        }
    }
}


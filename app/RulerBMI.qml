import QtQuick 2.0
import Ubuntu.Components 1.2
Item {
    property var arrBmi: [0,1.0,true]
    property int xLoc: 0;
    anchors{
        left: parent.left
        right:parent.right
    }
    width: parent.width
    height: units.gu(15)
    clip : true

    UbuntuShape {
        id: bmiIcon
        anchors.bottom: line.top
        anchors.bottomMargin:  units.gu(0.4)
        width: units.gu(12)
        height: units.gu(8)
        x:line.width/2 -bmiIcon.width/2
        visible:false
        backgroundColor: Theme.palette.normal.foreground
        radius: "small"
        Column{
            anchors.fill: parent
            Label {
                id:bmiS
                anchors.topMargin: units.gu(1)
                anchors.horizontalCenter: parent.horizontalCenter
                text: ""
                fontSize: "medium"
                color: Theme.palette.normal.foregroundText
            }
            Label {
                id:bmiR
                anchors.horizontalCenter: parent.horizontalCenter
                text: ""
                fontSize: "x-large"
                color: Theme.palette.normal.foregroundText
            }
        }
        Behavior on x {NumberAnimation{easing.type: Easing.InOutQuad; duration: 400 }}
        Behavior on backgroundColor {ColorAnimation{easing.type: Easing.InOutQuad; duration: 400 }}


    }
    Rectangle{
        id : line
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset :units.gu(3)

        width: parent.width
        height:units.gu(3)
    }
    Rectangle{
        id : line1
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset :units.gu(3)
        anchors.horizontalCenter: parent.horizontalCenter
        width: units.gu(3)
        height: parent.width
        opacity: 0.7
        rotation: 270
        transformOrigin: Item.Center
        gradient: adultGradient
        MouseArea{
            anchors.fill: parent
            onClicked: {
                changeXloc(mouseY)
            }
        }
        Gradient {id:adultGradient
            GradientStop { position: 0.0; color:UbuntuColors.red}
            GradientStop { position: (1/40) *5; color:UbuntuColors.red}
            GradientStop { position: (1/40) *7.25; color:UbuntuColors.orange}
            GradientStop { position: (1/40) *9; color:UbuntuColors.green}
            GradientStop { position: (1/40) *14; color:UbuntuColors.green}
            GradientStop { position: (1/40)*15.5; color:"yellow"}
            GradientStop { position: (1/40)*19; color:"yellow"}
            GradientStop { position: (1/40)*21; color: UbuntuColors.red }
        }
        Gradient {
            id:kidsGradient
            property var arrData:[0,0,0];
            GradientStop { position: 0.0; color:UbuntuColors.orange;}
            GradientStop { position: (1/25) *(kidsGradient.arrData[0]-12); color:UbuntuColors.orange;}
            GradientStop { position: (1/25) *(kidsGradient.arrData[0]-10); color:UbuntuColors.green;}
            GradientStop { position: (1/25) *(kidsGradient.arrData[1]-12); color:UbuntuColors.green;}
            GradientStop { position: (1/25) *(kidsGradient.arrData[1]-10); color:"yellow";}
            GradientStop { position: (1/25) *(kidsGradient.arrData[2]-9); color:UbuntuColors.red;}
            GradientStop { position: 1; color:UbuntuColors.red;}

        }
    }
    Triangle{
        id: triangle
        anchors.bottom: line.bottom
        x:line.width/2 -triangle.width/2
        visible:false
        Behavior on x {NumberAnimation{easing.type: Easing.InOutQuad; duration: 400 }}
        Behavior on color {ColorAnimation{easing.type: Easing.InOutQuad; duration: 400 }}
    }

    onArrBmiChanged:  {
        if(arrBmi[0]>0){
            calcXlocFromBmi(arrBmi[1],arrBmi[0])
        }
    }
    function calcXlocFromBmi(bmi){
        var part = line.width/divBy();
        var point = (bmi -10)* part;
        changeXloc (point,arrBmi[0]);
    }
    function divBy(){
        var divBy =40;
        if(arrBmi[0]<20)
            divBy=25;
        return divBy;
    }

    function changeXloc(x) {
        var nx= x - (bmiIcon.width/2);

        bmiIcon.visible=true;
        triangle.visible=true
        //fix out of bounds for bmiIcon
        if(nx<(bmiIcon.width/4)){
            nx=0;
        }
        if(nx>line.width-(bmiIcon.width)){
            nx=line.width-(bmiIcon.width);
        }
        var tnx= x -triangle.width/2;
        bmiIcon.x= nx
        triangle.x=tnx

        var b = (x / (line.width/divBy() )+10).toFixed(1);
        bmiR.text = b;
        arrBmi[1]=b;
        if(arrBmi[0]>20){
            line1.gradient=adultGradient;
            setAdultValues(b);
        }else{
            line1.gradient=kidsGradient;
            setKidsValue(b,arrBmi[0],Number(arrBmi[2]))
        }
    }
    function setKidsValue(a,age,gender){
        /*
arrBmi = [girl][age 2-20][underweight][normal][obese]
         [boys][age 2-20][underweight][normal][obese]
*/
        var arrBmi=[
                    [[[14.2],[18.0],[19.1]],
                     [[14.0],[17.2],[18.3]],
                     [[13.7],[16.8],[18.0]],
                     [[13.5],[16.8],[18.3]],
                     [[13.4],[17.1],[18.8]],
                     [[13.4],[17.6],[19.6]],
                     [[13.5],[18.1],[20.6]],
                     [[13.7],[19.1],[21.8]],
                     [[14.0],[20.0],[23.0]],
                     [[14.4],[20.8],[24.1]],
                     [[14.8],[21.7],[25.2]],
                     [[15.3],[22.5],[26.3]],
                     [[15.8],[23.3],[27.2]],
                     [[16.3],[24.0],[28.1]],
                     [[16.8],[24.6],[28.9]],
                     [[17.2],[25.2],[29.6]],
                     [[17.5],[25.7],[30.3]],
                     [[17.8],[26.1],[31.0]],
                     [[17.9],[26.5],[31.8]]],
                    [[[14.8],[18.2],[19.2]],
                     [[14.4],[17.3],[18.3]],
                     [[14.0],[16.9],[17.8]],
                     [[13.8],[16.8],[17.9]],
                     [[13.75],[17.0],[18.2]],
                     [[13.7],[17.4],[19.1]],
                     [[13.8],[17.9],[20.0]],
                     [[14.0],[18.6],[21.0]],
                     [[14.2],[19.4],[22.1]],
                     [[14.6],[20.2],[23.2]],
                     [[15.0],[21.0],[24.2]],
                     [[15.4],[21.8],[25.2]],
                     [[16.0],[22.6],[26.0]],
                     [[12.6],[23.4],[26.8]],
                     [[17.1],[24.1],[27.5]],
                     [[17.7],[24.9],[28.2]],
                     [[18.2],[25.6],[29.0]],
                     [[18.7],[26.4],[29.7]],
                     [[19.1],[27.0],[30.6]]]];

        if(a<arrBmi[gender][age-2][0]){
            drawUnderweight();
        }else if(a>arrBmi[gender][age-2][0]&&a<arrBmi[gender][age-2][1]){
            drawNormal();
        }else if(a>arrBmi[gender][age-2][1]&&a<arrBmi[gender][age-2][2]){
            drawOverweight();
        }else if(a>arrBmi[gender][age-2][2]){
            drawObese(0);
        }
        kidsGradient.arrData=arrBmi[gender][age-2];
    }

    function setAdultValues(bmi){
        if(bmi<15){
            drawVerySeverelyUnderweight();
        }else if(bmi>15&&bmi<16){
            drawSeverelyUnderweight();
        }else if(bmi>16&&bmi<18.5){
            drawUnderweight();
        }else if(bmi>18.5&&bmi<25){
            drawNormal();
        }else if(bmi>25&&bmi<30){
            drawOverweight();
        }else if(bmi>30&&bmi<35){
            drawObeseClassI();
        }else if(bmi>35&&bmi<40){
            drawObeseClassII();
        }else if(bmi>40){
            drawObeseClassIII();
        }

    }
    function drawVerySeverelyUnderweight(){
        bmiS.text= "Very severely\nunderweight";
        bmiIcon.backgroundColor=UbuntuColors.red;
        triangle.color =UbuntuColors.red;
        bmiS.color="#fff";
        bmiR.color="#fff";
        bmiIcon.height=units.gu(8)
    }

    function drawSeverelyUnderweight(){
        bmiS.text= "Severely\nUnderweight"
        bmiIcon.backgroundColor=UbuntuColors.red
        triangle.color =UbuntuColors.red;
        bmiS.color="#fff";
        bmiR.color="#fff";
        bmiIcon.height=units.gu(8)
    }

    function drawUnderweight(){
        bmiS.text= "Underweight"
        bmiIcon.backgroundColor=UbuntuColors.orange
        bmiS.color="#fff";
        bmiR.color="#fff";
        triangle.color =UbuntuColors.orange;
        bmiIcon.height=units.gu(6)
    }

    function drawNormal(){
        bmiS.text= "Normal"
        bmiIcon.backgroundColor=UbuntuColors.green
        triangle.color =UbuntuColors.green
        bmiS.color="#fff";
        bmiR.color="#fff";
        bmiIcon.height=units.gu(6)
    }

    function drawOverweight(){
        bmiS.text= "Overweight"
        bmiIcon.backgroundColor="yellow"
        triangle.color ="yellow";
        bmiS.color=UbuntuColors.red
        bmiR.color=UbuntuColors.red
        bmiIcon.height=units.gu(6)
    }
    function drawObese(c){
        if (c===1){
            bmiS.text= "Obese\nClass I"
        }else if(c===2){
            bmiS.text= "Obese\nClass II"
        }else if(c===3){
            bmiS.text= "Obese\nClass III"
        }else{
            bmiS.text= "Obese"
        }
        bmiIcon.backgroundColor=UbuntuColors.red
        triangle.color =UbuntuColors.red;
        bmiS.color="#fff";
        bmiR.color="#fff";
        if(c>0){
            bmiIcon.height=units.gu(8)
        }else{
            bmiIcon.height=units.gu(6)
        }
    }
    function drawObeseClassI(){
        drawObese(1)
    }
    function drawObeseClassII(){
        drawObese(2)
    }
    function drawObeseClassIII(){
        drawObese(3)
    }
}

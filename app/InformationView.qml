import QtQuick 2.0
import Ubuntu.Components 1.1

Item{
    id:i
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins:  units.gu(2)
    width:parent.width -units.gu(4)
    property string content: "";
    Label{
        id:infoLabel
        wrapMode: TextEdit.Wrap
        anchors.fill: parent
        horizontalAlignment:Text.AlignJustify
        text:{
            if(content==="bmi"){
                bmiString;
            }else if(content==="fat"){
                fatString;
            }else{
                "";
            }
        }


        property string bmiString: i18n.tr("<h3>body mass index (BMI)</h3>\n\
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
        property string fatString: i18n.tr("<h3>Body Fat %</h3>\n\
                             This Body Fat Calculator uses the U.S. Navy fitness formula to get an estimated measuring of body fat percent.\n\
                             All you need is a tape measure.\n\
                             <br><b>NOTICE:</b> This is not represent a measure of an accurate <b>Body Fat</b>. It is just an estimate.\n\
                             <br><a href='https://en.wikipedia.org/wiki/Body_fat_percentage'>(See also: Wikipedia)</a>")

    }
}


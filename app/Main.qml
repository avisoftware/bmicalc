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
        pageStack.push(tabs)
        var component = Qt.createQmlObject(
                    'import QtQuick 2.0; Rectangle { anchors.fill: parent; z: -10; color: "#00a132"; }',
                    pageStack.header);
    }
    PageStack {
        id: pageStack
        Tabs{
            id: tabs
            Keys.forwardTo: [tabs.currentPage.item]
            selectedTabIndex: bmiTab.index
            Component.onCompleted: {
                tabs.selectedTabIndex= 0;
            }
            Keys.onTabPressed: {
                if( event.modifiers & Qt.ControlModifier) {
                    var currentTab = tabs.selectedTabIndex;
                    currentTab ++;
                    if( currentTab >= tabs.tabChildren.length){
                        currentTab = 0;
                    }
                    tabs.selectedTabIndex = currentTab;
                }
            }

            Keys.onBacktabPressed: {
                if( event.modifiers & Qt.ControlModifier) {
                    var currentTab = tabs.selectedTabIndex;
                    currentTab --;
                    if( currentTab < 0){
                        currentTab = tabs.tabChildren.length -1;
                    }
                    tabs.selectedTabIndex = currentTab;
                }
            }
            Tab{
                id: bmiTab
                objectName: "bmiTab"
                title: i18n.tr("BMI Calculator")
                page: Loader{
                    source: tabs.selectedTab == bmiTab ? Qt.resolvedUrl("BmiView.qml"):""
                }
            }
            Tab{
                id: bodyFatTab
                objectName: "bodyFatTab"
                title: i18n.tr("Body Fat %")
                page: Loader{
                    source: tabs.selectedTab == bodyFatTab ? Qt.resolvedUrl("BodyFatUsNavyView.qml"):""
                }
            }
        }
    }

    Page {
        id:infoPage
        visible: false
        title: i18n.tr("Information")
        head{
            foregroundColor:"#fff";
        }
        LayoutMirroring.enabled: false
        property string content: "";
        InformationView{
            content:infoPage.content;
        }
    }
}

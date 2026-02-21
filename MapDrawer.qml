import QtQuick 2.12
import QtQuick.Controls 2.12

Drawer {
    id: drawer
    width: 0.7 * parent.width
    height: parent.height

    ListModel {
        id: dataModel
        ListElement {
            poi_name: "Saint-Petersburg"
            latitude: 59.940144
            longitude: 30.303894
        }
        ListElement {
            poi_name: "Harbin"
            latitude: 45.75
            longitude: 126.625
        }
        ListElement {
            poi_name: "Singapore"
            latitude: 1.3521
            longitude: 103.8198
        }
    }

    ListView {
        id: view

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: dataModel
        clip: true

        // подсветка выделенного
        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        delegate: Item {
            id: listDelegate

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

            width: view.width
            height: 40

            Rectangle {
                anchors.margins: 5
                anchors.fill: parent
                radius: height / 2
                color: "skyblue"
                border {
                    color: "black"
                    width: 1
                }

                Text {
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering
                    text: "%1: lat: %2, lon: %3".arg(model.poi_name).arg(model.latitude).arg(model.longitude);
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { view.currentIndex = model.index; }
                }
            }
        }

        header: Rectangle {
            width: view.width
            height: 45
            anchors.margins: 20
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Go to selected"
                onClicked: {
                    var currentItemData = dataModel.get(view.currentIndex)
                    myWorldMap.center.latitude = currentItemData.latitude
                    myWorldMap.center.longitude = currentItemData.longitude
                    drawer.close()
                }

            }

        }

        footer: Rectangle {
            width: view.width
            height: 45
            anchors.margins: 20
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Close"
                onClicked: drawer.close()
            }

        }
    }


}

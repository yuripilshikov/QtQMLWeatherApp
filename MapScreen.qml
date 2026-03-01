import QtQuick 2.12
import QtQuick.Window 2.2
import QtLocation 5.0
import QtPositioning 5.0
import QtQuick.Controls 2.12

Item {
    id: root

    Map {
        id: myWorldMap
        anchors.fill: parent
        plugin: Plugin {
            name: "osm"
        }

        center: QtPositioning.coordinate(61.03827826158261, 30.122246327358795) // Приозерск
        zoomLevel: 10

        MouseArea {
            anchors.fill: myWorldMap
            hoverEnabled: true // Required to get coordinates on hover, not just clicks

            // Custom property to store the converted coordinate
            property var coordinate: myWorldMap.toCoordinate(Qt.point(mouseX, mouseY))

            onClicked: {

                console.log("Clicked coordinates:", coordinate.latitude, coordinate.longitude);
                // Говорим модели, что нужно запросить погоду
                appModel.requestWeather(coordinate.latitude, coordinate.longitude)
            }
        }
    }

    MapDrawer {
        id: myDrawer
    }

    Button {
        text: "="
        onClicked: myDrawer.open()
        anchors.top: root.top
        anchors.left: root.left
        anchors.margins: 10
    }
}

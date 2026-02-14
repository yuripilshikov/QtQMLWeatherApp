import QtQuick 2.0
import QtQuick.Window 2.2
import QtLocation 5.0
import QtPositioning 5.0
import QtQuick.Controls 2.0

Item {
    id: root
    // сигнал: данные о погоде отправлены
    signal coordinatesSent()

    Map {
        id: map
        anchors.fill: parent
        plugin: Plugin {  // Using OpenStreetMap plugin as an example
            name: "osm"
        }
        center: QtPositioning.coordinate(61.03827826158261, 30.122246327358795) // Приозерск
        zoomLevel: 10

        Component.onCompleted: {
            // связываем отправку координат и обработку координат в стеке
            root.coordinatesSent.connect(stack.coordsSet)
        }

        MouseArea {
            anchors.fill: map
            hoverEnabled: true // Required to get coordinates on hover, not just clicks

            // Custom property to store the converted coordinate
            property var coordinate: map.toCoordinate(Qt.point(mouseX, mouseY))

            onClicked: {
                console.log("Clicked coordinates:", coordinate.latitude, coordinate.longitude);
                root.coordinatesSent() // сигналим стеку, что нужно включить экран загрузки
                _wam.requestWeather(coordinate.latitude, coordinate.longitude)
            }
        }
    }
}


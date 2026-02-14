import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    visible: true
    width: 600
    height: 800
    title: qsTr("Weather data assistant")

    StackView {
        id: stack
        initialItem: mapScreen
        anchors.fill: parent

        // координаты отправлены -- включаем экран загрузки
        signal coordsSet()
        onCoordsSet: {
            stack.push(loadingScreen)
        }

        // передача полученных данных в weatherScreen
        signal sendWeatherData(string weather)


    }

    Component {
        id: mapScreen
        MapScreen{
            id: mapScreenScreen
        }
    }

    Component {
        id: loadingScreen
        LoadingScreen {}

    }

    Component {
        id: weatherScreen
        WeatherScreen{}
    }

    // соединения сигнал-слот с weatherapimanager
    Connections {
        target: _wam
        onWeatherDataReceived: {
            //console.log("Weather data received!\n" + weatherData )
            // сделать что-то с данными...

            stack.pop()
            stack.push(weatherScreen)
            stack.sendWeatherData(weatherData)

            //stack.push(weatherScreen)
            // передать в weather screen данные
        }
    }
}

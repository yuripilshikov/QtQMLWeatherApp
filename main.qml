import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 748
    height: 1024
    title: qsTr("Hello World")

    property AppModel appModel: AppModel {}
    property NavigationManager navigationManager: NavigationManager {
        stackView: stack
        mainWindow: this
    }

    Connections {
        target: appModel
        onIsLoadingChanged: {
            if (appModel.isLoading) navigationManager.showLoading()
        }
        onCurrentWeatherDataChanged: {
            navigationManager.showWeather(appModel.currentWeatherData)
        }
    }

    Connections {
        target: _wam
        onWeatherDataReceived: {
            //console.log("Weather data received!")
            navigationManager.goBack()
            navigationManager.showWeather(weatherData)
        }
        onErrorOccured: {
            navigationManager.goBack()
            //errorDialog.text = errorMessage
            //errorDialog.open()
            console.log("ERROR!!! " + errorMessage)
        }
    }

    StackView {
        id: stack
        initialItem: mapScreen
        anchors.fill: parent
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
}

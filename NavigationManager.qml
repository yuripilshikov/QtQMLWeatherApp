import QtQuick 2.0
import QtQuick.Controls 2.0

QtObject {
    property StackView stackView;
    property var mainWindow;

    function showMap() {
        stackView.pop(null); // очистить стек
        stackView.push("MapScreen.qml");
    }

    function showLoading() {
        stackView.push("LoadingScreen.qml");
    }

    function showWeather(weatherData) {
        var weatherScreen = stackView.push("WeatherScreen.qml", {"weatherData": weatherData});
    }

    function goBack() {
        stackView.pop();
    }
}

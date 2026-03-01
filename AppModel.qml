import QtQuick 2.0

QtObject {
    property var currentWeatherData: ({});
    property bool isLoading: false;
    property string lastError: ""

    function requestWeather(lat, lon) {
        isLoading = true;
        lastError = "";
        _wam.requestWeather(lat, lon);
        //console.log("Requesting weather!");
    }

    function updateWeather(data) {
        currentWeatherData = data;
        isLoading = false;
    }

    function setError(error) {
        lastError = error;
        isLoading = false;
    }
}

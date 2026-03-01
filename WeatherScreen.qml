import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property var weatherData
    property var weatherCodes: ({})

    Column {
        anchors.centerIn: parent

        Image {
            id: pureSvgImageIcon
            width: 100
            height: 100
            sourceSize: Qt.size(100, 100)
        }

        Text {
            id: weatherIcon
            font.pointSize: 100
        }

        Text {
            id: weatherDescriptionText
            text: "abracadabra"
            font.pixelSize: 20
        }

        Text {
            id: placeInfo
            font.pixelSize: 20
        }

        Text {
            id: temperatureText
            font.pixelSize: 20
        }

        Text {
            id: pressureText
            font.pixelSize: 20
        }
        Text {
            id: humidityText
            font.pixelSize: 20
        }
        Button {
            text: "go back"
            onClicked: {
                navigationManager.goBack()
            }
        }
    }

    Component.onCompleted: {
        var xhr = new XMLHttpRequest
        xhr.open("GET", "qrc:/json/weathercodes.json")
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                if(xhr.status === 200) {
                    //console.log(xhr.responseText)
                    try {
                        weatherCodes = JSON.parse(xhr.responseText)
                        console.log("parsing successful")
                        console.log(weatherCodes[0])
                    } catch(err) {
                        if(e instanceof SyntaxError) {
                            console.error("QML JSON parse error (syntax error)" + e.message)
                        } else {
                            console.error("QML JSON parse error: " + e.message)
                        }
                    }
                } else {
                    console.log("ERROR: " + xhr.status)
                }
            }
        }
        xhr.send()
    }

    function populateData() {
        var jWeatherData = JSON.parse(weatherData)
        placeInfo.text = "Weather at (" + jWeatherData.latitude + ", " + jWeatherData.longitude
                + ") elevation: " + jWeatherData.elevation;
        temperatureText.text = "Temperature: " + jWeatherData.current.apparent_temperature
                + " " + jWeatherData.current_units.apparent_temperature;
        pressureText.text = "Pressure: " + jWeatherData.current.surface_pressure
                + " " + jWeatherData.current_units.surface_pressure;
        humidityText.text = "Humidity: " + jWeatherData.current.relative_humidity_2m
                + " " + jWeatherData.current_units.relative_humidity_2m;

        // weather code
        var weatherCode = jWeatherData.current.weather_code;
        console.log(weatherCode)
        var info = weatherCodes[weatherCode] || {description: "Unknown", emoji: "❓", icon: "default"};

        weatherDescriptionText.text = info.description
        weatherIcon.text = info.emoji

        pureSvgImageIcon.source = "data:image/svg+xml;utf8," + _wip.showWeatherIcon(weatherCode);
    }
}


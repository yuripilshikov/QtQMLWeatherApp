import QtQuick 2.0

Item {
    id: root

    Rectangle {
        id: weatherContent
        anchors.fill: parent
        color: "skyblue"

        signal postWeatherData(string weatherData)

        onPostWeatherData: {
            console.log("=========================/n")
            console.log(weatherData)

            var jWeatherData = JSON.parse(weatherData)
            console.log(jWeatherData.current.apparent_temperature);
            placeInfo.text = "Weather at (" + jWeatherData.latitude + ", " + jWeatherData.longitude
                    + ") elevation: " + jWeatherData.elevation;
            temperatureText.text = "Temperature: " + jWeatherData.current.apparent_temperature
                    + " " + jWeatherData.current_units.apparent_temperature;
            pressureText.text = "Pressure: " + jWeatherData.current.surface_pressure
                    + " " + jWeatherData.current_units.surface_pressure;
            humidityText.text = "Humidity: " + jWeatherData.current.relative_humidity_2m
                    + " " + jWeatherData.current_units.relative_humidity_2m;

        }

        Component.onCompleted: {
            stack.sendWeatherData.connect(weatherContent.postWeatherData)
        }

        Column {
            anchors.centerIn: parent

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
        }






    }

}

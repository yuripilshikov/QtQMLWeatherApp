import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root

    // сигнал: возвращаемся обратно в карту
    signal returnToMapScreen()

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

            var weatherCode = jWeatherData.current.weather_code;
            // вариант с простым svgImageProvider, который присылает svg в чистом виде
            pureSvgImageIcon.source = "data:image/svg+xml;utf8," + _wip.showWeatherIcon(weatherCode);

            // вариант с использованием эмодзи
            switch(weatherCode)
            {
            case 0:
                weatherDescriptionText.text = "Clear sky"
                weatherIcon.text = "☀️"
                break
            case 1:
                weatherDescriptionText.text = "Mainly clear"
                weatherIcon.text = "⛅"
                break
            case 2:
                weatherDescriptionText.text = "Partly cloudy"
                weatherIcon.text = "☁️"
                break
            case 3:
                weatherDescriptionText.text = "Overcast"
                weatherIcon.text = "☁️"
                break
            case 45:
                weatherDescriptionText.text = "Fog"
                weatherIcon.text = "🌫️"
                break
            case 48:
                weatherDescriptionText.text = "Depositing rime fog"
                weatherIcon.text = "🌫️"
                break
            case 51:
                weatherDescriptionText.text = "Light intensity drizzle"
                weatherIcon.text = "🌦️"
                break
            case 53:
                weatherDescriptionText.text = "Moderate intensity drizzle"
                weatherIcon.text = "🌦️"
                break
            case 55:
                weatherDescriptionText.text = "Dense intensity drizzle"
                weatherIcon.text = "🌦️"
                break
            case 56:
                weatherDescriptionText.text = "Light intensity freezing drizzle"
                weatherIcon.text = "🌦️"
                break
            case 57:
                weatherDescriptionText.text = "Dense intensity freezing drizzle"
                weatherIcon.text = "🌦️"
                break
            case 61:
                weatherDescriptionText.text = "Slight intensity rain"
                weatherIcon.text = "🌧️"
                break
            case 63:
                weatherDescriptionText.text = "Moderate intensity rain"
                weatherIcon.text = "🌧️"
                break
            case 65:
                weatherDescriptionText.text = "Heavy intensity rain"
                weatherIcon.text = "🌧️"
                break
            case 66:
                weatherDescriptionText.text = "Light intensity freezing rain"
                weatherIcon.text = "🌧️"
                break
            case 67:
                weatherDescriptionText.text = "Heavy intensity freezing rain"
                weatherIcon.text = "🌧️"
                break
            case 71:
                weatherDescriptionText.text = "Slight intensity snow fall"
                weatherIcon.text = "🌨️"
                break
            case 73:
                weatherDescriptionText.text = "Medium intensity snow fall"
                weatherIcon.text = "🌨️"
                break
            case 75:
                weatherDescriptionText.text = "Heavy intensity snow fall"
                weatherIcon.text = "🌨️"
                break
            case 77:
                weatherDescriptionText.text = "Snow grains"
                weatherIcon.text = "🌨️"
                break
            case 80:
                weatherDescriptionText.text = "Slight rain showers"
                weatherIcon.text = "🌧️"
                break
            case 81:
                weatherDescriptionText.text = "Moderate rain showers"
                weatherIcon.text = "🌧️"
                break
            case 82:
                weatherDescriptionText.text = "Violent rain showers"
                weatherIcon.text = "🌧️"
                break
            case 85:
                weatherDescriptionText.text = "Slight snow showers"
                weatherIcon.text = "🌨️"
                break
            case 86:
                weatherDescriptionText.text = "Heavy snow showers"
                weatherIcon.text = "🌨️"
                break
            default:
                weatherDescriptionText.text = "Thunderstorm"
            }
        }

        Component.onCompleted: {
            stack.sendWeatherData.connect(weatherContent.postWeatherData)

            //Соединяем возвращение на родной экран
            root.returnToMapScreen.connect(stack.returningToMapScreen)
        }

        Column {
            anchors.centerIn: parent

            // Попробовал передавать svg в виде текста (из weathericonprovider)
            Image {
                id: pureSvgImageIcon
                //source: "data:image/svg+xml;utf8," + _wip.showWeatherIcon();
                width: 100
                height: 100
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
                    root.returnToMapScreen();
                }
            }
        }
    }

}

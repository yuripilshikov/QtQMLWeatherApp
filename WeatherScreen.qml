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
        }

        Component.onCompleted: {
            stack.sendWeatherData.connect(weatherContent.postWeatherData)
        }
    }

}

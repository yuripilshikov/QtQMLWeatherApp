#include "weatherapimanager.h"

#include <QNetworkAccessManager>
#include <QNetworkReply>

WeatherAPIManager::WeatherAPIManager(QObject *parent) : QObject(parent)
{
    m_networkAccessManager = new QNetworkAccessManager(this);
}

QString WeatherAPIManager::sayHi(const QString &str)
{
    return "Hello there!" + str;
}

void WeatherAPIManager::requestWeather(const QString &latitude, const QString &longitude)
{
    QString url = QString("https://api.open-meteo.com/v1/forecast?latitude=%1&longitude=%2&current=wind_gusts_10m,wind_direction_10m,surface_pressure,wind_speed_10m,pressure_msl,cloud_cover,weather_code,snowfall,showers,rain,precipitation,is_day,apparent_temperature,relative_humidity_2m,temperature_2m&wind_speed_unit=ms").arg(latitude).arg(longitude);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply* reply = m_networkAccessManager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply](){
        onReplyFinished(reply);
        reply->deleteLater();
    });
}

void WeatherAPIManager::onReplyFinished(QNetworkReply* reply)
{
    if(reply->error() == QNetworkReply::NoError)
    {
        //QByteArray data = reply->readAll();
        QString data = reply->readAll();
        emit weatherDataReceived(data);
    }
    else
    {
        emit errorOccured(reply->errorString());
    }
}

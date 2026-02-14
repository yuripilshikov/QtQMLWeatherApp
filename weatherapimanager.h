#ifndef WEATHERAPIMANAGER_H
#define WEATHERAPIMANAGER_H

#include <QObject>

class QNetworkAccessManager;
class QNetworkReply;

class WeatherAPIManager : public QObject
{
    Q_OBJECT

    QNetworkAccessManager* m_networkAccessManager;
public:
    explicit WeatherAPIManager(QObject *parent = nullptr);

    Q_INVOKABLE QString sayHi(QString const& str);

public slots:
    // Запрос погоды
    void requestWeather(QString const& latitude, QString const& longitude);

signals:
    void weatherDataReceived(QString const& weatherData);
    void errorOccured(QString const& errorMessage);

private slots:
    void onReplyFinished(QNetworkReply* reply);


};

#endif // WEATHERAPIMANAGER_H

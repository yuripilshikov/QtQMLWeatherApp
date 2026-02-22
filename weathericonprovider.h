#ifndef WEATHERICONPROVIDER_H
#define WEATHERICONPROVIDER_H

#include <QObject>

class WeatherIconProvider : public QObject
{
    Q_OBJECT
public:
    explicit WeatherIconProvider(QObject *parent = nullptr);

    Q_INVOKABLE QString showWeatherIcon(int code);

signals:

};

#endif // WEATHERICONPROVIDER_H

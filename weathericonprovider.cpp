#include "weathericonprovider.h"
#include <QTextStream>
#include <QFile>
#include <QDebug>

WeatherIconProvider::WeatherIconProvider(QObject *parent) : QObject(parent)
{    
}

QString WeatherIconProvider::showWeatherIcon(int code)
{
    qDebug() << "CODE OF WEATHER: " << code;
    QString svgpath = "";

    // sun
    if(code == 0)
    {
        svgpath = ":/svg/sun.svg";
    }
    else if(code >= 51 && code <= 57)
    {
        svgpath = ":/svg/drizzle.svg";
    }
    else if(code == 45 || code == 48)
    {
        svgpath = ":/svg/fog.svg";
    }
    else if(code >= 61 && code <= 65)
    {
        svgpath = ":/svg/rain.svg";
    }
    else if(code >= 80 && code <= 82)
    {
        svgpath = ":/svg/rainshower.svg";
    }
    else if(code >= 1 && code <= 3)
    {
        svgpath = ":/svg/sun_and_cloud.svg";
    }
    else
    {
        svgpath = ":/svg/snow.svg";
    }

    qDebug() << "CODE OF WEATHER: " << code << " svgpath: " << svgpath;



    QFile file(svgpath);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        // cloud with lighting
        return "<svg xmlns=\"http://www.w3.org/2000/svg\" "
               "width=\"100\" height=\"100\" "
               "viewBox=\"0 0 100 100\" "
               "fill=\"none\" stroke=\"currentColor\" "
               "stroke-width=\"2\" stroke-linecap=\"round\" "
               "stroke-linejoin=\"round\">"
               "<path d=\"M6 16.326A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 .5 8.973\"/>"
               "<path d=\"m13 12-3 5h4l-3 5\"/>"
               "</svg>";
    }

    QTextStream in(&file);
    QString content = in.readAll();
    file.close();

    return content;
}

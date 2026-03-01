#include "weathericonprovider.h"
#include <QTextStream>
#include <QFile>
#include <QDebug>

WeatherIconProvider::WeatherIconProvider(QObject *parent) : QObject(parent)
{    
}

QString WeatherIconProvider::getWeatherIcon(const QString &code)
{
    QString svgPath = QString(":/svg/%1.svg").arg(code);
    QFile file(svgPath);
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

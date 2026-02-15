#include "jsonparser.h"

#include <QJsonObject>
#include <QJsonDocument>

QVariantMap JsonParser::parseJson(QString jsonstring)
{
    QVariantMap map;

    // parse JSON
    QJsonDocument doc = QJsonDocument::fromJson(jsonstring.toUtf8());

    if(doc.isObject())
    {
        QJsonObject json = doc.object();
        QJsonValue current = json.value("current");

        if(current.isObject())
        {
            QJsonObject obj = current.toObject();
            map["temperature"] = obj["temperature_2m"].toString();
            map["pressure"] = obj["surface_pressure"].toString();
        }
    }
    return map;
}

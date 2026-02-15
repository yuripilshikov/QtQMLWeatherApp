#ifndef JSONPARSER_H
#define JSONPARSER_H

#include <QVariantMap>

// TODO refactor

class JsonParser
{
public:
    QVariantMap parseJson(QString jsonstring);
};

#endif // JSONPARSER_H

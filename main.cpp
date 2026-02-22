#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "weatherapimanager.h"
#include "weathericonprovider.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    // пробрасываем API менеджер
    WeatherAPIManager wam;
    engine.rootContext()->setContextProperty("_wam", QVariant::fromValue(&wam));

    WeatherIconProvider wip;
    engine.rootContext()->setContextProperty("_wip", QVariant::fromValue(&wip));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

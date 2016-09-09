
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <Qdir>

#include "world.h"

#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc,argv);

    qmlRegisterType<World>("TiltyRocket", 1, 0, "World");

    QQmlApplicationEngine engine(QUrl("qrc:/TiltyRocket.qml"));
    //qDebug() << "Default path >> "+engine.offlineStoragePath();

    QDir dir;
    QString customPath = dir.currentPath()+"/OffLineStorage";

    qDebug() << "Default path >> "+engine.offlineStoragePath();
    qDebug() << "Desired path >> "+ customPath;
    if(dir.mkpath(QString(customPath))){

        engine.setOfflineStoragePath(QString(customPath));
        qDebug() << "New path >> "+engine.offlineStoragePath();
    }
    else
    {
        qDebug() << "Local file storage location was unable to be altered.";
    }

    return app.exec();
}

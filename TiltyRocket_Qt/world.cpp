#include "world.h"

#include <QQmlEngine>
#include <QQmlComponent>
#include <QQuickView>
#include <qglobal.h>
#include <QTime>
#include <QDebug>

World::World(QQuickItem  *parent)
    : QQuickItem (parent)
{
    QTime time = QTime::currentTime();
    qsrand((uint)time.msec());
}

bool World::activeNode() const
{
    return m_activeNode;
}

void World::setActiveNode(bool node)
{
    m_activeNode = node;
}

int World::numXpos() const
{
    return m_numXpos;
}

void World::setNumXpos(int num)
{
    m_numXpos = num;
    this->generateWorld();
    emit numXposChanged();
}

int World::numYpos() const
{
    return m_numYpos;
}

void World::setNumYpos(int num)
{
    m_numYpos = num;
    this->generateWorld();
    emit numYposChanged();
}

int World::width() const
{
    return m_width;
}

void World::setWidth(int n)
{
    m_width = n;
    emit widthChanged();
}

int World::height() const
{
    return m_height;
}
void World::setHeight(int n)
{
    m_height = n;
    emit this->heightChanged();
}

QQmlComponent *World::delegate() const
{
    return m_delegate;
}

void World::setDelegate(QQmlComponent *obj)
{
    m_delegate = obj;
    emit delegateChanged();
}

QQmlComponent *World::containerType() const
{
    return m_containerType;
}

void World::setContainerType(QQmlComponent *obj)
{
    m_containerType = obj;
    emit containerTypeChanged();
}

QVariant *World::parentObj() const
{
    return m_parentObj;
}
void World::setParentObj(QVariant *obj)
{
    m_parentObj = obj;
    emit parentObjChanged();
}

void World::generateWorld()
{
    if(m_numXpos > 0 && m_numYpos > 0)
    {
        positions.resize(m_numXpos, std::vector<int>(m_numYpos, 0));
        for(int i = 0; i < m_numXpos; i++)
        {
            for(int j = 0; j < m_numYpos; j++)
            {
                if(i == 0 || j == 0 || i == m_numXpos -1 || j == m_numYpos -1)
                {
                    positions[i][j] = 1;
                }
                else
                {
                    positions[i][j] = qrand() % 2;
                }
            }
        }
        for(int j = 0; j < m_numYpos; j++)
        {
            QString test;
            for(int i = 0; i < m_numXpos; i++)
            {
                test += QString::number(positions[i][j]) + " ";
            }
            qWarning() << test;
        }
        this->createQmlObject("content/Asteroid.qml",0,0);
    }
}

void World::createQmlObject(const QString &name, int x, int y)
{
    QObject *obj;

    QObject *containerObj;
    QQuickItem *container;
    if(!m_delegate)
        return;
    obj = m_delegate->create();

    if(!m_parentObj)
        return;

    if(!m_containerType)
        return;
    containerObj = m_containerType->create();
    container = containerObj->findChild<QQuickItem*>("QmlWorld");
    //obj->setproperty("parent", m_parentObj);
    //QQuickItem *test = qobject_cast<QQuickItem*>(m_parentObj->value<QObject*>());
    //obj->setParent(qobject_cast<QQuickItem*>(m_parentObj->value<QObject*>()));
    //obj->setParent(QVariant::fromValue<QQuickItem*>(m_parentObj->value));
    //obj->setParent(this);
    //obj->setProperty("parent", qobject_cast<QVariant*>(m_parentObj->value<QObject*>()));
    //obj->setProperty("parent", QVariant::fromValue<QQuickItem*>(container));
    obj->setProperty("parent", QVariant::fromValue<QQuickItem*>(this));
    obj->setProperty("x", 20);

//        QQmlEngine engine;
//        QQmlComponent component(&engine, "content/Asteroid.qml");
//        if(component.isNull())
//            return;
//        QObject *object = component.create();
//        if(!object)
//            return;
//        //object->setProperty("parent", QVariant::fromValue<QQmlComponent*>(this));
//        object->setParent(this);


    //    // Using QQuickView
    //    QQuickView view;
    //    view.setSource(QUrl::fromLocalFile("content/Asteroid.qml"));
    //    view.show();
    //    //QObject *object = view.rootObject();

//    QObject *prnt;
//    QObject *prntObj;
//    if(!m_parentObj)
//        return;
//    prntObj = m_parentObj->create();
//    prnt = prntObj->findChild<QObject*>("simpleWorld");
//    //obj->setParent((**this));

//    //obj->setProperty("parent", QVariant::fromValue<QObject*>(this));

//    if(!prnt)
//        return;

}

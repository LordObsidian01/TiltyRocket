#ifndef WORLD_H
#define WORLD_H

#include <QQuickItem>
#include <QQmlComponent>
#include <QObject>
#include <vector>

class World : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool activeNode READ activeNode WRITE setActiveNode NOTIFY activeNodeChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(int numXpos READ numXpos WRITE setNumXpos NOTIFY numXposChanged)
    Q_PROPERTY(int numYpos READ numYpos WRITE setNumYpos NOTIFY numYposChanged)

    Q_PROPERTY(QQmlComponent *delegate READ delegate WRITE setDelegate NOTIFY delegateChanged)
    Q_PROPERTY(QVariant *parentObj READ parentObj WRITE setParentObj NOTIFY parentObjChanged)
    Q_PROPERTY(QQmlComponent *containerType READ containerType WRITE setContainerType NOTIFY containerTypeChanged)
public:
    World(QQuickItem *parent = 0);

    bool activeNode() const;
    void setActiveNode(bool);

    int numXpos() const;
    void setNumXpos(int);

    int numYpos() const;
    void setNumYpos(int);

    int width() const;
    void setWidth(int);

    int height() const;
    void setHeight(int n);

    QQmlComponent *delegate() const;
    void setDelegate(QQmlComponent *);

    QVariant *parentObj() const;
    void setParentObj(QVariant *obj);

    QQmlComponent *containerType() const;
    void setContainerType(QQmlComponent *);

    void generateWorld();

    void createQmlObject(const QString &name, int x, int y);

private:
    bool m_activeNode;
    int m_numXpos;
    int m_numYpos;
    int m_width;
    int m_height;
    QQmlComponent *m_delegate;
    QQmlComponent *m_containerType;
    QVariant *m_parentObj;
    std::vector<std::vector<int>> positions;

signals:
    void activeNodeChanged();
    void numXposChanged();
    void numYposChanged();
    void delegateChanged();
    void parentObjChanged();
    void widthChanged();
    void heightChanged();
    void containerTypeChanged();
public slots:
};

#endif // WORLD_H

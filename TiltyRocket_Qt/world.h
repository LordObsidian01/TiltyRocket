#ifndef WORLD_H
#define WORLD_H

#include <QObject>
#include <vector>

class World : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool activeNode READ activeNode WRITE setActiveNode NOTIFY activeNodeChanged)
    Q_PROPERTY(int numXpos READ numXpos WRITE setNumXpos NOTIFY numXposChanged)
    Q_PROPERTY(int numYpos READ numYpos WRITE setNumYpos NOTIFY numYposChanged)

public:
    World(QObject *parent = 0);

    bool activeNode() const;
    void setActiveNode(bool);

    int numXpos() const;
    void setNumXpos(int);

    int numYpos() const;
    void setNumYpos(int);

    void generateWorld();

private:
    bool m_activeNode;
    int m_numXpos;
    int m_numYpos;
    std::vector<std::vector<int>> positions;

signals:
    void activeNodeChanged();
    void numXposChanged();
    void numYposChanged();
public slots:
};

#endif // WORLD_H

#include "world.h"

#include <qglobal.h>
#include <QTime>
#include <QDebug>

World::World(QObject *parent)
    : QObject(parent)
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
}

int World::numYpos() const
{
    return m_numYpos;
}

void World::setNumYpos(int num)
{
    m_numYpos = num;
    this->generateWorld();
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
    }

}

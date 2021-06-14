#ifndef APPLICATIONMANAGER_H
#define APPLICATIONMANAGER_H

#include "NetworkManager.h"

class ApplicationManager : public QObject {
  Q_OBJECT

  Q_PROPERTY(NetworkManager* networkManager READ getNetworkManager CONSTANT)

public:
  ApplicationManager();

  NetworkManager* getNetworkManager() { return &m_networkManager; }


private:
  NetworkManager m_networkManager;
};

#endif // APPLICATIONMANAGER_H

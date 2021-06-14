QT += quick

CONFIG += c++14

SOURCES += \
        main.cpp \
        src/ApplicationManager.cpp \
        src/DataLayer/Project.cpp \
        src/NetworkManager.cpp

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/ApplicationManager.h \
    src/DataLayer/Project.h \
    src/NetworkManager.h

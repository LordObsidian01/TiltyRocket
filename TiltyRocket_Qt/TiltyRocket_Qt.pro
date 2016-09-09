TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp                  \
                    world.cpp        \
                    scorekeeper.cpp


RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    build/Qt_5_5_1_for_Windows_Phone_arm_MSVC2013_32bit/release/AppxManifest.xml \
    build/Qt_5_5_1_for_Windows_Phone_x86_MSVC2013_32bit_Emulator/debug/AppxManifest.xml \
    build/Qt_5_5_1_for_Windows_Phone_x86_MSVC2013_32bit_Emulator/release/AppxManifest.xml \
    build/Qt_5_6_0_for_Windows_Runtime_64bit/debug/AppxManifest.xml

FORMS +=

HEADERS +=               \
           world.h       \
           scorekeeper.h


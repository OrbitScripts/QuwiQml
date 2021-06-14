import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
  width: 600
  height: 400
  visible: true
  title: qsTr("Quwi Test Version")

  StackView {
    id: stackView
    anchors.fill: parent
    initialItem: "qrc:/qml/pages/loginPage.qml"
  }
}

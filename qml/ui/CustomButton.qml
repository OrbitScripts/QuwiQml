import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  id: control

  function startBusyIndicator() {
    enabled = false
    busyIndicator.visible = true
    busyIndicator.running = true
  }

  function stopBusyIndicator() {
    enabled = true
    busyIndicator.running = false
    busyIndicator.visible = false
  }

  contentItem: Item {

    Text {
      visible: !busyIndicator.visible
      width: parent.width
      height: parent.height
      text: control.text
      font: control.font
      color: "white"
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      elide: Text.ElideRight
    }

    BusyIndicator {
      id: busyIndicator
      anchors.centerIn: parent
      visible: false
      scale: 0.5
    }
  }

  background: Rectangle {
    color: control.hovered ? "#7494c3" :"#588bd6"
    radius: 4
  }
}

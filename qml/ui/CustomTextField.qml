import QtQuick 2.9
import QtQuick.Controls 2.2

TextField {
  property string errorText

  color: "white"
  horizontalAlignment: TextInput.AlignHCenter
  selectByMouse: true

  background: Rectangle {
    Text {
      anchors.left: parent.left
      anchors.right: parent.right
      leftPadding: 16
      rightPadding: 16
      visible: errorText.length > 0
      text: errorText
      color: "#b40800"
      elide: Text.ElideRight
    }

    color: "#174588"
    border.color: errorText.length > 0 ? "#b40800" : "#386ab3"
    radius: 4
  }
}

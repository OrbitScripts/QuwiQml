import QtQuick 2.9
import QtQuick.Controls 2.2
import "../ui"

Item { 
  Component.onCompleted: {
    appManager.networkManager.projectsRequest()
  }

  Text {
    id: heading
    anchors.topMargin: 16
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    text: "Home Page"
    color: "black"
    font.bold: true
    font.pointSize: 16
  }

  ListView {
    anchors.topMargin: 16
    anchors.bottomMargin: 16
    anchors.leftMargin: 96
    anchors.rightMargin: 96
    anchors.top: heading.bottom
    anchors.bottom: logoutButton.top
    anchors.left: parent.left
    anchors.right: parent.right
    model: appManager.networkManager.projects

    delegate: Text {
      text: modelData
    }
  }

  Connections {
    target: appManager.networkManager
    onFinishRequest: {
      if (url === "https://api.quwi.com/v2/auth/logout") {
        logoutButton.stopBusyIndicator()
        if (!error) {
          stackView.pop()
        }
      }
    }
  }

  CustomButton {
    id: logoutButton
    anchors.bottomMargin: 32
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    width: 250
    height: 42
    text: qsTr("Logout")

    onClicked: {
      logoutButton.startBusyIndicator()
      appManager.networkManager.logoutRequest()
    }
  }
}

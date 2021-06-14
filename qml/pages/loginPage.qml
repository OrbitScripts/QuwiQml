import QtQuick 2.9
import QtQuick.Controls 2.2
import "../ui"

Rectangle {
  color: "#2d5da3"

  function validateEmail(email) {
    var regExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    return regExp.test(String(email).toLowerCase())
  }

  function validationLogin() {
    var isOk = loginInput.text.length > 0 && validateEmail(loginInput.text)
    if (!isOk) {
      loginInput.errorText = "Email is not a valid email address."
    }
    return isOk
  }

  function validationPassword() {
    var isOk = passwordInput.text.length > 0
    if (!isOk) {
      passwordInput.errorText = "Password can not be blank"
    }
    return isOk
  }

  Image {
    id: logo
    anchors.topMargin: 32
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    width: 48
    height: 48
    source: "qrc:/data/images/quwi.png"
  }

  Text {
    id: logoLabel
    anchors.topMargin: 16
    anchors.top: logo.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    text: "QUWI"
    color: "black"
    font.bold: true
    font.pointSize: 16
  }

  CustomTextField {
    id: loginInput
    anchors.topMargin: 32
    anchors.top: logoLabel.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    width: 250
    height: 42
    placeholderText: qsTr("Email")

    onTextChanged: {
      loginInput.errorText = ""
      passwordInput.errorText = ""
    }
  }

  CustomTextField {
    id: passwordInput
    anchors.topMargin: 18
    anchors.top: loginInput.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    width: 250
    height: 42
    placeholderText: qsTr("Password")
    echoMode: TextInput.Password

    onTextChanged: {
      loginInput.errorText = ""
      passwordInput.errorText = ""
    }
  }

  Connections {
    target: appManager.networkManager
    onFinishRequest: {
      if (url === "https://api.quwi.com/v2/auth/login") {
        loginInput.errorText = error
        loginButton.stopBusyIndicator()
        if (!error) {
          passwordInput.text = ""
          stackView.push("qrc:/qml/pages/homePage.qml")
        }
      }
    }
  }

  CustomButton {
    id: loginButton
    anchors.topMargin: 18
    anchors.top: passwordInput.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    width: 250
    height: 42
    text: qsTr("Login")

    onClicked: {
      if (validationLogin() && validationPassword()) {
        loginButton.startBusyIndicator()
        appManager.networkManager.loginRequest(loginInput.text, passwordInput.text)
      }
    }
  }

  Text {
    function getStyledText(textDecoration) {
      return "<a style='text-decoration: %1; color: \"#77a1e2\"; font-size: 11px;' href='https://quwi.com/signup'>Don\'t have an account? Register for free</a>".arg(textDecoration)
    }

    id: registerLink
    anchors.topMargin: 36
    anchors.top: loginButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    text: getStyledText("none")
    textFormat: Text.RichText
    onLinkActivated: Qt.openUrlExternally(link)
    onLinkHovered: {
      text = hoveredLink ? getStyledText("underline") : getStyledText("none")
    }

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.NoButton
      cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
  }


  Keys.onReturnPressed: (stackView.currentItem === this) ? loginButton.clicked() : null
  Keys.onEnterPressed: (stackView.currentItem === this) ? loginButton.clicked() : null
}

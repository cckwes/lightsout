import QtQuick 1.1

Rectangle {
    id: buttonArea
    width: 150
    height: 60
    radius: 20

    property string text;

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: "#45106C"
        }
        GradientStop {
            position: 1.0
            color: "#30006A"
        }
    }

    Text {
        id: buttonText
        text: buttonArea.text
        font.pixelSize: 25
        font.weight: Font.Bold
        color: "white"
        anchors.centerIn: parent
    }
}

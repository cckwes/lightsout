import QtQuick 1.1

Image {
    id: bulb
    width: 148
    height: 225
    smooth: true
    source: "images/light_off.jpg"

    states: [
        State {
            name: "on"
            PropertyChanges {
                target: bulb
                source: "images/light_on.jpg"
            }
        },
        State {
            name: "off"
            PropertyChanges {
                target: bulb
                source: "images/light_off.jpg"
            }
        }
    ]
}

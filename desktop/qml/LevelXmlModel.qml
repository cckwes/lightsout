import QtQuick 1.1
import "js/engine.js" as Engine

XmlListModel {
    id: levelXmlModel
    query: "/lights/light"

    XmlRole { name: "number"; query: "number/string()" }
    XmlRole { name: "state"; query: "state/string()" }

    onStatusChanged: {
        if (levelXmlModel.status == XmlListModel.Ready) {
            Engine.xmlLevelLoaded();
        }
    }
}

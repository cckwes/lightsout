import QtQuick 1.1
import "js/engine.js" as Engine

Rectangle {
    id: mainWindow
    width: 1280
    height: 768
    color: "black"

    property int level
    property int moves: 0
    property int rows
    property int columns

    Component.onCompleted: {
        mainWindow.level = 1;
        mainWindow.moves = 0;
        Engine.loadLevel(mainWindow.level);
    }

    function resetLevel() {
        mainWindow.level = 1;
        mainWindow.moves = 0;
//        mainWindow.updateLevel(mainWindow.level);
        Engine.loadLevel(mainWindow.level);
    }

    Text {
        id: levelLabel
        text: "Level:"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 50
        color: "white"
        font.pixelSize: 30
    }
    Text {
        id: levelingLabel
        text: mainWindow.level
        anchors.left: levelLabel.right
        anchors.leftMargin: 20
        anchors.top: levelLabel.top
        color: "white"
        font.pixelSize: 30
    }

    Text {
        id: moveLabel
        text: "Move(s):"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: levelLabel.top
        anchors.topMargin: 50
        color: "white"
        font.pixelSize: 30
    }
    Text {
        id: movesLabel
        text: mainWindow.moves
        anchors.left: moveLabel.right
        anchors.leftMargin: 20
        anchors.top: moveLabel.top
        color: "white"
        font.pixelSize: 30
    }


    Button {
        id: refreshButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: "Refresh"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.moves = 0;
                Engine.loadLevel(mainWindow.level);
            }
        }
    }
    Button {
        id: resetButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.left: refreshButton.right
        anchors.leftMargin: 10
        text: "Reset"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.resetLevel();
            }
        }
    }


    Item {
        width: 900
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        GridView {
            id: masterGrid
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            model: lightModel
            delegate: Item {
                width: masterGrid.cellWidth
                height: masterGrid.cellHeight
                Light {
                    id: lightRec
                    state: model.state
                    anchors.fill: parent

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            //console.log(model.number);
                            Engine.triggerSurrounding(model.number,mainWindow.rows,mainWindow.columns);
                            mainWindow.moves += 1;
                            Engine.checkAllOff(lightModel.count);
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: lightModel
    }

    LevelXmlModel {
        id: lightXmlModel
        source: "level/level-"+mainWindow.level+".xml";
    }

    Rectangle {
        id: levelCompleteMask
        anchors.fill: parent
        color: "#c6000000"
        visible: false

        Column {
            width: parent.width
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            spacing: 40

            Text {
                text: "Level Completed!"
                font.pixelSize: 34
                color: "white"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
            Rectangle {
                height: 2
                width: parent.width
                color: "blue"
            }

            Text {
                font.pixelSize: 26
                color: "white"
                text: "Level " + mainWindow.level + " completed in " + mainWindow.moves + " moves"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                font.pixelSize: 26
                color: "white"
                text: "Click to continue to the next level"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.level += 1;
//                mainWindow.updateLevel(mainWindow.level);
                Engine.loadLevel(mainWindow.level);
                mainWindow.moves = 0;
                levelCompleteMask.visible = false;
            }
        }
    }

    Rectangle {
        id: gameCompleteMask
        anchors.fill: parent
        color: "#c6000000"
        visible: false

        Column {
            width: parent.width
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            Text {
                text: "Game Completed!"
                font.pixelSize: 34
                color: "white"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
            Rectangle {
                height: 2
                width: parent.width
                color: "blue"
            }

            Text {
                font.pixelSize: 26
                color: "white"
                text: "Congratulations, you have completed all " + mainWindow.level + " levels, stay tuned for more levels!"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.level = 1;
//                mainWindow.updateLevel(mainWindow.level);
                Engine.loadLevel(mainWindow.level);
                mainWindow.moves = 0;
                gameCompleteMask.visible = false;
            }
        }
    }

//    Dialog {
//       id: levelCompletedDialog
//       title: Column {
//           width: parent.width
//           spacing: 5
//           Text {
//               text: "Level Completed!"
//               font.pixelSize: 34
//               color: "white"
//               width: parent.width
//               horizontalAlignment: Text.AlignHCenter
//           }
//           Rectangle {
//               height: 2
//               width: parent.width
//               color: "blue"
//           }
//       }

//       content:Item {
//         id: name
//         height: 100
//         width: parent.width
//         Text {
//           id: text
//           font.pixelSize: 26
//           anchors.centerIn: parent
//           color: "white"
//           text: "Level " + mainWindow.level + " completed in " + mainWindow.moves + " moves"
//         }
//       }

//       buttons: Button {
//           anchors.centerIn: parent
//           anchors.top: name.bottom
//           anchors.topMargin: 20
//           text: "Next Level"
//           onClicked: {
//               levelCompletedDialog.close();
//               mainWindow.level += 1;
//               mainWindow.updateLevel(mainWindow.level);
//               Engine.loadLevel(mainWindow.level);
//               mainWindow.moves = 0;
//           }
//       }

//       onRejected: {
//           mainWindow.level += 1;
//           mainWindow.updateLevel(mainWindow.level);
//           Engine.loadLevel(mainWindow.level);
//           mainWindow.moves = 0;
//       }
//    }

//    Dialog {
//       id: gameCompletedDialog
//       title: Column {
//           width: parent.width
//           spacing: 5
//           Text {
//               text: "Game Completed!"
//               font.pixelSize: 34
//               color: "white"
//               width: parent.width
//               horizontalAlignment: Text.AlignHCenter
//           }
//           Rectangle {
//               height: 2
//               width: parent.width
//               color: "blue"
//           }
//       }

//       content:Item {
//         id: gameName
//         height: 100
//         width: parent.width
//         Text {
//           id: gameText
//           font.pixelSize: 26
//           width: parent.width
//           wrapMode: Text.WordWrap
//           color: "white"
//           text: "Congratulations, you have completed all " + mainWindow.level + " levels, stay tuned for more levels!"
//         }
//       }

//       buttons: Button {
//           anchors.centerIn: parent
//           anchors.top: gameName.bottom
//           anchors.topMargin: 20
//           text: "Reset"
//           onClicked: {
//               gameCompletedDialog.close();
//               mainWindow.level = 1;
//               mainWindow.updateLevel(mainWindow.level);
//               Engine.loadLevel(mainWindow.level);
//               mainWindow.moves = 0;
//           }
//       }

//       onRejected: {
//           mainWindow.level = 1;
//           mainWindow.updateLevel(mainWindow.level);
//           Engine.loadLevel(mainWindow.level);
//           mainWindow.moves = 0;
//       }
//    }

//    QueryDialog {
//        id: resetWarningDialog
//        message: "Warning! This will reset to level one!"
//        acceptButtonText: "Ok"
//        rejectButtonText: "Cancel"

//        onAccepted: {
//            mainWindow.level = 1;
//            mainWindow.moves = 0;
//            mainWindow.updateLevel(mainWindow.level);
//            Engine.loadLevel(mainWindow.level);
//            resetWarningDialog.close();
//        }

//        onRejected: {
//            resetWarningDialog.close();
//        }
//    }
}

function triggerSurrounding(position,rows,columns) {
    var position = parseInt(position);
    var rows = parseInt(rows);
    var columns = parseInt(columns);

    if (position == 0) {
        topLeftTrigger(columns);
        triggerLightbulb(position);
    }
    else if (position == (columns - 1)) {
        topRightTrigger(columns);
        triggerLightbulb(position);
    }
    else if (position == ((rows - 1) * columns)) {
        bottomLeftTrigger(columns,rows);
        triggerLightbulb(position);
    }
    else if (position == (rows * columns - 1)) {
        bottomRightTrigger(columns,rows);
        triggerLightbulb(position);
    }
    else if (position < columns) {
        topRowTrigger(position,columns);
        triggerLightbulb(position);
    }
    else if (position > (columns * (rows - 1))) {
        bottomRowTrigger(position,columns);
        triggerLightbulb(position);
    }
    else if (position % columns == 0) {
        leftColumnTrigger(position,columns);
        triggerLightbulb(position);
    }
    else if (position % columns == (columns - 1)) {
        rightColumnTrigger(position,columns);
        triggerLightbulb(position);
    }
    else {
        normalTrigger(position, columns);
        triggerLightbulb(position);
    }
}

function topRightTrigger(columns) {
    triggerLightbulb(columns * 2 - 1);
    triggerLightbulb(columns - 2);
}

function topLeftTrigger(columns) {
    triggerLightbulb(columns);
    triggerLightbulb(1);
}

function bottomLeftTrigger(columns,rows) {
    triggerLightbulb((rows - 2) * columns);
    triggerLightbulb((rows - 1) * columns + 1);
}

function bottomRightTrigger(columns,rows) {
    triggerLightbulb((rows - 1) * columns - 1);
    triggerLightbulb(rows * columns - 2);
}

function topRowTrigger(element,columns) {
    triggerLightbulb(element - 1);
    triggerLightbulb(element + 1);
    triggerLightbulb(element + columns);
}

function bottomRowTrigger(element,columns) {
    triggerLightbulb(element - 1);
    triggerLightbulb(element + 1);
    triggerLightbulb(element - columns);
}

function leftColumnTrigger(element,columns) {
    triggerLightbulb(element - columns);
    triggerLightbulb(element + columns);
    triggerLightbulb(element + 1);
}

function rightColumnTrigger(element,columns) {
    triggerLightbulb(element - columns);
    triggerLightbulb(element + columns);
    triggerLightbulb(element - 1);
}

function normalTrigger(element,columns) {
    triggerLightbulb(element - columns);
    triggerLightbulb(element + columns);
    triggerLightbulb(element - 1);
    triggerLightbulb(element + 1);
}

function triggerLightbulb(element) {
    lightModel.get(element).state == "on" ? lightModel.get(element).state = "off" : lightModel.get(element).state = "on";
}

function checkAllOff(elements){
    var allOff = true;
    for (var i = 0; i < elements; i++) {
        if (lightModel.get(i).state == "on") {
            allOff = false;
            break;
        }
    }

    if (allOff == true) {
        if (mainWindow.level == 20) {
            gameCompleteMask.visible = true;
        } else {
            levelCompleteMask.visible = true;
        }
    }
}

function loadLevel(number) {
    lightXmlModel.source = "level/new_level/level-"+number+".xml";
    lightXmlModel.reload();
}

function xmlLevelLoaded() {
    lightModel.clear();
    for (var i = 0; i < lightXmlModel.count; i++) {
        lightModel.append({"number": lightXmlModel.get(i).number, "state": lightXmlModel.get(i).state});
    }
    mainWindow.rows = getRows(lightXmlModel.count);
    mainWindow.columns = getColumns(lightXmlModel.count);
    masterGrid.cellHeight = getCellHeight(mainWindow.rows);
    masterGrid.cellWidth = getCellWidth(mainWindow.rows);
    masterGrid.width = getGridWidth(mainWindow.rows);
}

function getRows(elements) {
    if (elements == 15) {
        return 3;
    } else if (elements == 25) {
        return 5;
    } else if (elements == 24) {
        return 4;
    }
}

function getColumns(elements) {
    if (elements == 15 || elements == 25) {
        return 5;
    } else if (elements == 24) {
        return 6;
    }
}

function getCellHeight(rows) {
    if (rows == 3) {
        return 245;
    } else if (rows == 5) {
        return 147;
    } else if (rows == 4) {
        return 196;
    }
}

function getCellWidth(rows) {
    if (rows == 3) {
        return 164;
    } else if (rows == 5) {
        return 98;
    } else if (rows == 4 ) {
        return 131;
    }
}

function getGridWidth(rows) {
    if (rows == 3) {
        return 900;
    } else if (rows == 5) {
        return 540;
    } else if (rows == 4) {
        return 818;
    }
}

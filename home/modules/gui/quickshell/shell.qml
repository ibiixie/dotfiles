//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import Niri

PanelWindow {
    required property var modelData

    screen: Quickshell.screens.find(s => s.name == "DP-5")

    id: bar

    color: "transparent"

    anchors {
        bottom: true
        left: true
        right: true
    }

    margins {
        left: 4
        right: 4
        bottom: 4
    }

    implicitHeight: 32

    Niri {
        id: niri
        Component.onCompleted: connect()

        onConnected: console.info("Connected to niri")
        onErrorOccurred: function(error) {
            console.error("Niri error:", error)
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Process {
        id: weatherProcess

        command: ["/home/biixie/.config/quickshell/scripts/weather.sh"]
        running: true

        function setTemperature(degrees: float) {
            weatherLabel.text = " " + degrees + "°C";
        }

        stdout: StdioCollector {
            onStreamFinished: weatherProcess.setTemperature(parseFloat(this.text.trim()))
        }
    }

    Timer {
        interval: 900000
        running: true
        repeat: true
        onTriggered: weatherProcess.running = true
    }

    RowLayout {
        id: bar_splitter
        anchors.fill: parent
        spacing: 0

        Item {
            id: start
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                spacing: 8
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    color: "black"

                    clip: true

                    border {
                        color: "#d3869b"
                        pixelAligned: true
                        width: 1
                    }

                    radius: 0

                    width: implicitWidth
                    height: implicitHeight

                    implicitWidth: windowLabel.implicitWidth + 10
                    implicitHeight: windowLabel.implicitHeight + 4

                    Text {
                        id: windowLabel

                        anchors.centerIn: parent
                        
                        text: niri.focusedWindow?.title.length > 60 ? niri.focusedWindow?.title.slice(0, 64) + "..." : niri.focusedWindow?.title ?? "None"
                        color: "white"

                        font.family: "Maple Mono Normal NL NF"
                        font.pointSize: 12
                    }
                }
            }
        }

        Item {
            id: middle
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                spacing: 8
                anchors.centerIn: parent
                
                Rectangle {
                    color: "black"

                    border {
                        color: "#d3869b"
                        pixelAligned: true
                        width: 1
                    }

                    radius: 0

                    width: implicitWidth
                    height: implicitHeight

                    implicitWidth: dateLabel.implicitWidth + 10
                    implicitHeight: dateLabel.implicitHeight + 4

                    Text {
                        id: dateLabel
                        
                        anchors.centerIn: parent

                        color: "white"

                        font.family: "Maple Mono Normal NL NF"
                        font.pointSize: 12
        
                        text: Qt.formatDateTime(clock.date, "󰃮 dddd, MMMM d, yyyy")
                    }                    
                }

                Rectangle {
                    color: "black"

                    border {
                        color: "#d3869b"
                        pixelAligned: true
                        width: 1
                    }

                    radius: 0

                    width: implicitWidth
                    height: implicitHeight

                    implicitWidth: clockLabel.implicitWidth + 10
                    implicitHeight: clockLabel.implicitHeight + 4

                    Text {
                        id: clockLabel

                        anchors.centerIn: parent

                        color: "white"

                        font.family: "Maple Mono Normal NL NF"
                        font.pointSize: 12

                        text: Qt.formatDateTime(clock.date, " hh:mm:ss t")
                    }
                }
                
                Rectangle {
                    id: weatherWidget
                    
                    color: "black"

                    border {
                        color: "#d3869b"
                        pixelAligned: true
                        width: 1
                    }

                    radius: 0

                    width: implicitWidth
                    height: implicitHeight

                    implicitWidth: weatherLabel.implicitWidth + 10
                    implicitHeight: weatherLabel.implicitHeight + 4

                    Text {
                        id: weatherLabel
                        
                        anchors.centerIn: parent

                        color: "white"

                        font.family: "Maple Mono Normal NL NF"
                        font.pointSize: 12
        
                        text: "NULL"
                    }                    
                }

            }
        }

        Item {
            id: end
            Layout.fillWidth: true
            Layout.fillHeight: true

            Row {
                spacing: 8
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    visible: false
                    
                    color: "black"

                    border {
                        color: "#d3869b"
                        pixelAligned: true
                        width: 1
                    }

                    radius: 0

                    width: implicitWidth
                    height: implicitHeight

                    implicitWidth: tray.implicitWidth + 10
                    implicitHeight: tray.implicitHeight + 4

                    Row {
                        id: tray
                        Repeater {
                            model: SystemTray.items

                            Item {
                                id: trayIcon
                                
                                required property SystemTrayItem modelData
                                width: 32
                                height: 32

                                IconImage {
                                    anchors.fill: parent
                                    source: modelData.icon
                                    implicitSize: 32
                                    asynchronous: true
                                }

                                QsMenuAnchor {
                                    id: menuAnchor
                                    menu: trayIcon.modelData.menu
                                    anchor.item: trayIcon
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                                    onClicked: (mouse) => {
                                        if (mouse.button === Qt.RightButton && trayIcon.modelData.hasMenu) {
                                            menuAnchor.open()
                                        } else if (mouse.button === Qt.LeftButton) {
                                            if (trayIcon.modelData.hasMenu && !trayIcon.modelData.onlyMenu === false) {
                                                trayIcon.modelData.activate()
                                            } else {
                                                menuAnchor.open()
                                            }
                                        } else if (mouse.button === Qt.MiddleButton) {
                                            trayIcon.modelData.secondaryActivate()
                                        }
                                    }
                                    onWheel: (wheel) => trayIcon.modelData.scroll(wheel.angleDelta.y, false)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


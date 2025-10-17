import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects

Variants {
    model: Quickshell.screens;

    delegate: Component {
        PanelWindow {
            required property var modelData

            screen: modelData

            id: bar

            anchors {
                bottom: true
                left: true
                right: true
            }

            color: "#00000000"

            implicitHeight: 30

            Rectangle {
                id: background
                anchors.fill: parent
                color: "transparent"
            }

            Item {
                id: blur
                anchors.fill: parent
                clip: true

                MultiEffect {
                    x: -parent.x
                    y: -parent.y
                    width: background.width
                    height: background.height
                    source: background

                    blurEnabled: true
                    blurMax: 1024
                    blur: 1024.0
                    blurMultiplier: 20.0
                }

                Text {
                    id: clock
                    anchors.centerIn: parent
                    color: "#FAF7EA"

                    font.family: "JetBrains Mono NL Nerd Font Mono"
                    font.pointSize: 14
        
                    Process {
                        id: dateProc
                        command: ["date"]
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: clock.text = this.text
                        }
                    }

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: dateProc.running = true
                    }

                }
                
            }
        }
    }
}

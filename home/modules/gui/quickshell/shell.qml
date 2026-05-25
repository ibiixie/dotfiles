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
                color: "#000000"
            }

            Item {
                id: blur
                anchors.fill: parent
                clip: true

                Text {
                    id: clock_text
                    anchors.centerIn: parent
                    color: "#FAF7EA"

                    font.family: "Maple Mono Normal NL NF"
                    font.pointSize: 14
                    
                    text: Qt.formatDateTime(clock.date, "dddd, MMMM d, yyyy — hh:mm:ss t")
                }

                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }
                
            }
        }
    }
}

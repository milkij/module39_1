import QtQuick
import QtQuick.Window 2.15

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: "Make transition"

    Rectangle {
        id: scene
        anchors.fill: parent
        state: "LeftState"

        Rectangle{
            id: leftRectangle
            x: 100
            y: 200
            color: "lightgrey"
            width: 100
            height: 100
            border.color: "black"
            border.width: 3
            radius: 5
            //
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    if (scene.state === "LeftState") {
                        ball.x += 30;
                        if (ball.x >= rightRectangle.x) {
                            scene.state = "IntermediateState";
                        }
                    } else if (scene.state === "IntermediateState") {
                        scene.state = "ReturnRightState";
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                text: qsTr(parent.x)
            }
        }

        Rectangle{
            id: rightRectangle
            x: 300
            y: 200
            color: "lightgrey"
            width: 100
            height: 100
            border.color: "black"
            border.width: 3
            radius: 5
            //
            MouseArea {
                anchors.fill: parent
                onClicked: scene.state = "LeftState";


            }
            Text {
                anchors.centerIn: parent
                text: qsTr(parent.x)
            }
        }

        Rectangle {
            id: ball
             color: "darkgreen"
             x: leftRectangle.x + 5
             y: leftRectangle.y + 5
             width: leftRectangle.width - 10
             height: leftRectangle.height - 10
             radius: width / 2
             Text {
                 anchors.centerIn: parent
                 text: qsTr(parent.x)
                 color: "white"
             }
        }

        states: [
            State {
                name: "RightState"
                PropertyChanges {
                    target: ball
                    x: rightRectangle.x + 5
                }
            },
            State {
                name: "LeftState"
                PropertyChanges {
                    target: ball
                    x: leftRectangle.x + 5
                }
            },
            State {
                name: "IntermediateState"
                PropertyChanges {
                    target: ball
                    x: rightRectangle.x + 5
                }
                StateChangeScript {
                    script: {
                        scene.state = "LeftState";
                    }
                }
            },
            State {
                name: "ReturnLeftState"
                PropertyChanges {
                    target: ball
                    x: leftRectangle.x + 5
                }
            }
        ]

        transitions: [
            Transition {
                from: "LeftState"
                to: "IntermediateState"
                NumberAnimation {
                   properties: "x,y"
                   duration: 1000
                   easing.type: Easing.OutBounce
                }
            },
            Transition {
                from: "IntermediateState"
                to: "LeftState"
                NumberAnimation {
                   properties: "x,y"
                   duration: 1000
                   easing.type: Easing.InOutExpo
                }
            },
            Transition {
                from: "IntermediateState"
                to: "ReturnLeftState"
                NumberAnimation {
                   properties: "x,y"
                   duration: 1000
                   easing.type: Easing.InOutExpo
                }
            }
        ]

    }

}

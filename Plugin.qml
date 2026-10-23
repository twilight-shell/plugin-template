import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Twilight.Core

// The least a plugin does that is worth reading: a card with a greeting in the
// bottom-left corner, settings you can change in the settings window, and an
// IPC call that hides and shows it.
//
//     qs -c shell ipc call my-plugin toggle
Scope {
    id: root

    // The shell sets this to the output it is on. A plugin may leave it out.
    property string outputName: ""

    // The plugin's settings: ~/.config/twilight-shell/my-plugin.toml, made from
    // my-plugin.defaults.toml the first time the plugin runs. The values live
    // there and nowhere in the code.
    ConfigFile {
        id: config

        name: "my-plugin"
        defaults: Qt.resolvedUrl("my-plugin.defaults.toml")
    }

    // `!!` and `Number(...)`: the defaults are read a moment after the plugin
    // starts, until then there is nothing to read.
    readonly property bool shown: !!config.get("show")
    readonly property string greeting: String(config.get("greeting") ?? "")
    readonly property real size: Number(config.get("size")) || 14

    IpcHandler {
        target: "my-plugin"

        function toggle(): void {
            config.set("show", !root.shown);
        }
    }

    PanelWindow {
        visible: root.shown
        screen: Quickshell.screens.find(s => s.name === root.outputName) ?? Quickshell.screens[0]
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        // Never catches the pointer, so what is under the card stays usable.
        mask: Region {}

        WlrLayershell.namespace: "twilight-my-plugin"
        WlrLayershell.layer: WlrLayer.Top

        anchors {
            bottom: true
            left: true
        }
        margins {
            bottom: 24
            left: 24
        }
        implicitWidth: label.implicitWidth + 44
        implicitHeight: label.implicitHeight + 32

        // Sticker, StyledText and the colors come from core, so the plugin looks
        // like the rest of the shell and follows its palette.
        Sticker {
            anchors.fill: parent
            anchors.bottomMargin: Theme.lift
            radius: 16
            lift: Theme.lift
            fill: Theme.surface

            StyledText {
                id: label

                anchors.centerIn: parent
                text: root.greeting
                font.pixelSize: root.size
            }
        }
    }
}

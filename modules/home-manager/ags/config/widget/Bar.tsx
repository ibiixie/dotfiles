import { App, Astal, Gdk } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"

import Battery from "gi://AstalBattery"

function Time({ format = "%H:%M"}) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className = "Time"
        onDestroy = { () => time.drop() }
        label = { time() }
    />
}

function BatteryLevel() {
    const bat = Battery.get_default();

    print(bat.percentage)

    return <box className="Battery">
        <label label={bind(bat, "percentage").as(p =>
            `${Math.floor(p * 100)} %`
        )} />
    </box>
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        marginLeft = {16}
        marginTop = {16}
        marginBottom = {16}
        borderWidth = { 0 }
        gdkmonitor = {gdkmonitor}
        exclusivity = {Astal.Exclusivity.EXCLUSIVE}
        anchor = {
            Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.BOTTOM
        }
        application = {App}>
        <box vertical = {true}>
            <BatteryLevel/>
            <Time/>
        </box>
    </window>
}

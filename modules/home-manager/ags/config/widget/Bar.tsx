import { App, Astal, Gdk } from "astal/gtk3"
import { Variable, GLib } from "astal"

function Time({ format = "%H:%M"}) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className = "Time"
        onDestroy = { () => time.drop() }
        label = { time() }
    />
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
            <Time/>
        </box>
    </window>
}

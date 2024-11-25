import Bar from "./bar/bar.js"
import { applauncher } from "./applauncher/applauncher.js"

App.config({
    style: "./style.css",
    windows: [
        Bar(),
	applauncher,
    ],
})

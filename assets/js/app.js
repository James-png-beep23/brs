// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

// Import custom hooks
import { RevenueChart, TaskDistributionChart, TaskCompletionChart, RegistryTasksChart, RegistryApplicationsChart } from "./chart-hook"
import { ShareOwnerShip, ShareVoteRights, AllocateShares } from "./form-events"

// Define hooks for LiveView
let hooks = {}
hooks.RevenueChart = RevenueChart;
hooks.TaskDistributionChart = TaskDistributionChart
hooks.TaskCompletionChart = TaskCompletionChart
hooks.RegistryTasksChart = RegistryTasksChart
hooks.RegistryApplicationsChart = RegistryApplicationsChart
hooks.ShareOwnerShip = ShareOwnerShip
hooks.ShareVoteRights = ShareVoteRights
hooks.AllocateShares = AllocateShares

// Hook to listen for changes on the select element without requiring a form wrapper
hooks.onChangeTab = {
  mounted() {
    this.el.addEventListener('change', event => {
      const eventName = this.el.dataset.event
      const target = this.el.dataset.target || null;
      if (target) {
        this.pushEventTo(target, eventName, { index: event.target.value })
      } else {
        this.pushEvent(eventName, { index: event.target.value })
      }
    })
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { hooks: hooks, params: { _csrf_token: csrfToken } })

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


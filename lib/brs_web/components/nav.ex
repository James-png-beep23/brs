defmodule BrsWeb.Nav do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  import BrsWeb.ControllerHelpers

  use Phoenix.VerifiedRoutes,
    endpoint: BrsWeb.Endpoint,
    router: BrsWeb.Router

  def nav(assigns) do
    ~H"""
    <div class="px-4 mx-auto max-w-7xl">
      <div class="flex flex-row items-start justify-between sm:items-center py-9">
        <div>
          <img
            alt="Business Registration Service"
            class="h-7 sm:h-10 lg:h-12"
            src="https://kbrs.pesaflow.com/resources/download/brs-kenya-detailed-logo"
          />
        </div>
        <%= if !is_authenticated?(@conn) do %>
          <div class="flex items-center justify-end flex-1 lg:w-0">
            <.link
              href={~p"/auth/login/sso"}
              class="text-sm font-medium text-black whitespace-nowrap sm:text-base hover:text-gray-500"
            >
              Sign in
            </.link>
            <.link
              class="inline-flex items-center justify-center px-3 py-2 ml-2 text-sm font-medium text-white border border-transparent rounded shadow-sm sm:ml-7 whitespace-nowrap sm:px-4 sm:text-base bg-primary-500 hover:bg-primary-400"
              href={~p"/auth/register/sso"}
            >
              Create account
            </.link>
          </div>
        <% else %>
          <div class="flex items-center justify-end flex-1 lg:w-0 gap-4">
            <.link
              href={~p"/registries/brs/dashboard"}
              class="text-sm font-medium text-gray-600 whitespace-nowrap sm:text-base hover:text-black"
            >
              Dashboard
            </.link>
            <%= if show_system_admin_link?(@conn.assigns.current_user) do %>
              <.link
                href={"#{admin_link(@conn.assigns.current_user)}"}
                class="ml-5 text-sm font-medium text-gray-600 whitespace-nowrap sm:text-base hover:text-black"
              >
                Admin
              </.link>
            <% end %>
            <%= if show_system_config_link?(@conn.assigns.current_user) do %>
              <.link href={~p"/system"}>
                <svg
                  class="w-5 h-5 ml-2 sm:ml-7 hover:text-black hover:bg-zinc-200/80"
                  viewBox="0 0 8.4666669 8.4666669"
                >
                  <defs id="defs2" />
                  <g id="layer1" transform="translate(0,-288.53332)">
                    <path
                      d="m 14,1 c -0.43057,-2.2524e-4 -0.812955,0.2751544 -0.949219,0.6835938 l -1.015625,3.046875 c -0.410051,0.1443778 -0.81115,0.3099019 -1.203125,0.4980468 L 7.9589844,3.7929688 c -0.385025,-0.192405 -0.8499682,-0.1168812 -1.1542969,0.1875 l -2.828125,2.828125 c -0.3043812,0.3043287 -0.379905,0.7692719 -0.1875,1.1542968 l 1.4335937,2.8671874 c -0.1885794,0.39394 -0.3554568,0.796828 -0.5,1.208984 l -3.0429687,1.015626 c -0.4084391,0.136264 -0.68381856,0.518648 -0.68359375,0.949218 v 4 c -2.2524e-4,0.43057 0.27515435,0.812955 0.68359375,0.949219 l 3.0527344,1.017578 c 0.1438828,0.407584 0.3090971,0.805606 0.4960937,1.195313 l -1.4394531,2.878906 c -0.1924051,0.385025 -0.1168813,0.849968 0.1875,1.154297 l 2.828125,2.830078 c 0.3043287,0.304381 0.7692719,0.379905 1.1542969,0.1875 l 2.8730466,-1.4375 c 0.391573,0.187086 0.791637,0.352283 1.201172,0.496094 l 1.017578,3.050781 C 13.187045,30.734612 13.56943,31.009991 14,31.009766 h 4 c 0.43057,2.25e-4 0.812955,-0.275154 0.949219,-0.683594 l 1.017578,-3.056641 c 0.406496,-0.143244 0.804637,-0.308036 1.193359,-0.49414 l 2.88086,1.441406 c 0.385025,0.192405 0.849967,0.116881 1.154296,-0.1875 l 2.828126,-2.830078 c 0.304381,-0.304329 0.379905,-0.769272 0.1875,-1.154297 l -1.435547,-2.871094 c 0.188179,-0.392579 0.353616,-0.794395 0.498047,-1.205078 l 3.046874,-1.015625 c 0.40844,-0.136264 0.683819,-0.518649 0.683594,-0.949219 v -4 c 2.25e-4,-0.43057 -0.275155,-0.812954 -0.683594,-0.949218 L 27.271484,12.039062 C 27.127133,11.629665 26.96127,11.229223 26.773438,10.837891 l 1.4375,-2.8750004 c 0.192405,-0.3850249 0.116881,-0.8499681 -0.1875,-1.1542968 L 25.195312,3.9804688 C 24.890983,3.676088 24.426041,3.6005642 24.041016,3.7929688 l -2.865235,1.4316406 c -0.395249,-0.1889764 -0.799375,-0.3552819 -1.21289,-0.5 L 18.949219,1.6835938 C 18.812955,1.2751544 18.43057,0.99977476 18,1 Z m 1.996094,7.9980469 c 3.854148,0 7.005859,3.1516861 7.005859,7.0058591 0,3.854136 -3.151711,6.998047 -7.005859,6.998047 -3.854149,0 -6.9980471,-3.143911 -6.9980471,-6.998047 0,-3.854173 3.1438981,-7.0058591 6.9980471,-7.0058591 z"
                      transform="matrix(0.26458333,0,0,0.26458333,0,288.53332)"
                    />
                  </g>
                </svg>
              </.link>
            <% end %>
            <.link
              href={~p"/auth/logout"}
              method="delete"
              class="px-2 py-1 ml-2 text-sm font-medium text-white rounded-lg sm:ml-7 whitespace-nowrap sm:text-base bg-primary-500 hover:text-black hover:bg-zinc-200/80"
            >
              Sign Out
            </.link>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  attr :menu_items, :list, required: true
  attr :current_user, :any

  def admin_header(assigns) do
    ~H"""
    <div class="sticky top-0 z-40 flex items-center px-4 py-4 bg-white shadow-sm shrink-0 gap-x-4 sm:gap-x-6 sm:px-6 lg:px-8">
      <button
        phx-click={
          JS.toggle_class("hidden", to: "#mobile-menu")
          |> JS.toggle_class("hidden", to: "#menu-overlay")
        }
        type="button"
        class="-m-2.5 p-2.5 text-gray-700 lg:hidden"
      >
        <span class="sr-only">Open sidebar</span>
        <svg
          class="w-6 h-6"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
          />
        </svg>
      </button>
      <!-- Separator -->
      <div class="w-px h-6 bg-gray-900/10 lg:hidden" aria-hidden="true"></div>

      <div class="flex items-center self-stretch justify-end flex-1 gap-x-4 lg:gap-x-6">
        <div class="flex items-center gap-x-8">
          <.link href={~p"/registries/brs/dashboard"} class="flex items-center space-x-2">
            <span class="text-xs font-semibold leading-6 text-red-600 sm:text-sm" aria-hidden="true">
              Switch to Individual
            </span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="18"
              viewBox="0 0 16 18"
              fill="none"
            >
              <path
                d="M14.6666 13.1667H1.33325M1.33325 13.1667L4.66659 9.83333M1.33325 13.1667L4.66658 16.5M1.33325 4.83333H14.6666M14.6666 4.83333L11.3333 1.5M14.6666 4.83333L11.3333 8.16667"
                stroke="#ED2926"
                stroke-width="1.67"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </.link>
          <.link href={~p"/system"}>
            <svg class="w-5 h-5 text-red-400" viewBox="0 0 8.4666669 8.4666669">
              <defs id="defs2" />
              <g id="layer1" transform="translate(0,-288.53332)">
                <path
                  d="m 14,1 c -0.43057,-2.2524e-4 -0.812955,0.2751544 -0.949219,0.6835938 l -1.015625,3.046875 c -0.410051,0.1443778 -0.81115,0.3099019 -1.203125,0.4980468 L 7.9589844,3.7929688 c -0.385025,-0.192405 -0.8499682,-0.1168812 -1.1542969,0.1875 l -2.828125,2.828125 c -0.3043812,0.3043287 -0.379905,0.7692719 -0.1875,1.1542968 l 1.4335937,2.8671874 c -0.1885794,0.39394 -0.3554568,0.796828 -0.5,1.208984 l -3.0429687,1.015626 c -0.4084391,0.136264 -0.68381856,0.518648 -0.68359375,0.949218 v 4 c -2.2524e-4,0.43057 0.27515435,0.812955 0.68359375,0.949219 l 3.0527344,1.017578 c 0.1438828,0.407584 0.3090971,0.805606 0.4960937,1.195313 l -1.4394531,2.878906 c -0.1924051,0.385025 -0.1168813,0.849968 0.1875,1.154297 l 2.828125,2.830078 c 0.3043287,0.304381 0.7692719,0.379905 1.1542969,0.1875 l 2.8730466,-1.4375 c 0.391573,0.187086 0.791637,0.352283 1.201172,0.496094 l 1.017578,3.050781 C 13.187045,30.734612 13.56943,31.009991 14,31.009766 h 4 c 0.43057,2.25e-4 0.812955,-0.275154 0.949219,-0.683594 l 1.017578,-3.056641 c 0.406496,-0.143244 0.804637,-0.308036 1.193359,-0.49414 l 2.88086,1.441406 c 0.385025,0.192405 0.849967,0.116881 1.154296,-0.1875 l 2.828126,-2.830078 c 0.304381,-0.304329 0.379905,-0.769272 0.1875,-1.154297 l -1.435547,-2.871094 c 0.188179,-0.392579 0.353616,-0.794395 0.498047,-1.205078 l 3.046874,-1.015625 c 0.40844,-0.136264 0.683819,-0.518649 0.683594,-0.949219 v -4 c 2.25e-4,-0.43057 -0.275155,-0.812954 -0.683594,-0.949218 L 27.271484,12.039062 C 27.127133,11.629665 26.96127,11.229223 26.773438,10.837891 l 1.4375,-2.8750004 c 0.192405,-0.3850249 0.116881,-0.8499681 -0.1875,-1.1542968 L 25.195312,3.9804688 C 24.890983,3.676088 24.426041,3.6005642 24.041016,3.7929688 l -2.865235,1.4316406 c -0.395249,-0.1889764 -0.799375,-0.3552819 -1.21289,-0.5 L 18.949219,1.6835938 C 18.812955,1.2751544 18.43057,0.99977476 18,1 Z m 1.996094,7.9980469 c 3.854148,0 7.005859,3.1516861 7.005859,7.0058591 0,3.854136 -3.151711,6.998047 -7.005859,6.998047 -3.854149,0 -6.9980471,-3.143911 -6.9980471,-6.998047 0,-3.854173 3.1438981,-7.0058591 6.9980471,-7.0058591 z"
                  transform="matrix(0.26458333,0,0,0.26458333,0,288.53332)"
                />
              </g>
            </svg>
          </.link>
          <!-- Profile dropdown -->
          <div class="relative" phx-click-away={JS.add_class("hidden", to: "#profile-menu")}>
            <button
              phx-click={JS.toggle_class("hidden", to: "#profile-menu")}
              type="button"
              class="-m-1.5 flex items-center p-1.5 "
              id="user-menu-button"
              aria-expanded="false"
              aria-haspopup="true"
            >
              <span class="sr-only">Open user menu</span>
              <%= if !is_nil(@current_user) && Map.has_key?(@current_user, :avatar) do %>
                <.avatar
                  src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                  size="sm"
                  class="border"
                  name={@current_user.first_name <> " " <> @current_user.last_name}
                />
              <% else %>
                <%= if !is_nil(@current_user) do %>
                  <.avatar
                    size="sm"
                    name={@current_user.first_name <> " " <> @current_user.last_name}
                  />
                <% else %>
                  <.avatar size="sm" name="Guest" />
                <% end %>
              <% end %>
            </button>

            <div
              id="profile-menu"
              class="absolute top-0 right-0 z-50 hidden mt-10 bg-white border shadow border-neutral-200/70 whitespace-nowrap"
              class="absolute right-0 z-10 mt-2.5 w-40 origin-top-right rounded-md bg-white py-2 shadow-lg ring-1 ring-gray-900/5 focus:outline-none"
              role="menu"
              aria-orientation="vertical"
              aria-labelledby="user-menu-button"
              tabindex="-1"
            >
              <!-- Active: "bg-gray-50", Not Active: "" -->
              <%= for link <- @menu_items do %>
                <.link
                  href={link.path}
                  method={if link.name == :logout, do: "delete", else: nil}
                  class="block px-3 py-1 text-sm leading-6 text-gray-900 hover:bg-gray-50"
                  role="menuitem"
                  tabindex="-1"
                >
                  <%= link.label %>
                </.link>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  attr(:src, :string, default: nil, doc: "hosted avatar URL")
  attr(:size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"])
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:name, :string, default: nil, doc: "name for placeholder initials")

  # Sizes for TailwindCSS
  @size_classes %{
    "xs" => "w-6 h-6 text-xs",
    "sm" => "w-8 h-8 text-sm",
    "md" => "w-12 h-12 text-base",
    "lg" => "w-16 h-16 text-lg",
    "xl" => "w-20 h-20 text-xl"
  }

  def avatar(assigns) do
    ~H"""
    <div class={"inline-flex items-center justify-center rounded-full bg-gray-200 #{size_class(@size)} #{@class}"}>
      <img :if={@src} src={@src} alt={@name || "Avatar"} class="w-8 h-8 rounded-full bg-gray-50" />
      <div
        :if={!@src}
        class="flex items-center justify-center w-full h-full text-white bg-gray-500 rounded-full"
      >
        <span><%= placeholder_initials(@name) %></span>
      </div>
    </div>
    """
  end

  def top_nav(assigns) do
    ~H"""
    <div class="bg-primary-500 pt-4 pb-1 text-white lg:static lg:overflow-y-visible border-b-[5px] border-primary-700">
      <div class="px-4 mx-auto max-w-8xl lg:px-5 xl:px-6 sm:bg-transparent">
        <div class="relative flex justify-between">
          <!-- logo container -->
          <div class="flex">
            <div class="flex items-center flex-shrink-0">
              <a href={~p"/"}>
                <img
                  src="https://kbrs.pesaflow.com/files/local-download?name=BRS_logo_white+%281%29.svg&path=b29ca2f97e9e2668e3d1c3c18d5d27549725721f.svg"
                  width="auto"
                  class="h-11"
                  alt="logo"
                />
              </a>
            </div>
          </div>
          <!-- User Profile dropdown -->
          <div class="lg:flex lg:items-center lg:justify-end gap-4">
            <%= if show_system_admin_link?(@current_user) do %>
              <.link
                href={"#{admin_link(@current_user)}"}
                class="px-2 py-1 ml-2 text-sm font-medium bg-white rounded-lg text-primary-500 sm:ml-7 whitespace-nowrap sm:text-base hover:text-black hover:bg-zinc-200/80"
              >
                Admin
              </.link>
            <% end %>
            <%= if show_system_config_link?(@current_user) do %>
              <.link href={~p"/system"}>
                <svg
                  class="w-5 h-5 ml-5 text-white fill-current sm:ml-7 hover:text-black hover:bg-zinc-200/80"
                  viewBox="0 0 8.4666669 8.4666669"
                >
                  <defs id="defs2" />
                  <g id="layer1" transform="translate(0,-288.53332)">
                    <path
                      d="m 14,1 c -0.43057,-2.2524e-4 -0.812955,0.2751544 -0.949219,0.6835938 l -1.015625,3.046875 c -0.410051,0.1443778 -0.81115,0.3099019 -1.203125,0.4980468 L 7.9589844,3.7929688 c -0.385025,-0.192405 -0.8499682,-0.1168812 -1.1542969,0.1875 l -2.828125,2.828125 c -0.3043812,0.3043287 -0.379905,0.7692719 -0.1875,1.1542968 l 1.4335937,2.8671874 c -0.1885794,0.39394 -0.3554568,0.796828 -0.5,1.208984 l -3.0429687,1.015626 c -0.4084391,0.136264 -0.68381856,0.518648 -0.68359375,0.949218 v 4 c -2.2524e-4,0.43057 0.27515435,0.812955 0.68359375,0.949219 l 3.0527344,1.017578 c 0.1438828,0.407584 0.3090971,0.805606 0.4960937,1.195313 l -1.4394531,2.878906 c -0.1924051,0.385025 -0.1168813,0.849968 0.1875,1.154297 l 2.828125,2.830078 c 0.3043287,0.304381 0.7692719,0.379905 1.1542969,0.1875 l 2.8730466,-1.4375 c 0.391573,0.187086 0.791637,0.352283 1.201172,0.496094 l 1.017578,3.050781 C 13.187045,30.734612 13.56943,31.009991 14,31.009766 h 4 c 0.43057,2.25e-4 0.812955,-0.275154 0.949219,-0.683594 l 1.017578,-3.056641 c 0.406496,-0.143244 0.804637,-0.308036 1.193359,-0.49414 l 2.88086,1.441406 c 0.385025,0.192405 0.849967,0.116881 1.154296,-0.1875 l 2.828126,-2.830078 c 0.304381,-0.304329 0.379905,-0.769272 0.1875,-1.154297 l -1.435547,-2.871094 c 0.188179,-0.392579 0.353616,-0.794395 0.498047,-1.205078 l 3.046874,-1.015625 c 0.40844,-0.136264 0.683819,-0.518649 0.683594,-0.949219 v -4 c 2.25e-4,-0.43057 -0.275155,-0.812954 -0.683594,-0.949218 L 27.271484,12.039062 C 27.127133,11.629665 26.96127,11.229223 26.773438,10.837891 l 1.4375,-2.8750004 c 0.192405,-0.3850249 0.116881,-0.8499681 -0.1875,-1.1542968 L 25.195312,3.9804688 C 24.890983,3.676088 24.426041,3.6005642 24.041016,3.7929688 l -2.865235,1.4316406 c -0.395249,-0.1889764 -0.799375,-0.3552819 -1.21289,-0.5 L 18.949219,1.6835938 C 18.812955,1.2751544 18.43057,0.99977476 18,1 Z m 1.996094,7.9980469 c 3.854148,0 7.005859,3.1516861 7.005859,7.0058591 0,3.854136 -3.151711,6.998047 -7.005859,6.998047 -3.854149,0 -6.9980471,-3.143911 -6.9980471,-6.998047 0,-3.854173 3.1438981,-7.0058591 6.9980471,-7.0058591 z"
                      transform="matrix(0.26458333,0,0,0.26458333,0,288.53332)"
                    />
                  </g>
                </svg>
              </.link>
            <% end %>
            <div
              phx-click-away={JS.add_class("hidden", to: "#user-menu")}
              class="relative flex-shrink-0 ml-5"
            >
              <button
                phx-click={JS.toggle_class("hidden", to: "#user-menu")}
                x-on:click="openUser = !openUser"
                class="flex w-8 h-8 overflow-hidden rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
              >
                <img
                  class="min-w-full min-h-full rounded-full"
                  src="https://kbrs.pesaflow.com/images/ico-av-male-9b71320fc28c42ee0240a3d2519bfd26.svg?vsn=d"
                  alt=""
                />
              </button>
              <ol
                id="user-menu"
                class="absolute right-0 z-10 hidden w-48 py-1 mt-2 origin-top-right bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
              >
                <li>
                  <.link
                    href={~p"/auth/logout"}
                    method="delete"
                    class="block px-4 py-2 text-sm text-gray-700 truncate hover:bg-gray-100"
                    role="menuitem"
                    tabindex="-1"
                  >
                    Log out
                  </.link>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  attr :registries, :list
  attr :current_registry, :any

  def main_menu(assigns) do
    ~H"""
    <section class="bg-white border-b border-primary-910">
      <div class="px-0 mx-auto lg:max-w-8xl lg:px-5 xl:px-6">
        <div class="flex flex-row items-end justify-between">
          <div class="flex-1 lg:pt-5 lg:flex-initial">
            <div
              phx-click-away={JS.add_class("hidden", to: "#main-menu")}
              class="relative hover:cursor-pointer"
            >
              <button
                phx-click={JS.toggle_class("hidden", to: "#main-menu")}
                type="button"
                class="relative block max-w-full min-w-full px-4 py-3 text-base leading-5 text-center text-gray-200 cursor-default lg:w-64 bg-primary-500 lg:rounded-tl-md lg:rounded-tr-md lg:border-b-2 border-primary-700"
                aria-haspopup="listbox"
                aria-expanded="true"
                aria-labelledby="listbox-label"
              >
                <span class="flex items-center text-sm">
                  <span class="block pr-5 ml-0 font-semibold truncate">
                    <%= @current_registry.name %>
                  </span>
                </span>
                <span class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                  <svg
                    class="w-5 h-5 ml-2 -mr-1"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z"
                      clip-rule="evenodd"
                    >
                    </path>
                  </svg>
                </span>
              </button>
              <!-- Select popover, show/hide based on select state. -->
              <ul
                id="main-menu"
                class="absolute z-10 hidden w-full py-1 mt-1 overflow-auto text-base rounded-md shadow-lg max-h-60 scrollbar bg-primary-920 ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm overflow-x-clip"
                tabindex="-1"
                role="listbox"
                aria-labelledby="listbox-label"
                aria-activedescendant="listbox-option-3"
              >
                <%= for registry <- @registries do %>
                  <div class="pb-2 mx-4 mt-4 mb-2 border-b border-primary-910">
                    <p class="text-xs font-medium text-gray-500"><%= registry.title %></p>
                  </div>
                  <%= for menu <- registry.menu_items do %>
                    <li
                      class="group z-10 hover:bg-[#F2F7FD] text-primary-500 relative cursor-pointer select-none py-2 pr-4"
                      role="option"
                    >
                      <.link
                        phx-click={
                          JS.push("switch_registry") |> JS.toggle_class("hidden", to: "#main-menu")
                        }
                        phx-value-slug={menu.name}
                        phx-value-uri={menu.path}
                      >
                        <div class="flex items-center">
                          <span class="block pr-5 ml-4 text-sm font-medium truncate whitespace-nowrap">
                            <%= menu.label %>
                          </span>
                        </div>
                        <span class="absolute inset-y-0 right-0 flex items-center pr-4 text-primary-500">
                          <svg
                            class="w-3 h-2"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 8 12"
                          >
                            <path
                              stroke="currentColor"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              stroke-width="1.667"
                              d="m1.5 11 5-5-5-5"
                            >
                            </path>
                          </svg>
                        </span>
                      </.link>
                    </li>
                  <% end %>
                <% end %>
              </ul>
            </div>
          </div>
          <div class="relative flex-col self-stretch justify-center hidden max-w-md mt-0 lg:mt-0 sm:text-right lg:flex">
            <p class="text-xs font-medium text-gray-400">Last Login</p>
            <p class="text-xs font-medium text-gray-400">Oct 07 2024 1:47 pm</p>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def business_breadcrumbs(assigns) do
    ~H"""
    <div>
      <section class="hidden sm:block">
        <!-- nav breadcrumbs section -->
        <div class="hidden py-4 bg-gray-200 border-b lg:block border-primary-910">
          <div class="px-4 mx-auto max-w-8xl lg:px-5 xl:px-6">
            <div class="mt-0 mb-0">
              <nav class="flex" aria-label="Breadcrumb">
                <ol role="list" class="flex items-center space-x-4">
                  <li>
                    <div>
                      <a href="/registries/brs/dashboard" class="flex-shrink-0 block group">
                        <!-- Heroicon name: mini/home -->
                        <span class="sr-only">Home</span>
                        <div class="flex items-center">
                          <div class="w-10 h-10 overflow-hidden rounded-full">
                            <img
                              class="inline-block min-w-full min-h-full"
                              src="https://kbrs.pesaflow.com/images/ico-av-male-9b71320fc28c42ee0240a3d2519bfd26.svg?vsn=d"
                              alt=""
                            />
                          </div>
                          <div class="ml-3">
                            <p class="text-sm font-semibold text-primary-500 group-hover:text-primary-500">
                              Kipkoech Haron
                            </p>
                            <p class="text-xs font-medium text-gray-900">CITIZEN</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div class="flex items-center space-x-3">
                      <!-- Heroicon name: mini/chevron-right -->
                      <svg
                        class="flex-shrink-0 w-5 h-5 text-gray-600"
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                        aria-hidden="true"
                      >
                        <path
                          fill-rule="evenodd"
                          d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                          clip-rule="evenodd"
                        >
                        </path>
                      </svg>
                      <a href="#" class="flex-shrink-0 block group">
                        <div class="flex items-center">
                          <div class="inline-flex">
                            <span class="inline-block p-2 border border-gray-600 rounded-lg">
                              <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="23"
                                height="23"
                                viewBox="0 0 23 23"
                                fill="none"
                              >
                                <path
                                  d="M21.625 13.7777C18.4983 15.0434 15.0805 15.7403 11.5 15.7403C7.91946 15.7403 4.50171 15.0434 1.375 13.7777M16 5.61536V3.36536C16 2.12272 14.9926 1.11536 13.75 1.11536H9.25C8.00736 1.11536 7 2.12272 7 3.36536V5.61536M11.5 12.3654H11.5113M3.625 21.3654H19.375C20.6176 21.3654 21.625 20.358 21.625 19.1154V7.86536C21.625 6.62272 20.6176 5.61536 19.375 5.61536H3.625C2.38236 5.61536 1.375 6.62272 1.375 7.86536V19.1154C1.375 20.358 2.38236 21.3654 3.625 21.3654Z"
                                  stroke="#505050"
                                  stroke-width="2"
                                  stroke-linecap="round"
                                  stroke-linejoin="round"
                                >
                                </path>
                              </svg>
                            </span>
                          </div>
                          <div class="ml-3">
                            <p class="text-sm font-semibold text-gray-700">Business Test</p>
                            <p class="text-xs font-medium text-gray-900">BUSINESS NAME</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>
        <!-- nav breadcrumbs section  -->
      </section>
    </div>
    """
  end

  defp size_class(size) do
    Map.get(@size_classes, size, @size_classes["sm"])
  end

  defp placeholder_initials(nil), do: "?"

  defp placeholder_initials(name) do
    name
    |> String.split()
    |> Enum.map(&String.first/1)
    |> Enum.join()
    |> String.upcase()
  end

  defp show_system_config_link?(current_user) do
    Enum.any?(current_user.backend_users, fn backend_user ->
      backend_user.registry_id == nil
    end)
  end

  defp show_system_admin_link?(current_user) do
    Enum.any?(current_user.backend_users, fn backend_user ->
      backend_user.registry_id != nil
    end)
  end

  defp admin_link(current_user) do
    default_registry_exists? =
      Enum.find(current_user.backend_users, fn backend_user ->
        backend_user.registry && backend_user.registry.is_default
      end)

    case default_registry_exists? do
      %Brs.Accounts.BackendUser{registry: %{slug: slug}} ->
        ~p"/admin/registries/#{slug}"

      _ ->
        case Enum.find(current_user.backend_users, fn backend_user ->
               backend_user.registry
             end) do
          %Brs.Accounts.BackendUser{registry: %{slug: slug}} ->
            ~p"/admin/registries/#{slug}"
        end
    end
  end
end

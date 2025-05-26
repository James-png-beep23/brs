defmodule BrsWeb.AdminSidebar do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  attr :menu_items, :list, required: true
  attr :title, :string, default: nil
  attr :logo, :string, required: false
  attr :current_path, :any
  attr :current_registry, :any
  attr :registry_menu, :list, required: true
  attr :current_backend_user, :any, default: nil

  def sidebar_menu(assigns) do
    ~H"""
    <div>
      <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->
      <div id="mobile-panel" class="relative z-50 lg:hidden" role="dialog" aria-modal="true">
        <div
          phx-click={JS.toggle_class("hidden", to: "#mobile-menu")}
          phx-window-keydown={JS.toggle_class("hidden", to: "#mobile-menu")}
          phx-key="escape"
          class="fixed inset-0 hidden bg-gray-900/80"
          id="menu-overlay"
        >
        </div>

        <div class="fixed inset-0 flex hidden" id="mobile-menu">
          <div class="relative flex flex-1 w-full max-w-xs mr-16">
            <div class="absolute top-0 flex justify-center w-16 pt-5 left-full">
              <button
                phx-click={
                  JS.toggle_class("hidden", to: "#mobile-menu")
                  |> JS.toggle_class("hidden", to: "#menu-overlay")
                }
                type="button"
                class="-m-2.5 p-2.5"
              >
                <span class="sr-only">Close sidebar</span>
                <svg
                  class="w-6 h-6 text-white"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  aria-hidden="true"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            <!-- Sidebar component, swap this element with another sidebar if you like -->
            <div class="flex flex-col px-4 pt-5 pb-4 overflow-y-auto bg-white grow gap-y-7">
              <div class="flex items-center gap-3">
                <div class="flex items-center shrink-0">
                  <img class="w-36" src={@logo} alt="BRS Logo" />
                </div>
              </div>

              <div class="w-full">
                <div
                  phx-click-away={JS.add_class("hidden", to: "#mobile-registries-menu")}
                  class="relative"
                >
                  <button
                    phx-click={
                      JS.toggle_class("hidden", to: "#mobile-registries-menu")
                      |> JS.toggle_class("rotate-180", to: "#mobile-registries-icon")
                    }
                    class="flex w-full items-center justify-between md:min-w-[244px] gap-6 py-2.5 px-3 text-sm font-bold transition-colors bg-white border-0 border-b-2 border-red-600 rounded-t-lg ring-1 ring-inset ring-gray-300 text-primary-500 hover:bg-neutral-100 active:bg-white focus:bg-white focus:outline-none disabled:opacity-50 disabled:pointer-events-none relative after:content-[''] after:absolute after:left-0 after:bottom-0 after:h-[1px] after:bg-red-600 after:w-full"
                  >
                    Companies Registry
                    <svg
                      id="mobile-registries-icon"
                      class="w-4 h-4 transition-transform duration-200 ease-in-out transform"
                      width="20"
                      height="20"
                      viewBox="0 0 20 20"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M5 7.5L10 12.5L15 7.5"
                        stroke="#092443"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </button>

                  <div class="absolute top-0 left-0 right-0 z-50 mt-14">
                    <div
                      id="mobile-registries-menu"
                      class="hidden pt-3 pb-1 rounded-b-lg shadow bg-backdrop"
                    >
                      <ul class="space-y-1">
                        <li
                          class="relative py-3 pr-3 cursor-default select-none bg-sky-50 text-primary-500 hover:cursor-pointer"
                          id="listbox-option-1"
                          role="option"
                        >
                          <div class="flex items-center text-sm leading-4">
                            <!-- Selected: "font-medium", Not Selected: "font-normal" -->
                            <span class="block ml-3 font-medium whitespace-nowrap">
                              <span>Company Registry</span>
                            </span>
                          </div>
                          <span class="absolute inset-y-0 right-0 flex items-center pr-4 text-primary-500">
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              class="w-4 h-4"
                              width="16"
                              height="16"
                              viewBox="0 0 16 16"
                              fill="none"
                            >
                              <path
                                fill-rule="evenodd"
                                clip-rule="evenodd"
                                d="M8 16C12.4183 16 16 12.4183 16 8C16 3.58172 12.4183 0 8 0C3.58172 0 0 3.58172 0 8C0 12.4183 3.58172 16 8 16ZM11.7071 6.70711C12.0976 6.31658 12.0976 5.68342 11.7071 5.29289C11.3166 4.90237 10.6834 4.90237 10.2929 5.29289L7 8.58579L5.70711 7.29289C5.31658 6.90237 4.68342 6.90237 4.29289 7.29289C3.90237 7.68342 3.90237 8.31658 4.29289 8.70711L6.29289 10.7071C6.68342 11.0976 7.31658 11.0976 7.70711 10.7071L11.7071 6.70711Z"
                                fill="#0A2543"
                              />
                            </svg>
                          </span>
                        </li>
                        <%= for menu <- @registry_menu do %>
                          <div class="px-3 pt-3">
                            <div class="pb-2 mb-2 border-b border-stone-300">
                              <p class="text-xs font-medium uppercase text-gray-9s00">
                                <%= menu.title %>
                              </p>
                            </div>
                          </div>
                          <%= for link <- menu.menu_items do %>
                            <li class="px-4">
                              <a
                                href={link.path}
                                class="text-sm text-primary-500 font-medium py-1.5 hover:bg-gray-50 block"
                              >
                                <%= link.label %>
                              </a>
                            </li>
                          <% end %>
                        <% end %>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>

              <%= for link <- @menu_items do %>
                <nav class="flex flex-col">
                  <div class="mb-2">
                    <p class="text-xs font-normal text-primary-500 font-Lexend tracking-[4px]">
                      <%= link.title %>
                    </p>
                  </div>
                  <ul role="list" class="flex flex-col flex-1 gap-y-7">
                    <li>
                      <BrsWeb.MenuItem.menu_item
                        items={link.menu_items}
                        current_path={@current_path}
                        current_backend_user={@current_backend_user}
                      />
                    </li>
                  </ul>
                </nav>
              <% end %>
            </div>
          </div>
        </div>
      </div>
      <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->
      <!-- Static sidebar for desktop -->
      <div class="hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-72 lg:flex-col">
        <!-- Sidebar component, swap this element with another sidebar if you like -->
        <div class="flex flex-col px-4 pt-3 pb-4 overflow-y-auto bg-white border-r grow gap-y-10 scrollbar border-slate-200">
          <div>
            <.logo src={@logo} />
          </div>
          <div class="w-full">
            <div class="relative" phx-click-away={JS.add_class("hidden", to: "#registries-menu")}>
              <button
                phx-click={
                  JS.toggle_class("hidden", to: "#registries-menu")
                  |> JS.toggle_class("rotate-180", to: "#registries-icon")
                }
                class="flex w-full items-center justify-between md:min-w-[244px] gap-6 py-2.5 px-3
                text-base font-bold transition-colors bg-white border-0 border-b-2 border-red-600 rounded-t-lg ring-1
                ring-inset ring-gray-300 text-primary-500 hover:bg-neutral-100 active:bg-white focus:bg-white focus:outline-none
                disabled:opacity-50 disabled:pointer-events-none relative after:content-[''] after:absolute after:left-0 after:bottom-0 after:h-[1px]
                after:bg-red-600 after:w-full"
              >
                <%= if has_assign?(assigns, :current_registry) do %>
                  <%= @current_registry.name %>
                <% else %>
                  <p>Company Registries</p>
                <% end %>
                <svg
                  id="registries-icon"
                  class="w-4 h-4 transition-transform duration-200 ease-in-out transform"
                  width="20"
                  height="20"
                  viewBox="0 0 20 20"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M5 7.5L10 12.5L15 7.5"
                    stroke="#092443"
                    stroke-width="1.66667"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </button>
              <div class="absolute top-0 left-0 right-0 z-50 mt-14">
                <div id="registries-menu" class="hidden pt-3 pb-1 rounded-b-lg shadow bg-backdrop">
                  <ul class="space-y-1">
                    <li
                      class="relative py-3 pr-3 cursor-default select-none bg-sky-50 text-primary-500 hover:cursor-pointer"
                      id="listbox-option-0"
                      role="option"
                    >
                      <div class="flex items-center text-sm leading-4">
                        <!-- Selected: "font-medium", Not Selected: "font-normal" -->
                        <span class="block ml-3 font-medium whitespace-nowrap">
                          <span>Company Registry</span>
                        </span>
                      </div>
                      <span class="absolute inset-y-0 right-0 flex items-center pr-4 text-primary-500">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          class="w-4 h-4"
                          width="16"
                          height="16"
                          viewBox="0 0 16 16"
                          fill="none"
                        >
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M8 16C12.4183 16 16 12.4183 16 8C16 3.58172 12.4183 0 8 0C3.58172 0 0 3.58172 0 8C0 12.4183 3.58172 16 8 16ZM11.7071 6.70711C12.0976 6.31658 12.0976 5.68342 11.7071 5.29289C11.3166 4.90237 10.6834 4.90237 10.2929 5.29289L7 8.58579L5.70711 7.29289C5.31658 6.90237 4.68342 6.90237 4.29289 7.29289C3.90237 7.68342 3.90237 8.31658 4.29289 8.70711L6.29289 10.7071C6.68342 11.0976 7.31658 11.0976 7.70711 10.7071L11.7071 6.70711Z"
                            fill="#0A2543"
                          />
                        </svg>
                      </span>
                    </li>
                    <%= for menu <- @registry_menu do %>
                      <div class="px-3 pt-3">
                        <div class="pb-2 mb-2 border-b border-stone-300">
                          <p class="text-xs font-medium uppercase text-gray-9s00">
                            <%= menu.title %>
                          </p>
                        </div>
                      </div>
                      <%= for link <- menu.menu_items do %>
                        <li class="px-4">
                          <a
                            href={link.path}
                            phx-click={JS.push("switch_registry")}
                            phx-value-slug={link.name}
                            phx-value-uri={link.path}
                            class="text-sm text-primary-500 font-medium py-1.5 hover:bg-gray-50 block"
                          >
                            <%= link.label %>
                          </a>
                        </li>
                      <% end %>
                    <% end %>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          <%= for link <- @menu_items do %>
            <nav class="flex flex-col">
              <div class="mb-2">
                <p class="text-xs font-normal text-primary-500 font-Lexend tracking-[4px]">
                  <%= link.title %>
                </p>
              </div>
              <ul role="list" class="flex flex-col flex-1 gap-y-7">
                <li>
                  <BrsWeb.MenuItem.menu_item
                    items={link.menu_items}
                    current_path={@current_path}
                    current_backend_user={@current_backend_user}
                  />
                </li>
              </ul>
            </nav>
          <% end %>
        </div>
      </div>
      <!-- /Static sidebar for desktop -->
    </div>
    """
  end

  attr :src, :string, required: false

  def logo(assigns) do
    ~H"""
    <a href="/">
      <div class="flex items-center gap-3">
        <div class="flex items-center shrink-0">
          <img class="w-44" src={@src} alt="BRS Logo" />
        </div>
      </div>
    </a>
    """
  end

  attr :current_user, :any
  attr :registries, :list
  attr :current_path, :any
  attr :current_registry, :any
  attr :current_backend_user, :any

  def registry_sidebar(assigns) do
    ~H"""
    <div class="hidden lg:block lg:col-span-2 xl:col-span-3">
      <nav
        aria-label="Sidebar"
        class="sticky overflow-hidden bg-white border rounded-lg md:sticky md:relative md:flex md:flex-col border-primary-910 top-4"
      >
        <div id="profile-switcher">
          <div class="p-2 border-b border-primary-910">
            <div class="relative max-w-full sm:w-full overflow-x-clip overscroll-x-contain">
              <button
                phx-click={JS.toggle_class("hidden", to: "#businesses-switcher")}
                type="button"
                class="relative max-w-full min-w-full py-2 pl-2 pr-10 text-left bg-gray-200 border-0 rounded-md cursor-default w-60 focus:font-medium focus:text-primary-600 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500 sm:text-sm ring-inset"
              >
                <div class="flex items-center text-sm leading-4">
                  <span class="block ml-1 truncate whitespace-nowrap">
                    <span class="text-xs font-medium text-black uppercase">individual Account</span>
                    <br />
                    <p class="pb-0 m-0 text-base font-semibold text-primary-500 group-hover:text-primary-500">
                      <%= BrsWeb.ViewHelpers.full_name(@current_user) %>
                    </p>
                  </span>
                </div>

                <span class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600 pointer-events-none">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                    class="w-5 h-5 ml-2 -mr-1 transition-transform duration-300 ease-linear transform rotate-0"
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
              <div
                id="businesses-switcher"
                class="mt-1 w-full absolute z-10 rounded-md bg-[#F5F6FA] border border-primary-910 shadow-md text-base ring-0 ring-black ring-opacity-5 focus:outline-none sm:text-sm overflow-x-clip hidden"
              >
                <div class="p-3 space-y-2 border-b">
                  <div class="flex flex-row items-center justify-between space-x-2">
                    <p class="ml-0 text-xs font-medium text-black uppercase truncate">Businesses</p>

                    <div class="ml-0" style="display: none;">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="10"
                        viewBox="0 0 16 10"
                        fill="none"
                      >
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M5.70711 9.70711C5.31658 10.0976 4.68342 10.0976 4.2929 9.70711L0.292894 5.70711C-0.0976312 5.31658 -0.0976312 4.68342 0.292894 4.29289L4.29289 0.292894C4.68342 -0.0976312 5.31658 -0.0976312 5.70711 0.292894C6.09763 0.683417 6.09763 1.31658 5.70711 1.70711L3.41421 4L15 4C15.5523 4 16 4.44771 16 5C16 5.55228 15.5523 6 15 6L3.41421 6L5.70711 8.29289C6.09763 8.68342 6.09763 9.31658 5.70711 9.70711Z"
                          fill="#0A2543"
                        >
                        </path>
                      </svg>
                    </div>
                  </div>

                  <div class="mx-0">
                    <form action="#" method="GET" class="flex w-full md:ml-0">
                      <label for="search-field" class="sr-only">Search</label>
                      <div class="relative w-full text-gray-400 bg-white rounded-lg focus-within:text-gray-600">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              d="M17.5 17.5L14.5834 14.5833M16.6667 9.58333C16.6667 13.4954 13.4954 16.6667 9.58333 16.6667C5.67132 16.6667 2.5 13.4954 2.5 9.58333C2.5 5.67132 5.67132 2.5 9.58333 2.5C13.4954 2.5 16.6667 5.67132 16.6667 9.58333Z"
                              stroke="#667085"
                              stroke-width="1.66667"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                            >
                            </path>
                          </svg>
                        </div>

                        <input
                          id="search-field"
                          placeholder="Search"
                          type="search"
                          name="search"
                          class="block w-full rounded-md border-0 py-1.5 pl-11 text-gray-900 ring-1 ring-inset ring-primary-910 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-primary-500 sm:text-sm sm:leading-6"
                        />
                      </div>
                    </form>
                  </div>
                </div>

                <ul class="w-full overflow-auto max-h-60 max-w-ful sm:w-full scrollbar scrollbar-thin">
                  <!---->
                  <li class="relative z-10 py-2 pl-3 text-gray-900 border-b cursor-default select-none group hover:underline pr-9 last:border-0">
                    <.link
                      href={"/registries/#{@current_registry.slug}/businesses/1905976/services"}
                      class="flex items-center"
                    >
                      <span class="block ml-0 font-medium capitalize truncate whitespace-nowrap group-hover:text-primary-600">
                        Business Test
                      </span>
                    </.link>
                    <span class="absolute right-0 flex items-center justify-center p-1 mr-3 text-white transform -translate-y-1/2 rounded cursor-pointer bg-primary-500 hover:bg-primary-300 h-fit group-hover:text-white top-1/2">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 8 12"
                        class="h-2.5 w-2.5"
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
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <div class="w-full p-4 border-b-2 border-primary-500 relative after:h-[6px] after:absolute after:w-[102px] after:bg-primary-700 after:right-0 after:-bottom-[6px] after:skew-x-[40deg] before:w-8 before:absolute before:h-[6px] before:bg-primary-700 before:right-0 before:-bottom-[6px]">
          <button class="flex items-center justify-between w-full text-sm font-medium text-left focus:outline-none focus-visible:ring focus-visible:ring-purple-500 focus-visible:ring-opacity-75">
            <div class="flex-shrink-0 block group">
              <div class="flex items-center">
                <div class="w-12 h-12 overflow-hidden border rounded-full border-primary-910">
                  <img
                    class="min-w-full min-h-full"
                    src="https://kbrs.pesaflow.com/images/ico-av-male-9b71320fc28c42ee0240a3d2519bfd26.svg?vsn=d"
                    alt=""
                  />
                </div>
                <div class="ml-3">
                  <p class="text-base font-semibold text-primary-500">
                    <%= BrsWeb.ViewHelpers.full_name(@current_user) %>
                  </p>
                  <p class="text-xs font-medium text-gray-900 uppercase">CITIZEN</p>
                </div>
              </div>
            </div>
          </button>
        </div>
        <BrsWeb.MenuItem.profile_menu_item items={@registries} current_path={@current_path} />

        <.support_contacts />
      </nav>
    </div>
    """
  end

  attr :current_user, :any
  attr :registries, :list
  attr :current_path, :any
  attr :current_registry, :any
  attr :current_backend_user, :any

  def business_sidebar(assigns) do
    ~H"""
    <div class="hidden lg:block lg:col-span-2 xl:col-span-3">
      <nav
        aria-label="Sidebar"
        class="sticky overflow-hidden bg-white border rounded-lg md:sticky md:relative md:flex md:flex-col border-primary-910 top-4"
      >
        <div id="vue-root-switcher">
          <div class="p-2 border-b border-primary-910">
            <div class="relative max-w-full sm:w-full overflow-x-clip overscroll-x-contain">
              <button
                phx-click={JS.toggle_class("hidden", to: "#individual-switcher")}
                type="button"
                class="relative max-w-full min-w-full py-2 pl-2 pr-10 text-left bg-gray-200 border-0 rounded-md cursor-default w-60 focus:font-medium focus:text-primary-600 focus:border-primary-500 focus:outline-none focus:ring-2 focus:ring-primary-500 sm:text-sm ring-inset"
              >
                <div class="flex items-center text-sm leading-4">
                  <span class="block ml-1 truncate whitespace-nowrap">
                    <span class="text-xs font-medium text-black uppercase">business Account</span>
                    <br />
                    <p class="pb-0 m-0 text-base font-semibold text-primary-500 group-hover:text-primary-500">
                      Business Test
                    </p>
                  </span>
                </div>

                <span class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600 pointer-events-none">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                    class="w-5 h-5 ml-2 -mr-1 transition-transform duration-300 ease-linear transform rotate-0"
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
              <div
                id="individual-switcher"
                class="mt-1 w-full absolute z-10 rounded-md bg-[#F5F6FA] border border-primary-910 shadow-md text-base ring-0 ring-black ring-opacity-5 focus:outline-none sm:text-sm overflow-x-clip hidden"
              >
                <div class="p-3 space-y-2 border-b">
                  <div class="flex flex-row items-center justify-between space-x-2">
                    <p class="ml-0 text-xs font-medium text-black uppercase truncate">Businesses</p>

                    <div class="ml-0" style="display: none;">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="10"
                        viewBox="0 0 16 10"
                        fill="none"
                      >
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M5.70711 9.70711C5.31658 10.0976 4.68342 10.0976 4.2929 9.70711L0.292894 5.70711C-0.0976312 5.31658 -0.0976312 4.68342 0.292894 4.29289L4.29289 0.292894C4.68342 -0.0976312 5.31658 -0.0976312 5.70711 0.292894C6.09763 0.683417 6.09763 1.31658 5.70711 1.70711L3.41421 4L15 4C15.5523 4 16 4.44771 16 5C16 5.55228 15.5523 6 15 6L3.41421 6L5.70711 8.29289C6.09763 8.68342 6.09763 9.31658 5.70711 9.70711Z"
                          fill="#0A2543"
                        >
                        </path>
                      </svg>
                    </div>
                  </div>

                  <div class="mx-0">
                    <form action="#" method="GET" class="flex w-full md:ml-0">
                      <label for="search-field" class="sr-only">Search</label>
                      <div class="relative w-full text-gray-400 bg-white rounded-lg focus-within:text-gray-600">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              d="M17.5 17.5L14.5834 14.5833M16.6667 9.58333C16.6667 13.4954 13.4954 16.6667 9.58333 16.6667C5.67132 16.6667 2.5 13.4954 2.5 9.58333C2.5 5.67132 5.67132 2.5 9.58333 2.5C13.4954 2.5 16.6667 5.67132 16.6667 9.58333Z"
                              stroke="#667085"
                              stroke-width="1.66667"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                            >
                            </path>
                          </svg>
                        </div>

                        <input
                          id="search-field"
                          placeholder="Search"
                          type="search"
                          name="search"
                          class="block w-full rounded-md border-0 py-1.5 pl-11 text-gray-900 ring-1 ring-inset ring-primary-910 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-primary-500 sm:text-sm sm:leading-6"
                        />
                      </div>
                    </form>
                  </div>
                </div>

                <ul class="w-full overflow-auto max-h-60 max-w-ful sm:w-full scrollbar scrollbar-thin">
                  <li class="relative z-10 py-2 pl-3 text-gray-900 border-b cursor-default select-none group hover:underline pr-9 last:border-0">
                    <a
                      href={"/registries/#{@current_registry.slug}/dashboard"}
                      class="flex items-center"
                    >
                      <span class="block ml-0 font-medium capitalize truncate whitespace-nowrap group-hover:text-primary-600">
                        Individual Account
                      </span>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <!-- user profile widget -->
        <div class="w-full p-4 border-b-2 border-primary-500 relative after:h-[6px] after:absolute after:w-[102px] after:bg-primary-700 after:right-0 after:-bottom-[6px] after:skew-x-[40deg] before:w-8 before:absolute before:h-[6px] before:bg-primary-700 before:right-0 before:-bottom-[6px]">
          <div class="flex items-center justify-start w-full text-sm font-medium text-left focus:outline-none focus-visible:ring focus-visible:ring-purple-500 focus-visible:ring-opacity-75">
            <div class="w-12 h-12">
              <svg
                width="50"
                height="47"
                viewBox="0 0 50 47"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <rect
                  x="0.522222"
                  y="0.522222"
                  width="48.0445"
                  height="45.9556"
                  rx="7.83333"
                  fill="#F9FAFB"
                >
                </rect>
                <path
                  d="M35.1195 24.9751C31.8538 26.297 28.2842 27.025 24.5445 27.025C20.8048 27.025 17.2352 26.297 13.9695 24.9751M29.2445 16.45V14.1C29.2445 12.8021 28.1924 11.75 26.8945 11.75H22.1945C20.8966 11.75 19.8445 12.8021 19.8445 14.1V16.45M24.5445 23.5H24.5562M16.3195 32.9H32.7695C34.0674 32.9 35.1195 31.8479 35.1195 30.55V18.8C35.1195 17.5021 34.0674 16.45 32.7695 16.45H16.3195C15.0216 16.45 13.9695 17.5021 13.9695 18.8V30.55C13.9695 31.8479 15.0216 32.9 16.3195 32.9Z"
                  stroke="#111827"
                  stroke-width="2.08889"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                </path>
                <rect
                  x="0.522222"
                  y="0.522222"
                  width="48.0445"
                  height="45.9556"
                  rx="7.83333"
                  stroke="#B2B9C0"
                  stroke-width="1.04444"
                >
                </rect>
              </svg>
            </div>
            <div class="ml-3 truncate whitespace-nowrap">
              <p class="text-base font-bold truncate text-primary-500 whitespace-nowrap">
                Business Test
              </p>
              <p class="text-xs font-medium text-gray-900 uppercase">BUSINESS NAME</p>
            </div>
          </div>
        </div>
        <!-- main nav -->
        <BrsWeb.MenuItem.profile_menu_item items={@registries} current_path={@current_path} />
        <!-- support contacts -->
        <.support_contacts />
      </nav>
    </div>
    """
  end

  def support_contacts(assigns) do
    ~H"""
    <div class="p-5 pt-[80px]">
      <div class="mt-0 bg-primary-920 font-normal text-white rounded-r-lg p-4 border-l-2 border-primary-500 relative after:h-[102px] after:absolute after:w-[6px] after:bg-primary-700 after:-left-[6px] after:bottom-1 after:-skew-y-[40deg] before:w-[6px] before:absolute before:h-[40px] before:bg-primary-700 before:-left-[6px] before:bottom-0">
        <div class="mb-6">
          <p class="text-xl font-semibold text-primary-500">Need Help?</p>
        </div>
        <div class="space-y-4">
          <div>
            <p class="text-base font-semibold text-primary-500">
              Business Registration Service Customer Care
            </p>
          </div>
          <div>
            <p class="mb-1 text-sm font-semibold text-primary-500">Call Us</p>
            <ul class="m-0 text-sm font-medium text-primary-500">
              <li>+254 11 112 7000</li>
            </ul>
          </div>
          <div>
            <p class="mb-1 text-sm font-semibold text-primary-500">Visit Us</p>
            <ul class="m-0 text-sm font-medium text-primary-500">
              <li>17th Floor, 316 UpperHill Chambers,</li>
              <li>2nd Ngong Avenue, Nairobi, Kenya</li>
              <li>P. O. Box 30404-00100</li>
            </ul>
          </div>
          <div>
            <p class="mb-1 text-sm font-semibold text-primary-500">Our Working hours</p>
            <ul class="m-0 text-sm font-medium text-primary-500">
              <li>9:00am to 5:00pm,</li>
              <li>Monday to Friday</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp has_assign?(assigns, key) do
    Map.has_key?(assigns, key)
  end
end

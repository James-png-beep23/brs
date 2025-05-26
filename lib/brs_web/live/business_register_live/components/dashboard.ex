defmodule BrsWeb.BusinessRegisterLive.Components.Dashboard do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{registry: current_registry} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(init_tabs(String.to_atom(current_registry.slug)))}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mt-4 mb-6">
      <%= if @registry.slug == "brs" do %>
        <div class="enable-bootstrap">
          <div
            class="items-center justify-between px-4 pb-3 overflow-hidden border-2 rounded-lg sm:flex bg-soft sm:px-6 sm:pb-0 border-primary alert alert-info"
            style="background-color:#BEDBFE;border:none"
          >
            <div class="flex items-end max-w-lg sm:space-x-2 xl:max-w-xl 2xl:max-w-3xl">
              <div class="hidden w-40 mr-2 sm:inline-block xl:w-44 2xl:pt-2">
                <img
                  alt=""
                  class=""
                  src="https://kbrs.pesaflow.com/resources/download/brief-case-svg"
                />
              </div>
              <div class="self-center pt-3 pb-3">
                <div class="px-0 space-y-2 sm:px-4 sm:space-y-1">
                  <h3 class="text-lg font-bold leading-6 text-gray-900 md:text-xl">
                    Link a Business
                  </h3>
                  <p class="text-sm font-medium text-gray-600 xl:text-sm">
                    Did you register your business before 2017 and require up-to-date documents? Link your business today free of charge and access all BRS services Online.
                    <br />
                    <span class="text-black">This service is free</span>
                  </p>
                </div>
              </div>
            </div>
            <div class="flex justify-end sm:ml-4">
              <a
                class="btn btn-info"
                href={~p"/"}
                style="background-color:#ffffff;color:#082443;font-weight: 700;border:none"
              >
                Start Now
              </a>
            </div>
          </div>
        </div>
      <% end %>
      <.live_component
        module={BrsWeb.BusinessRegisterLive.Components.DashboardNavComponent}
        tabs={@tabs}
        active_tab={@active_tab}
        current_user={@current_user}
        current_registry={@registry}
        current_account={@current_account}
        id="dashboard-nav"
      />
    </div>
    """
  end

  defp init_tabs(:mpsr) do
    %{
      tabs: [
        %{
          id: 1,
          title: "Notices",
          mod: BrsWeb.BusinessRegisterLive.Components.Notices
        },
        %{
          id: 2,
          title: "Businesses",
          mod: BrsWeb.BusinessRegisterLive.Components.Business
        },
        %{
          id: 3,
          title: "Other Organisations",
          mod: BrsWeb.BusinessRegisterLive.Components.Corrections
        },
        %{
          id: 4,
          title: "Searches",
          mod: BrsWeb.BusinessRegisterLive.Components.ApplicationHistory
        },
        %{
          id: 5,
          title: "Application History",
          mod: BrsWeb.BusinessRegisterLive.Components.ApplicationHistory
        }
      ],
      active_tab: 1
    }
  end

  defp init_tabs(slug) when slug in [:brs, :or, :trustees] do
    %{
      tabs: [
        %{
          id: 1,
          title: "Make Application",
          mod: BrsWeb.BusinessRegisterLive.Components.Services
        },
        %{
          id: 2,
          title: "Businesses",
          mod: BrsWeb.BusinessRegisterLive.Components.Business
        },
        %{
          id: 3,
          title: "Corrections",
          mod: BrsWeb.BusinessRegisterLive.Components.Corrections
        },
        %{
          id: 4,
          title: "Application History",
          mod: BrsWeb.BusinessRegisterLive.Components.ApplicationHistory
        }
      ],
      active_tab: 1
    }
  end

  defp init_tabs(_) do
    %{tabs: [], active_tab: nil}
  end
end

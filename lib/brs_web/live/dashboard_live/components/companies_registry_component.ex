defmodule BrsWeb.DashboardLive.CompaniesRegistryComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok,
     assign(
       socket,
       chart_data()
     )}
  end

  defp chart_data() do
    %{
      total_revenue: [60, 65, 68, 70, 75, 70, 68, 78, 80, 65, 58, 60, 65],
      task_distribution: [
        %{
          name: "Queue",
          y: 734,
          color: "#ED2926"
        },
        %{
          name: "Pending",
          y: 440,
          color: "#0068FF"
        },
        %{
          name: "Corrections",
          y: 293,
          color: "#0047BA"
        },
        %{
          name: "Completed",
          y: 283,
          color: "#20903C"
        }
      ],
      task_completion: [
        ["Completed", 734],
        ["Incomplete Tasks", 440]
      ],
      registry_tasks: [2039, 7231, 9106, 6129, 3144, 4176, 7135, 9148, 2216, 3194, 1095, 754],
      registry_applications: [
        %{
          name: "Companies",
          color: "#0A2543",
          data: [2, 4.48, 6.41, 2.51, 2, 4, 7.45, 5, 3, 6, 1, 7]
        },
        %{
          name: "MPSR",
          color: "#17569B",
          data: [2, 4.48, 6.41, 2.51, 6, 4, 7.45, 5, 3, 6, 1, 7]
        },
        %{
          name: "Official Receiver",
          color: "#2A80DF",
          data: [2, 4.48, 6.41, 2.51, 0, 4, 7.45, 5, 3, 6, 1, 7]
        },
        %{
          name: "Hire Purchases",
          color: "#83B5EC",
          borderRadiusTopLeft: 8,
          data: [8.63, 5, 3, 6, 1, 6.63, 2.63, 4.63, 5.63, 7.63, 8.63, 2.63]
        }
      ]
    }
  end
end

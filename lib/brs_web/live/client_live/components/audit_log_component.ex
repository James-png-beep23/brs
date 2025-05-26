defmodule BrsWeb.ClientLive.AuditLogComponent do
  use BrsWeb, :live_component

  use Brs.AuditTrails,
    repo: Brs.Repo,
    schema: Brs.AuditLog

  def update(%{client: client} = assigns, socket) do
    audit_logs =
      case client.user_id do
        nil ->
          []

        id ->
          list_audits(%{user_id: id, resource: "applications"})
      end

    user_application_audit_logs = fetch_application_records_from_audit_logs(audit_logs)

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(audit_trails: user_application_audit_logs)
    }
  end

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div>
        <div class="inline-flex items-center justify-start px-4 py-2 space-x-3 bg-white rounded-full">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="18"
            height="18"
            viewBox="0 0 18 18"
            fill="none"
          >
            <path
              d="M9 0.875C7.39303 0.875 5.82214 1.35152 4.486 2.24431C3.14985 3.1371 2.10844 4.40605 1.49348 5.8907C0.87852 7.37535 0.717618 9.00901 1.03112 10.5851C1.34463 12.1612 2.11846 13.6089 3.25476 14.7452C4.39106 15.8815 5.8388 16.6554 7.4149 16.9689C8.99099 17.2824 10.6247 17.1215 12.1093 16.5065C13.594 15.8916 14.8629 14.8502 15.7557 13.514C16.6485 12.1779 17.125 10.607 17.125 9C17.1227 6.84581 16.266 4.78051 14.7427 3.25727C13.2195 1.73403 11.1542 0.877275 9 0.875ZM9 15.875C7.64026 15.875 6.31105 15.4718 5.18046 14.7164C4.04987 13.9609 3.16868 12.8872 2.64833 11.6309C2.12798 10.3747 1.99183 8.99237 2.2571 7.65875C2.52238 6.32513 3.17716 5.10013 4.13864 4.13864C5.10013 3.17716 6.32514 2.52237 7.65876 2.2571C8.99238 1.99183 10.3747 2.12798 11.631 2.64833C12.8872 3.16868 13.9609 4.04987 14.7164 5.18045C15.4718 6.31104 15.875 7.64025 15.875 9C15.8729 10.8227 15.1479 12.5702 13.8591 13.8591C12.5702 15.1479 10.8227 15.8729 9 15.875ZM10.25 12.75C10.25 12.9158 10.1842 13.0747 10.0669 13.1919C9.94974 13.3092 9.79076 13.375 9.625 13.375C9.29348 13.375 8.97554 13.2433 8.74112 13.0089C8.5067 12.7745 8.375 12.4565 8.375 12.125V9C8.20924 9 8.05027 8.93415 7.93306 8.81694C7.81585 8.69973 7.75 8.54076 7.75 8.375C7.75 8.20924 7.81585 8.05027 7.93306 7.93306C8.05027 7.81585 8.20924 7.75 8.375 7.75C8.70652 7.75 9.02447 7.8817 9.25889 8.11612C9.49331 8.35054 9.625 8.66848 9.625 9V12.125C9.79076 12.125 9.94974 12.1908 10.0669 12.3081C10.1842 12.4253 10.25 12.5842 10.25 12.75ZM7.75 5.5625C7.75 5.37708 7.80499 5.19582 7.908 5.04165C8.01101 4.88748 8.15743 4.76732 8.32874 4.69636C8.50004 4.62541 8.68854 4.60684 8.8704 4.64301C9.05226 4.67919 9.2193 4.76848 9.35042 4.89959C9.48153 5.0307 9.57082 5.19775 9.60699 5.3796C9.64316 5.56146 9.6246 5.74996 9.55364 5.92127C9.48268 6.09257 9.36252 6.23899 9.20835 6.342C9.05418 6.44502 8.87292 6.5 8.6875 6.5C8.43886 6.5 8.20041 6.40123 8.02459 6.22541C7.84878 6.0496 7.75 5.81114 7.75 5.5625Z"
              fill="#344054"
            />
          </svg>

          <p class="text-sm font-medium text-gray-700 sm:text-base">
            Only showing recent tasks
          </p>
        </div>
      </div>

      <div>
        <!-- table content -->
        <div class="flex flex-col mb-4">
          <div class="sm:overflow-auto lg:overflow-visible">
            <!-- Table Desktop -->
            <div class="hidden w-full align-middle sm:block">
              <div class="pb-4 divide-y divide-gray-200 rounded-lg shadow sm:overflow-x-auto ring-1 ring-black ring-opacity-5 sm:pb-0">
                <table class="min-w-full divide-y divide-gray-300 table-auto">
                  <thead class="bg-gray-50">
                    <tr>
                      <th
                        scope="col"
                        class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-600 sm:pl-4"
                      >
                        Date
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Action
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Application
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Comment
                      </th>
                    </tr>
                  </thead>
                  <tbody class="bg-white divide-y divide-gray-200">
                    <%= for audit_trail <- @audit_trails do %>
                      <tr>
                        <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                          <div>
                            <p class="text-sm font-medium text-gray-900">
                              <%= date_format_sht(audit_trail.audit_log.inserted_at) %>
                            </p>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <p class="text-sm font-normal text-gray-500 capitalize">
                              <%= audit_trail.audit_log.action %>
                            </p>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <p class="text-sm font-normal text-gray-500">
                              <%= audit_trail.record.application_number %>
                            </p>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <p class="text-sm font-normal text-gray-500">
                              N/A
                            </p>
                          </div>
                        </td>
                      </tr>
                    <% end %>
                  </tbody>
                </table>
                <nav
                  class="flex items-center justify-between px-3 py-3 pr-4 bg-white border-t border-gray-300 sm:pr-6"
                  aria-label="Pagination"
                >
                  <div class="block">
                    <p class="text-sm text-gray-700">
                      Showing <span class="font-medium">1</span>
                      to <span class="font-medium">2</span>
                      of <span class="font-medium">2</span>
                      results
                    </p>
                  </div>
                  <div class="flex justify-between sm:justify-end">
                    <!-- Active:  class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50"  -->
                    <a
                      href="#"
                      class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md cursor-not-allowed hover:bg-gray-50"
                    >
                      Previous
                    </a>
                    <a
                      href="#"
                      class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md cursor-not-allowed hover:bg-gray-50"
                    >
                      Next
                    </a>
                  </div>
                </nav>
              </div>
            </div>
            <!-- Mobile table -->
            <div class="block bg-white divide-y divide-gray-300 rounded-lg shadow sm:hidden">
              <%= for audit_trail <- @audit_trails do %>
                <div class="w-full p-3 mx-auto">
                  <button
                    type="button"
                    aria-expanded="true"
                    class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                    aria-controls="headlessui-disclosure-panel-119"
                  >
                    <div>
                      <p class="mb-2 text-sm font-medium text-gray-900">Action</p>
                      <p class="text-sm font-medium text-gray-700 capitalize">
                        <%= audit_trail.audit_log.action %>
                      </p>
                    </div>
                    <span
                      phx-click={
                        JS.toggle(
                          to: "#audit-card#{audit_trail.audit_log.id}",
                          in: "block",
                          out: "hidden"
                        )
                        |> JS.toggle_class(
                          "rotate-0 rotate-180",
                          to: "#audit-card-icon#{audit_trail.audit_log.id}"
                        )
                      }
                      class="inline-block p-0.5 border rounded-md border-gray-400"
                    >
                      <svg
                        id={"audit-card-icon#{audit_trail.audit_log.id}"}
                        class="w-5 h-5 text-gray-500 rotate-180"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke-width="2"
                        stroke="currentColor"
                        aria-hidden="true"
                      >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7"></path>
                      </svg>
                    </span>
                  </button>
                  <div id={"audit-card#{audit_trail.audit_log.id}"} class="hidden">
                    <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Date</p>
                        <p class="text-sm font-normal text-gray-900">
                          <%= date_format_sht(audit_trail.audit_log.inserted_at) %>
                        </p>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Action</p>
                        <p class="text-sm font-normal text-gray-900 capitalize">
                          <%= audit_trail.audit_log.action %>
                        </p>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Application</p>
                        <div>
                          <p class="text-sm font-normal text-gray-900">
                            <%= audit_trail.record.application_number %>
                          </p>
                        </div>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Comment</p>
                        <div>
                          <p class="text-sm font-normal text-gray-900">
                            N/A
                          </p>
                        </div>
                      </div>
                    </div>
                    <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                      <a
                        href={
                          ~p"/admin/registries/#{@current_registry.slug}/applications/#{audit_trail.record.id}"
                        }
                        class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                      >
                        View
                      </a>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp fetch_application_records_from_audit_logs(audit_logs) do
    Enum.map(audit_logs, fn audit_log ->
      record = Brs.Repo.get(Brs.Applications.Application, audit_log.record_id)

      %{
        audit_log: audit_log,
        record: record
      }
    end)
  end
end

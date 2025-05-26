defmodule BrsWeb.MenuItem do
  use Phoenix.Component

  import BrsWeb.ViewHelpers

  attr :items, :list, required: true
  attr :current_backend_user, :any, required: true
  attr :current_path, :any

  def menu_item(assigns) do
    ~H"""
    <ul role="list" class="space-y-2">
      <%= for link <- @items do %>
        <%= if (is_nil(link.action) and is_nil(link.resource)) or (@current_backend_user && can?(@current_backend_user, link.action, link.resource)) do %>
          <li>
            <.link
              navigate={link.path}
              class={"#{if current_page(@current_path, link.path), do: "bg-primary-500 text-white", else: "bg-white text-slate-700 hover:bg-gray-50 "} text-base font-semibold leading-normal rounded-md px-3 py-2 flex items-center gap-3"}
            >
              <.svg_icon current_path={@current_path} icon={link.icon} path={link.path} />
              <%= link.label %>
            </.link>
          </li>
        <% end %>
      <% end %>
    </ul>
    """
  end

  attr :items, :list, required: true
  attr :current_path, :any

  def profile_menu_item(assigns) do
    ~H"""
    <div class="p-4 pt-[60px] space-y-1">
      <%= for link <- @items do %>
        <.link
          patch={link.path}
          class={"flex items-center px-4 py-2 text-sm font-medium group rounded-r-md  #{if current_page(@current_path, link.path), do: "bg-primary-500 text-white border-primary-700 border-l-4 hover:bg-primary-500",
          else: "text-primary-500 hover:bg-gray-50 hover:text-primary-500 hover:border-gray-50"}
             "}
        >
          <.svg_icon current_path={@current_path} icon={link.icon} path={link.path} />
          <%= link.label %>
        </.link>
      <% end %>
    </div>
    """
  end

  attr :current_path, :string, required: true
  attr :icon, :atom
  attr :path, :string

  defp svg_icon(%{icon: :dashboard} = assigns) do
    ~H"""
    <svg width="24" height="25" viewBox="0 0 24 25" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M8 17.987H16M11.0177 3.75106L4.23539 9.02619C3.78202 9.37881 3.55534 9.55512 3.39203 9.77592C3.24737 9.9715 3.1396 10.1918 3.07403 10.4261C3 10.6906 3 10.9778 3 11.5521V18.787C3 19.9071 3 20.4672 3.21799 20.895C3.40973 21.2713 3.71569 21.5773 4.09202 21.7691C4.51984 21.987 5.07989 21.987 6.2 21.987H17.8C18.9201 21.987 19.4802 21.987 19.908 21.7691C20.2843 21.5773 20.5903 21.2713 20.782 20.895C21 20.4672 21 19.9071 21 18.787V11.5521C21 10.9778 21 10.6906 20.926 10.4261C20.8604 10.1918 20.7526 9.9715 20.608 9.77592C20.4447 9.55512 20.218 9.37881 19.7646 9.02619L12.9823 3.75106C12.631 3.47781 12.4553 3.34118 12.2613 3.28866C12.0902 3.24232 11.9098 3.24232 11.7387 3.28866C11.5447 3.34118 11.369 3.47781 11.0177 3.75106Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :applications} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="22" viewBox="0 0 18 22" fill="none">
      <path
        d="M11 1.26953V5.40007C11 5.96012 11 6.24015 11.109 6.45406C11.2049 6.64222 11.3578 6.7952 11.546 6.89108C11.7599 7.00007 12.0399 7.00007 12.6 7.00007H16.7305M11 16H5M13 12H5M17 8.98822V16.2C17 17.8802 17 18.7202 16.673 19.362C16.3854 19.9265 15.9265 20.3854 15.362 20.673C14.7202 21 13.8802 21 12.2 21H5.8C4.11984 21 3.27976 21 2.63803 20.673C2.07354 20.3854 1.6146 19.9265 1.32698 19.362C1 18.7202 1 17.8802 1 16.2V5.8C1 4.11984 1 3.27976 1.32698 2.63803C1.6146 2.07354 2.07354 1.6146 2.63803 1.32698C3.27976 1 4.11984 1 5.8 1H9.01178C9.74555 1 10.1124 1 10.4577 1.08289C10.7638 1.15638 11.0564 1.27759 11.3249 1.44208C11.6276 1.6276 11.887 1.88703 12.4059 2.40589L15.5941 5.59411C16.113 6.11297 16.3724 6.3724 16.5579 6.67515C16.7224 6.94356 16.8436 7.2362 16.9171 7.5423C17 7.88757 17 8.25445 17 8.98822Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :tasks} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
      <path
        d="M5 14L7 16L11.5 11.5M7 7V4.2C7 3.0799 7 2.51984 7.21799 2.09202C7.40973 1.71569 7.71569 1.40973 8.09202 1.21799C8.51984 1 9.07989 1 10.2 1H17.8C18.9201 1 19.4802 1 19.908 1.21799C20.2843 1.40973 20.5903 1.71569 20.782 2.09202C21 2.51984 21 3.0799 21 4.2V11.8C21 12.9201 21 13.4802 20.782 13.908C20.5903 14.2843 20.2843 14.5903 19.908 14.782C19.4802 15 18.9201 15 17.8 15H15M4.2 21H11.8C12.9201 21 13.4802 21 13.908 20.782C14.2843 20.5903 14.5903 20.2843 14.782 19.908C15 19.4802 15 18.9201 15 17.8V10.2C15 9.07989 15 8.51984 14.782 8.09202C14.5903 7.71569 14.2843 7.40973 13.908 7.21799C13.4802 7 12.9201 7 11.8 7H4.2C3.0799 7 2.51984 7 2.09202 7.21799C1.71569 7.40973 1.40973 7.71569 1.21799 8.09202C1 8.51984 1 9.07989 1 10.2V17.8C1 18.9201 1 19.4802 1.21799 19.908C1.40973 20.2843 1.71569 20.5903 2.09202 20.782C2.51984 21 3.07989 21 4.2 21Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :billing} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="18" viewBox="0 0 22 18" fill="none">
      <path
        d="M18 17V11M15 14H21M21 6H1M21 8V4.2C21 3.0799 21 2.51984 20.782 2.09202C20.5903 1.7157 20.2843 1.40974 19.908 1.21799C19.4802 1 18.9201 1 17.8 1H4.2C3.0799 1 2.51984 1 2.09202 1.21799C1.7157 1.40973 1.40973 1.71569 1.21799 2.09202C1 2.51984 1 3.0799 1 4.2V11.8C1 12.9201 1 13.4802 1.21799 13.908C1.40973 14.2843 1.71569 14.5903 2.09202 14.782C2.51984 15 3.0799 15 4.2 15H11"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :reports} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
      <path
        d="M6 11V15M14 9V15M10 5V15M5.8 19H14.2C15.8802 19 16.7202 19 17.362 18.673C17.9265 18.3854 18.3854 17.9265 18.673 17.362C19 16.7202 19 15.8802 19 14.2V5.8C19 4.11984 19 3.27976 18.673 2.63803C18.3854 2.07354 17.9265 1.6146 17.362 1.32698C16.7202 1 15.8802 1 14.2 1H5.8C4.11984 1 3.27976 1 2.63803 1.32698C2.07354 1.6146 1.6146 2.07354 1.32698 2.63803C1 3.27976 1 4.11984 1 5.8V14.2C1 15.8802 1 16.7202 1.32698 17.362C1.6146 17.9265 2.07354 18.3854 2.63803 18.673C3.27976 19 4.11984 19 5.8 19Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :clients} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
      <path
        d="M15 16L17 18L21 14M11 13H7C5.13623 13 4.20435 13 3.46927 13.3045C2.48915 13.7105 1.71046 14.4892 1.30448 15.4693C1 16.2044 1 17.1362 1 19M14.5 1.29076C15.9659 1.88415 17 3.32131 17 5C17 6.67869 15.9659 8.11585 14.5 8.70924M12.5 5C12.5 7.20914 10.7091 9 8.5 9C6.29086 9 4.5 7.20914 4.5 5C4.5 2.79086 6.29086 1 8.5 1C10.7091 1 12.5 2.79086 12.5 5Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :staffs} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
      <path
        d="M21 19V17C21 15.1362 19.7252 13.5701 18 13.126M14.5 1.29076C15.9659 1.88415 17 3.32131 17 5C17 6.67869 15.9659 8.11585 14.5 8.70924M16 19C16 17.1362 16 16.2044 15.6955 15.4693C15.2895 14.4892 14.5108 13.7105 13.5307 13.3045C12.7956 13 11.8638 13 10 13H7C5.13623 13 4.20435 13 3.46927 13.3045C2.48915 13.7105 1.71046 14.4892 1.30448 15.4693C1 16.2044 1 17.1362 1 19M12.5 5C12.5 7.20914 10.7091 9 8.5 9C6.29086 9 4.5 7.20914 4.5 5C4.5 2.79086 6.29086 1 8.5 1C10.7091 1 12.5 2.79086 12.5 5Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :access_control} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="22"
      height="20"
      viewBox="0 0 512 512"
      fill={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
    >
      <g>
        <g>
          <g>
            <path d="m256,501c-4,0-8-1.2-11.4-3.5-147.3-99.1-232.4-247.2-233.6-406.4-0.1-9.3 6.2-17.5 15.2-19.9l224.6-59.6c3.4-0.9 7-0.9 10.5,0l224.6,59.6c9,2.4 15.2,10.6 15.2,19.9-1.1,159.1-86.3,307.3-233.6,406.4-3.5,2.3-7.5,3.5-11.5,3.5zm-203.7-394.4c6.2,135.4 79.6,261.3 203.7,349.2 124.1-87.9 197.5-213.8 203.7-349.2l-203.7-54.1-203.7,54.1z" />
          </g>
        </g>
      </g>
    </svg>
    """
  end

  defp svg_icon(%{icon: :announcements} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
      <path
        d="M3 12.9999L4.57465 19.2985C4.61893 19.4756 4.64107 19.5642 4.66727 19.6415C4.92317 20.397 5.60352 20.9282 6.39852 20.9933C6.4799 20.9999 6.5712 20.9999 6.75379 20.9999C6.98244 20.9999 7.09677 20.9999 7.19308 20.9906C8.145 20.8982 8.89834 20.1449 8.99066 19.193C9 19.0967 9 18.9823 9 18.7537V4.49991M17.5 12.4999C19.433 12.4999 21 10.9329 21 8.99991C21 7.06691 19.433 5.49991 17.5 5.49991M9.25 4.49991H5.5C3.01472 4.49991 0.999998 6.51463 1 8.99991C1 11.4852 3.01472 13.4999 5.5 13.4999H9.25C11.0164 13.4999 13.1772 14.4468 14.8443 15.3556C15.8168 15.8857 16.3031 16.1508 16.6216 16.1118C16.9169 16.0756 17.1402 15.943 17.3133 15.701C17.5 15.4401 17.5 14.9179 17.5 13.8736V4.1262C17.5 3.08191 17.5 2.55976 17.3133 2.2988C17.1402 2.05681 16.9169 1.92421 16.6216 1.88804C16.3031 1.84903 15.8168 2.11411 14.8443 2.64427C13.1772 3.55302 11.0164 4.49991 9.25 4.49991Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :companies} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
      <path
        d="M15 5C15 4.07003 15 3.60504 14.8978 3.22354C14.6204 2.18827 13.8117 1.37962 12.7765 1.10222C12.395 1 11.93 1 11 1C10.07 1 9.60504 1 9.22354 1.10222C8.18827 1.37962 7.37962 2.18827 7.10222 3.22354C7 3.60504 7 4.07003 7 5M4.2 19H17.8C18.9201 19 19.4802 19 19.908 18.782C20.2843 18.5903 20.5903 18.2843 20.782 17.908C21 17.4802 21 16.9201 21 15.8V8.2C21 7.07989 21 6.51984 20.782 6.09202C20.5903 5.71569 20.2843 5.40973 19.908 5.21799C19.4802 5 18.9201 5 17.8 5H4.2C3.07989 5 2.51984 5 2.09202 5.21799C1.71569 5.40973 1.40973 5.71569 1.21799 6.09202C1 6.51984 1 7.07989 1 8.2V15.8C1 16.9201 1 17.4802 1.21799 17.908C1.40973 18.2843 1.71569 18.5903 2.09202 18.782C2.51984 19 3.0799 19 4.2 19Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :name_search} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
      <path
        d="M19 19L14.65 14.65M9 4C11.7614 4 14 6.23858 14 9M17 9C17 13.4183 13.4183 17 9 17C4.58172 17 1 13.4183 1 9C1 4.58172 4.58172 1 9 1C13.4183 1 17 4.58172 17 9Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :business_owners} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
      <path
        d="M15 16L17 18L21 14M11 13H7C5.13623 13 4.20435 13 3.46927 13.3045C2.48915 13.7105 1.71046 14.4892 1.30448 15.4693C1 16.2044 1 17.1362 1 19M14.5 1.29076C15.9659 1.88415 17 3.32131 17 5C17 6.67869 15.9659 8.11585 14.5 8.70924M12.5 5C12.5 7.20914 10.7091 9 8.5 9C6.29086 9 4.5 7.20914 4.5 5C4.5 2.79086 6.29086 1 8.5 1C10.7091 1 12.5 2.79086 12.5 5Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :beneficial_owners} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
      <path
        d="M21 19V17C21 15.1362 19.7252 13.5701 18 13.126M14.5 1.29076C15.9659 1.88415 17 3.32131 17 5C17 6.67869 15.9659 8.11585 14.5 8.70924M16 19C16 17.1362 16 16.2044 15.6955 15.4693C15.2895 14.4892 14.5108 13.7105 13.5307 13.3045C12.7956 13 11.8638 13 10 13H7C5.13623 13 4.20435 13 3.46927 13.3045C2.48915 13.7105 1.71046 14.4892 1.30448 15.4693C1 16.2044 1 17.1362 1 19M12.5 5C12.5 7.20914 10.7091 9 8.5 9C6.29086 9 4.5 7.20914 4.5 5C4.5 2.79086 6.29086 1 8.5 1C10.7091 1 12.5 2.79086 12.5 5Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :hire_purchase} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="22" viewBox="0 0 18 22" fill="none">
      <path
        d="M11 1.26953V5.40007C11 5.96012 11 6.24015 11.109 6.45406C11.2049 6.64222 11.3578 6.7952 11.546 6.89108C11.7599 7.00007 12.0399 7.00007 12.6 7.00007H16.7305M11 16H5M13 12H5M17 8.98822V16.2C17 17.8802 17 18.7202 16.673 19.362C16.3854 19.9265 15.9265 20.3854 15.362 20.673C14.7202 21 13.8802 21 12.2 21H5.8C4.11984 21 3.27976 21 2.63803 20.673C2.07354 20.3854 1.6146 19.9265 1.32698 19.362C1 18.7202 1 17.8802 1 16.2V5.8C1 4.11984 1 3.27976 1.32698 2.63803C1.6146 2.07354 2.07354 1.6146 2.63803 1.32698C3.27976 1 4.11984 1 5.8 1H9.01178C9.74555 1 10.1124 1 10.4577 1.08289C10.7638 1.15638 11.0564 1.27759 11.3249 1.44208C11.6276 1.6276 11.887 1.88703 12.4059 2.40589L15.5941 5.59411C16.113 6.11297 16.3724 6.3724 16.5579 6.67515C16.7224 6.94356 16.8436 7.2362 16.9171 7.5423C17 7.88757 17 8.25445 17 8.98822Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :ip_register} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
      <path
        d="M19 19L14.65 14.65M9 4C11.7614 4 14 6.23858 14 9M17 9C17 13.4183 13.4183 17 9 17C4.58172 17 1 13.4183 1 9C1 4.58172 4.58172 1 9 1C13.4183 1 17 4.58172 17 9Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :mpsr} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
      <path
        d="M15 5C15 4.07003 15 3.60504 14.8978 3.22354C14.6204 2.18827 13.8117 1.37962 12.7765 1.10222C12.395 1 11.93 1 11 1C10.07 1 9.60504 1 9.22354 1.10222C8.18827 1.37962 7.37962 2.18827 7.10222 3.22354C7 3.60504 7 4.07003 7 5M4.2 19H17.8C18.9201 19 19.4802 19 19.908 18.782C20.2843 18.5903 20.5903 18.2843 20.782 17.908C21 17.4802 21 16.9201 21 15.8V8.2C21 7.07989 21 6.51984 20.782 6.09202C20.5903 5.71569 20.2843 5.40973 19.908 5.21799C19.4802 5 18.9201 5 17.8 5H4.2C3.07989 5 2.51984 5 2.09202 5.21799C1.71569 5.40973 1.40973 5.71569 1.21799 6.09202C1 6.51984 1 7.07989 1 8.2V15.8C1 16.9201 1 17.4802 1.21799 17.908C1.40973 18.2843 1.71569 18.5903 2.09202 18.782C2.51984 19 3.0799 19 4.2 19Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :notices} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="22" viewBox="0 0 18 22" fill="none">
      <path
        d="M11 1.26953V5.40007C11 5.96012 11 6.24015 11.109 6.45406C11.2049 6.64222 11.3578 6.7952 11.546 6.89108C11.7599 7.00007 12.0399 7.00007 12.6 7.00007H16.7305M11 16H5M13 12H5M17 8.98822V16.2C17 17.8802 17 18.7202 16.673 19.362C16.3854 19.9265 15.9265 20.3854 15.362 20.673C14.7202 21 13.8802 21 12.2 21H5.8C4.11984 21 3.27976 21 2.63803 20.673C2.07354 20.3854 1.6146 19.9265 1.32698 19.362C1 18.7202 1 17.8802 1 16.2V5.8C1 4.11984 1 3.27976 1.32698 2.63803C1.6146 2.07354 2.07354 1.6146 2.63803 1.32698C3.27976 1 4.11984 1 5.8 1H9.01178C9.74555 1 10.1124 1 10.4577 1.08289C10.7638 1.15638 11.0564 1.27759 11.3249 1.44208C11.6276 1.6276 11.887 1.88703 12.4059 2.40589L15.5941 5.59411C16.113 6.11297 16.3724 6.3724 16.5579 6.67515C16.7224 6.94356 16.8436 7.2362 16.9171 7.5423C17 7.88757 17 8.25445 17 8.98822Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :searches} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="22" viewBox="0 0 18 22" fill="none">
      <path
        d="M11 1.26953V5.40007C11 5.96012 11 6.24015 11.109 6.45406C11.2049 6.64222 11.3578 6.7952 11.546 6.89108C11.7599 7.00007 12.0399 7.00007 12.6 7.00007H16.7305M11 16H5M13 12H5M17 8.98822V16.2C17 17.8802 17 18.7202 16.673 19.362C16.3854 19.9265 15.9265 20.3854 15.362 20.673C14.7202 21 13.8802 21 12.2 21H5.8C4.11984 21 3.27976 21 2.63803 20.673C2.07354 20.3854 1.6146 19.9265 1.32698 19.362C1 18.7202 1 17.8802 1 16.2V5.8C1 4.11984 1 3.27976 1.32698 2.63803C1.6146 2.07354 2.07354 1.6146 2.63803 1.32698C3.27976 1 4.11984 1 5.8 1H9.01178C9.74555 1 10.1124 1 10.4577 1.08289C10.7638 1.15638 11.0564 1.27759 11.3249 1.44208C11.6276 1.6276 11.887 1.88703 12.4059 2.40589L15.5941 5.59411C16.113 6.11297 16.3724 6.3724 16.5579 6.67515C16.7224 6.94356 16.8436 7.2362 16.9171 7.5423C17 7.88757 17 8.25445 17 8.98822Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :person} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="2"
      stroke="currentColor"
      aria-hidden="true"
      class="flex-shrink-0 w-6 h-6 mr-3 -ml-1"
    >
      <path
        d="M11 13.5H6.5C5.10444 13.5 4.40665 13.5 3.83886 13.6722C2.56045 14.06 1.56004 15.0605 1.17224 16.3389C1 16.9067 1 17.6044 1 19M15 16L17 18L21 14M13.5 5.5C13.5 7.98528 11.4853 10 9 10C6.51472 10 4.5 7.98528 4.5 5.5C4.5 3.01472 6.51472 1 9 1C11.4853 1 13.5 3.01472 13.5 5.5Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :company} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="2"
      stroke="currentColor"
      aria-hidden="true"
      class="flex-shrink-0 w-6 h-6 mr-3 -ml-1"
    >
      <path
        d="M3 17V16.8C3 15.1198 3 14.2798 3.32698 13.638C3.6146 13.0735 4.07354 12.6146 4.63803 12.327C5.27976 12 6.11984 12 7.8 12H14.2C15.8802 12 16.7202 12 17.362 12.327C17.9265 12.6146 18.3854 13.0735 18.673 13.638C19 14.2798 19 15.1198 19 16.8V17M3 17C1.89543 17 1 17.8954 1 19C1 20.1046 1.89543 21 3 21C4.10457 21 5 20.1046 5 19C5 17.8954 4.10457 17 3 17ZM19 17C17.8954 17 17 17.8954 17 19C17 20.1046 17.8954 21 19 21C20.1046 21 21 20.1046 21 19C21 17.8954 20.1046 17 19 17ZM11 17C9.89543 17 9 17.8954 9 19C9 20.1046 9.89543 21 11 21C12.1046 21 13 20.1046 13 19C13 17.8954 12.1046 17 11 17ZM11 17V7M5 7H17C17.9319 7 18.3978 7 18.7654 6.84776C19.2554 6.64477 19.6448 6.25542 19.8478 5.76537C20 5.39782 20 4.93188 20 4C20 3.06812 20 2.60218 19.8478 2.23463C19.6448 1.74458 19.2554 1.35523 18.7654 1.15224C18.3978 1 17.9319 1 17 1H5C4.06812 1 3.60218 1 3.23463 1.15224C2.74458 1.35523 2.35523 1.74458 2.15224 2.23463C2 2.60218 2 3.06812 2 4C2 4.93188 2 5.39782 2.15224 5.76537C2.35523 6.25542 2.74458 6.64477 3.23463 6.84776C3.60218 7 4.06812 7 5 7Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :business_register} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="22"
      height="20"
      viewBox="0 0 22 20"
      fill="none"
      class="flex-shrink-0 w-6 h-6 mr-3 -ml-1"
    >
      <path
        d="M18 19L21 16M21 16L18 13M21 16H15M11 13.5H6.5C5.10444 13.5 4.40665 13.5 3.83886 13.6722C2.56045 14.06 1.56004 15.0605 1.17224 16.3389C1 16.9067 1 17.6044 1 19M13.5 5.5C13.5 7.98528 11.4853 10 9 10C6.51472 10 4.5 7.98528 4.5 5.5C4.5 3.01472 6.51472 1 9 1C11.4853 1 13.5 3.01472 13.5 5.5Z"
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  defp svg_icon(%{icon: :home} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="2"
      stroke="currentColor"
      aria-hidden="true"
      class="flex-shrink-0 w-6 h-6 mr-3 -ml-1"
    >
      <path
        stroke={"#{if current_page(@current_path, @path), do: "#ffffff", else: "#0A2543"}"}
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
      >
      </path>
    </svg>
    """
  end

  defp svg_icon(assigns) do
    ~H"""
    """
  end

  defp current_page(current_path, path) do
    String.equivalent?(current_path, path)
  end
end

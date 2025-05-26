defmodule BrsWeb.Menus do
  use BrsWeb, :live_view

  # Main function to get all menus, including side menu, profile menu, and configs menu
  def side_menu(current_uri) do
    registry = determine_registry(current_uri.path) || "brs"

    [
      %{
        title: "MAIN MENU",
        menu_items: main_menu_items(registry)
      },
      %{
        title: "ADMIN MENU",
        menu_items: admin_menu_items(registry)
      },
      %{
        title: "REGISTRY",
        menu_items: registry_menu_items(registry)
      }
    ]
  end

  # Profile Menu
  def profile_menu() do
    [
      menu_item(:profile, "Your Profile", ~p"/admin/profile/1"),
      menu_item(:configs, "Configs", ~p"/system"),
      menu_item(:logout, "Logout", ~p"/auth/logout")
    ]
  end

  # Configs Menu
  def configs_menu(_) do
    [
      %{
        title: "CONFIGS MENU",
        menu_items: [
          menu_item(:forms, "Forms", ~p"/system/forms", :applications),
          menu_item(:services, "Services", ~p"/system/services", :applications),
          menu_item(:registries, "Registries", ~p"/system/registries", :companies)
        ]
      },
      %{
        title: "BUSINESSES",
        menu_items: [
          menu_item(
            :business_owner_types,
            "Owner Types",
            ~p"/system/business-owner-types",
            :staffs
          ),
          menu_item(:business_types, "Business Types", ~p"/system/business-types", :companies)
        ]
      }
    ]
  end

  # Registry Menu
  def registry_menu(_) do
    [
      %{
        title: "REGISTRIES",
        menu_items: [
          menu_item(:brs, "All Registries", ~p"/admin/registries/brs", :brs),
          menu_item(
            :or,
            "Official Receiver",
            ~p"/admin/registries/or",
            :or
          ),
          menu_item(:mpsr, "Collateral Registry(MPSR)", ~p"/admin/registries/mpsr", :mpsr),
          menu_item(
            :hp,
            "Hire Purchase",
            ~p"/admin/registries/hp",
            :hp
          ),
          menu_item(
            :trustees,
            "Trust Registry",
            ~p"/admin/registries/trustees",
            :trustees
          )
        ]
      }
    ]
  end

  # Helpers

  # Function to determine which registry pattern matches the current URI
  defp determine_registry(path) do
    [
      {:brs, ~r/brs/},
      {:or, ~r/or|ip-register/},
      {:hp, ~r/hp/},
      {:trustees, ~r/trustees/},
      {:mpsr, ~r/(mpsr|notices|searches)/},
      {:all_registries, ~r/all-registries/}
    ]
    |> Enum.find(fn {_registry, pattern} -> String.match?(path, pattern) end)
    |> case do
      {registry, _pattern} -> registry
      nil -> nil
    end
  end

  # Main menu items
  defp main_menu_items(registry) do
    [
      menu_item(:dashboard, "Dashboard", ~p"/admin/registries/#{registry}", :dashboard),
      menu_item(
        :applications,
        "Applications",
        ~p"/admin/registries/#{registry}/applications",
        :applications
      ),
      menu_item(:tasks, "Tasks", ~p"/admin/tasks", :tasks),
      menu_item(:billing, "Billing", ~p"/admin/billing", :billing),
      menu_item(:reports, "Reports", ~p"/admin/reports", :reports)
    ]
  end

  # Admin menu items
  defp admin_menu_items(registry) do
    [
      menu_item(:clients, "Clients", ~p"/admin/registries/#{registry}/clients", :clients),
      menu_item(:staffs, "Staff", ~p"/admin/registries/#{registry}/staffs", :staffs),
      menu_item(:announcements, "Announcements", ~p"/admin/announcements", :announcements),
      menu_item(
        :access_control,
        "Access Control",
        ~p"/admin/registries/#{registry}/security",
        :access_control,
        :manage,
        %Brs.Accounts.Role{}
      )
    ]
  end

  # Registry-specific menu items based on the matched registry
  defp registry_menu_items(:or) do
    [
      menu_item(
        :or,
        "OR Companies",
        ~p"/admin/registries/or",
        :companies
      ),
      menu_item(:ip_register, "IP Register", ~p"/admin/registries/hp/ip-register", :ip_register)
    ]
  end

  defp registry_menu_items(:mpsr) do
    [
      menu_item(:mpsr, "MPSR Entities", ~p"/admin/registries/mpsr", :mpsr),
      menu_item(:notices, "Notices", ~p"/admin/registries/notices", :notices),
      menu_item(:searches, "Searches", ~p"/admin/registries/searches", :searches)
    ]
  end

  defp registry_menu_items(:hp) do
    [
      menu_item(
        :hp,
        "Hire Purchase",
        ~p"/admin/registries/hp",
        :hp
      )
    ]
  end

  defp registry_menu_items(_) do
    [
      menu_item(:companies, "Companies", ~p"/admin/registries/brs/companies", :companies),
      menu_item(:name_search, "Name Searches", ~p"/admin/registries/brs/name-search", :name_search),
      menu_item(
        :business_owners,
        "Business Owners",
        ~p"/admin/registries/brs/business-owners",
        :business_owners
      ),
      menu_item(
        :beneficial_owners,
        "Beneficial Owners",
        ~p"/admin/registries/brs/beneficial-owners",
        :beneficial_owners
      )
    ]
  end

  # Frontend registries menus
  def registries_menu(all_registries) do
    [
      %{
        title: "REGISTRIES",
        menu_items: build_menus(all_registries)
      }
    ]
  end

  def build_menus(registries) do
    Enum.map(registries, fn registry ->
      uri =
        case registry.slug do
          "hp" -> "/registries/#{registry.slug}/businesses"
          _ -> "/registries/#{registry.slug}/dashboard"
        end

      menu_item(
        String.to_atom(registry.slug),
        registry.name,
        uri,
        String.to_atom(registry.slug)
      )
    end)
  end

  # Frontend sibebar menu

  def registry_sidebar_items(slug) when slug in [:brs, :or, :trustees] do
    slug = Atom.to_string(slug)

    [
      menu_item(:dashboard, "Home", ~p"/registries/#{slug}/dashboard", :home),
      menu_item(
        :authorised_persons,
        "Authorised Persons",
        ~p"/registries/#{slug}/authorised-persons",
        :person
      ),
      menu_item(
        :company_secretary,
        "Company Secretary",
        ~p"/registries/#{slug}/company-secretary",
        :company
      )
    ]
  end

  def registry_sidebar_items(slug) when slug in [:hp, :mpsr] do
    slug = Atom.to_string(slug)

    [
      menu_item(:dashboard, "Home", ~p"/registries/#{slug}/dashboard", :home)
    ]
  end

  def registry_sidebar_items(_) do
    [
      menu_item(:dashboard, "Home", ~p"/registries/brs/dashboard", :home)
    ]
  end

  # Frontend business side menu items

  def business_sidebar_items(slug, business_id) when slug in [:brs, :or, :trustees] do
    slug = Atom.to_string(slug)

    [
      menu_item(
        :dashboard,
        "Home",
        ~p"/registries/#{slug}/businesses/#{business_id}/services",
        :home
      ),
      menu_item(
        :authorised_persons,
        "Company Details",
        ~p"/registries/#{slug}/businesses/#{business_id}/details",
        :person
      ),
      menu_item(
        :company_secretary,
        "Annual Returns",
        ~p"/registries/#{slug}/businesses/#{business_id}/annual-returns",
        :company
      ),
      menu_item(
        :company_secretary,
        "Maintain Company",
        ~p"/registries/#{slug}/businesses/#{business_id}/manage",
        :company
      ),
      menu_item(
        :company_secretary,
        "Access Control",
        ~p"/registries/#{slug}/businesses/#{business_id}/access-control",
        :company
      ),
      menu_item(
        :company_secretary,
        "Audit Trail",
        ~p"/registries/#{slug}/businesses/#{business_id}/audit-trail",
        :company
      ),
      menu_item(
        :company_secretary,
        "eSecretary",
        ~p"/registries/#{slug}/businesses/#{business_id}/esecretary",
        :company
      ),
      menu_item(
        :company_secretary,
        "Employees",
        ~p"/registries/#{slug}/businesses/#{business_id}/employees",
        :company
      )
    ]
  end

  def business_sidebar_items(slug, business_id) when slug in [:hp, :mpsr] do
    slug = Atom.to_string(slug)

    [
      menu_item(
        :dashboard,
        "Home",
        ~p"/registries/#{slug}/businesses/#{business_id}/services",
        :home
      )
    ]
  end

  def business_sidebar_items(_, business_id) do
    [
      menu_item(:dashboard, "Home", ~p"/registries/brs/businesses/#{business_id}/services", :home)
    ]
  end

  # Generalized helper to create a menu item
  defp menu_item(name, label, path, icon \\ nil, action \\ nil, resource \\ nil) do
    %{name: name, label: label, path: path, icon: icon, action: action, resource: resource}
  end
end

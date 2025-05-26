defmodule BrsWeb.Router do
  use BrsWeb, :router
  import BrsWeb.Plug.Authenticate
  require BrsWeb.EntityRouter

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BrsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug BrsWeb.Plug.RequestURI
    plug BrsWeb.Plug.LoadRegistries
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :registries do
    plug :put_layout, html: {BrsWeb.Layouts, :business}
  end

  pipeline :system do
    plug :put_layout, html: {BrsWeb.Layouts, :configs}
  end

  pipeline :current_service do
    plug BrsWeb.Plug.AssignCurrentService
  end

  scope "/", BrsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/registries/:slug", BrsWeb do
    pipe_through [:browser, :registries, :authenticated]

    live_session :business_registry,
      layout: {BrsWeb.Layouts, :business},
      on_mount: BrsWeb.InitAssigns.common_hooks() do
      scope "/", BusinessRegisterLive do
        live "/dashboard", Registry, :dashboard
        live "/authorised-persons", Registry, :authorised_persons
        live "/company-secretary", Registry, :company_secretary
        live "/businesses", Registry, :businesses
      end

      BrsWeb.EntityRouter.frontend_routes()
    end
  end

  scope "/services/:id", BrsWeb do
    pipe_through [:browser, :authenticated, :current_service]

    live_session :services,
      layout: {BrsWeb.Layouts, :business},
      on_mount: BrsWeb.InitAssigns.service_hooks() do
      live "/apply", ApplicationLive.Apply, :apply
    end
  end

  scope "/applications", BrsWeb do
    pipe_through [:browser, :authenticated]

    live_session :applications,
      layout: {BrsWeb.Layouts, :business},
      on_mount: BrsWeb.InitAssigns.application_hooks() do
      live "/:id/edit", ApplicationLive.Apply, :edit
      live "/:id", ApplicationLive.Show, :show
    end
  end

  scope "/system", BrsWeb do
    pipe_through [:browser, :authenticated, :system]

    get "/", SystemController, :index

    live_session :require_authenticated_user,
      layout: {BrsWeb.Layouts, :configs},
      on_mount: [
        {BrsWeb.InitAssigns, :current_user},
        {BrsWeb.InitAssigns, :request_uri},
        {BrsWeb.InitAssigns, :load_registries}
      ] do
      scope "/services" do
        live "/", ServiceLive.Index, :index
        live "/new", ServiceLive.Index, :new
        live "/:id", ServiceLive.Show, :show
        live "/:id/edit", ServiceLive.Show, :edit
        live "/:id/workflow", WorkflowLive.Index
        live "/:id/stages/new", StageLive.New, :index

        live "/:service_id/stages/:stage_id/edit", ServiceLive.Index, :edit_stage
      end

      scope "/forms" do
        get "/", FormController, :index
        delete "/:id", FormController, :delete

        live "/new", FormLive.Index, :new
        live "/:id/edit", FormLive.Index, :edit

        live "/business_name_registration", BusinessNameRegistrationLive.Index, :index
      end

      scope "/registries" do
        live "/", RegistryLive.Index, :index
        live "/new", RegistryLive.Index, :new
        live "/:id/edit", RegistryLive.Show, :edit
      end

      scope "/business-owner-types" do
        live "/", Configs.BusinessOwnerTypeLive.Index, :index
        live "/new", Configs.BusinessOwnerTypeLive.Index, :new
        live "/:id/edit", Configs.BusinessOwnerTypeLive.Show, :edit
      end

      scope "/business-types" do
        live "/", Configs.BusinessTypeLive.Index, :index
        live "/new", Configs.BusinessTypeLive.Index, :new
        live "/:id/edit", Configs.BusinessTypeLive.Show, :edit
      end
    end
  end

  scope "/admin", BrsWeb, as: :admin do
    pipe_through [:browser, :authenticated]

    live_session :admin,
      layout: {BrsWeb.Layouts, :admin},
      on_mount: [
        {BrsWeb.InitAssigns, :request_uri},
        {BrsWeb.InitAssigns, :current_user},
        {BrsWeb.InitAssigns, :load_registries},
        {BrsWeb.InitAssigns, :current_registry}
      ] do
      live "/dashboard", DashboardLive.Index
      live "/all-registries", DashboardLive.AllRegistries

      scope "/profile" do
        live "/:id", ProfileLive.Index, :index
      end

      scope "/tasks" do
        live "/", TaskLive.Index, :index
        live "/:id", TaskLive.Show, :show
      end

      scope "/billing" do
        live "/", BillingLive.Index, :index
      end

      scope "/reports" do
        live "/", ReportLive.Index, :index
        live "/:id", ReportLive.Show, :show
      end

      scope "/announcements" do
        live "/", AnnouncementLive.Index, :index
        live "/new", AnnouncementLive.Add, :new
        live "/:id/edit", AnnouncementLive.Edit, :edit
        live "/:id/preview", AnnouncementLive.Preview, :preview
      end

      scope "/registries/:slug" do
        live "/", DashboardLive.Index

        scope "/clients" do
          live "/", ClientLive.Index, :index
          live "/new", ClientLive.Index, :new
          live "/:id", ClientLive.Show, :show
        end

        scope "/applications" do
          live "/", AdminApplicationLive.Index, :index
          live "/:id", AdminApplicationLive.Show, :show
        end

        live "/companies", CompanyLive.Index, :index
        live "/companies/:id", CompanyLive.Show, :show
        live "/name-search", NameSearchLive.Index, :index
        live "/business-owners", BusinessOwnerLive.Index, :index
        live "/business-owners/:id", BusinessOwnerLive.Show, :show
        live "/beneficial-owners", BeneficialOwnerLive.Index, :index

        live "/official-receiver", OfficialReceiverLive.Index, :index
        live "/official-receiver/:id", OfficialReceiverLive.Show, :show

        live "/mpsr", MpsrLive.Index, :index
        live "/mpsr/:id", MpsrLive.Show, :show
        live "/:id/view-notices/:notice_id", MpsrLive.ShowNotices, :show_notices

        live "/hire-purchase", HirePurchaseLive.Index, :index
        live "/hire-purchase/:id", HirePurchaseLive.Show, :show

        live "/trust-incorporation", TrustIncorporationLive.Index, :index
        live "/trust-incorporation/:id", TrustIncorporationLive.Show, :show

        live "/notices", NoticesLive.Index, :index
        live "/notices/:id", NoticesLive.Show, :show

        live "/ip-register", IpRegisterLive.Index, :index

        live "/searches", SearchesLive.Index, :index
        live "/searches/:id", SearchesLive.Show, :show

        scope "/security" do
          live "/", AccessControlLive.Index, :index
          live "/:type/:id", AccessControlLive.Show, :show
          live "/:type/:id/edit", AccessControlLive.Show, :edit
        end

        scope "/staffs" do
          live "/", StaffLive.Index, :index
          live "/:id/profile", StaffLive.Profile, :index
          live "/:id/edit", StaffLive.StaffManager, :edit
          live "/new", StaffLive.StaffManager, :new
        end
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", BrsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:brs, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BrsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/auth", BrsWeb do
    pipe_through :browser

    get "/login/sso", SessionController, :login_sso
    get "/login/sso/callback", SessionController, :login_sso_callback
    get "/register/sso", SessionController, :register_sso
    delete "/logout", SessionController, :logout
  end
end

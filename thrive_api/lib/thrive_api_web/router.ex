defmodule ThriveApiWeb.Router do
  use ThriveApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ThriveApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ThriveApiWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", ThriveApiWeb do
    pipe_through :api

    post "/register", AuthController, :create
    post "/login", AuthController, :login

    resources "/profiles", ProfileController, except: [:new, :edit]
    resources "/goals", GoalController, except: [:new, :edit]
  end

  pipeline :administrator do
    plug ThriveApiWeb.RoleBasedPipeline, ["administrator"]
  end

  pipeline :manager do
    plug ThriveApiWeb.RoleBasedPipeline, ["administrator", "manager"]
  end

  pipeline :employee do
    plug ThriveApiWeb.RoleBasedPipeline, ["administrator", "manager", "employee"]
  end

  scope "/api/admin", ThriveApiWeb do
    pipe_through [:api, :administrator]
    resources "/profiles", ProfileController, only: [:show, :create, :update, :delete]
  end

  scope "/api/manager", ThriveApiWeb do
    pipe_through [:api, :manager]
    resources "/profiles", ProfileController, only: [:show, :create, :update]
  end

  scope "/api/employee", ThriveApiWeb do
    pipe_through [:api, :employee]
    resources "/profiles", ProfileController, only: [:show, :update]
  end

end

defmodule ThriveApiWeb.RoleBasedPipeline do
  import Plug.Conn

  alias ThriveApi.Guardian

  def init(opts), do: opts

  def call(conn, roles) do
    current_user = Guardian.Plug.current_resource(conn)

    if current_user && Enum.member?(roles, current_user.role) do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> Phoenix.Controller.render(ThriveApiWeb.ErrorView, "unauthorized.json")
      |> halt()
    end
  end
end

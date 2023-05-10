defmodule ThriveApiWeb.UserView do

  def render("user.json", %{user: user, jwt: jwt}) do
    %{
      user: %{id: user.id, email: user.email, role: user.role},
      jwt: jwt
    }
  end
end

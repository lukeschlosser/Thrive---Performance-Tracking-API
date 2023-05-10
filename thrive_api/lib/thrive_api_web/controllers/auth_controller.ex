defmodule ThriveApiWeb.AuthController do
  use ThriveApiWeb, :controller

  # Alias the relevant modules
  alias ThriveApi.Accounts
  alias ThriveApi.Accounts.User
  alias ThriveApi.Guardian

  # Create a new user
  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      # If the user was created successfully, sign and encode a JWT token for the user and return it
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user)
        conn
        |> put_status(:created)
        |> put_view(ThriveApiWeb.UserView)
        |> render("user.json", user: user, jwt: jwt)
      # If the user could not be created due to invalid input, return the validation errors
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ThriveApiWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  # Authenticate an existing user
  def login(conn, %{"session" => session_params}) do
    case User.authenticate_user(session_params["email"], session_params["password"]) do
      # If the authentication was successful, sign and encode a JWT token for the user and return it
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user)
        conn
        |> put_view(ThriveApiWeb.UserView)
        |> render("session.json", user: user, jwt: jwt)
      # If the authentication was unsuccessful, return an error message
      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(ThriveApiWeb.ChangesetView)
        |> render("error.json", message: reason)
    end
  end
end

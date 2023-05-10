defmodule ThriveApiWeb.ProfileController do
  use ThriveApiWeb, :controller

  alias ThriveApi.Accounts
  alias ThriveApi.Accounts.Profile

  # Show a profile with the given ID
  def show(conn, %{"id" => id}) do
    profile = Accounts.get_profile!(id)
    render(conn, "show.json", profile: profile)
  end

  # Create a new profile
  def create(conn, %{"profile" => profile_params}) do
    # Use the Accounts module to create a new profile
    with {:ok, %Profile{} = profile} <- Accounts.create_profile(profile_params) do
      # Return a 201 Created response with the location of the new resource in the Location header
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.profile_path(conn, :show, profile))
      |> render("show.json", profile: profile)
    end
  end

  # Update an existing profile with the given ID
  def update(conn, %{"id" => id, "profile" => profile_params}) do
    # Get the profile from the database with the given ID
    profile = Accounts.get_profile!(id)
    # Attempt to update the retrieved profile with the given profile parameters
    with {:ok, %Profile{} = updated_profile} <- Accounts.update_profile(profile, profile_params) do
      # If the update is successful, render the updated profile as JSON
      render(conn, "show.json", profile: updated_profile)
    end
  end

  # Delete an existing profile with the given ID
  def delete(conn, %{"id" => id}) do
    # Get the profile from the database with the given ID
    profile = Accounts.get_profile!(id)
    # Delete the retrieved profile from the database
    {:ok, _} = Accounts.delete_profile(profile)
    # Send a successful response with no content
    send_resp(conn, :no_content, "")
  end
end

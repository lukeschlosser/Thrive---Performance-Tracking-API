defmodule ThriveApi.Accounts do
  alias ThriveApi.Accounts.User
  alias ThriveApi.Accounts.Profile
  alias ThriveApi.Accounts.Goal
  alias ThriveApi.Repo

  # Register a new user
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # Get a profile by its ID or raise an error
  def get_profile!(id), do: Repo.get!(Profile, id)

  # Create a new profile
  def create_profile(attrs \\ %{}) do
    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

  # Update an existing profile
  def update_profile(%Profile{} = profile, attrs) do
    profile
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  # Delete an existing profile
  def delete_profile(%Profile{} = profile), do: Repo.delete(profile)

  # Get all goals
  def list_goals, do: Repo.all(Goal)

  # Get a goal with a given ID
  def get_goal!(id), do: Repo.get!(Goal, id)

  # Create a new goal with the provided attributes (or empty attributes if none are provided)
  def create_goal(attrs \\ %{}) do
    %Goal{}
    |> Goal.changeset(attrs)
    |> Repo.insert()
  end

  # Update an existing goal with the provided attributes
  def update_goal(%Goal{} = goal, attrs) do
    goal
    |> Goal.changeset(attrs)
    |> Repo.update()
  end

  # Delete a goal with the provided ID
  def delete_goal(%Goal{} = goal), do: Repo.delete(goal)

end

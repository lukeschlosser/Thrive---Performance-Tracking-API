defmodule ThriveApiWeb.GoalController do
  use ThriveApiWeb, :controller

  alias ThriveApi.Accounts
  alias ThriveApi.Accounts.Goal

  # List all goals
  def index(conn, _params) do
    goals = Accounts.list_goals()
    render(conn, "index.json", goals: goals)
  end

  # Show a goal with the given ID
  def show(conn, %{"id" => id}) do
    goal = Accounts.get_goal!(id)
    render(conn, "show.json", goal: goal)
  end

  # Create a new goal
  def create(conn, %{"goal" => goal_params}) do
    with {:ok, %Goal{} = goal} <- Accounts.create_goal(goal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.goal_path(conn, :show, goal))
      |> render("show.json", goal: goal)
    end
  end

  # Update an existing goal with the given ID
  def update(conn, %{"id" => id, "goal" => goal_params}) do
    goal = Accounts.get_goal!(id)
    with {:ok, %Goal{} = updated_goal} <- Accounts.update_goal(goal, goal_params) do
      render(conn, "show.json", goal: updated_goal)
    end
  end

  # Delete an existing goal with the given ID
  def delete(conn, %{"id" => id}) do
    goal = Accounts.get_goal!(id)
    {:ok, _} = Accounts.delete_goal(goal)
    send_resp(conn, :no_content, "")
  end
end

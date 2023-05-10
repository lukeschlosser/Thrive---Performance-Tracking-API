defmodule ThriveApi.Accounts.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  # Define the schema for the goals table in the database
  schema "goals" do
    field :title, :string
    field :description, :string
    field :due_date, :date
    field :status, :string
    field :progress, :integer
    belongs_to :employee, ThriveApi.Accounts.User

    timestamps()
  end

  # Define the changeset function for validating and casting goal attributes
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title, :description, :due_date, :status, :progress, :employee_id])
    |> validate_required([:title, :description, :due_date, :status, :progress, :employee_id])
  end
end

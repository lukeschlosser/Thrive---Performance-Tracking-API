defmodule ThriveApi.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :title, :string
      add :description, :string
      add :due_date, :date
      add :status, :string
      add :progress, :integer
      add :employee_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:goals, [:employee_id])
  end
end

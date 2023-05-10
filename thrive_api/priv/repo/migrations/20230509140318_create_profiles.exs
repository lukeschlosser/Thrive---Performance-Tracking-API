defmodule ThriveApi.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :string
      add :last_name, :string
      add :job_title, :string
      add :department, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:profiles, [:user_id])
    create index(:profiles, [:manager_id])
  end
end

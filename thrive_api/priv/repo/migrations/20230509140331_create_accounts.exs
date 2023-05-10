defmodule ThriveApi.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string
      add :hashed_password, :binary
      add :confirmed, :boolean, default: false
      add :confirm_token, :binary
      add :reset_token, :binary
      add :reset_requested_at, :naive_datetime

      timestamps()
    end

    create unique_index(:accounts, [:email])
  end
end

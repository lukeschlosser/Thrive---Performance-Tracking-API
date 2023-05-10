defmodule ThriveApi.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  # Define the schema for the "profiles" table
  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :job_title, :string
    field :department, :string
    belongs_to :user, ThriveApi.Accounts.User
    belongs_to :manager, ThriveApi.Accounts.User, foreign_key: :manager_id

    timestamps()
  end

  # Changeset function to validate and transform profile data
  @doc false
  def changeset(profile, attrs) do
    profile
    # Cast the provided attributes to the profile struct
    |> cast(attrs, [:first_name, :last_name, :job_title, :department, :user_id, :manager_id])
    # Validate the required fields
    |> validate_required([:first_name, :last_name, :job_title, :department, :user_id])
  end
end

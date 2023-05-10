defmodule ThriveApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias ThriveApi.Repo
  alias Pbkdf2

  # Define the schema for the "users" table
  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :role, :string
    field :password, :string, virtual: true

    has_one :profile, ThriveApi.Accounts.Profile
    has_many :employees, ThriveApi.Accounts.Profile, foreign_key: :manager_id

    timestamps()
  end

  # Changeset function to validate and transform user data
  @doc false
  def changeset(user, attrs) do
    user
    # Cast the provided attributes to the user struct
    |> cast(attrs, [:email, :password, :role])
    # Validate the required fields
    |> validate_required([:email, :role])
    # Ensure access
    |> validate_inclusion(:role, ["administrator", "manager", "employee"])
    # Ensure the email is unique
    |> unique_constraint(:email)
    # Hash the password and store it in the password_hash field
    |> put_password_hash(attrs[:password])
  end

  # Hash the password and store it in the password_hash field
  defp put_password_hash(changeset, password) do
    case password do
      nil -> changeset
      _ -> put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password, :salt))
    end
  end

  # Authenticate a user by email and password
  def authenticate_user(email, password) do
    # Query the user by email
    query = from u in __MODULE__, where: u.email == ^email
    case Repo.one(query) do
      # If the email is not found, return an error
      nil -> {:error, "Email not found"}
      # If the email is found, verify the password
      user -> authenticate_password(user, password)
    end
  end

  # Verify the provided password against the stored password hash
  defp authenticate_password(user, password) do
    case Pbkdf2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      _ -> {:error, "Invalid password"}
    end
  end
end

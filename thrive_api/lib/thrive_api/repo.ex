defmodule ThriveApi.Repo do
  use Ecto.Repo,
    otp_app: :thrive_api,
    adapter: Ecto.Adapters.Postgres
end

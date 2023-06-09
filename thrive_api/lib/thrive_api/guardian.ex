defmodule ThriveApi.Guardian do
  use Guardian, otp_app: :thrive_api

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    {:ok, claims["sub"]}
  end
end

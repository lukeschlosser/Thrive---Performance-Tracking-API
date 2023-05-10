defmodule ThriveApiWeb.ChangesetView do
  def render("error.json", %{changeset: changeset}) do
    # Get the error messages from the changeset
    errors = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)

    %{
      errors: errors
    }
  end

  defp translate_error({msg, opts}) do
    # Translate the error message
    msg = to_string(msg)
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end

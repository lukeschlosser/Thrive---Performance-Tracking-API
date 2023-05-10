defmodule ThriveApiWeb.ProfileView do
  # Why is the below causing errors?
  # use ThriveApiWeb, :view

  # Render the JSON representation of a profile
  def render("show.json", %{profile: profile}) do
    %{
      id: profile.id,
      first_name: profile.first_name,
      last_name: profile.last_name,
      job_title: profile.job_title,
      department: profile.department,
      user_id: profile.user_id,
      manager_id: profile.manager_id
    }
  end
end

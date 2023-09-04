defmodule Streamline.Repo do
  use Ecto.Repo,
    otp_app: :streamline,
    adapter: Ecto.Adapters.Postgres
end

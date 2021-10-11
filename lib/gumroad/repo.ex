defmodule Gumroad.Repo do
  use Ecto.Repo,
    otp_app: :gumroad,
    adapter: Ecto.Adapters.Postgres
end

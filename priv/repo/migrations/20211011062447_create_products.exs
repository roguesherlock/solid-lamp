defmodule Gumroad.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :price, :integer

      timestamps()
    end
  end
end

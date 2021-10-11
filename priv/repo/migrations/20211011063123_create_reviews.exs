defmodule Gumroad.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :description, :string
      add :rating, :float
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:reviews, [:product_id])
  end
end

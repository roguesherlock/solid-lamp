defmodule Gumroad.Products.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :description, :string
    field :rating, :float
    belongs_to :product, Gumroad.Products.Product

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:description, :rating, :product_id])
    |> validate_required([:description, :rating, :product_id])
    |> validate_inclusion(:rating, [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0])
  end
end

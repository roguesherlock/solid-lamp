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
  end
end

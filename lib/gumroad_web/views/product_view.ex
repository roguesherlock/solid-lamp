defmodule GumroadWeb.ProductView do
  use GumroadWeb, :view
  alias GumroadWeb.ProductView
  alias GumroadWeb.ReviewView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price
    }
    |> Map.merge(%{
      reviews: render_relationship(product.reviews, ReviewView, "review.json")
    })
  end

  defp render_relationship(%Ecto.Association.NotLoaded{}, _, _), do: nil

  defp render_relationship(relation, view, template) do
    render_many(relation, view, template)
  end
end

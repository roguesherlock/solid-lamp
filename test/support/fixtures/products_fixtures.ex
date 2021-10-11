defmodule Gumroad.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gumroad.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: 120
      })
      |> Gumroad.Products.create_product()

    product
  end

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    product = product_fixture()

    {:ok, review} =
      attrs
      |> Enum.into(%{
        description: "some description",
        rating: 2.5,
        product_id: product.id
      })
      |> Gumroad.Products.create_review()

    review
  end
end

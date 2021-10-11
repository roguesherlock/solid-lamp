defmodule Gumroad.ProductsTest do
  use Gumroad.DataCase

  alias Gumroad.Products

  describe "products" do
    alias Gumroad.Products.Product

    import Gumroad.ProductsFixtures

    @invalid_attrs %{description: nil, name: nil, price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{description: "some description", name: "some name", price: 120}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.price == 120
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name",
        price: 456
      }

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.price == 456
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "reviews" do
    alias Gumroad.Products.Review

    import Gumroad.ProductsFixtures

    @invalid_attrs %{description: nil, rating: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Products.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture() |> Repo.preload(:product)
      assert Products.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      product = product_fixture()
      valid_attrs = %{description: "some description", rating: 120, product_id: product.id}

      assert {:ok, %Review{} = review} = Products.create_review(valid_attrs)
      assert review.description == "some description"
      assert review.rating == 120
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture() |> Repo.preload(:product)
      update_attrs = %{description: "some updated description", rating: 456}

      assert {:ok, %Review{} = review} = Products.update_review(review, update_attrs)
      assert review.description == "some updated description"
      assert review.rating == 456
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture() |> Repo.preload(:product)
      assert {:error, %Ecto.Changeset{}} = Products.update_review(review, @invalid_attrs)
      assert review == Products.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Products.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Products.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Products.change_review(review)
    end
  end
end

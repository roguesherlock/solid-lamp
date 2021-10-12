defmodule GumroadWeb.ProductLive.Show do
  use GumroadWeb, :live_view

  alias Gumroad.Products
  alias Gumroad.Products.Review

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    product = Products.get_product!(id)
    reviews = Products.list_reviews_for_product(product)
    average_rating = Float.round(Enum.sum(Enum.map(reviews, & &1.rating)) / length(reviews), 2)

    {:noreply,
     socket
     |> assign(:product, product)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:review, %Review{product_id: product.id})
     |> assign(:reviews, reviews)
     |> assign(:average_rating, average_rating)}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
  defp page_title(:add_review), do: "What's your rating?"
end

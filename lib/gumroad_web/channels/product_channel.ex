defmodule GumroadWeb.ProductChannel do
  use GumroadWeb, :channel
  alias Gumroad.Products

  @impl true
  def join("product:" <> product_id, payload, socket) do
    product = Products.get_product!(product_id)
    socket = assign(socket, :product, product)
    response = GumroadWeb.ProductView.render("product.json", %{product: product})

    if authorized?(payload) do
      {:ok, response, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_info({:new_review, payload}, socket) do
    broadcast!(socket, :new_review, payload)
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (product:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

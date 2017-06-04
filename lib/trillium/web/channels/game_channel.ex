defmodule Trillium.Web.GameChannel do
  use Trillium.Web, :channel

  alias Trillium.Set

  @placeholder_cards ["example", "cards", "here"]

  def join("game", payload, socket) do
    if authorized?(payload) do
      {:ok, %{cards: @placeholder_cards}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("set", payload, socket) do
    if Set.valid?(payload) do
      broadcast socket, "set", payload
    end

    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true
  end
end

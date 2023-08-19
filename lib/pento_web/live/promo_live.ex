defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    form = to_form(Promo.change_recipient(%Recipient{}))
    {:ok,
      socket
      |> assign(form: form)}
  end

  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(recipient))
  end

  def handle_event(
      "validate",
      %{"recipient" => recipient_params},
      %{assigns: %{form: recipient_form}} = socket
      ) do
    changeset =
      recipient_form.data
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    IO.inspect(changeset)
    form = to_form(changeset)

    {:noreply,
    socket
    |> assign(:form, form)}
  end

  def handle_event("save", %{"recipient" => _recipient_params}, _socket) do
    :timer.sleep(1000)
  end
end

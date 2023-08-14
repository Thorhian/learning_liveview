defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    answer = :rand.uniform(10)
    {:ok, assign(socket,
                 score: 0,
                 message: "Guess a number.",
                 answer: answer
                 )}
  end
  
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %><br>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number= {n} >
          <%= n %>
        </.link>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    answer = socket.assigns.answer
    {guess, _remainder} = Integer.parse(guess)
    {message, score} =
      if guess == answer do
        {"Your guess: #{guess}. Correct!", socket.assigns.score + 1}
      else
        {"Your guess: #{guess}. Wrong. Guess again.", socket.assigns.score - 1}
      end

    {
      :noreply,
      assign(
          socket,
          message: message,
          score: score,
          answer: socket.assigns.answer,
          time: time()
          )
    }
  end
end

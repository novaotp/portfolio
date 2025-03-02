defmodule PortfolioWeb.Hooks.RequestUri do
  @moduledoc """
  A hook to provide the current URI in the socket.
  """

  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    socket =
      socket
      |> attach_hook(:save_request_path, :handle_params, &save_request_path/3)

    {:cont, socket}
  end

  defp save_request_path(_params, url, socket) do
    socket =
      socket
      |> assign(:current_uri, URI.parse(url))

    {:cont, socket}
  end
end

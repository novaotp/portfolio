defmodule PortfolioWeb.Hooks.Locale do
  @moduledoc """
  A hook to provide the locale in the socket.
  """

  def on_mount(:default, _params, session, socket) do
    Gettext.put_locale(PortfolioWeb.Gettext, session["locale"])

    {:cont, socket}
  end
end

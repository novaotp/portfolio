defmodule PortfolioWeb.Hooks.Locale do
  def on_mount(:default, _params, session, socket) do
    Gettext.put_locale(PortfolioWeb.Gettext, session["locale"])

    {:cont, socket}
  end
end

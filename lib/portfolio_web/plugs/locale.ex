defmodule PortfolioWeb.Plugs.Locale do
  import Plug.Conn

  @known_locales Gettext.known_locales(PortfolioWeb.Gettext)

  def init(default_locale), do: default_locale

  def call(conn, default_locale) do
    locale = get_locale(conn, default_locale)

    Gettext.put_locale(PortfolioWeb.Gettext, locale)

    conn
    |> put_resp_cookie("locale", locale, max_age: :timer.hours(24) * 365)
    |> assign(:locale, locale)
    |> put_session(:locale, locale)
  end

  defp get_locale(conn, default_locale) do
    if (cookie_locale = conn.cookies["locale"]) && cookie_locale in @known_locales do
      cookie_locale
    else
      default_locale
    end
  end
end

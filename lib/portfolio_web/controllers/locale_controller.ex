defmodule PortfolioWeb.LocaleController do
  use PortfolioWeb, :controller
  use Gettext, backend: PortfolioWeb.Gettext

  def update(conn, %{"locale" => locale, "to" => to}) do
    Gettext.put_locale(PortfolioWeb.Gettext, locale)

    conn
    |> put_resp_cookie("locale", locale, max_age: :timer.hours(24) * 365)
    |> redirect(to: to)
  end
end

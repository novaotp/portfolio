defmodule PortfolioWeb.BlogLive do
  use PortfolioWeb, :live_view

  alias Portfolio.Blog
  import PortfolioWeb.Components.Domains.Post

  def mount(_params, _session, socket) do
    posts =
      PortfolioWeb.Gettext
      |> Gettext.get_locale()
      |> Blog.all_posts()

    socket =
      socket
      |> assign(page_title: "Blog")
      |> assign(:posts, posts)

    {:ok, socket}
  end
end

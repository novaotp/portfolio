defmodule PortfolioWeb.PostLive do
  use PortfolioWeb, :live_view

  alias Portfolio.Blog
  import PortfolioWeb.Components.Domains.Post

  def mount(%{"id" => id}, _session, socket) do
    post = Blog.get_post_by_id!(Gettext.get_locale(PortfolioWeb.Gettext), id)
    latest_posts = Blog.latest_posts(Gettext.get_locale(PortfolioWeb.Gettext), id)

    socket =
      socket
      |> assign(page_title: post.title)
      |> assign(post: post)
      |> assign(latest_posts: latest_posts)

    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    post = Blog.get_post_by_id!(Gettext.get_locale(PortfolioWeb.Gettext), id)
    latest_posts = Blog.latest_posts(Gettext.get_locale(PortfolioWeb.Gettext), id)

    socket =
      socket
      |> assign(page_title: post.title)
      |> assign(post: post)
      |> assign(latest_posts: latest_posts)

    {:noreply, socket}
  end
end

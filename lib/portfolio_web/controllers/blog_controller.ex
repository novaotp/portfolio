defmodule PortfolioWeb.BlogController do
  use PortfolioWeb, :controller

  alias Portfolio.Blog

  def home(conn, _params) do
    posts =
      if tag = conn.query_params["tag"] do
        Blog.get_posts_by_tag!(Gettext.get_locale(PortfolioWeb.Gettext), tag)
      else
        Blog.all_posts(Gettext.get_locale(PortfolioWeb.Gettext))
      end

    conn
    |> render(:home, page_title: "Blog", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post_by_id!(Gettext.get_locale(PortfolioWeb.Gettext), id)
    latest_posts = Blog.latest_posts(Gettext.get_locale(PortfolioWeb.Gettext), id)

    conn
    |> render(
      :show,
      page_title: post.title,
      post: post,
      latest_posts: latest_posts
    )
  end
end

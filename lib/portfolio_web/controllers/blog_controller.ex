defmodule PortfolioWeb.BlogController do
  use PortfolioWeb, :controller

  alias Portfolio.Blog

  def home(conn, _params) do
    posts =
      if tag = conn.query_params["tag"] do
        Blog.get_posts_by_tag!(tag)
      else
        Blog.all_posts()
      end

    render(conn, :home, posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post_by_id!(id)
    latest_posts = Blog.latest_posts(id)

    conn
    |> render(
      :show,
      page_title: post.title,
      post: post,
      latest_posts: latest_posts
    )
  end
end

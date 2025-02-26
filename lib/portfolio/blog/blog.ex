defmodule Portfolio.Blog do
  @moduledoc """
  The entity that handles blog-related operations.
  """

  alias Portfolio.Blog

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  use NimblePublisher,
    build: Blog.Post,
    parser: Blog.Parser,
    html_converter: Blog.MarkdownConverter,
    from: Application.app_dir(:portfolio, "priv/posts/**/*.md"),
    as: :posts,
    earmark_options: [postprocessor: &Blog.Processor.process/1],
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  def all_posts(locale), do: @posts |> Enum.filter(&(&1.locale == locale))

  @spec all_tags() :: list(String.t())
  def all_tags, do: @tags

  @spec latest_posts(String.t()) :: list(Blog.Post.t())
  def latest_posts(locale), do: locale |> all_posts() |> Enum.take(3)

  @doc """
  Fetch the latest posts but not `avoid`. Useful for not showing the same post
  the user is reading in the latest posts.
  """
  @spec latest_posts(String.t(), String.t()) :: list(Blog.Post.t())
  def latest_posts(locale, avoid) do
    locale
    |> all_posts()
    |> Enum.filter(&(&1.id != avoid))
    |> Enum.take(3)
  end

  @spec get_post_by_id!(String.t(), String.t()) :: Blog.Post.t()
  def get_post_by_id!(locale, id) do
    locale |> all_posts() |> Enum.find(&(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end

  @spec get_posts_by_tag!(String.t(), String.t()) :: list(Blog.Post.t())
  def get_posts_by_tag!(locale, tag) do
    case Enum.filter(all_posts(locale), &(tag in &1.tags)) do
      [] -> raise NotFoundError, "posts with tag=#{tag} not found"
      posts -> posts
    end
  end
end

defmodule PortfolioWeb.BlogHTML do
  use PortfolioWeb, :html

  embed_templates "blog_html/*"

  def post_card(assigns) do
    ~H"""
    <.link href={~p"/blog/#{@post.id}"} class="gap-2 flex flex-col items-start py-5">
      <.date post={@post} />
      <h2 class="text-2xl">{@post.title}</h2>
      <p class="text-zinc-500 py-2">{@post.description}</p>
      <div class="flex flex-wrap gap-2">
        <span :for={tag <- @post.tags} class="bg-blue-700 text-white px-3 py-1 rounded-full text-sm">
          {tag}
        </span>
      </div>
    </.link>
    """
  end

  def date(assigns) do
    ~H"""
    <time class="text-sm text-zinc-500">
      <%= if @post.updated_at do %>
        Last updated on {Calendar.strftime(@post.updated_at, "%B %d, %Y")}
      <% else %>
        Published on {Calendar.strftime(@post.date, "%B %d, %Y")}
      <% end %>
    </time>
    """
  end
end

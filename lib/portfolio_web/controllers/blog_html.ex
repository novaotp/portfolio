defmodule PortfolioWeb.BlogHTML do
  use PortfolioWeb, :html

  alias PortfolioWeb.Constants

  embed_templates "blog_html/*"

  def post_card(assigns) do
    ~H"""
    <.link href={~p"/blog/#{@post.id}"} class="gap-2 flex flex-col items-start py-5">
      <.date post={@post} />
      <h2 class="text-xl lg:text-2xl">{@post.title}</h2>
      <p class="text-zinc-500 py-2">{@post.description}</p>
      <div class="flex flex-wrap gap-2">
        <span :for={tag <- @post.tags} class="bg-blue-700 text-white px-3 py-1 rounded-full text-sm">
          {Gettext.gettext(PortfolioWeb.Gettext, tag)}
        </span>
      </div>
    </.link>
    """
  end

  def date(assigns) do
    ~H"""
    <time class="text-sm text-zinc-500">
      <%= if @post.updated_at do %>
        {gettext("Last updated on")} {format_date(
          Gettext.get_locale(PortfolioWeb.Gettext),
          @post.updated_at
        )}
      <% else %>
        {gettext("Published on")} {format_date(Gettext.get_locale(PortfolioWeb.Gettext), @post.date)}
      <% end %>
    </time>
    """
  end

  defp format_date(locale, date) do
    if locale == "fr" do
      Calendar.strftime(date, "%d %B %Y", month_names: &Constants.localized_month/1)
    else
      Calendar.strftime(date, "%B %d, %Y")
    end
  end
end

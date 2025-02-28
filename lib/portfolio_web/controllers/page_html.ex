defmodule PortfolioWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use PortfolioWeb, :html

  alias PortfolioWeb.Constants

  embed_templates "page_html/*"

  attr(:periods, :list,
    required: true,
    doc: "A list of tuples in the format `{start_date, end_date}` using `Date` structs."
  )

  attr(:tags, :list, default: [])
  attr(:show_months, :boolean, default: false)
  attr(:href, :string)

  slot(:inner_block)
  slot(:description)
  slot(:extra)

  def experience_card(assigns) do
    ~H"""
    <div class="flex flex-col items-start gap-2 mb-8">
      <time class="text-zinc-400 text-sm font-medium">
        {format_periods(@periods, @show_months)}
      </time>
      <h3 class="font-medium">
        <a
          href={@href}
          target="_blank"
          rel="noreferrer noopener"
          class="relative flex items-center gap-1"
        >
          <span>{render_slot(@inner_block)}</span>
          <Heroicons.icon name="arrow-up-right" type="mini" class="size-5" />
        </a>
      </h3>
      <p class="text-sm text-zinc-600">{render_slot(@description)}</p>
      <%= for extra <- @extra do %>
        {render_slot(extra)}
      <% end %>
      <div class="flex flex-wrap gap-2 mt-2">
        <span :for={tag <- @tags} class="bg-indigo-700 py-1 px-3 text-sm rounded-full text-white">
          {tag}
        </span>
      </div>
    </div>
    """
  end

  defp format_periods(periods, show_months) do
    periods
    |> Enum.map(fn {from, to} ->
      if show_months and from.month == to.month do
        format_date(from, show_months)
      else
        "#{format_date(from, show_months)} - #{format_date(to, show_months)}"
      end
    end)
    |> Enum.join(" / ")
  end

  defp format_date(date, show_months) do
    if show_months do
      Calendar.strftime(date, "%b %Y", month_names: &Constants.localized_month/1)
    else
      date.year
    end
  end

  attr(:tags, :list, default: [])
  attr(:href, :string)
  attr(:image_path, :string)
  attr(:image_alt, :string)

  slot(:inner_block)
  slot(:description)

  def project_card(assigns) do
    ~H"""
    <div class="relative w-full flex flex-col-reverse sm:flex-row items-start gap-5 mb-8">
      <img
        src={@image_path}
        alt={@image_alt}
        class="w-[200px] sm:w-auto sm:max-h-20 aspect-video rounded-md"
      />
      <div class="flex flex-col gap-2">
        <h3 class="font-medium">
          <a
            href={@href}
            target="_blank"
            rel="noreferrer noopener"
            class="relative flex items-center gap-1"
          >
            <span>{render_slot(@inner_block)}</span>
            <Heroicons.icon name="arrow-up-right" type="mini" class="size-5" />
          </a>
        </h3>
        <p class="text-sm text-zinc-600">{render_slot(@description)}</p>
        <div class="flex flex-wrap gap-2 mt-2">
          <span :for={tag <- @tags} class="bg-indigo-700 py-1 px-3 text-sm rounded-full text-white">
            {tag}
          </span>
        </div>
      </div>
    </div>
    """
  end
end

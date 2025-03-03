defmodule PortfolioWeb.Components.Core.Display.Badge do
  use Phoenix.Component

  slot(:inner_block, required: true)

  def badge(assigns) do
    ~H"""
    <span class="bg-indigo-700 dark:bg-indigo-300 dark:text-zinc-800 text-white px-3 py-1 rounded-full text-sm">
      {render_slot(@inner_block)}
    </span>
    """
  end
end

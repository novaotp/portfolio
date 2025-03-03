defmodule PortfolioWeb.Components.Core.Display.Divider do
  use Phoenix.Component

  def divider(assigns) do
    ~H"""
    <hr class="border-zinc-300 dark:border-zinc-600" />
    """
  end
end

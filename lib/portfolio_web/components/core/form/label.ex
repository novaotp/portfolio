defmodule PortfolioWeb.Components.Core.Form.Label do
  use Phoenix.Component

  @doc """
  Renders a label.
  """

  attr(:for, :string, default: nil)
  slot(:inner_block, required: true)

  def label(assigns) do
    ~H"""
    <label for={@for} class="block leading-6 text-zinc-800 dark:text-zinc-100">
      {render_slot(@inner_block)}
    </label>
    """
  end
end

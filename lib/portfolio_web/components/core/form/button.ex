defmodule PortfolioWeb.Components.Core.Form.Button do
  use Phoenix.Component

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button phx-click="go" class="ml-2">Send!</.button>
  """

  attr(:type, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:rest, :global, include: ~w(disabled form name value))

  slot(:inner_block, required: true)

  def button(assigns) do
    ~H"""
    <button
      type={@type}
      class={[
        "phx-submit-loading:opacity-75 rounded-lg bg-indigo-700 hover:bg-indigo-600 dark:bg-indigo-300 dark:hover:bg-indigo-400 focus:ring-2 focus:ring-offset-2 py-2.5 px-5",
        "leading-6 text-white dark:text-zinc-800 active:text-white/80 dark:active:text-zinc-800/80 duration-150",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end
end

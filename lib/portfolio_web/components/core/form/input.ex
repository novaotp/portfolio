defmodule PortfolioWeb.Components.Core.Form.Input do
  use Phoenix.Component

  @doc """
  Renders an input.

  A `Phoenix.HTML.FormField` may be passed as argument,
  which is used to retrieve the input name, id, and values.
  Otherwise all attributes may be passed explicitly.

  ## Examples

      <.input field={@form[:email]} type="email" />
      <.input name="my-input" errors={["oh no!"]} />
  """

  attr(:field, Phoenix.HTML.FormField,
    doc: "A form field struct retrieved from the form, for example: `@form[:email]`."
  )

  attr(:id, :any, default: nil)
  attr(:name, :any)
  attr(:value, :any)

  attr(:rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)
  )

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(assigns) do
    ~H"""
    <input
      type={@type}
      name={@name}
      id={@id}
      value={Phoenix.HTML.Form.normalize_value(@type, @value)}
      class={[
        "w-full px-5 py-3 rounded-lg text-sm text-zinc-900 dark:bg-zinc-800 focus:ring-2 focus:ring-offset-2 sm:text-sm sm:leading-6",
        @errors == [] &&
          "border-zinc-300 dark:border-zinc-700 focus:border-indigo-400 dark:focus:border-indigo-600",
        @errors != [] && "border-red-400 focus:border-red-400"
      ]}
      {@rest}
    />
    """
  end
end

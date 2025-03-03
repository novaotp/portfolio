defmodule PortfolioWeb.Components.Core.Form.Textarea do
  use Phoenix.Component

  @doc """
  Renders a textarea.

  A `Phoenix.HTML.FormField` may be passed as argument,
  which is used to retrieve the input name, id, and values.
  Otherwise all attributes may be passed explicitly.

  ## Examples

      <.textarea field={@form[:message]} type="message" />
  """

  attr(:field, Phoenix.HTML.FormField,
    doc:
      "A form field struct retrieved from the form, for example: `@form[:message]`. Explodes into the other values."
  )

  attr(:id, :any, default: nil)
  attr(:name, :any)
  attr(:value, :any)

  attr(:rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)
  )

  def textarea(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> textarea()
  end

  def textarea(assigns) do
    ~H"""
    <textarea
      id={@id}
      name={@name}
      class={[
        "p-5 text-sm block w-full rounded-lg text-zinc-900 dark:text-zinc-100 dark:bg-zinc-800 focus:ring-2 focus:ring-offset-2 sm:leading-6 min-h-[200px]",
        @errors == [] && "border-zinc-300 dark:border-zinc-700 focus:border-indigo-400",
        @errors != [] && "border-red-400 focus:border-red-400"
      ]}
      {@rest}
    >{Phoenix.HTML.Form.normalize_value("textarea", @value)}</textarea>
    """
  end
end

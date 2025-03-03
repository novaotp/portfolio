defmodule PortfolioWeb.Components.Core.Form.FormField do
  use Phoenix.Component

  import PortfolioWeb.Components.Core.Form.Label

  attr(:field, Phoenix.HTML.FormField,
    doc: "A form field struct retrieved from the form, for example: `@form[:email]`."
  )

  attr(:id, :any, default: nil)
  attr(:errors, :list, default: [])

  slot(:label)
  slot(:inner_block)

  def form_field(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    errors = if Phoenix.Component.used_input?(field), do: field.errors, else: []

    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(errors, &translate_error(&1)))
    |> input()
  end

  def form_field(assigns) do
    ~H"""
    <div class="relative flex flex-col gap-[10px]">
      <.label for={@id}>{render_slot(@label)}</.label>
       {render_slot(@inner_block)}
    </div>
    """
  end
end

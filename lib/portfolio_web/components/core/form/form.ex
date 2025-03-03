defmodule PortfolioWeb.Components.Core.Form do
  @moduledoc """
  Provides components related to forms :
  * Button
  * Input
  * Textarea
  """

  defmacro __using__() do
    quote do
      import __MODULE__.{
        Button,
        FormField,
        Input,
        Label,
        Textarea
      }
    end
  end
end

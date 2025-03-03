defmodule PortfolioWeb.Components.Core.Display do
  @moduledoc """
  Provides components related to displaying data :
  * Badge
  * Divider
  """

  defmacro __using__() do
    quote do
      import __MODULE__.{
        Badge,
        Divider
      }
    end
  end
end

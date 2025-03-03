defmodule PortfolioWeb.Components.Core do
  defmacro __using__() do
    quote do
      use __MODULE__.{
        Display,
        Form
      }
    end
  end
end

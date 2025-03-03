defmodule PortfolioWeb.Constants do
  use Gettext, backend: PortfolioWeb.Gettext

  def months() do
    [
      gettext("January"),
      gettext("February"),
      gettext("March"),
      gettext("April"),
      gettext("May"),
      gettext("June"),
      gettext("July"),
      gettext("August"),
      gettext("September"),
      gettext("October"),
      gettext("November"),
      gettext("December")
    ]
  end

  @doc """
  Provides the localized month based on its value between 1 and 12.

  Ideal to be passed to `Calendar.strftime`'s `month_names` option via the capture operator.

  # Examples

      iex> Calendar.strftime(~D[2025-02-27], "%B", month_names: &Constants.localized_month/1)

      # English
      iex> "Februrary"

      # French
      iex> "Février"
  """
  def localized_month(month), do: months() |> Enum.at(month - 1)
end

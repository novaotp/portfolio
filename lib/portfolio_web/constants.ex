defmodule PortfolioWeb.Constants do
  use Gettext, backend: PortfolioWeb.Gettext

  def months() do
    [
      Gettext.gettext(PortfolioWeb.Gettext, "January"),
      Gettext.gettext(PortfolioWeb.Gettext, "February"),
      Gettext.gettext(PortfolioWeb.Gettext, "March"),
      Gettext.gettext(PortfolioWeb.Gettext, "April"),
      Gettext.gettext(PortfolioWeb.Gettext, "May"),
      Gettext.gettext(PortfolioWeb.Gettext, "June"),
      Gettext.gettext(PortfolioWeb.Gettext, "July"),
      Gettext.gettext(PortfolioWeb.Gettext, "August"),
      Gettext.gettext(PortfolioWeb.Gettext, "September"),
      Gettext.gettext(PortfolioWeb.Gettext, "October"),
      Gettext.gettext(PortfolioWeb.Gettext, "November"),
      Gettext.gettext(PortfolioWeb.Gettext, "December")
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

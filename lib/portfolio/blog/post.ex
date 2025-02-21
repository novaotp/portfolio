defmodule Portfolio.Blog.Post do
  @enforce_keys [:id, :title, :body, :description, :tags, :date]
  defstruct [:id, :title, :body, :description, :tags, :date, updated_at: nil]

  @type t :: %__MODULE__{
          id: String.t(),
          title: String.t(),
          description: String.t(),
          body: String.t(),
          tags: list(String.t()),
          date: DateTime.t(),
          updated_at: DateTime.t() | nil
        }

  def build(filename, attrs, body) do
    [year, month_day_id] = filename |> Path.rootname() |> Path.split() |> Enum.take(-2)
    [month, day, id] = month_day_id |> String.split("-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    attrs =
      attrs
      |> Map.put_new(:updated_at, nil)
      |> Map.to_list()

    struct!(__MODULE__, [id: id, date: date, body: body] ++ attrs)
  end
end

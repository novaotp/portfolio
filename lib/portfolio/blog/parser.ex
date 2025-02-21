defmodule Portfolio.Blog.Parser do
  def parse(path, contents) do
    with {:ok, attrs, body} <- split(path, contents) do
      body =
        body
        |> prepend_table_of_contents()

      {attrs, body}
    end
  end

  defp split(path, contents) do
    case :binary.split(contents, ["\n---\n", "\r\n---\r\n"]) do
      [_] ->
        {:error, "could not find separator --- in #{inspect(path)}"}

      [code, body] ->
        case Code.eval_string(code, []) do
          {%{} = attrs, _} ->
            {:ok, attrs, body}

          {other, _} ->
            {:error,
             "expected attributes for #{inspect(path)} to return a map, got: #{inspect(other)}"}
        end
    end
  end

  defp prepend_table_of_contents(body) do
    table_of_contents =
      body
      |> String.trim("\n")
      |> String.split("\n\n")
      |> Enum.filter(&String.starts_with?(&1, "## "))
      |> Enum.map(fn original ->
        title = String.replace(original, "## ", "")

        "- [#{title}](##{slugify(title)})"
      end)
      |> Enum.join("\n")

    if table_of_contents == "" do
      body
    else
      """
      ## Table of contents

      #{table_of_contents}

      #{body}
      """
    end
  end

  defp slugify(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z]+/, "-")
    |> String.trim("-")
  end
end

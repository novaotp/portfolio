defmodule Portfolio.Blog.MarkdownConverter do
  def convert(filepath, body, _attrs, opts) do
    if Path.extname(filepath) in [".md"] do
      highlighters = Keyword.get(opts, :highlighters, [])

      body
      |> Earmark.as_html!()
      |> NimblePublisher.highlight(highlighters)
    end
  end
end

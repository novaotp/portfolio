defmodule PortfolioWeb.ContactLive do
  use PortfolioWeb, :live_view

  defmodule FormData do
    use Ecto.Schema

    import Ecto.Changeset

    embedded_schema do
      field(:name, :string)
      field(:email, :string)
      field(:message, :string)
    end

    def changeset(form \\ %FormData{}) do
      form
      |> cast(%{}, [:name, :email, :message])
    end

    def apply_changeset(form, params) do
      form
      |> cast(params, [:name, :email, :message])
      |> validate_required([:name, :email, :message])
      |> validate_name()
      |> validate_email()
      |> validate_message()
    end

    defp validate_name(changeset), do: changeset |> validate_length(:name, min: 3)
    defp validate_email(changeset), do: changeset |> validate_format(:email, ~r/@/)
    defp validate_message(changeset), do: changeset |> validate_length(:message, min: 20)
  end

  defmodule ContactEmail do
    import Swoosh.Email
    alias Ecto.Changeset

    @doc """
    Creates an email and sends it.
    """
    @spec send(Ecto.Changeset.t()) :: {:ok, term()} | {:error, term()}
    def send(changeset) do
      changeset
      |> create_email()
      |> Portfolio.Mailer.deliver()
    end

    defp create_email(changeset) do
      contact = extract_from_changeset(changeset)
      config = Application.get_env(:portfolio, Portfolio.Mailer)

      new()
      |> to({config[:name], config[:email]})
      |> from({contact.name, contact.email})
      |> reply_to(contact.email)
      |> subject("Message from contact form at sajidur.dev")
      |> text_body(contact.message)
    end

    defp extract_from_changeset(changeset) do
      %{
        name: Changeset.get_field(changeset, :name),
        email: Changeset.get_field(changeset, :email),
        message: Changeset.get_field(changeset, :message)
      }
    end
  end

  def mount(_params, _session, socket) do
    changeset = FormData.changeset()

    socket =
      socket
      |> assign(:init, changeset)
      |> assign(:form, changeset |> to_form())

    {:ok, socket}
  end

  def handle_event("validate", %{"form_data" => params}, socket) do
    changeset = socket.assigns.init |> FormData.apply_changeset(params)

    socket =
      socket
      |> assign(:form, changeset |> to_form(action: :validate))

    {:noreply, socket}
  end

  def handle_event("send", %{"form_data" => params}, socket) do
    changeset = socket.assigns.init |> FormData.apply_changeset(params)

    socket =
      if changeset.valid? do
        with {:ok, _} <- ContactEmail.send(changeset) do
          socket
          |> put_flash(:info, "Email sent successfully")
        else
          {:error, reason} ->
            socket
            |> put_flash(:error, reason)
        end
      else
        socket
        |> assign(:form, changeset |> to_form(action: :send))
      end

    {:noreply, socket}
  end
end

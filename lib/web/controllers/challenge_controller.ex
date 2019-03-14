defmodule Web.ChallengeController do
  use Web, :controller
  plug Web.Plugs.FetchPage when action in [:index]

  alias IdeaPortal.Challenges

  def index(conn, params) do
    %{page: page, per: per} = conn.assigns
    filter = Map.get(params, "filter", %{})
    pagination = Challenges.all(filter: filter, page: page, per: per)

    conn
    |> assign(:challenges, pagination.page)
    |> assign(:pagination, pagination.pagination)
    |> assign(:filter, filter)
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    case Challenges.get(id) do
      nil ->
        conn |> redirect(to: Routes.challenge_path(conn, :index))

      challenge ->
        conn
        |> assign(:challenge, challenge)
        |> render("show.html")
    end
  end

  def new(conn, _params) do
    %{current_user: user} = conn.assigns

    conn
    |> assign(:changeset, Challenges.new(user))
    |> render("new.html")
  end

  def create(conn, %{"challenge" => params}) do
    %{current_user: user} = conn.assigns

    case Challenges.submit(user, params) do
      {:ok, _challenge} ->
        conn
        |> put_flash(:info, "Challenge submitted!")
        |> redirect(to: Routes.challenge_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> put_status(422)
        |> render("new.html")
    end
  end
end
defmodule User.Plug.Router do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug(:dispatch)

  forward("/user", to: User.Plug.UserController)
  forward("/auth", to: User.Plug.AuthController)

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end

  match _ do
    send_resp(conn, 404, "Page not found!")
  end
end

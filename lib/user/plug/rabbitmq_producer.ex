defmodule User.Plug.RabbitmqProducer do

    def send_message(user, token) do
    hostname = "localhost"
    username = "guest"
    password = "guest"
    options = [host: hostname, port: 5672, virtual_host: "/", username: username, password: password]
    {:ok, connection} = AMQP.Connection.open(options, :undefined)
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "gen_server_test_queue", durable: true)
    message = Poison.encode!(%{id: user.id, first_name: user.first_name, last_name: user.last_name, affiliation: user.affiliation, auth_token: token})
    AMQP.Basic.publish(channel, "", "gen_server_test_queue", message, [content_type: "application/json"])
    IO.puts(" [X] Sent #{message}")
    AMQP.Connection.close(connection)
    end

end
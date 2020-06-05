defmodule User.Plug.RabbitmqProducer do

    def send_message(user) do
    # hostname = System.get_env("RABBITMQ_HOST")
    # username = System.get_env("RABBITMQ_DEFAULT_USER")
    # password = System.get_env("RABBITMQ_DEFAULT_PASS")
    # options = [host: hostname, port: 5672, virtual_host: "/", username: username, password: password]
    {:ok, connection} = AMQP.Connection.open("amqp://tfavcusn:vr7hadAWY3fVvmTMgUJ-VwDsf_otp7yU@kangaroo.rmq.cloudamqp.com/tfavcusn", :undefined)
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "gen_server_test_queue", durable: true)
    message = Poison.encode!(%{id: user.id, first_name: user.first_name, last_name: user.last_name, affiliation: user.affiliation})
    AMQP.Basic.publish(channel, "", "gen_server_test_queue", message, [content_type: "application/json"])
    IO.puts(" [X] Sent #{message}")
    AMQP.Connection.close(connection)
    end

end
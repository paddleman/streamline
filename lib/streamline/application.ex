defmodule Streamline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StreamlineWeb.Telemetry,
      # Start the Ecto repository
      Streamline.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Streamline.PubSub},
      # Start Finch
      {Finch, name: Streamline.Finch},
      # Start the Endpoint (http/https)
      StreamlineWeb.Endpoint
      # Start a worker by calling: Streamline.Worker.start_link(arg)
      # {Streamline.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Streamline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StreamlineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

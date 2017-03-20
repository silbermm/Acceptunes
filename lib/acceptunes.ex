defmodule Acceptunes do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(RallyServer, [[name: RallyServer]]),
      worker(Acceptunes.Scheduler, [[name: Acceptunes.Scheduler]])
    ]

    opts = [strategy: :one_for_one, name: Acceptunes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

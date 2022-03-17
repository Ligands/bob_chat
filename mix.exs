defmodule BobChat.MixProject do
  use Mix.Project

  def project do
    [
      app: :bob_chat,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {BobChat.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 1.0"}
    ]
  end
end

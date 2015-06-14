defmodule Blognix.Mixfile do
  use Mix.Project

  def project do
    [app: :blognix,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Blognix, []},
     applications: app_list(Mix.env)]
  end

  def app_list do
    [:phoenix, :phoenix_html, :cowboy, :logger,
      :phoenix_ecto, :postgrex]
  end

  def app_list(:test), do: [:hound | app_list]
  def app_list(_), do: app_list

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.13.1"},
     {:phoenix_ecto, "~> 0.4"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 1.0"},
     {:phoenix_live_reload, "~> 0.4", only: :dev},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 0.10"},
     { :inflex, "~> 1.3.0" },
     {:hound, "~> 0.7", only: :test}]
  end
end

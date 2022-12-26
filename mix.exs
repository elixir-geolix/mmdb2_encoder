defmodule MMDB2Encoder.MixProject do
  use Mix.Project

  @url_changelog "https://hexdocs.pm/mmdb2_encoder/changelog.html"
  @url_github "https://github.com/elixir-geolix/mmdb2_encoder"
  @version "0.1.0-dev"

  def project do
    [
      app: :mmdb2_encoder,
      name: "MMDB2 Encoder",
      version: @version,
      elixir: "~> 1.9",
      deps: deps(),
      description: "MMDB2 File Format Encoder",
      dialyzer: dialyzer(),
      docs: docs(),
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.2", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.15.0", only: :test, runtime: false},
      {:mmdb2_decoder, "~> 3.0.0", only: :test, runtime: false}
    ]
  end

  defp dialyzer do
    [
      flags: [
        :error_handling,
        :underspecs,
        :unmatched_returns
      ],
      plt_core_path: "plts",
      plt_local_path: "plts"
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      formatters: ["html"],
      main: "MMDB2Encoder",
      source_ref: "v#{@version}",
      source_url: @url_github
    ]
  end

  defp package do
    [
      files: ["CHANGELOG.md", "LICENSE", "mix.exs", "README.md", "lib"],
      licenses: ["Apache-2.0"],
      links: %{
        "Changelog" => @url_changelog,
        "GitHub" => @url_github
      }
    ]
  end
end

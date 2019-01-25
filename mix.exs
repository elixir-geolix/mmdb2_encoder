defmodule MMDB2Encoder.Mixfile do
  use Mix.Project

  @url_github "https://github.com/elixir-geolix/mmdb2_encoder"

  def project do
    [
      app: :mmdb2_encoder,
      name: "MMDB2 Encoder",
      version: "0.1.0-dev",
      elixir: "~> 1.5",
      deps: deps(),
      description: "MMDB2 File Format Encoder",
      docs: docs(),
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.travis": :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test, runtime: false},
      {:mmdb2_decoder, "~> 0.4.0", only: :test, runtime: false}
    ]
  end

  defp docs do
    [
      main: "MMDB2Encoder",
      source_ref: "master",
      source_url: @url_github
    ]
  end

  defp package do
    %{
      files: ["CHANGELOG.md", "LICENSE", "mix.exs", "README.md", "lib"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => @url_github},
      maintainers: ["Marc Neudert"]
    }
  end
end

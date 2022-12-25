list = Enum.to_list(1..100)

defmodule Bench do
  require Iter

  def enum(list), do: list |> Enum.map(&(&1 + 1)) |> Enum.filter(&(rem(&1, 2) == 1))
  def stream(list), do: list |> Stream.map(&(&1 + 1)) |> Enum.filter(&(rem(&1, 2) == 1))
  def iter(list), do: list |> Iter.map(&(&1 + 1)) |> Iter.filter(&(rem(&1, 2) == 1))

  def comprehension(list) do
    for x <- list, y = x + 1, rem(y, 2) == 1, do: y
  end
end

Benchee.run(
  %{
    "Enum" => fn -> Bench.enum(list) end,
    "Stream" => fn -> Bench.stream(list) end,
    "for" => fn -> Bench.comprehension(list) end,
    "Iter" => fn -> Bench.iter(list) end
  },
  time: 2,
  memory_time: 0.5
)

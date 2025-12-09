# Learn functional programming with Elixir

```elixir
Mix.install([
  {:pythonx, "~> 0.4.2"},
  {:kino_pythonx, "~> 0.1.0"}
])
```

## Chapter 1

```elixir
list = ["dogs", "hot dogs", "bananas"]
Enum.map(list, &String.upcase/1)
```

```elixir
defmodule StringList do
def upcase([]), do: []
def upcase([first | rest]), do: [String.upcase(first) | upcase(rest)]
end
StringList.upcase(["dogs","hot dogs"])
```

<h3>
The functional paradigm focuses
on building software using pure functions organized in a way that describes
what software must do, not how it must do it.</h3>
</h3>

## Chapter 2: Variables and Functions

```elixir
name = "Agustin"
"hello, " <> name <> "!"
```

```elixir
hello = fn name -> "hello, " <> name <> "!" end
hello.("Agustin")
```

```elixir
hello.("Kevin")
```

```elixir
hello2 = fn name -> "Hello, #{name}!" end
hello2.("agustiN")
```



## Chapter 3: Pattern matching

```elixir
[a,a,a] = [1, 1, 1]
[a,a,a] = ["ok", "ok", "ok"]
```

```elixir
abilites = %{strength: 16, dexterity: 12, intelligence: 10}
%{strength: strength_value} = abilites
%{} = abilites
```

```elixir
defmodule NumberCompare do
def greater(number, other_number) do
check(number >= other_number, number, other_number)
end
defp check(true, number, _), do: number
defp check(false, _, other_number), do: other_number
end
```

```elixir
NumberCompare.greater(false, 2)
```

In RPGs, players have points to spend on their character attributes. Create
a function that returns the total number of points players have spent on
their characters. The function will receive a map containing the strength,
dexterity, and intelligence values. Each point in strength should be multi-
plied by two, and dexterity and intelligence should be multiplied by three.

```elixir
defmodule PlayerPoints do
  def calculate(strength, dexterity, intelligence) do
    strength * 2 + dexterity * 3 + intelligence * 3 
  end
end
```

```elixir
PlayerPoints.calculate(1,2,3)
```

Create a function that returns Tic-Tac-Toe game winners.

You can repre-sent the board with a tuple of nine elements, where each group of three
items is a row.The return of the function should be a tuple. When we
have a winner, the first element should be the atom :winner, and the second
should be the player. When we have no winner, the tuple should contain
one item that is the atom :no_winner.

It should work like this:
TicTacToe.winner({
:x, :o, :x,
:o, :x, :o,
:o, :o, :x
})
# {:winner, :x}
TicTacToe.winner({
:x, :o, :x,
:o, :x, :o,
:o, :x, :o
})

```elixir
defmodule TicTacToe do
  def winner(board) when tuple_size(board) == 9 do
    plays = winning_possibilities(board)

    case Enum.find(plays, fn [a, b, c] -> a == b and b == c and a in [:x, :o] end) do
      nil -> :no_winner
      [winner, _, _] -> {:winner, winner}
    end
  end

  defp winning_possibilities(board) do
    {
      a, b, c,
      d, e, f,
      g, h, i
    } = board

    [
      [a, b, c],
      [d, e, f],
      [g, h, i],
      [a, d, g],
      [b, e, h],
      [c, f, i],
      [a, e, i],
      [c, e, g]
    ]
  end
end
```

```elixir
defmodule TTT do
def winner({
x, x, x,
_, _, _,
_, _, _
}), do: {:winner, x}
def winner({
_, _, _,
x, x, x,
_, _, _
}), do: {:winner, x}
def winner({
_, _, _,
_, _, _,
x, x, x
}), do: {:winner, x}
def winner({
x, _, _,
x, _, _,
x, _, _
}), do: {:winner, x}
def winner({
_, x, _,
_, x, _,
_, x,
_
}), do: {:winner, x}
def winner({
_, _, x,
_, _, x,
_, _, x
}), do: {:winner, x}
def winner({
x, _, _,
_, x, _,
_, _, x
}), do: {:winner, x}
def winner({
_, _, x,
_, x, _,
x, _, _
}), do: {:winner, x}
def winner(_board), do: :no_winner
end
```

```elixir
# TicTacToe.winner({
# :x, :o, :x,
# :o, :x, :o,
# :o, :x, :o
# })

TTT.winner({
:x, :o, :x,
:o, :x, :o,
:o, :x, :o
})
```

```elixir
TicTacToe.winner({
:x, :o, :x,
:o, :x, :o,
:o, :o, :x
})
```

Create a function that calculates income tax following these rules: a salary
equal or below 2,000 pays no tax; below or equal to 3,000 pays 5%; below
or equal to 6,000 pays 10%; everything higher than 6,000 pays 15%.

```elixir
defmodule IncomingTax do
  defguard is_first_range(price) when price >= 0 and price <= 2000
  defguard is_second_range(price) when price > 2000 and price <= 3000
  defguard is_third_range(price) when price > 3000 and price <= 6000


  def tax(price), do: calculate(price)

  defp calculate(price) when is_first_range(price) do
    0
  end

    defp calculate(price) when is_second_range(price) do
    price * 0.05
  end

    defp calculate(price) when is_third_range(price) do
    price * 0.10
  end

  defp calculate(price) do
    price * 0.15
  end
end
```

```elixir
IncomingTax.tax(2500)
```

Create an Elixir script where users can type their salary and see the
income tax and the net wage. You can use the module from the previous
exercise, but this script should parse the user input and display a message
when users type something that is not a valid number.

```elixir
defmodule UserResume do
  def calculate(salary) do
    unless is_integer(salary) or is_float(salary) do
      # raise ArgumentError, "salary must be an integer"
      IO.puts("salary must be an integer")
    end
    
    value=netWage(salary)
    IO.puts("The net wage is $#{value}")
  end

  defp incomingTax(salary) do
    IncomingTax.tax(salary)
  end

  defp netWage(salary) do
    salary - incomingTax(salary)
  end
end
```

```elixir
UserResume.calculate(300)
```

## Chapter 4: Recursion

<h3>
Decrease and conquer
</h3>

<p>
  Decrease and conquer is a technique for reducing a problem to its simplest
form and starting to solve it incrementally.
  Example: Factorial
</p>

<h3>
Divide and conquer
</h3>

Is about separating the problem into two
or more parts that can be processed independently and can be combined in
the end.
Example: MergeSort

<!-- livebook:{"break_markdown":true} -->

Write two recursive functions: one that finds the biggest element of a list
and another that finds the smallest. You should use them like this:

MyList.max([4, 2, 16, 9, 10])
res => 16

MyList.min([4, 2, 16, 9, 10])
res => 2

```elixir
defmodule MyList do
  def max([]), do: nil
  def max([a]), do: a
  def max([a, b | rest]) when a >= b, do: find_max(rest, a)
  def max([a, b | rest]) when a < b, do: find_max(rest, b)
  defp find_max([], max), do: max
  defp find_max([head | rest], max) when head >= max, do: find_max(rest, head)
  defp find_max([head | rest], max) when head < max, do: find_max(rest, max)
  
  def min([]), do: nil
  def min([a]), do: a
  def min([a, b | rest]) when a <= b, do: find_min(rest, a)
  def min([a, b | rest]) when a > b, do: find_min(rest, b)
  defp find_min([], min), do: min
  defp find_min([head | rest], min) when head <= min, do: find_min(rest, head)
  defp find_min([head | rest], min) when head > min, do: find_min(rest, min)
end
```

```elixir
IO.puts(MyList.min([31,12,3,4,5,6,7,8]))
IO.puts(MyList.max([31,12,3,4,5,6,7,8]))

```

In the section Transforming Lists, on page 62, we traveled to a fantasy
world and enchanted some items. Create a new module called GeneralStore
where you can create a function that filters based on whether the products
are magical. You can use the same test data from EnchanterShop:
GeneralStore.filter_items(GeneralStore.test_data, magic: true)
res => [%{title: "Healing Potion", price: 60, magic: true},
res -> %{title: "Dragon's Spear", price: 100, magic: true}]
GeneralStore.filter_items(GeneralStore.test_data, magic: false)
res => [%{title: "Longsword", price: 50, magic:

```elixir
defmodule GeneralStore do
  def test_data do
    [
      %{title: "Longsword", price: 50, magic: false},
      %{title: "Healing Potion", price: 60, magic: true},
      %{title: "Rope", price: 10, magic: false},
      %{title: "Dragon's Spear", price: 100, magic: true}
    ]
  end

  def filter_items([], magic: magic), do: []

  def filter_items([item = %{magic: item_magic} | rest], magic: filter_magic)
      when item_magic == filter_magic do
    [item | filter_items(rest, magic: filter_magic)]
  end

  def filter_items([item | rest], magic: filter_magic) do
    filter_items(rest, magic: filter_magic)
  end
end
```

We’ve created a function that sorts the items of a list in ascending order.
Now create a Sort.descending/1 function that sorts the elements in descending
order.

```elixir
defmodule Sort do

  def desc_sort([]), do: []
  def desc_sort([a]), do: [a]
  def desc_sort (list) do
    half_list = div(Enum.count(list), 2)
    {list_a, list_b} = Enum.split(list, half_list)
    merge(desc_sort(list_a), desc_sort(list_b))
  end

  defp merge([], list_b), do: list_b
  defp merge(list_a, []), do: list_a
  defp merge([head_a | tail_a], [head_b | tail_b]) when head_a >= head_b do
    [head_a | merge(tail_a, [head_b | tail_b])]
  end
   defp merge([head_a | tail_a], [head_b | tail_b]) when head_a < head_b do
     [head_b | merge([head_a | tail_a], tail_b)]
   end
end
```

```elixir
Sort.desc_sort([1,2,3,4,5,6])
```

## Chapter 5: Higher Order Functions

```elixir
defmodule Factorial do
  def of(0), do: 1

  def of(n) when n > 0 do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.take(n)
    |> Enum.reduce(&(&1 * &2))
  end
end
```

```elixir
Factorial.of(40)
```

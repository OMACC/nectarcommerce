# https://hexdocs.pm/ecto/Ecto.Type.html
defmodule ExShop.AddressType do
  @behaviour Ecto.Type

  def type, do: :integer

  @address_types %{
    "shipping" => 1,
    "billing"  => 2
  }

  # these two can be autogenerated

  @address_reverse_lookup %{
    1 => "shipping",
    2 => "billing"
  }

  @valid_address_types [1, 2]

  def cast(string) when is_binary(string) do
    case Map.get(@address_types, string) do
      {int, _}  -> {:ok, int}
      nil -> :error
    end
  end

  def cast(integer) when is_integer(integer) and integer in @valid_address_types, do: {:ok, integer}

  def cast(_), do: :error
  def load(integer) when is_integer(integer) and integer in @valid_address_types, do: {:ok, Map.get(@address_reverse_lookup, integer)}
  def load(_), do: :error

  # this happens post casting, no validation needed here
  def dump(integer) when is_integer(integer), do: {:ok, integer}
  def dump(_), do: :error

  def get_address_type!(string) do
    Map.fetch!(@address_types, string)
  end

end

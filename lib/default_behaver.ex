defmodule DefaultBehaver do
  @behaviour Behave
  def fun(_, _), do: "ohai from #{__MODULE__}"
end

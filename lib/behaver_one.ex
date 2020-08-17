defmodule BehaverOne do
  @behaviour Behave

  def fun(creds, integer) do
    "#{__MODULE__} #{inspect(binding())}"
  end
end

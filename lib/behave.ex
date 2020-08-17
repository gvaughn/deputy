defmodule Behave do
  use Deputy,
    deputies: %{
      "b1" => BehaverOne,
      "b2" => BehaverTwo
    }

  @callback fun(map, integer) :: String.t()

  # NOTE can't use @impl here because the behavior isn't defined yet
  # @impl true
  # def fun(creds, integer) do
  #   deputy(creds).fun(creds, integer)
  # end

  # NOTE I can add more clauses to deputy/1
  def deputy(_), do: DefaultBehaver

  # NOTE after a module is compiled we can do
  # Behave.behaviour_info(:callbacks)
end

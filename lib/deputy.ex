defmodule Deputy do
  @moduledoc """
  The goal here is to have some behaviour (eg Marketplace) and a
  master "Deputy" module that knows how to delegate to a particular
  implementation at runtime based upon a parameter/pattern match
  """

  defmacro __using__(opts) do
    quote do
      @before_compile unquote(__MODULE__)
      def deputy(%{service: s}) do
        unquote(opts[:deputies])[s]
      end
    end
  end

  defmacro __before_compile__(env) do
    # IO.inspect(env.functions, limit: :infinity)
    # IO.inspect(env)
    env.module
    |> Module.get_attribute(:callback)
    |> Enum.map(&delegate_callback/1)
    |> IO.inspect()
  end

  defp delegate_callback({:callback, {:::, _meta, [fun_def, _ret_type]}, _}) do
    {fun_name, _meta, args} = fun_def
    arity = length(args)
    if arity == 0, do: raise("can't handle zero arity functions")
    IO.inspect("#{fun_name}/#{length(args)}")

    params = Macro.generate_arguments(arity, __MODULE__)

    quote do
      def unquote(fun_name)(unquote_splicing(params)) do
        deputy(arg1).unquote(fun_name)(unquote_splicing(params))
      end
    end
  end
end

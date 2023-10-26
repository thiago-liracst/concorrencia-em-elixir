defmodule Semaphore do
  use GenServer

  def start_link(initial_count) do
    GenServer.start_link(__MODULE__, {initial_count, self()})
  end

  def init({count, owner}) do
    {:ok, %{count: count, owner: owner}}
  end

  defp acquire({:ok, state} = server) do
    if state.count > 0 && state.owner == self() do
      {:ok, %{state | count: state.count - 1}}
    else
      {:error, "Semáforo ocupado."}
    end
  end

  defp release({:ok, state} = server) do
    if state.owner == self() do
      {:ok, %{state | count: state.count + 1}}
    else
      {:error, "Você não é o proprietário do semáforo."}
    end
  end

  def acquire(server) do
    GenServer.call(server, :acquire)
  end

  def release(server) do
    GenServer.call(server, :release)
  end
end


{:ok, semaphore} = Semaphore.start_link(1)

Semaphore.acquire(semaphore)
IO.puts("Adquiriu o semáforo.")
# Realize o trabalho crítico aqui.

Semaphore.release(semaphore)
IO.puts("Liberou o semáforo.")

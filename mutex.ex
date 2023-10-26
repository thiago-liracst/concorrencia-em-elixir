defmodule MyMutex do
  @mutex_name :my_mutex

  def start_link do
    :mutex.start_link(@mutex_name)
  end

  def lock(mutex_pid) do
    :mutex.lock(mutex_pid)
  end

  def unlock(mutex_pid) do
    :mutex.unlock(mutex_pid)
  end

  def with_mutex(fun) do
    case start_link() do
      {:ok, mutex_pid} ->
        case lock(mutex_pid) do
          :ok ->
            result = fun.()
            unlock(mutex_pid)
            {:ok, result}
          {:error, _reason} ->
            {:error, "Failed to acquire lock"}
        end
      {:error, _reason} ->
        {:error, "Failed to start mutex"}
    end
  end
end

defmodule MyModule do
  def some_critical_function do
    MyMutex.with_mutex(fn ->
      # Código crítico que requer exclusão mútua
      IO.puts("Valor atual do contad")
    end)
  end
end

MyModule.some_critical_function()

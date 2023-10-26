defmodule SimpleCounter do
  use GenServer

  # Função de inicialização do GenServer
  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  # Funções públicas para interagir com o contador
  def increment do
    GenServer.cast(__MODULE__, :increment)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  # Callbacks do GenServer
  def init(initial_value) do
    {:ok, initial_value}
  end

  def handle_cast(:increment, count) do
    {:noreply, count + 1}
  end

  def handle_call(:get, _from, count) do
    {:reply, count, count}
  end
end

# Inicialize o contador com um valor inicial de 0
{:ok, counter} = SimpleCounter.start_link(0)

# Incremente o contador
SimpleCounter.increment()

# Obtenha o valor atual do contador
value = SimpleCounter.get()

IO.puts("Valor atual do contador: #{value}, PID: #{inspect counter}")

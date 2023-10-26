# Função para loop dos processos
defmodule Loop do
  def loop(name) do
    receive do
      {:message, msg} ->
        IO.puts("#{inspect(name)} recebeu a mensagem: #{msg}")
    end
    loop(name)
  end
end

# Criando dois processos
pid1 = spawn(fn -> Loop.loop(:process1) end)
pid2 = spawn(fn -> Loop.loop(:process2) end)

# Enviando mensagens entre os processos
send(pid1, {:message, "Olá, processo 2!"})
send(pid2, {:message, "Olá, processo 1!"})

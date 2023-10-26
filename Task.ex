# Exemplo de uso da biblioteca Task para paralelismo
tasks = [
  Task.async(fn -> do_work_1() end),
  Task.async(fn -> do_work_2() end),
  Task.async(fn -> do_work_3() end)
]

results = tasks
|> Enum.map(&Task.await/1)

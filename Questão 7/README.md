# 1 - Explique o conceito de transação em um banco de dados e dê um exemplo onde se aplica o uso de transações
O conceito de transaçõe é que são processos que fazem a execução de operações de um banco de dados, garantindo que essas operações sejam executadas de formas consistentes e e isoladas.
Um dos seus principais usos são em bancos para realizar transferencias.

# 2 - Explique por que as transações são executadas de forma concorrente em um banco de dados e não uma após a outra
Elas são executadas dessa forma para poder melhorar o desempenho do sistema, melhorando então a eficiencia do bando de dados a também sua otimização.

# 3 - Explique como são executadas as operações “ler_item” e “escrever_item” em um banco de dados
a operação ler_item é esexutada quando necessitamos realizar uma consulta dentro do banco de dados para buscar alguma informação.
Já a escrever_item, vai funcionar para quando necessitarmos de mexer dentro do banco de dados, seja para excluir, atualizar ou inserir um novo registro.

# 4 - Pergunta
Ela passa pelos estados de "Ativa", "Pausada", "Com Defeito", "indefinida" e "Confirmada".
- A Ativa significa que a transação está sendo executada mas ainda não foi finalizada.  
- A Pausada significa que a transição está quase concluída, porém, ainda não foi confirmada.
- A com defeito significa que alguma operação deu errado e a transição retornou um erro, com isso a mesma é revertida
- A indefinida diz que a transição não pode definir um estado corretamente
- A Confirmada que significa que as operações foram executadas e ela foi finalizada com sucesso.

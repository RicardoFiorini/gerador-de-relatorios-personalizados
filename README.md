# 🚀 Gerador de Relatórios Personalizados (Versão ÉPICA)

Este é um algoritmo de console em Portugol que simula um sistema de Business Intelligence (BI) para gerar relatórios personalizados.

O que torna este projeto "épico" é sua arquitetura de **pipeline de dados**. O usuário não apenas filtra ou ordena; ele constrói uma **"Visão"** (View) dos dados e pode aplicar múltiplas transformações (filtrar, depois ordenar) antes de exibir ou exportar o resultado final.



## ✨ Funcionalidades Principais

* **1. Adicionar Registro:**
    * Permite o cadastro de novos registros (Funcionários).
    * **Validação:** Impede o cadastro de registros com **ID duplicado**.
    * **Validação:** Garante que `Idade` e `Salário` sejam valores positivos.

* **2. Definir Filtros:**
    * Permite ao usuário definir filtros complexos (ex: Idade entre 20 e 30, Salário acima de R$ 5000).
    * **Validação:** Garante que o valor mínimo não seja maior que o máximo.
    * **Ação:** Esta ação aciona o `gerarVisaoRelatorio()`, que cria a "Visão" apenas com os registros que passam no filtro.

* **3. Resetar Filtros:**
    * Limpa todos os filtros e regenera a "Visão" para incluir todos os registros.

* **4. Ordenar Visão Atual:**
    * Permite ordenar a **"Visão"** atual (que já pode estar filtrada) por ID, Nome, Idade ou Salário.
    * **Lógica Eficiente:** O algoritmo não move os dados brutos; ele apenas reordena o vetor de *índices* (`visaoAtual.indices`), o que é muito mais rápido e eficiente.

* **5. Exibir Relatório (Visão Atual):**
    * Exibe uma tabela formatada no console contendo *apenas* os dados da "Visão" atual, respeitando os filtros e a ordem definidos pelo usuário.

* **6. Exportar Relatório (Visão Atual):**
    * Permite ao usuário exportar a "Visão" atual.
    * **Simulação de I/O:** Como o VisualG não possui I/O de arquivos, esta função *simula* a exportação, imprimindo no console um texto perfeitamente formatado como **CSV** ou como uma tabela de **PDF**.

## 🏛️ A Arquitetura "Épica": A Pipeline de "Visão"

O segredo deste algoritmo é a separação entre os dados brutos e a visualização deles.

### 1. Os Dados Brutos (`dados: vetor[...] de Registro`)
É o "banco de dados" completo. Armazena todos os registros originais. *Nunca é modificado* (exceto ao adicionar novos dados).

### 2. O Filtro (`filtroAtual: Filtro`)
É um registro que armazena as regras (ex: `idadeMin = 20`, `idadeMax = 30`).

### 3. A Visão (`visaoAtual: Visao`)
Este é o conceito-chave. É um vetor que armazena apenas os **ÍNDICES** (posições) dos dados que passam pelo filtro.

**Exemplo de Fluxo:**

1.  **Dados Brutos:**
    * `[1] = (ID 10, "Ana")`
    * `[2] = (ID 20, "Bruno")`
    * `[3] = (ID 30, "Carla")`
2.  **Usuário define o Filtro:** `idade > 25`.
3.  `gerarVisaoRelatorio()` é chamado. Ele varre os dados brutos e descobre que "Bruno" (índice 2) e "Carla" (índice 3) passam no filtro.
4.  **A `visaoAtual.indices` agora contém:** `[2, 3]`. O `totalIndices` é 2.
5.  **Usuário pede para Ordenar por Nome (Z-A).**
6.  `ordenarVisao()` é chamado. Ele compara `dados[2].nome` ("Bruno") com `dados[3].nome` ("Carla"). "Carla" vem antes de "Bruno" na ordem Z-A.
7.  O sistema troca os *índices* na visão.
8.  **A `visaoAtual.indices` agora contém:** `[3, 2]`.
9.  **Usuário pede para Exibir o Relatório.**
10. `exibirRelatorioAtual()` é chamado.
    * Ele lê o primeiro índice da visão: `3`. Imprime `dados[3]` ("Carla").
    * Ele lê o segundo índice da visão: `2`. Imprime `dados[2]` ("Bruno").

O resultado é um relatório filtrado E ordenado, sem jamais ter alterado a ordem dos dados originais.

## 🚀 Como Executar

Para executar este algoritmo, você precisará de um interpretador de Portugol.

1.  **VisualG (Recomendado):**
    * Baixe e instale o [VisualG](httpf://visualg.com.br/cli/).
    * Copie o código-fonte (`.alg`) do arquivo.
    * Abra o VisualG e cole o código.
    * Pressione **F9** (ou clique em "Rodar") para executar o programa.

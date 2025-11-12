algoritmo "Gerador de Relatórios Personalizados ÉPICO"

// --- Constantes de Limite ---
const
   LIMITE_REGISTROS = 100

// --- Definição dos Tipos (Registros) ---
tipo Registro
   id: inteiro
   nome: caractere
   idade: inteiro
   salario: real
   dataContratacao: caractere
fimTipo

// TIPO 2: Armazena a configuração do filtro atual
tipo Filtro
   idadeMin: inteiro
   idadeMax: inteiro
   salarioMin: real
   salarioMax: real
fimTipo

// TIPO 3: A "Visão" - armazena os ÍNDICES dos registros que passam no filtro
tipo Visao
   indices: vetor[1..LIMITE_REGISTROS] de inteiro
   totalIndices: inteiro
fimTipo

// --- Variáveis Globais ---
var
   dados: vetor[1..LIMITE_REGISTROS] de Registro // O "Banco de Dados"
   totalDados: inteiro
   
   filtroAtual: Filtro // A configuração do filtro
   visaoAtual: Visao   // Os resultados do filtro
   
   opcao: inteiro

// --- Procedimento: Pausa a execução ---
procedimento Pausar()
var
   tecla: caractere
inicio
   escreva("\n(Pressione [ENTER] para voltar ao menu...)")
   leia(tecla)
fimprocedimento

// --- Função: Busca um registro pelo ID ---
// (Retorna o ÍNDICE [1..100] ou 0 se não encontrar)
funcao buscarRegistroPorID(idBusca: inteiro) : inteiro
var
   i: inteiro
inicio
   para i de 1 até totalDados faca
      se (dados[i].id = idBusca) entao
         retorne i
      fimse
   fimpara
   retorne 0
fimfuncao

// --- Procedimento: Adicionar Registro (com validação) ---
procedimento adicionarRegistro()
var
   idRegistro, idadeRegistro: inteiro
   salarioRegistro: real
inicio
   limpatela
   escreva("--- Adicionar Registro ---\n")
   
   se (totalDados >= LIMITE_REGISTROS) entao
      escreva("[ERRO] Limite de (", LIMITE_REGISTROS, ") registros atingido!\n")
   senao
      escreva("ID (único): ")
      leia(idRegistro)
      
      // 1. Validação de Duplicidade de ID
      se (buscarRegistroPorID(idRegistro) > 0) entao
         escreva("\n[ERRO] Já existe um registro com este ID!\n")
      senao
         // 2. Validação de Valores
         idadeRegistro <- 0
         enquanto (idadeRegistro <= 0) faca
            escreva("Idade: ")
            leia(idadeRegistro)
         fimenquanto
         
         salarioRegistro <- 0
         enquanto (salarioRegistro <= 0) faca
            escreva("Salário: R$ ")
            leia(salarioRegistro)
         fimenquanto
         
         // 3. Adiciona
         totalDados <- totalDados + 1
         dados[totalDados].id <- idRegistro
         dados[totalDados].idade <- idadeRegistro
         dados[totalDados].salario <- salarioRegistro
         
         escreva("Nome: ")
         leia(dados[totalDados].nome)
         escreva("Data de Contratação (DD/MM/AAAA): ")
         leia(dados[totalDados].dataContratacao)
         
         escreva("\nRegistro adicionado com sucesso!\n")
      fimse
   fimse
fimprocedimento

// --- Procedimento: Gera a "Visão" com base no filtro atual ---
// Esta é a rotina mais importante. Ela preenche o vetor 'visaoAtual.indices'
procedimento gerarVisaoRelatorio()
var
   i: inteiro
   r: Registro // Auxiliar
inicio
   // Limpa a visão anterior
   visaoAtual.totalIndices <- 0
   
   // Loop principal pelos DADOS BRUTOS
   para i de 1 até totalDados faca
      r <- dados[i] // Pega o registro
      
      // Aplica o filtro (armazenado na var global 'filtroAtual')
      se (r.idade >= filtroAtual.idadeMin) e
         (r.idade <= filtroAtual.idadeMax) e
         (r.salario >= filtroAtual.salarioMin) e
         (r.salario <= filtroAtual.salarioMax) entao
         
         // Se passar, adiciona o ÍNDICE (i) à visão
         visaoAtual.totalIndices <- visaoAtual.totalIndices + 1
         visaoAtual.indices[visaoAtual.totalIndices] <- i
         
      fimse
   fimpara
fimprocedimento

// --- Procedimento: Define os filtros e regera a visão ---
procedimento definirFiltros()
var
   idadeMin, idadeMax: inteiro
   salarioMin, salarioMax: real
inicio
   limpatela
   escreva("--- Definir Filtros do Relatório ---\n")
   
   idadeMin <- 0
   enquanto (idadeMin <= 0) faca
      escreva("Filtrar por Idade (mínima): ")
      leia(idadeMin)
   fimenquanto
   
   idadeMax <- idadeMin
   enquanto (idadeMax < idadeMin) faca
      escreva("Filtrar por Idade (máxima) [", idadeMin, "]: ")
      leia(idadeMax)
   fimenquanto
   
   salarioMin <- 0
   enquanto (salarioMin <= 0) faca
      escreva("Filtrar por Salário (mínimo): R$ ")
      leia(salarioMin)
   fimenquanto
   
   salarioMax <- salarioMin
   enquanto (salarioMax < salarioMin) faca
      escreva("Filtrar por Salário (máximo) [", salarioMin:0:2, "]: R$ ")
      leia(salarioMax)
   fimenquanto
   
   // Salva os filtros na variável global
   filtroAtual.idadeMin <- idadeMin
   filtroAtual.idadeMax <- idadeMax
   filtroAtual.salarioMin <- salarioMin
   filtroAtual.salarioMax <- salarioMax
   
   // Regera a visão
   gerarVisaoRelatorio()
   
   escreva("\nFiltro aplicado! ", visaoAtual.totalIndices, " registros encontrados.\n")
fimprocedimento

// --- Procedimento: Reseta os filtros e regera a visão ---
procedimento resetarFiltros()
inicio
   filtroAtual.idadeMin <- 0
   filtroAtual.idadeMax <- 999
   filtroAtual.salarioMin <- 0
   filtroAtual.salarioMax <- 999999999
   
   // Regera a visão com todos os dados
   gerarVisaoRelatorio()
   
   escreva("\nFiltros resetados. Exibindo todos os ", visaoAtual.totalIndices, " registros.\n")
fimprocedimento

// --- Procedimento: Troca a posição de dois ÍNDICES na VISÃO ---
// (Helper para a ordenação)
procedimento trocarIndicesVisao(posA, posB: inteiro)
var
   aux: inteiro
inicio
   aux <- visaoAtual.indices[posA]
   visaoAtual.indices[posA] <- visaoAtual.indices[posB]
   visaoAtual.indices[posB] <- aux
fimprocedimento

// --- Procedimento: Ordenar a VISÃO ATUAL (sem tocar nos dados brutos) ---
procedimento ordenarVisao()
var
   i, j, opOrd: inteiro
   idxRealA, idxRealB: inteiro // Os índices que apontam para os dados brutos
   rA, rB: Registro // Os registros reais
inicio
   limpatela
   escreva("--- Ordenar Visão do Relatório ---\n")
   
   se (visaoAtual.totalIndices < 2) entao
      escreva("[AVISO] É preciso ter pelo menos 2 registros na visão para ordenar.\n")
      retorne
   fimse
   
   escreva("Escolha o critério de ordenação:\n")
   escreva("1. ID\n")
   escreva("2. Nome\n")
   escreva("3. Idade\n")
   escreva("4. Salário\n")
   escreva("Opção: ")
   leia(opOrd)
   
   // Algoritmo de Ordenação (Bubble Sort)
   // A mágica: O loop opera de 1 até 'totalIndices' (o tamanho da VISÃO)
   para i de 1 até visaoAtual.totalIndices - 1 faca
      para j de i + 1 até visaoAtual.totalIndices faca
         
         // Pega os índices reais (ex: 5 e 12)
         idxRealA <- visaoAtual.indices[i]
         idxRealB <- visaoAtual.indices[j]
         
         // Pega os dados reais
         rA <- dados[idxRealA]
         rB <- dados[idxRealB]
         
         // Compara os DADOS REAIS
         escolha opOrd
            caso 1 // ID
               se (rA.id > rB.id) entao
                  trocarIndicesVisao(i, j) // Troca os ÍNDICES na visão
               fimse
            caso 2 // Nome
               se (rA.nome > rB.nome) entao
                  trocarIndicesVisao(i, j)
               fimse
            caso 3 // Idade
               se (rA.idade > rB.idade) entao
                  trocarIndicesVisao(i, j)
               fimse
            caso 4 // Salário
               se (rA.salario > rB.salario) entao
                  trocarIndicesVisao(i, j)
               fimse
         fimescolha
         
      fimpara
   fimpara
   
   escreva("\nVisão do relatório ordenada com sucesso!\n")
fimprocedimento

// --- Procedimento: Exibe a VISÃO ATUAL (Filtrada e Ordenada) ---
procedimento exibirRelatorioAtual()
var
   i, idxReal: inteiro
   r: Registro
inicio
   limpatela
   escreva("=================================================================================\n")
   escreva("=                       RELATÓRIO ATUAL (", visaoAtual.totalIndices, " registros)                      =\n")
   escreva("=================================================================================\n")
   escreva("ID   | Nome                 | Idade | Salário        | Data Contratação\n")
   escreva("---------------------------------------------------------------------------------\n")
   
   se (visaoAtual.totalIndices = 0) entao
      escreva("  (Nenhum registro encontrado para os filtros atuais)\n")
   senao
      // Loop sobre a VISÃO
      para i de 1 até visaoAtual.totalIndices faca
         idxReal <- visaoAtual.indices[i] // Pega o índice real
         r <- dados[idxReal] // Pega o dado real
         
         escreva(r.id:4, " | ")
         escreva(r.nome:20, " | ")
         escreva(r.idade:5, " | ")
         escreva("R$", r.salario:10:2, " | ")
         escreva(r.dataContratacao, "\n")
      fimpara
   fimse
   escreva("=================================================================================\n")
fimprocedimento

// --- Procedimento: Exportar (Simulado, pois VisualG não tem I/O de arquivo) ---
procedimento menuExportar()
var
   i, idxReal, opExport: inteiro
   r: Registro
inicio
   limpatela
   escreva("--- Exportar Relatório (", visaoAtual.totalIndices, " registros) ---\n")
   escreva("1. Exportar para CSV (Simulado)\n")
   escreva("2. Exportar para PDF (Simulado)\n")
   escreva("0. Cancelar\n")
   escreva("Opção: ")
   leia(opExport)
   
   se (opExport = 1) entao // CSV
      escreva("\n--- SIMULAÇÃO DE ARQUIVO 'relatorio.csv' ---\n\n")
      escreva("ID,Nome,Idade,Salario,DataContratacao\n")
      para i de 1 até visaoAtual.totalIndices faca
         idxReal <- visaoAtual.indices[i]
         r <- dados[idxReal]
         escreva(r.id, ",", r.nome, ",", r.idade, ",", r.salario:0:2, ",", r.dataContratacao, "\n")
      fimpara
      escreva("\n--- FIM DA SIMULAÇÃO CSV ---\n")
      
   senao se (opExport = 2) entao // PDF
      escreva("\n+-------------------------------------------------------------------------------+\n")
      escreva("|                         SIMULAÇÃO DE ARQUIVO 'relatorio.pdf'                  |\n")
      escreva("+----+----------------------+-------+----------------+--------------------------+\n")
      escreva("| ID | Nome                 | Idade | Salário        | Data Contratação         |\n")
      escreva("+----+----------------------+-------+----------------+--------------------------+\n")
      para i de 1 até visaoAtual.totalIndices faca
         idxReal <- visaoAtual.indices[i]
         r <- dados[idxReal]
         escreva("| ", r.id:2, " | ", r.nome:20, " | ", r.idade:5, " | ", "R$", r.salario:10:2, " | ", r.dataContratacao:24, " |\n")
      fimpara
      escreva("+----+----------------------+-------+----------------+--------------------------+\n")
      escreva("| Total de Registros: ", visaoAtual.totalIndices:65, " |\n")
      escreva("+-------------------------------------------------------------------------------+\n")
      
   senao
      escreva("\nExportação cancelada.\n")
   fimse
fimprocedimento

// --- Bloco Principal (Início da Execução) ---
inicio
   totalDados <- 0
   
   // Inicializa a pipeline na primeira execução
   resetarFiltros() // Isso também chama gerarVisaoRelatorio()
   
   // Menu Principal
   repita
      limpatela
      escreva("=========================================\n")
      escreva("=    Gerador de Relatórios ÉPICO    =\n")
      escreva("=========================================\n")
      escreva(" Registros Totais: ", totalDados, "/", LIMITE_REGISTROS, "\n")
      escreva(" Registros na Visão: ", visaoAtual.totalIndices, "\n")
      escreva("=========================================\n")
      escreva("1. Adicionar Registro\n")
      escreva("2. Definir Filtros\n")
      escreva("3. Resetar Filtros\n")
      escreva("4. Ordenar Visão Atual\n")
      escreva("5. Exibir Relatório (Visão Atual)\n")
      escreva("6. Exportar Relatório (Visão Atual)\n")
      escreva("0. Sair\n")
      escreva("-----------------------------------------\n")
      escreva("Escolha uma opção: ")
      leia(opcao)

      escolha opcao
         caso 1
            adicionarRegistro()
            gerarVisaoRelatorio() // Atualiza a visão com o novo registro (se ele passar no filtro)
            Pausar()
         caso 2
            definirFiltros() // Já chama 'gerarVisaoRelatorio'
            Pausar()
         caso 3
            resetarFiltros() // Já chama 'gerarVisaoRelatorio'
            Pausar()
         caso 4
            ordenarVisao()
            Pausar()
         caso 5
            exibirRelatorioAtual()
            Pausar()
         caso 6
            menuExportar()
            Pausar()
         caso 0
            escreva("\nSaindo do Gerador de Relatórios...\n")
         padrão
            escreva("\n[ERRO] Opção inválida.\n")
            Pausar()
      fimescolha
      
   até (opcao = 0)
fimalgoritmo

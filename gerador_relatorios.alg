algoritmo "Gerador de Relatórios Personalizados"

// Estruturas de Dados
tipo Registro
    id : inteiro
    nome : caractere
    idade : inteiro
    salario : real
    dataContratacao : caractere
fimTipo

tipo Relatorio
    registros : vetor[1..100] de Registro
    totalRegistros : inteiro
fimTipo

// Variáveis Globais
relatorio : Relatorio
opcao : inteiro
filtroIdadeMinima : inteiro
filtroIdadeMaxima : inteiro
filtroSalarioMinimo : real
filtroSalarioMaximo : real
opcaoOrdenacao : inteiro
exportacaoFormato : inteiro

// Função para adicionar registros ao relatório
funcao adicionarRegistro()
    se relatorio.totalRegistros < 100 então
        relatorio.totalRegistros ← relatorio.totalRegistros + 1
        escreva("ID: ")
        leia(relatorio.registros[relatorio.totalRegistros].id)
        escreva("Nome: ")
        leia(relatorio.registros[relatorio.totalRegistros].nome)
        escreva("Idade: ")
        leia(relatorio.registros[relatorio.totalRegistros].idade)
        escreva("Salário: ")
        leia(relatorio.registros[relatorio.totalRegistros].salario)
        escreva("Data de Contratação (DD/MM/AAAA): ")
        leia(relatorio.registros[relatorio.totalRegistros].dataContratacao)
        escreva("Registro adicionado com sucesso!\n")
    senão
        escreva("Limite de registros atingido.\n")
    fimse
fimfuncao

// Função para filtrar registros
funcao filtrarRegistros()
    filtroIdadeMinima ← 0
    filtroIdadeMaxima ← 150
    filtroSalarioMinimo ← 0
    filtroSalarioMaximo ← 9999999

    escreva("Filtrar por Idade (minima): ")
    leia(filtroIdadeMinima)
    escreva("Filtrar por Idade (maxima): ")
    leia(filtroIdadeMaxima)
    escreva("Filtrar por Salário (minimo): ")
    leia(filtroSalarioMinimo)
    escreva("Filtrar por Salário (maximo): ")
    leia(filtroSalarioMaximo)

    escreva("\n=== Registros Filtrados ===\n")
    para i de 1 até relatorio.totalRegistros faça
        se (relatorio.registros[i].idade >= filtroIdadeMinima) e (relatorio.registros[i].idade <= filtroIdadeMaxima) e 
           (relatorio.registros[i].salario >= filtroSalarioMinimo) e (relatorio.registros[i].salario <= filtroSalarioMaximo) então
            escreva("ID: ", relatorio.registros[i].id, ", Nome: ", relatorio.registros[i].nome, 
                    ", Idade: ", relatorio.registros[i].idade, ", Salário: ", relatorio.registros[i].salario, 
                    ", Data de Contratação: ", relatorio.registros[i].dataContratacao, "\n")
        fimse
    fimpara
fimfuncao

// Função para ordenar registros
funcao ordenarRegistros()
    escreva("\nEscolha o critério de ordenação:\n")
    escreva("1. ID\n")
    escreva("2. Nome\n")
    escreva("3. Idade\n")
    escreva("4. Salário\n")
    escreva("Escolha uma opção: ")
    leia(opcaoOrdenacao)

    para i de 1 até relatorio.totalRegistros - 1 faça
        para j de i + 1 até relatorio.totalRegistros faça
            escolha opcaoOrdenacao
                caso 1 // Ordenar por ID
                    se relatorio.registros[i].id > relatorio.registros[j].id então
                        // Troca
                        aux ← relatorio.registros[i]
                        relatorio.registros[i] ← relatorio.registros[j]
                        relatorio.registros[j] ← aux
                    fimse
                caso 2 // Ordenar por Nome
                    se relatorio.registros[i].nome > relatorio.registros[j].nome então
                        // Troca
                        aux ← relatorio.registros[i]
                        relatorio.registros[i] ← relatorio.registros[j]
                        relatorio.registros[j] ← aux
                    fimse
                caso 3 // Ordenar por Idade
                    se relatorio.registros[i].idade > relatorio.registros[j].idade então
                        // Troca
                        aux ← relatorio.registros[i]
                        relatorio.registros[i] ← relatorio.registros[j]
                        relatorio.registros[j] ← aux
                    fimse
                caso 4 // Ordenar por Salário
                    se relatorio.registros[i].salario > relatorio.registros[j].salario então
                        // Troca
                        aux ← relatorio.registros[i]
                        relatorio.registros[i] ← relatorio.registros[j]
                        relatorio.registros[j] ← aux
                    fimse
            fimescolha
        fimpara
    fimpara
    escreva("Registros ordenados com sucesso!\n")
fimfuncao

// Função para exportar para CSV
funcao exportarCSV()
    arquivo : texto
    arquivo ← abrir("relatorio.csv", "w")
    
    escreva(arquivo, "ID,Nome,Idade,Salario,DataContratacao\n")
    para i de 1 até relatorio.totalRegistros faça
        escreva(arquivo, relatorio.registros[i].id, ",", relatorio.registros[i].nome, ",", 
                relatorio.registros[i].idade, ",", relatorio.registros[i].salario, ",", 
                relatorio.registros[i].dataContratacao, "\n")
    fimpara
    fechar(arquivo)
    escreva("Relatório exportado para CSV com sucesso!\n")
fimfuncao

// Função para exportar para PDF (simulação, apenas imprime os dados)
funcao exportarPDF()
    escreva("\n=== Exportação para PDF ===\n")
    escreva("ID\tNome\tIdade\tSalário\tData de Contratação\n")
    para i de 1 até relatorio.totalRegistros faça
        escreva(relatorio.registros[i].id, "\t", relatorio.registros[i].nome, "\t", 
                relatorio.registros[i].idade, "\t", relatorio.registros[i].salario, "\t", 
                relatorio.registros[i].dataContratacao, "\n")
    fimpara
    escreva("Relatório exportado para PDF (simulado) com sucesso!\n")
fimfuncao

// Menu Principal
inicio
    relatorio.totalRegistros ← 0

    repita
        escreva("\n=== Gerador de Relatórios Personalizados ===\n")
        escreva("1. Adicionar Registro\n")
        escreva("2. Filtrar Registros\n")
        escreva("3. Ordenar Registros\n")
        escreva("4. Exportar Relatório\n")
        escreva("0. Sair\n")
        escreva("Escolha uma opção: ")
        leia(opcao)

        escolha opcao
            caso 1
                adicionarRegistro()
            caso 2
                filtrarRegistros()
            caso 3
                ordenarRegistros()
            caso 4
                escreva("Escolha o formato de exportação:\n")
                escreva("1. CSV\n")
                escreva("2. PDF (simulado)\n")
                escreva("Escolha uma opção: ")
                leia(exportacaoFormato)

                escolha exportacaoFormato
                    caso 1
                        exportarCSV()
                    caso 2
                        exportarPDF()
                    caso contrário
                        escreva("Formato inválido.\n")
                fimescolha
            caso 0
                escreva("Saindo do Gerador de Relatórios...\n")
            caso contrário
                escreva("Opção inválida.\n")
        fimescolha
    até opcao = 0

fimalgoritmo

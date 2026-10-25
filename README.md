# Todos os gols da história da Uefa Euro

Projeto de análise e visualização de dados sobre a história da Euro, a principal competição de seleções de futebol da Uefa. O projeto reúne informações sobre edições, partidas, resultados, gols e jogadores, com consultas SQL e um relatório interativo desenvolvido no Power BI.

[**Clique aqui para acessar o relatório no Power BI**](https://app.powerbi.com/view?r=eyJrIjoiMGY4MWY1MTUtYzY1ZS00MDU5LTgzNDMtYmQxYWM0NzRkNTg1IiwidCI6ImFmNmE0MmI1LWJkMGUtNDUwNS1iMDdmLWY5MTdiMGNlMmYzZCJ9)

## Objetivos

- Organizar dados históricos das edições da Eurocopa.
- Analisar partidas, resultados e gols ao longo da história do torneio.
- Explorar informações dos jogadores que já marcaram gol na competição.
- Utilizar SQL para consultar, validar e transformar os dados.
- Desenvolver visualizações no Power BI para facilitar a análise dos dados.

## Tecnologias utilizadas

- **SQL Server:** armazenamento, consulta e transformação dos dados.
- **SQL:** consultas exploratórias, verificações de consistência e criação de uma view auxiliar.
- **Power BI:** criação do relatório interativo e visualização dos dados.
- **DAX:** criação de medidas e cálculos utilizados no modelo de dados e nas análises.

## Banco de dados e consultas SQL

O banco reúne tabelas relacionadas a:

- **Edições:** informações sobre as edições da competição.
- **Jogos:** data, fase, seleções, placar e informações sobre o local das partidas.
- **Gols:** registros dos gols e informações associadas, como jogador e minuto.
- **Jogadores:** informações pessoais dos jogadores.
- **Participantes:** nomes das seleções e correspondência entre nomes históricos e atuais.
- **Resultados:** informações estruturadas sobre os resultados das partidas.

O script SQL inclui consultas exploratórias e verificações de consistência, como a identificação de gols associados a jogadores não cadastrados, a conferência de minutos dos gols e a busca por possíveis divergências nos resultados.

### View `resultados_atualizados`

A view consolida os resultados das partidas em duas linhas por jogo — uma para cada seleção. Ela apresenta os gols marcados e sofridos por cada equipe, o adversário e informações contextuais da partida. Também utiliza a tabela de participantes para relacionar nomes históricos de seleções aos nomes atuais.

Essa estrutura facilita análises por seleção sem precisar separar a equipe mandante ou a primeira seleção da segunda seleção em colunas diferentes.

## Fontes de dados

- **[UEFA EURO](https://www.uefa.com/uefaeuro/):** fonte das informações sobre partidas e gols.
- **[Transfermarkt](https://www.transfermarkt.com/):** fonte de informações pessoais dos jogadores.

## Estrutura do projeto

- `dump_euro.sql`: arquivo de exportação do banco de dados.
- `script_euro.sql`: consultas SQL, verificações de consistência e criação da view `resultados_atualizados`.
- `.pbip-files/`: arquivos do projeto do Power BI.

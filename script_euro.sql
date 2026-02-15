-------------------------------------------------------
-- General queries on the database
-------------------------------------------------------

-- Matches decided by penalties
SELECT * FROM jogos WHERE desempate = 'pênaltis' ORDER BY idjogo DESC;

-- Drawn matches outside the group stage
SELECT * FROM jogos WHERE gols_selecao1 = gols_selecao2 AND fase != 'fase de grupos' ORDER BY idjogo DESC;

-- Players with names containing 'kane'
SELECT * FROM jogadores WHERE nome LIKE '%kane%';

-- Goals ordered by the number of goals
SELECT * FROM gols ORDER BY ngol DESC;

-- Players ordered by number of games
SELECT * FROM jogadores ORDER BY njogador DESC;

-- Count of results with victory on penalties
SELECT COUNT(idresultado) FROM resultados WHERE pen_vd = 'V';

-- Goals from a specific match
SELECT * FROM gols WHERE idjogo = 212;

-------------------------------------------------------
-- Data checks and validations
-------------------------------------------------------

-- Goals by players not existing in the players table
SELECT g.* 
FROM gols g 
LEFT JOIN jogadores j ON g.nome_jogador = j.nome 
WHERE j.nome IS NULL;

-- Goals scored in the wrong match time
SELECT * FROM gols WHERE etapa = '2º tempo' AND minuto < 45;
SELECT * FROM gols WHERE etapa = '2º tempo da prorrogação' AND minuto < 106;

-- Check if a goal's minute is greater or equal to the previous goal's minute in the same match
WITH comp_min AS (
    SELECT *, 
           LAG(g.minuto) OVER (ORDER BY g.idjogo) AS min_gol_anterior
    FROM gols g
),
comp_jogo AS (
    SELECT *, 
           LAG(g.idjogo) OVER (ORDER BY g.idjogo) AS jogo_gol_anterior
    FROM gols g
),
comp_etapa AS (
    SELECT *, 
           LAG(g.etapa) OVER (ORDER BY g.idjogo) AS etapa_gol_anterior
    FROM gols g
)
SELECT 
    cm.*, 
    ce.etapa_gol_anterior, 
    cj.jogo_gol_anterior
FROM comp_min cm
JOIN comp_jogo cj 
    ON cm.idgol = cj.idgol
JOIN comp_etapa ce 
    ON ce.idgol = cj.idgol
WHERE cm.min_gol_anterior >= cm.minuto
  AND cm.idjogo = cj.jogo_gol_anterior;

-- Checking inconsistencies in the results table
SELECT * FROM resultados WHERE gols_marcados > gols_sofridos AND VED = 'D';

-------------------------------------------------------
-- Views and auxiliary structures
-------------------------------------------------------

-- View: resultados_atualizados
-- Description:
--   This view consolidates all match results in the database.
--   For each match, it generates two rows — one per team.
--   Includes:
--     • Updated names for each team and opponent
--     • Goals scored and conceded
--     • Contextual information (date, stadium, city, stage, etc.)
--   It uses the 'participantes' table to map old and current country names
--   (e.g., "USSR" → "Russia").
--
-- Note:
--   This view simplifies aggregations (such as total goals per team)
--   by eliminating the need to differentiate between columns seleção1 and seleção2.

CREATE OR REPLACE VIEW resultados_atualizados AS
WITH resultados_invertidos AS (
    SELECT
        idjogo,
        idedicao,
        fase,
        data,
        horário,
        país,
        cidade,
        estádio,
        seleção2        AS seleção,
        gols_seleção2   AS gols_marcados,
        seleção1        AS adversário,
        gols_seleção1   AS gols_sofridos,
        desempate,
        venc_desempate
    FROM jogos
),

resultados_duplicados AS (
    SELECT * FROM resultados_invertidos
    UNION ALL
    SELECT * FROM jogos
)

SELECT 
    rd.idjogo,
    rd.idedicao,
    rd.fase,
    rd.data,
    rd.horário,
    rd.país,
    rd.cidade,
    rd.estádio,
    p1.nome_pais_atual AS seleção,
    rd.gols_marcados,
    p2.nome_pais_atual AS adversário,
    rd.gols_sofridos,
    rd.desempate,
    p3.nome_pais_atual AS venc_desempate
FROM resultados_duplicados rd
LEFT JOIN participantes p1 
    ON rd.seleção = p1.nome_pais
LEFT JOIN participantes p2 
    ON rd.adversário = p2.nome_pais
LEFT JOIN participantes p3 
    ON rd.venc_desempate = p3.nome_pais
ORDER BY rd.idjogo, seleção;

-------------------------------------------------------
-- Auxiliary queries
-------------------------------------------------------

SELECT * FROM edições;

-------------------------------------------------------
-- Test inserts (without specifying columns)
-------------------------------------------------------

-- Insert edition
INSERT INTO edições VALUES ('1', '1960', 'União Soviética', 'Iugoslávia');

-- Insert match
INSERT INTO jogos VALUES ('388', '2024', 'final', '2024-06-14', '16:00:00',
                         'Alemanha', 'Berlim', 'Estádio Olímpico de Berlim',
                         'Espanha', '3', '0', NULL, NULL);

-- Insert result
INSERT INTO resultados VALUES ('774', '387', 'Inglaterra', '2', '1', 'Holanda', 'V', NULL, NULL);

-- Insert player
INSERT INTO jogadores VALUES ('564', 'Xavi Simons', '2003-04-21', 'Holanda');

-- Insert goal
INSERT INTO gols VALUES ('943', '387', 'Inglaterra', 'Ollie Watkins', NULL, '2º tempo', '90', '2', '1');


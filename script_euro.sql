use euro;

# Devo trocar os nomes dos países nas tabelas (menos a jogos) para a forma como eles são chamados atualmente?

# Queries para pesquisa na base de dados
select * from jogos where desempate = 'pênaltis' order by idjogo desc;
select * from jogos where gols_seleção1 = gols_seleção2 and fase != 'fase de grupos' order by idjogo desc;
select * from jogadores where nome like '%kane%';
select * from gols order by ngol desc;
select * from jogadores order by njogador desc;
select count(idresultado) from resultados where pen_vd = 'V';
select * from gols where njogo = 212;


# Conferindo quais gols tem um nome de jogador que não consta na tabela jogadores
select * from gols g left join jogadores j on g.nome_jogador = j.nome where j.nome is null;

# Verificando se um gol está no tempo de jogo errado
select * from gols where etapa = '2º tempo' and minuto < 45;
select * from gols where etapa = '2º tempo da prorrogação' and minuto < 106;

# Verificando se o minuto do gol de um jogo é maior ou igual que o minuto do gol posterior
with comp_min as
(select *, lag(g.minuto) over(order by g.njogo) as min_gol_anterior from gols g), 
comp_jogo 
as (select *, lag(g.njogo) over(order by g.njogo) as jogo_gol_anterior from gols g)
select cm.*, cj.jogo_gol_anterior from comp_min cm join comp_jogo cj
on cm.ngol = cj.ngol
where cm.min_gol_anterior >= cm.minuto and cm.njogo = cj.jogo_gol_anterior;

# Verificando erros na tabela resultados
select * from resultados where gols_marcados > gols_sofridos and VED = 'D';




select * from edições;
insert into edições values ('1', '1960', 'União Soviética', 'Iugoslávia');

insert into jogos values ('382', '2024', 'quartas de final', '2024-06-05', '13:00:00', 'Alemanha', 'Stuttgart', 'MHP Arena', 'Espanha', '2', 'Alemanha', '1', 'prorrogação', 'Espanha');
insert into jogos values ('383', '2024', 'quartas de final', '2024-06-05', '16:00:00', 'Alemanha', 'Hamburgo', 'Volksparkstadion', 'Portugal', '0', 'França', '0', 'pênaltis', 'França');
insert into jogos values ('384', '2024', 'quartas de final', '2024-06-06', '13:00:00', 'Alemanha', 'Düsseldorf', 'Merkur Spiel-Arena', 'Inglaterra', '1', 'Suíça', '1', 'pênaltis', 'Inglaterra');
insert into jogos values ('385', '2024', 'quartas de final', '2024-06-06', '16:00:00', 'Alemanha', 'Berlim', 'Estádio Olímpico de Berlim', 'Holanda', '2', 'Turquia', '1', null, null);

insert into jogos values ('386', '2024', 'semifinal', '2024-06-09', '16:00:00', 'Alemanha', 'Munique', 'Allianz Arena', 'Espanha', '2', 'França', '1', null, null);
insert into jogos values ('387', '2024', 'semifinal', '2024-06-10', '16:00:00', 'Alemanha', 'Dortmund', 'Signal Iduna Park', 'Holanda', '1', 'Inglaterra', '2', null, null);

insert into jogos values ('388', '2024', 'final', '2024-06-14', '16:00:00', 'Alemanha', 'Berlim', 'Estádio Olímpico de Berlim', 'Espanha', '3', 'Inglaterra', '0', null, null);

insert into resultados values ('763', '382', 'Espanha', '2', '1', 'Alemanha', 'V', 'V', null);
insert into resultados values ('764', '382', 'Alemanha', '1', '2', 'Espanha', 'D', 'D', null);
insert into resultados values ('765', '383', 'Portugal', '0', '0', 'França', 'E', 'E', 'D');
insert into resultados values ('766', '383', 'França', '0', '0', 'Portugal', 'E', 'E', 'V');
insert into resultados values ('767', '384', 'Inglaterra', '1', '1', 'Suíça', 'E', 'E', 'V');
insert into resultados values ('768', '384', 'Suíça', '1', '1', 'Inglaterra', 'E', 'E', 'D');
insert into resultados values ('769', '385', 'Holanda', '2', '1', 'Turquia', 'V', null, null);
insert into resultados values ('770', '385', 'Turquia', '1', '2', 'Holanda', 'D', null, null);

insert into resultados values ('771', '386', 'Espanha', '2', '1', 'França', 'V', null, null);
insert into resultados values ('772', '386', 'França', '1', '2', 'Espanha', 'D', null, null);
insert into resultados values ('773', '387', 'Holanda', '1', '2', 'Inglaterra', 'D', null, null);
insert into resultados values ('774', '387', 'Inglaterra', '2', '1', 'Holanda', 'V', null, null);

insert into jogadores values ('554', 'Robin Le Normand', '1996-11-11', 'Espanha');
insert into jogadores values ('555', 'Rodri', '1996-06-22', 'Espanha');
insert into jogadores values ('556', 'Nico Williams', '2002-07-10', 'Espanha');
insert into jogadores values ('557', 'Dani Olmo', '1998-05-07', 'Espanha');

insert into jogadores values ('558', 'Jan Vertonghen', '1987-04-24', 'Bélgica');

insert into jogadores values ('559', 'Mikel Merino', '1996-06-22', 'Espanha');

insert into jogadores values ('560', 'Bukayo Saka', '2001-09-05', 'Inglaterra');

insert into jogadores values ('561', 'Stefan de Vrij', '1992-02-05', 'Holanda');

insert into jogadores values ('562', 'Randal Kolo Muani', '1998-12-05', 'França');
insert into jogadores values ('563', 'Lamine Yamal', '2007-07-13', 'Espanha');

insert into jogadores values ('564', 'Xavi Simons', '2003-04-21', 'Holanda');
insert into jogadores values ('565', 'Ollie Watkins', '1995-12-30', 'Inglaterra');

insert into gols values ('897', '366', 'Áustria', 'Donyell Malen', 'contra', '1º tempo', '6', '1', '0');
insert into gols values ('898', '366', 'Holanda', 'Cody Gakpo', null, '2º tempo', '47', '1', '1');
insert into gols values ('899', '366', 'Áustria', 'Romano Schmid', null, '2º tempo', '59', '2', '1');
insert into gols values ('900', '366', 'Holanda', 'Cody Gakpo', null, '2º tempo', '75', '2', '2');
insert into gols values ('901', '366', 'Áustria', 'Marcel Sabitzer', null, '2º tempo', '80', '3', '2');

insert into gols values ('915', '376', 'Eslováquia', 'Ivan Schranz', null, '1º tempo', '25', '1', '0');
insert into gols values ('916', '376', 'Inglaterra', 'Jude Bellingham', null, '2º tempo', '95', '1', '1');
insert into gols values ('917', '376', 'Inglaterra', 'Harry Kane', null, '1º tempo da prorrogação', '91', '2', '1');

insert into gols values ('918', '377', 'Geórgia', 'Robin Le Normand', 'contra', '1º tempo', '25', '1', '0');
insert into gols values ('919', '377', 'Espanha', 'Rodri', null, '2º tempo', '39', '1', '1');
insert into gols values ('920', '377', 'Espanha', 'Fabián Ruiz', null, '2º tempo', '51', '2', '1');
insert into gols values ('921', '377', 'Espanha', 'Nico Williams', null, '2º tempo', '75', '3', '1');
insert into gols values ('922', '377', 'Espanha', 'Dani Olmo', null, '2º tempo', '83', '4', '1');

insert into gols values ('923', '378', 'França', 'Jan Vertonghen', 'contra', '2º tempo', '85', '1', '0');

insert into gols values ('924', '380', 'Holanda', 'Cody Gakpo', null, '1º tempo', '20', '1', '0');
insert into gols values ('925', '380', 'Holanda', 'Donyell Malen', null, '2º tempo', '83', '2', '0');
insert into gols values ('926', '380', 'Holanda', 'Donyell Malen', null, '2º tempo', '93', '3', '0');

insert into gols values ('927', '381', 'Turquia', 'Merih Demiral', null, '1º tempo', '1', '1', '0');
insert into gols values ('928', '381', 'Turquia', 'Merih Demiral', null, '2º tempo', '59', '2', '0');
insert into gols values ('929', '381', 'Áustria', 'Michael Gregoritsch', null, '2º tempo', '66', '1', '2');

insert into gols values ('930', '382', 'Espanha', 'Dani Olmo', null, '2º tempo', '51', '1', '0');
insert into gols values ('931', '382', 'Alemanha', 'Florian Wirtz', null, '2º tempo', '89', '1', '1');
insert into gols values ('932', '382', 'Espanha', 'Mikel Merino', null, '2º tempo da prorrogação', '120', '2', '1');

insert into gols values ('933', '384', 'Suíça', 'Breel Embolo', null, '2º tempo', '75', '1', '0');
insert into gols values ('934', '384', 'Inglaterra', 'Bukayo Saka', null, '2º tempo', '80', '1', '1');

insert into gols values ('935', '385', 'Turquia', 'Samet Akaydin', null, '1º tempo', '35', '1', '0');
insert into gols values ('936', '385', 'Holanda', 'Stefan de Vrij', null, '2º tempo', '70', '1', '1');
insert into gols values ('937', '385', 'Holanda', 'Mert Müldür', 'contra', '2º tempo', '76', '2', '1');

insert into gols values ('938', '386', 'França', 'Randal Kolo Muani', null, '1º tempo', '9', '1', '0');
insert into gols values ('939', '386', 'Espanha', 'Lamine Yamal', null, '1º tempo', '21', '1', '1');
insert into gols values ('940', '386', 'Espanha', 'Dani Olmo', null, '1º tempo', '25', '2', '1');

insert into gols values ('941', '387', 'Holanda', 'Xavi Simons', null, '1º tempo', '7', '1', '0');
insert into gols values ('942', '387', 'Inglaterra', 'Harry Kane', null, '1º tempo', '18', '1', '1');
insert into gols values ('943', '387', 'Inglaterra', 'Ollie Watkins', null, '2º tempo', '90', '2', '1');
USE master
GO
DROP DATABASE escola

CREATE DATABASE escola
GO
USE escola
GO
 
CREATE TABLE aluno (
ra		INT				NOT NULL,
nome	VARCHAR(100)	NOT NULL,
idade	INT				NOT NULL
PRIMARY KEY (ra)
)
GO
CREATE TABLE disciplina (
codigo			INT				NOT NULL,
nome			VARCHAR(80)		NOT NULL,
carga_horaria	INT				NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE aluno_disciplina (
codigo_disciplina	INT		NOT NULL,
ra_aluno			INT		NOT NULL
PRIMARY KEY (ra_aluno, codigo_disciplina)
FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)
GO
CREATE TABLE curso (
codigo	INT				NOT NULL,
nome	VARCHAR(50)		NOT NULL,
area	VARCHAR(50)		NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE curso_disciplina (
codigo_disciplina	INT		NOT NULL,
codigo_curso		INT 	NOT NULL
PRIMARY KEY (codigo_curso, codigo_disciplina)
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo),
FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)
GO
CREATE TABLE titulacao (
codigo		INT				NOT NULL,
titulo		VARCHAR(40)		NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE professor (
registro		INT				NOT NULL,
nome			VARCHAR(100)	NOT NULL,
titulacao		INT				NOT NULL
PRIMARY KEY (registro)
FOREIGN KEY (titulacao) REFERENCES titulacao(codigo)
)
GO
CREATE TABLE disciplina_professor (
codigo_disciplina	INT 	NOT NULL,
registro_professor	INT		NOT NULL
PRIMARY KEY (registro_professor, codigo_disciplina)
FOREIGN KEY (registro_professor) REFERENCES professor(registro),
FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)
GO
INSERT INTO aluno VALUES
(3416,'DIEGO PIOVESAN DE RAMOS', 18),
(3423,'LEONARDO MAGALHÃES DA ROSA',17),
(3434,'LUIZA CRISTINA DE LIMA MARTINELI',20),
(3440,'IVO ANDRÉ FIGUEIRA DA SILVA',25),
(3443,'BRUNA LUISA SIMIONI',37),
(3448,'THAÍS NICOLINI DE MELLO',17),
(3457,'LÚCIO DANIEL TÂMARA ALVES',29),
(3459,'LEONARDO RODRIGUES',25),
(3465,'ÉDERSON RAFAEL VIEIRA',19),
(3466,'DAIANA ZANROSSO DE OLIVEIRA',21),
(3467,'DANIELA MAURER',23),
(3470,'ALEX SALVADORI PALUDO',42),
(3471,'VINÍCIUS SCHVARTZ',19),
(3472,'MARIANA CHIES ZAMPIERI',18),
(3482,'EDUARDO CAINAN GAVSKI',19),
(3483,'REDNALDO ORTIZ DONEDA',20),
(3499,'MAYELEN ZAMPIERON',22)
GO
INSERT INTO disciplina VALUES
(1,'Laboratório de Banco de Dados',80),
(2,'Laboratório de Engenharia de Software',80),
(3,'Programação Linear e Aplicações',80),
(4,'Redes de Computadores',80),
(5,'Segurança da informação',80),
(6,'Teste de Software',80),
(7,'Custos e Tarifas Logísticas',80),
(8,'Gestão de Estoques',80),
(9,'Fundamentos de Marketing',80),
(10,'Métodos Quantitativos de Gestão',80),
(11,'Gestão do Tráfego Urbano',80),
(12,'Sistemas de Movimentação e Transporte',80)
GO
INSERT INTO titulacao VALUES
(1,'Especialista'),
(2,'Mestre'),
(3,'Doutor')
GO
INSERT INTO curso VALUES
(1,'ADS','Ciências da Computação'),
(2,'Logística','Engenharia Civil')
GO
INSERT INTO professor VALUES
(1111,'Leandro',2),
(1112,'Antonio',2),
(1113,'Alexandre',3),
(1114,'Wellington',2),
(1115,'Luciano',1),
(1116,'Edson',2),
(1117,'Ana',2),
(1118,'Alfredo',1),
(1119,'Celio',2),
(1120,'Dewar',3),
(1121,'Julio',1)
GO
INSERT INTO curso_disciplina VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2)
GO
INSERT INTO disciplina_professor VALUES
(1,1111),
(2,1112),
(3,1113),
(4,1114),
(5,1115),
(6,1116),
(7,1117),
(8,1118),
(9,1117),
(10,1119),
(11,1120),
(12,1121)
GO
INSERT INTO aluno_disciplina VALUES
(1,3416),
(4,3416),
(1,3423),
(2,3423),
(5,3423),
(6,3423),
(2,3434),
(5,3434),
(6,3434),
(1,3440),
(5,3443),
(6,3443),
(4,3448),
(5,3448),
(6,3448),
(2,3457),
(4,3457),
(5,3457),
(6,3457),
(1,3459),
(6,3459),
(7,3465),
(11,3465),
(8,3466),
(11,3466),
(8,3467),
(12,3467),
(8,3470),
(9,3470),
(11,3470),
(12,3470),
(7,3471),
(7,3472),
(12,3472),
(9,3482),
(11,3482),
(8,3483),
(11,3483),
(12,3483),
(8,3499)

SELECT * FROM aluno
SELECT * FROM disciplina
SELECT * FROM aluno_disciplina
SELECT * FROM curso
SELECT * FROM curso_disciplina
SELECT * FROM titulacao
SELECT * FROM professor
SELECT * FROM disciplina_professor

-- Como fazer as listas de chamadas, com RA e nome por disciplina ?	
SELECT a.ra, d.nome
FROM aluno a, disciplina d, aluno_disciplina ad
WHERE a.ra = ad.ra_aluno AND d.codigo = ad.codigo_disciplina
-- Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram	
SELECT d.nome, p.nome
FROM disciplina d, professor p, disciplina_professor dp
WHERE d.codigo = dp.codigo_disciplina AND p.registro = dp.registro_professor
-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso	
SELECT d.nome, c.nome
FROM disciplina d, curso c, curso_disciplina cd
WHERE d.codigo = cd.codigo_disciplina AND c.codigo = cd.codigo_curso
-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua área	
SELECT d.nome, c.area
FROM disciplina d, curso c, curso_disciplina cd
WHERE d.codigo = cd.codigo_disciplina AND c.codigo = cd.codigo_curso
-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o título do professor que a ministra		
SELECT d.nome, t.titulo
FROM disciplina d, professor p, titulacao t, disciplina_professor dp
WHERE dp.registro_professor = p.registro AND dp.codigo_disciplina = d.codigo AND p.titulacao = t.codigo
-- Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos estão matriculados em cada uma delas	
SELECT d.nome, COUNT(a.ra) as aluno
FROM disciplina d, aluno a, aluno_disciplina ad
WHERE d.codigo = ad.codigo_disciplina AND a.ra = ad.ra_aluno
GROUP by d.nome
-- Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.  Só deve retornar de disciplinas que tenham, no mínimo, 5 alunos matriculados		
SELECT d.nome AS diciplina, p.nome AS professor
FROM disciplina d, professor p, disciplina_professor dp
WHERE dp.codigo_disciplina = d.codigo AND dp.registro_professor = p.registro AND d.nome IN (
	SELECT d.nome
	FROM disciplina d, aluno a, aluno_disciplina ad
	WHERE d.codigo = ad.codigo_disciplina AND a.ra = ad.ra_aluno
	GROUP by d.nome
	HAVING COUNT(a.ra) > 5
)
-- Fazer uma pesquisa que retorne o nome do curso e a quatidade de professores cadastrados que ministram aula nele. A coluna deve se chamar quantidade													
	SELECT c.nome, COUNT(c.nome) as quantidade
	FROM professor p, disciplina d, disciplina_professor dp,curso_disciplina cd, curso c
	WHERE d.codigo = dp.codigo_disciplina AND dp.registro_professor = p.registro AND c.codigo = cd.codigo_curso AND cd.codigo_disciplina = d.codigo
	GROUP BY c.nome

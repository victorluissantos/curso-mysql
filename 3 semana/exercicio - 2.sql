-- 	1. qual a moda(maior ocorrencia) de hora que mais se encontra no prospects - function
-- Line code
SELECT 
	count(DATE_FORMAT(p.data, '%h')) as 'moda_horario'
FROM
    prospects p
GROUP BY DATE_FORMAT(p.data, '%h')
ORDER BY 1 DESC
LIMIT 1;
-- create function
USE `pgto`;
DROP function IF EXISTS `get_moda_hora_prospect`;
DELIMITER $$
USE `pgto`$$
CREATE FUNCTION `get_moda_hora_prospect` ()
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				count(DATE_FORMAT(p.data, '%h')) as 'moda_horario'
			FROM
				prospects p
			GROUP BY DATE_FORMAT(p.data, '%h')
			ORDER BY 1 DESC
			LIMIT 1);
END$$
DELIMITER ;
-- call function
SELECT GET_MODA_HORA_PROSPECT();

-- 2. qual a moda(maior ocorrencia) de hora que mais se encontra no inscricoes - function
SELECT 
	count(DATE_FORMAT(i.data_criacao, '%h')) as 'moda_horario'
FROM
    inscricoes i
GROUP BY DATE_FORMAT(i.data_criacao, '%h')
ORDER BY 1 DESC
LIMIT 1;

-- create function
USE `pgto`;
DROP function IF EXISTS `get_moda_hora_inscricoe`;
DELIMITER $$
USE `pgto`$$
CREATE FUNCTION `get_moda_hora_inscricoe` ()
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
					count(DATE_FORMAT(i.data_criacao, '%h')) as 'moda_horario'
				FROM
					inscricoes i
				GROUP BY DATE_FORMAT(i.data_criacao, '%h')
				ORDER BY 1 DESC
				LIMIT 1);
END$$
DELIMITER ;
-- call function
SELECT GET_MODA_HORA_INSCRICOE();


-- 3. uma view que mostre dados unicos entre a juncao de inscricao e prospect, ou seja, quero uma view que lista todos os usuarios de prospect e de inscricoes, porem quem esta em inscricoes nao precisa estar na listagem do prospect
CREATE VIEW `pgto`.`globals` AS
    (SELECT 
        `pgto`.`inscricoes`.`nome` AS `nome`,
        `pgto`.`inscricoes`.`cpf` AS `cpf`,
        `pgto`.`inscricoes`.`data_nascimento` AS `data_nascimento`,
        `pgto`.`inscricoes`.`celular` AS `celular`,
        `pgto`.`inscricoes`.`telefone` AS `telefone`,
        `pgto`.`inscricoes`.`email` AS `email`,
        `pgto`.`inscricoes`.`cnh` AS `cnh`,
        `pgto`.`inscricoes`.`categoria` AS `categoria`,
        `pgto`.`inscricoes`.`uf` AS `uf`,
        `pgto`.`inscricoes`.`municipio` AS `municipio`,
        DATE_FORMAT(`pgto`.`inscricoes`.`data_criacao`, '%h') AS `DATE_FORMAT(``data_criacao``, '%h')`,
        `pgto`.`inscricoes`.`renach` AS `renach`
    FROM
        `pgto`.`inscricoes`) UNION (SELECT 
        `pgto`.`prospects`.`nome` AS `nome`,
        `pgto`.`prospects`.`cpf` AS `cpf`,
        `pgto`.`prospects`.`data_nascimento` AS `data_nascimento`,
        `pgto`.`prospects`.`celular` AS `celular`,
        `pgto`.`prospects`.`telefone` AS `telefone`,
        `pgto`.`prospects`.`email` AS `email`,
        `pgto`.`prospects`.`cnh` AS `cnh`,
        `pgto`.`prospects`.`cnh_cat` AS `cnh_cat`,
        `pgto`.`prospects`.`uf` AS `uf`,
        `pgto`.`prospects`.`cidade` AS `cidade`,
        DATE_FORMAT(`pgto`.`prospects`.`data`, '%h') AS `DATE_FORMAT(``data``, '%h')`,
        `pgto`.`prospects`.`renach` AS `renach`
    FROM
        `pgto`.`prospects`)

-- Create a view tih disctinct row
CREATE VIEW `pgto`.`insc_prosps` AS
    (SELECT DISTINCT
        `globals`.`nome` AS `nome`,
        `globals`.`cpf` AS `cpf`,
        `globals`.`data_nascimento` AS `data_nascimento`,
        `globals`.`celular` AS `celular`,
        `globals`.`telefone` AS `telefone`,
        `globals`.`email` AS `email`,
        `globals`.`cnh` AS `cnh`,
        `globals`.`categoria` AS `categoria`,
        `globals`.`uf` AS `uf`,
        `globals`.`municipio` AS `municipio`,
        `globals`.`DATE_FORMAT(``data_criacao``, '%h')` AS `DATE_FORMAT(``data_criacao``, '%h')`,
        `globals`.`renach` AS `renach`
    FROM
        `pgto`.`globals`)
-- call result
SELECT i.* FROM insc_prosps i

/**
	
    4. Qual a moda de idade da tabela inscricoes - function
    5. qual a moda de idade da tabela prospects - function
    6. qual a moda de idade das tabelas juntas, inscricoe e prospect - function
    7. Trigger, Todo nome e email inserido na tabela inscricoe seja atualizado para caixa alta ( upper() )
	8. Trigger, Todo nome e email inserido na tabela prospect seja atualizado para caixa alta ( upper() )

-- Dicas: date_formta, distinct, group by, order by
*/
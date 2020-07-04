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

-- 4. Qual a moda de idade da tabela inscricoes - function
-- Query / line
SELECT 
    YEAR(CURDATE()) - YEAR(i.data_nascimento) AS 'idade',
    count(i.id) as 'total'
FROM
    inscricoes i
WHERE
    YEAR(i.data_nascimento) <> '0000'
    AND
    i.data_nascimento IS NOT NULL
GROUP BY 1;
-- create view
USE `pgto`;
CREATE  OR REPLACE VIEW `getModaIdadeInsc` AS (SELECT 
    YEAR(CURDATE()) - YEAR(i.data_nascimento) AS 'idade',
    count(i.id) as 'total'
FROM
    inscricoes i
WHERE
    YEAR(i.data_nascimento) <> '0000'
    AND
    i.data_nascimento IS NOT NULL
GROUP BY 1);
-- Create function
USE `pgto`;
DROP function IF EXISTS `get_moda_idade_insc`;

DELIMITER $$
USE `pgto`$$
CREATE FUNCTION `get_moda_idade_insc` ()
RETURNS INTEGER
BEGIN
    DECLARE moda INT;
    SET moda = (SELECT idade FROM getModaIdadeInsc ORDER BY total desc LIMIT 1);
RETURN moda;
END$$

DELIMITER ;

-- call function
SELECT GET_MODA_IDADE_INSC();


-- 5. qual a moda de idade da tabela prospects - function
-- Line Code
SELECT 
    count(p.id) as 'total',
    YEAR(curdate()) - YEAR(p.data_nascimento) as 'idade'
FROM
    prospects p
WHERE
    p.data_nascimento <> '0000-00-00'
    AND
    p.data_nascimento is not null
GROUP BY 2;
-- create view
USE `pgto`;
CREATE  OR REPLACE VIEW `moda_idade_prospect` AS (SELECT 
                                            count(p.id) as 'total',
                                            YEAR(curdate()) - YEAR(p.data_nascimento) as 'idade'
                                        FROM
                                            prospects p
                                        WHERE
                                            p.data_nascimento <> '0000-00-00'
                                            AND
                                            p.data_nascimento is not null
                                        GROUP BY 2);
-- create function
USE `pgto`;
DROP function IF EXISTS `get_moda_idade_prospect`;

DELIMITER $$
USE `pgto`$$
CREATE FUNCTION `get_moda_idade_prospect` ()
RETURNS INTEGER
BEGIN
    DECLARE moda INT;
    SET moda = (SELECT idade FROM moda_idade_prospect order by total DESC LIMIT 1);
    RETURN moda;
END$$

DELIMITER ;

-- call function
select get_moda_idade_prospect();

-- 6. qual a moda de idade das tabelas juntas, inscricoe e prospect - function
-- create union
(
    SELECT 
    i.id,
    i.data_nascimento,
    YEAR(curdate()) - YEAR(i.data_nascimento) as 'idade'
FROM
    inscricoes i
WHERE
    YEAR(i.data_nascimento) <> '0000'
        AND i.data_nascimento IS NOT NULL
        ) 
    UNION
(
    SELECT
    p.id,
    p.data_nascimento,
    YEAR(curdate()) - YEAR(p.data_nascimento) as 'idade'
FROM
    prospects p
WHERE
    YEAR(p.data_nascimento) <> '0000'
        AND p.data_nascimento IS NOT NULL
);
-- Create View
USE `pgto`;
CREATE  OR REPLACE VIEW `uniaoProspectInscricoe` AS
(SELECT 
    i.id,
    i.data_nascimento,
    YEAR(curdate()) - YEAR(i.data_nascimento) as 'idade'
FROM
    inscricoes i
WHERE
    YEAR(i.data_nascimento) <> '0000'
        AND i.data_nascimento IS NOT NULL) 
UNION (SELECT
    p.id,
    p.data_nascimento,
    YEAR(curdate()) - YEAR(p.data_nascimento) as 'idade'
FROM
    prospects p
WHERE
    YEAR(p.data_nascimento) <> '0000'
        AND p.data_nascimento IS NOT NULL);
-- call view
SELECT 
    count(u.id),
    idade
FROM
    uniaoProspectInscricoe u
GROUP BY u.idade;
-- create function
USE `pgto`;
DROP function IF EXISTS `getModaIdadeGeral`;

DELIMITER $$
USE `pgto`$$
CREATE FUNCTION `getModaIdadeGeral`() RETURNS int(11)
BEGIN
    DECLARE idade INT;
    SET idade = (SELECT 
                    u.idade
                FROM
                    uniaoProspectInscricoe u
                GROUP BY u.idade
                ORDER BY count(u.id) DESC
                LIMIT 1);
RETURN idade;
END$$

DELIMITER ;
-- call function
SELECT GETMODAIDADEGERAL();

-- 7. Trigger, Todo nome e email inserido na tabela inscricoe seja atualizado para caixa alta ( upper() )
CREATE TRIGGER `pgto`.`inscricoes_BEFORE_INSERT` BEFORE INSERT ON `inscricoes` FOR EACH ROW
BEGIN
    SET NEW.nome = upper(NEW.nome);
    SET NEW.email = upper(NEW.email);
END

-- 8. Trigger, Todo nome e email inserido na tabela prospects seja atualizado para caixa alta ( upper() )
CREATE DEFINER=`root`@`%` TRIGGER `pgto`.`prospects_BEFORE_INSERT` BEFORE INSERT ON `prospects` FOR EACH ROW
BEGIN
    SET NEW.nome = upper(NEW.nome);
    SET NEW.email = upper(NEW.email);
END;

-- 9. Trigger AO atualizar  um registro na tabela inscricoes, eixar nome e email em upper()
CREATE DEFINER=`root`@`%` TRIGGER `pgto`.`inscricoes_BEFORE_UPDATE` BEFORE UPDATE ON `inscricoes` FOR EACH ROW
BEGIN
    SET new.nome=upper(NEW.nome);
    SET new.email=upper(NEW.email);
END

-- 10. Trigger AO atualizar  um registro na tabela prospects, eixar nome e email em upper()

CREATE DEFINER=`root`@`%` TRIGGER `pgto`.`prospects_BEFORE_UPDATE` BEFORE UPDATE ON `prospects` FOR EACH ROW
BEGIN
    SET new.nome=upper(NEW.nome);
    SET new.email=upper(NEW.email);
END
-- 1. Query que verifica se um determinado nome esta contido em uma table/coluna
SELECT distinct
    f.nome
FROM
    funcionarios f
WHERE
	UPPER(f.nome) like UPPER('%vic%')

-- 2. Query que verifica qual o provedor de email mais usado no sistema
SELECT 
    substring_index(f.email, '@', -1) as 'provedor',
    count(f.id) as 'total'
FROM
    funcionarios f
GROUP BY 1
ORDEr BY 2 DESC
LIMIT 1;


-- 3. Funcao que recebe um email e verifica se ele ja existe no banco
SELECT 
    IF(f.email IS NOT NULL, true, false)
FROM
    funcionarios f
WHERE
	UPPER(f.email) = upper('victorluissantos@live.com')
    
    
USE `pccs`;
DROP function IF EXISTS `verifica_email`;

DELIMITER $$
USE `pccs`$$
CREATE DEFINER=`root`@`%` FUNCTION `verifica_email`(email varchar(90)) RETURNS varchar(90)
BEGIN
	RETURN (SELECT 
					f.email
				FROM
					funcionarios f
				WHERE
					UPPER(f.email) = upper(email)
				limit 1);
END$$

DELIMITER ;

SELECT VERIFICA_EMAIL('victorluissantos@live.com.br');


-- 4. Funcao que recebe um cpf e verifica se ele ja existe no banco
SELECT 
    f.cpf
FROM
    funcionarios f
WHERE
	f.cpf = ''
LIMIT 1;

USE `pccs`;
DROP function IF EXISTS `verifica_cpf`;

DELIMITER $$
USE `pccs`$$
CREATE FUNCTION `verifica_cpf` (cpf varchar(14))
RETURNS varchar(14)
BEGIN

	RETURN (SELECT 
				f.cpf
			FROM
				funcionarios f
			WHERE
				f.cpf = cpf
			LIMIT 1);
END$$

DELIMITER ;

SELECT VERIFICA_CPF('333.149.072-42');


-- 5. Query que verifica qual a porcentagem de usuarios que nao possuem cadastro completo
SELECT 
    COUNT(f.id)
FROM
    funcionarios f;

SELECT 
    COUNT(*)
FROM
    funcionarios f
WHERE
    f.nome IS NULL OR f.email IS NULL
        OR f.data_nascimento IS NULL
        OR f.telefone IS NULL
        OR f.celular IS NULL;


USE `pccs`;
DROP function IF EXISTS `porcentagem_doc`;

DELIMITER $$
USE `pccs`$$
CREATE FUNCTION `porcentagem_doc` ()
RETURNS DOUBLE(4,2)
BEGIN
	DECLARE total INT;
    DECLARE incompleto INT;

	SET total = (SELECT 
					COUNT(f.id)
				FROM
					funcionarios f);
	SET incompleto = (SELECT 
							COUNT(*)
						FROM
							funcionarios f
						WHERE
							f.nome IS NULL OR f.email IS NULL
								OR f.data_nascimento IS NULL
								OR f.telefone IS NULL
								OR f.celular IS NULL);
RETURN (total/100)*incompleto;
END$$

DELIMITER ;

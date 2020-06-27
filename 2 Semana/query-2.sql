CREATE SCHEMA `pccs` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

CREATE TABLE `funcionarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(90) COLLATE utf8_bin NOT NULL,
  `email` varchar(90) COLLATE utf8_bin DEFAULT NULL,
  `telefone` varchar(14) COLLATE utf8_bin DEFAULT NULL,
  `celular` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `cpf` varchar(14) COLLATE utf8_bin NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



SELECT 
	id,
    nome,
    cpf,
    data_nascimento
FROM
    funcionarios
WHERE
  	upper(nome) like upper('v%')
    OR
    upper(email) like upper('v%')


SELECT DISTINCT
    nome
FROM
    funcionarios
WHERE
	nome = 'Victor Luis'


SELECT 
    SUBSTRING_INDEX(celular, ' ', 1) AS 'dd',
    COUNT(celular) AS 'total'
FROM
    funcionarios
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
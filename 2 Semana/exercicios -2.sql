/* 1. Qual o usuario com maior quantidade de transacao em pendente */
CREATE  FUNCTION `getQtdTransacao`(usuario_id INT) RETURNS int(11)
BEGIN
  DECLARE resultado INT;
    SET resultado = (SELECT 
            count(t.id) as 'total'
          FROM
            transacoes t
          WHERE
            t.usuario_id = usuario_id
            AND
            t.situacao = 'Pendente');
  RETURN resultado;
END

-- rodar/chamar
SELECT 
    u.login,
    getQtdTransacao(u.id) as ' total'
FROM
    usuarios u
ORDER BY 2 DESC
LIMIT 1;

-- 2. Qual o usuario com maior quantidade de creditos
CREATE FUNCTION `getCreditos`(usuario_id INT) RETURNS int(11)
BEGIN
  DECLARE creditos INT;
  SET creditos = (SELECT 
            SUM(t.qt_consultas)
          FROM
            transacoes t
          WHERE
            t.usuario_id = usuario_id
            AND
            t.situacao = 'Aprovado');
  RETURN creditos;
END

-- Run / Chamada
SELECT 
    u.login,
    getCreditos(u.id)
FROM
    usuarios u
ORDEr BY 2 DESC
LIMIT 1;


-- 3. Qual o usuario com maior quantidade de pagamento no cartao
USE `pesquisatudo`;
DROP function IF EXISTS `getQtdPayCard`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getQtdPayCard` (usuario int)
RETURNS INTEGER
BEGIN
  DECLARE resultado int;
    SET resultado = (SELECT 
            count(t.id) as 'total'
          FROM
            transacoes t
          WHERE
            t.bandeira <> 'Boleto'
            and
            t.usuario_id = usuario);
                        
  RETURN resultado;
END$$

DELIMITER ;

-- Run / Call
SELECT 
    u.login,
    getQtdPayCard(u.id) as 'pagamento cartao'
FROM
    usuarios u
ORDER BY 2 DESC
LIMIT 1;

-- 4. Qual usuario com a maior quantidade de transacao recusada
USE `pesquisatudo`;
DROP function IF EXISTS `getTransacRecusadaByUser`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getTransacRecusadaByUser` (usu_id INT)
RETURNS INTEGER
BEGIN
  DECLARE resultado INT;
    SET resultado = (SELECT 
            count(t.id)
          FROM
            transacoes t
          WHERE
            t.situacao='Recusado'
            AND
            t.usuario_id=usu_id);
RETURN resultado;
END$$

DELIMITER ;

-- Run || Call
SELECT 
    u.login,
    getTransacRecusadaByUser(u.id) as 'transacao_recusada'
FROM
    usuarios u
ORDER BY 2 DESC
LIMIT 1;


-- 5. Qual a media de horario das consultas (com funcao)
USE `pesquisatudo`;
DROP function IF EXISTS `GetMediaHoraConsulta`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `GetMediaHoraConsulta` ()
RETURNS DECIMAL(4,2)
BEGIN
  RETURN (SELECT 
        SUM(HOUR(data_consulta)) / (SELECT 
            COUNT(co.id)
          FROM
            consultas co) AS 'media_hora'
      FROM
        consultas c);
END$$

DELIMITER ;

-- Run / Call
SELECT GETMEDIAHORACONSULTA();

-- 6. Exiba via funcao a porcentagem para cada forma de pagamento em cada usuario
-- | usuario | Boleto | Cartao |
-- | victor  |   23%  |  77%   |
CREATE FUNCTION `getPorcentBoleto`(usu_id int) RETURNS decimal(4,2)
BEGIN
  DECLARE resultado INT;
    SET resultado = (SELECT 
            (count(t.bandeira)*100)/(SELECT 
                COUNT(tr.id)
              FROM
                transacoes tr
              WHERE
                tr.usuario_id=usu_id)
          FROM
            transacoes t
          WHERE
            t.usuario_id = usu_id
            AND
            bandeira='Boleto'
          GROUP BY t.bandeira);
  RETURN resultado;
END

-- Run || Call
SELECT 
    u.login,
    IF(GETPORCENTBOLETO(u.id) IS NULL,
        '00.00',
        GETPORCENTBOLETO(u.id)) AS 'Boleto',
    IF(GETPORCENTBOLETO(u.id) IS NULL,
        '100.00',
        100 - GETPORCENTBOLETO(u.id)) AS 'Cartao'
FROM
    usuarios u


-- 7. Qual a porcetagem geral para cada forma de pagamento no transacao. Exemplo de exibicao
-- | Boleto | Cartao |
-- |   23%  |  77%   |
USE `pesquisatudo`;
DROP function IF EXISTS `getBoletoPorcent`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getBoletoPorcent` ()
RETURNS DECIMAL(4,2)
BEGIN
  RETURN (SELECT 
        (count(t.id)*100)/(SELECT count(ta.id) FROM transacoes ta) as 'porcentagem'
      FROM
        transacoes t
      WHERE
        t.bandeira='Boleto'
      GROUP BY t.bandeira);
END$$

DELIMITER ;

-- Run || Call
SELECT 
    GETBOLETOPORCENT() AS 'boleto',
    (100 - GETBOLETOPORCENT()) AS 'cartao'
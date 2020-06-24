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

-- 6. Qual a media de horario das transacoes (com funcao)


-- 7. Exiba via funcao a porcentagem para cada forma de pagamento em cada usuario
-- | usuario | Boleto | Cartao |
-- | victor  |   23%  |  77%   |

-- 8. Qual a porcetagem geral para cada forma de pagamento no transacao. Exemplo de exibicao
-- | Boleto | Cartao |
-- |   23%  |  77%   |
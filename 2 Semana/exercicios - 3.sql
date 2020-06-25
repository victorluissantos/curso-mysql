/**
    2. Crie uma view para exibir somente as consultas com resultado
    3. Crie uma view para exibir as transacoes do mes ao lado do usuario responsavel
    4. Crie uma view que mostres o total de consultas aprovadas -3d -2d -1d: exemplo de exibicao
    | dia:23  | dia:22  | dia:21  |
    | 12  	  | 	23  | 	  15  |
    5. Crie um view que mostre total de consultas mes passado, total deste mes e estimativa para mes seguinte
*/

-- 1. Crie uma view table para exibir os boletos vencidos
USE `pesquisatudo`;
CREATE  OR REPLACE VIEW `boletos_vencido` AS (
SELECT 
    t.*
FROM
    transacoes t
WHERE
	t.bandeira = 'Boleto'
    and
    t.data_captura is null
    and
    DATE_ADD(t.data_transacao, INTERVAL 3 DAY) < NOW()
);

-- Run || call
SELECT 
    *
FROM
    boletos_vencido bv
    INNER JOIN
    usuarios u ON bv.usuario_id = u.id

-- 2. Crie uma view para exibir somente as consultas com resultado
CREATE VIEW `consultas_retorno` AS
    (SELECT 
        c.*
    FROM
        consultas c
    WHERE
        retorno IS NOT NULL)

-- Call || Run
SELECT 
    *
FROM
    consultas_retorno;


-- 3. Crie uma view para exibir as transacoes do mes ao lado do usuario responsavel
USE `pesquisatudo`;
CREATE  OR REPLACE VIEW `usuario_transacao_month` AS (
SELECT 
    u.login, t.*
FROM
    transacoes t
        INNER JOIN
    usuarios u ON t.usuario_id = u.id
WHERE
    MONTH(t.data_transacao) = MONTH(CURRENT_DATE())
);

-- Call || Run
SELECT 
    *
FROM
    usuario_transacao_month;


-- 4. Crie uma view que mostres o total de consultas aprovadas -3d -2d -1d: exemplo de exibicao
USE `pesquisatudo`;
CREATE  OR REPLACE VIEW `analise` AS (
SELECT 
    COUNT(c.id) AS 'total', 
    DAY(c.data_consulta) AS 'Dia'
FROM
    consultas c
WHERE
    c.retorno IS NOT NULL
        AND MONTH(c.data_consulta) = MONTH(CURDATE())
        AND DAY(c.data_consulta) IN (
        DAY(CURDATE()) - 3 , 
        DAY(CURDATE()) - 2,
        DAY(CURDATE()) - 1)
GROUP BY DAY(c.data_consulta));

-- Run || Call
select * from analise;


-- 5. Crie um view que mostre total de consultas mes passado, total deste mes e estimativa para mes seguinte
USE `pesquisatudo`;
DROP function IF EXISTS `getTotalMonth`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getTotalMonth` (dedutor INT)
RETURNS INTEGER
BEGIN
	DECLARE resultado INT;
    SET dedutor = IF(dedutor is null, 0, dedutor);
    SET resultado = (SELECT 
						count(c.id) as total
					FROM
						consultas c
					WHERE
						MONTH(c.data_consulta)=MONTH(curdate())-dedutor);
RETURN resultado;
END$$

DELIMITER ;

-- Run || Call
SELECT 
    GETTOTALMONTH(2) AS 'mes_anterior',
    GETTOTALMONTH(1) AS 'mes_passado',
    GETTOTALMONTH(0) AS 'mes_atual',
    ((GETTOTALMONTH(2) + GETTOTALMONTH(1) + GETTOTALMONTH(0)) / 3) AS 'previsao';
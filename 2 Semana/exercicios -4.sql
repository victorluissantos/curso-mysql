/*
    Total de transacoes aprovadas, somando a coluna qtd
    Total de transacoes pendentes vencidas obs: dias para o vencimento e uma variavel
    Total de transacoes pendentes a vencer
    Saldo atual
*/

-- 1. Total de consultas realiazadas
USE `pesquisatudo`;
DROP function IF EXISTS `getConsultasByUser`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getConsultasByUser` (usuario_id INT)
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				count(c.id)
			FROM
				consultas c
			WHERE
				c.usuario_id=usuario_id);
END$$

DELIMITER ;

-- 2. Total de consultas realizadas com retorno
USE `pesquisatudo`;
DROP function IF EXISTS `getConsultasReturnByUser`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getConsultasReturnByUser` (usuario_id INT)
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				count(c.id)
			FROM
				consultas c
			WHERE
				c.usuario_id=usuario_id
                AND
                c.retorno is not null);
END$$

DELIMITER ;

-- 3.Total de transacoes, somando a coluna qtd
USE `pesquisatudo`;
DROP function IF EXISTS `getTransacoesQtd`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getTransacoesQtd` (usuario_id INT)
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				sum(t.qt_consultas)
			FROM
				transacoes t
			WHERE
				t.usuario_id=usuario_id);
END$$

DELIMITER ;

-- 4.Total de transacoes aprovadas, somando a coluna qtd
USE `pesquisatudo`;
DROP function IF EXISTS `getQtdTransacoesApv`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getQtdTransacoesApv` (usuario_id INT)
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				sum(t.qt_consultas)
			FROM
				transacoes t
			WHERE
				t.usuario_id=usuario_id
                AND
                t.situacao='Aprovado');
END$$

DELIMITER ;


-- 5.Total de transacoes pendentes vencidas obs: dias para o vencimento e uma variavel
DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getBoletosVencidosByUser` (usuario_id INT, dias_vencimento INT)
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				count(t.id)
			FROM
				transacoes t
			WHERE
				t.bandeira='Boleto'
				AND
				t.data_captura IS NULL
                AND
                t.usuario_id=usuario_id
				AND
				DATE_ADD(t.data_transacao, INTERVAL dias_vencimento DAY) < current_time());
END$$

DELIMITER ;

-- 6.Total de transacoes pendentes a vencer obs: dias para o vencimento e uma variavel
DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getBoletosaVencerByUser` (usuario_id INT, dias_vencimento INT)
RETURNS INTEGER
BEGIN
	RETURN (SELECT 
				count(t.id)
			FROM
				transacoes t
			WHERE
				t.bandeira='Boleto'
				AND
				t.data_captura IS NULL
                AND
                t.usuario_id=usuario_id
				AND
				DATE_ADD(t.data_transacao, INTERVAL dias_vencimento DAY) >= current_time());
END$$

DELIMITER ;

-- Conta total de linhas no banco de dados inteiro
USE `pesquisatudo`;
DROP function IF EXISTS `getCountAllRows`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getCountAllRows` ()
RETURNS INTEGER
BEGIN

	DECLARE total_consultas INT;
    DECLARE total_transacoes INT;
    DECLARE total_usuarios INT;
    
	SET total_consultas=(SELECT 
							COUNT(c.id)
						FROM
							consultas c);
			
	SET total_transacoes=(SELECT 
								COUNT(t.id)
							FROM
								transacoes t);

	SET total_usuarios=(SELECT 
							COUNT(u.id)
						FROM
							usuarios u);
	RETURN (total_consultas+total_transacoes+total_usuarios);
END$$

DELIMITER ;


-- 7. Traz o saldo de um usuario
USE `pesquisatudo`;
DROP function IF EXISTS `getSaldoByUser`;

DELIMITER $$
USE `pesquisatudo`$$
CREATE FUNCTION `getSaldoByUser` (usuario INT)
RETURNS INTEGER
BEGIN
	DECLARE creditos INT;
    DECLARE consultas INT;
    
    SET creditos = (SELECT 
						SUM(t.qt_consultas)
					FROM
						transacoes t
					WHERE
						t.data_captura IS NOT NULL
						AND
						t.usuario_id=usuario);
	
    SET consultas = (SELECT 
							COUNT(c.id)
						FROM
							consultas c
						WHERE
							c.retorno IS NOT NULL
							AND
							c.usuario_id=usuario);
    
	RETURN (creditos-consultas);
END$$

DELIMITER ;

-- Criando funcao relatorio usuario
CREATE VIEW `pesquisatudo`.`rel_usuario` AS
    (SELECT 
        `u`.`id` AS `id`,
        `u`.`login` AS `login`,
        `u`.`senha` AS `senha`,
        `u`.`data_cadastro` AS `data_cadastro`,
        GETCONSULTASBYUSER(`u`.`id`) AS `consultas`,
        GETCONSULTASRETURNBYUSER(`u`.`id`) AS `retornos`,
        IF(ISNULL(GETTRANSACOESQTD(`u`.`id`)),
            0,
            GETTRANSACOESQTD(`u`.`id`)) AS `transacoes_qtd`,
        IF(ISNULL(GETQTDTRANSACOESAPV(`u`.`id`)),
            0,
            GETQTDTRANSACOESAPV(`u`.`id`)) AS `transacoes_aprv_qtd`,
        GETBOLETOSVENCIDOSBYUSER(`u`.`id`, 5) AS `Transacoes_vencidas`,
        GETBOLETOSAVENCERBYUSER(`u`.`id`, 5) AS `Transacoes_a_vencer`,
        IF(ISNULL(GETSALDOBYUSER(`u`.`id`)),
            0,
            GETSALDOBYUSER(`u`.`id`)) AS `saldo`
    FROM
        `pesquisatudo`.`usuarios` `u`)

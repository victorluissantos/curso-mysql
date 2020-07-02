/*
	1. Criacao da tabela multas
    2. Colunas, referencia a condutores e infracoes, data e hora, obs, status (notificacao, infracao, em recurso, vencida)
    3. Criar uma trigger que ao inserir uma multa com status diferente de vencida, subtraia a quantidade de pontos na tabela condutores
    4. Criar uma trigger que ao atualizar o status para vencida da multa, adicione a quantidade de pontos na tabela condutores
*/

CREATE TABLE `monitorcnh`.`multas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `condutor_id` INT NOT NULL,
  `infracoe_id` INT NOT NULL,
  `dt_infracao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `situacao` ENUM('notificacao', 'infracao', 'em recurso', 'vencida') NULL DEFAULT 'notificacao',
  PRIMARY KEY (`id`));


CREATE DEFINER=`root`@`%` TRIGGER `monitorcnh`.`multas_AFTER_INSERT` AFTER INSERT ON `multas` FOR EACH ROW
BEGIN
	UPDATE 
		condutores 
	SET 
		pontuacao = pontuacao - (SELECT 
									pontuacao 
								FROM 
									infracoes 
								WHERE 
									id=NEW.infracoe_id)
	WHERE
		id=NEW.condutore_id
        AND
        situacao<>'vencida';
END


CREATE DEFINER=`root`@`%` TRIGGER `monitorcnh`.`multas_AFTER_UPDATE` AFTER UPDATE ON `multas` FOR EACH ROW
BEGIN

	UPDATE condutores SET pontuacao = pontuacao + (SELECT 
						pontuacao 
					FROM 
						infracoes 
					WHERE 
						id=NEW.infracoe_id)
	WHERE
		id=new.condutore_id
        AND
        new.situacao='vencida';
END
CREATE SCHEMA `kitanda` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

CREATE TABLE `kitanda`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `produto` VARCHAR(60) NOT NULL,
  `quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`));

CREATE TABLE `kitanda`.`vendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `produto_id` INT NOT NULL,
  `quantidade` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`));

DELIMITER $$

DROP TRIGGER IF EXISTS kitanda.vendas_AFTER_INSERT$$
USE `kitanda`$$
CREATE DEFINER = CURRENT_USER TRIGGER `kitanda`.`vendas_AFTER_INSERT` AFTER INSERT ON `vendas` FOR EACH ROW
BEGIN
	UPDATE produtos SET estoque = estoque-NEW.quantidade WHERE id = new.produto_id;
END$$
DELIMITER ;


USE `kitanda`;

DELIMITER $$

DROP TRIGGER IF EXISTS kitanda.vendas_AFTER_DELETE$$
USE `kitanda`$$
CREATE DEFINER = CURRENT_USER TRIGGER `kitanda`.`vendas_AFTER_DELETE` AFTER DELETE ON `vendas` FOR EACH ROW
BEGIN
	UPDATE produtos SET estoque=estoque+OLD.quantidade WHERE id=OLD.produto_id;
END$$
DELIMITER ;

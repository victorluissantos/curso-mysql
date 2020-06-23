/*Dump export*/
-- https://paste.ubuntu.com/p/rQpZxFKYjK/

/* Criando scheme */
CREATE SCHEMA `pesquisatudo` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;


/* Criando tabela de ususarios */
CREATE TABLE `pesquisatudo`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(60) NOT NULL,
  `senha` VARCHAR(250) NOT NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_tIMESTAMP,
  PRIMARY KEY (`id`));


/* Criando tabela de consultas */
CREATE TABLE `pesquisatudo`.`consultas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `placa` VARCHAR(8) NOT NULL,
  `retorno` VARCHAR(250) NULL,
  `data_consulta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_consultas_usuario_idx` (`usuario_id` ASC),
  INDEX `idx_consultas_placa` (`placa` ASC),
  CONSTRAINT `fk_consultas_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `pesquisatudo`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/* Criando tabela de transacoes */
CREATE TABLE `pesquisatudo`.`transacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `data_transacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_captura` DATETIME NULL,
  `bandeira` ENUM('Boleto', 'Elo', 'Mastercard', 'Visa') NOT NULL DEFAULT 'Boleto',
  `situacao` ENUM('Pendente', 'Recusado', 'Aprovado') NOT NULL DEFAULT 'Pendente',
  `token` VARCHAR(90) NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `pesquisatudo`.`transacoes` 
ADD INDEX `fk_transacoes_usuario_idx` (`usuario_id` ASC);
ALTER TABLE `pesquisatudo`.`transacoes` 
ADD CONSTRAINT `fk_transacoes_usuario`
  FOREIGN KEY (`usuario_id`)
  REFERENCES `pesquisatudo`.`usuarios` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `pesquisatudo`.`transacoes` 
ADD INDEX `idx_transacoe_bandeira` (`bandeira` ASC);

ALTER TABLE `pesquisatudo`.`transacoes` 
ADD INDEX `idx_transacoe_situacao` (`situacao` ASC);


/* Inserindo usuario com senha criptografada */
INSERT INTO `pesquisatudo`.`usuarios` (`login`, `senha`) VALUES ('jose', md5('jose123'));

/* Criando quantidade e valor em transacoes */
ALTER TABLE `pesquisatudo`.`transacoes` 
ADD COLUMN `valor` DECIMAL(5,2) NOT NULL DEFAULT 0.00 AFTER `token`,
ADD COLUMN `qt_consultas` INT NOT NULL DEFAULT 1 AFTER `valor`;

/* Explodindo em delimitador uma string */
SELECT 
    substring_index(c.placa, '-', -1) as 'numeros',
    substring_index(c.placa, '-', 1) as 'letras'
FROM
    consultas c;
-- AAA   -    2001
--  1    0     -1


/* Concat Exemplo */
SELECT 
    concat(u.login, ' | ', u.senha) as 'concatenando colunas'
FROM
    usuarios u;
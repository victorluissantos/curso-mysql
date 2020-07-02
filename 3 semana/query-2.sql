CREATE SCHEMA `monitorcnh` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

CREATE TABLE `monitorcnh`.`condutores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NULL,
  `cpf` VARCHAR(14) NULL,
  `cnh` VARCHAR(10) NOT NULL,
  `categoria` VARCHAR(45) NULL,
  `renach` VARCHAR(11) NULL,
  `uf` VARCHAR(2) NOT NULL,
  `pontuacao` INT NULL DEFAULT 20,
  `email` VARCHAR(150) NULL,
  `celular` VARCHAR(16) NULL,
  `dt_validade` DATE NULL,
  `dt_nascimento` DATE NULL,
  `ear` ENUM('Sim', 'Nao') NOT NULL DEFAULT 'Nao',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`));

CREATE TABLE `monitorcnh`.`infracoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(6) NOT NULL,
  `descricao` VARCHAR(500) NOT NULL,
  `responsavel` ENUM('Condutor', 'Proprietário', 'Pedestre', 'Emb/Transp', 'PF ou PJ', 'Serv. público') NOT NULL DEFAULT 'Condutor' COMMENT 'Condutor\nProprietário\nPedestre\nEmb/Transp\nPF ou PJ\nServ. público',
  `valor` DECIMAL(7,2) NULL,
  `autuador` VARCHAR(80) NULL,
  `artigos` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
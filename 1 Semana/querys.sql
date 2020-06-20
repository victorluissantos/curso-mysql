/* Criacao do cascate, fk */
ALTER TABLE `ebiblioteca`.`emprestimos` 
ADD INDEX `fk_emprestimos_livro_idx` (`livro_id` ASC);
ALTER TABLE `ebiblioteca`.`emprestimos` 
ADD CONSTRAINT `fk_emprestimos_livro`
  FOREIGN KEY (`livro_id`)
  REFERENCES `ebiblioteca`.`livros` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `ebiblioteca`.`emprestimos` 
ADD INDEX `fk_emprestimos_usuario_idx` (`usuario_id` ASC);
ALTER TABLE `ebiblioteca`.`emprestimos` 
ADD CONSTRAINT `fk_emprestimos_usuario`
  FOREIGN KEY (`usuario_id`)
  REFERENCES `ebiblioteca`.`usuarios` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


/* Criando ENUM de situacao na coluna livros */
ALTER TABLE `ebiblioteca`.`livros` CHANGE COLUMN `situacao` ENUM('Disponivel', 'Excluido') NOT NULL DEFAULT 'Disponivel' ;

/* Criando index */
ALTER TABLE `ebiblioteca`.`livros` 
ADD INDEX `idx_titulo` (`titulo` ASC);

/* Criando index da situcao */
ALTER TABLE `ebiblioteca`.`livros` 
ADD INDEX `idx_situacao` (`situacao` ASC);

/* Criando tabela de tarifas */
CREATE TABLE `ebiblioteca`.`tarifas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `multa` DECIMAL(3,2) NULL,
  `diaria` DECIMAL(3,2) NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`));


/* Calculando atraso por dia atraso */
SELECT 
    e.*,
    (
		SELECT multa FROM tarifas
    ) as 'mora',
    (
		SELECT (DATEDIFf(now(), DATE_ADD(e.data_retirada, INTERVAL 3 DAY))*diaria) FROM tarifas
    ) as 'multa',
    DATEDIFf(now(), DATE_ADD(e.data_retirada, INTERVAL 3 DAY)) as 'dias de atraso'
FROM
    emprestimos e
WHERE
	e.id = 12


/* Calcula multa, mora e total a pagar */
SELECT 
    e.*,
    (SELECT 
            multa
        FROM
            tarifas) AS 'mora',
    (SELECT 
            (DATEDIFF(NOW(),
                        DATE_ADD(e.data_retirada,
                            INTERVAL 3 DAY)) * diaria)
        FROM
            tarifas) AS 'multa',
    (SELECT 
            SUM((DATEDIFF(NOW(),
                        DATE_ADD(e.data_retirada,
                            INTERVAL 3 DAY)) * diaria) + multa)
        FROM
            tarifas) AS 'Total a pagar multa',
    DATEDIFF(NOW(),
            DATE_ADD(e.data_retirada,
                INTERVAL 3 DAY)) AS 'dias de atraso'
FROM
    emprestimos e
WHERE
    e.id = 12
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
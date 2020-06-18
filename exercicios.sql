/* 1.Usuario com a maior idade */
SELECT 
    nome
FROM
    usuarios
WHERE
	data_nascimento is not null
ORDER BY data_nascimento ASC
LIMIT 1

/* 2.Usuario que fez o primeiro emprestimo */
SELECT 
    u.nome
FROM
    emprestimos e
        JOIN
    usuarios u ON e.usuario_id = u.id
ORDER BY data_retirada ASC
LIMIT 1;
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

/* 3.Usuario com maior periodo em atrazo */
SELECT 
    u.nome
FROM
    emprestimos e
    JOIN
    usuarios u ON u.id=e.usuario_id
WHERE
	e.data_entrega is null
    AND
    DATE_ADD(e.data_retirada, INTERVAL 3 DAY) > NOW()
ORDER BY e.data_retirada ASC
LIMIT 1;

/* 4.Livro que mais foi emprestado */
SELECT 
    l.titulo, 
    COUNT(e.livro_id) AS 'Emprestimo'
FROM
    emprestimos e
        JOIN
    livros l ON e.livro_id = l.id
GROUP BY e.livro_id
ORDER BY 2 DESC
LIMIT 1;

/* 5.Livro que menos foi emprestado */
SELECT 
    count(e.livro_id) as 'total',
    l.titulo
FROM
    emprestimos e
    INNER JOIN
    livros l ON e.livro_id = l.id
GROUP BY e.livro_id
ORDER BY 1 ASC
LIMIT 1

/* Pegando os nunca emprestados */
SELECT 
    l.titulo
FROM
    livros l
        LEFT JOIN
    emprestimos e ON l.id = e.livro_id
WHERE
    e.id IS NULL

/* Quando precisa pegar livros que nem mesmo foram emprestado, nenhuma vez */
SELECT
    count(e.id) as 'total',
    l.titulo
FROM
    livros l
    LEFT JOIN
    emprestimos e ON l.id=e.livro_id
GROUP BY l.titulo
ORDER BY 1 ASC
LIMIT 1;
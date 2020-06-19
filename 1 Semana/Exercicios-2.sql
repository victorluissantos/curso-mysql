/* movimentacao entrada ou saida no periodo */
SELECT 
    COUNT(e.id) as 'total de movimentacao no perigoo 10 a 15'
FROM
    emprestimos e
WHERE
    e.data_retirada BETWEEN '2020-06-10' AND '2020-06-15'
    OR
    e.data_entrega BETWEEN '2020-06-10' AND '2020-06-15'

/* Quais os livros disponiveis para emprestimo */
SELECT 
    l.titulo
FROM
	livros l
    LEFT JOIN
    emprestimos e on l.id = e.livro_id
WHERE
	e.data_entrega is null
    AND
    e.id is null


/* 1. Total de livros Excluido e total de livros disponiveis */
SELECT 
    count(l.situacao) as 'totais',
    l.situacao
FROM
    livros l
GROUP BY l.situacao

/* 2. Livros que estao como excluido e estao emprestados */
SELECT 
    l.titulo
FROM
    livros l
        JOIN
    emprestimos e ON e.livro_id = l.id
WHERE
    l.situacao = 'Excluido'
        AND
	e.data_entrega IS NULL
GROUP BY l.titulo

/* 3. Livros que estao como disponivel, mas estao como emprestados em aberto */
SELECT 
    l.titulo
FROM
    livros l
        JOIN
    emprestimos e ON l.id = e.livro_id
WHERE
    l.situacao = 'Disponivel'
        AND e.data_entrega IS NULL
GROUP BY l.titulo

/* 4. Entre os livros excluido, qual o que mais teve emprestimo */
SELECT 
    COUNT(l.titulo) AS 'Quantidade',
    l.titulo
FROM
    livros l
        JOIN
    emprestimos e ON e.livro_id = l.id
WHERE
    l.situacao = 'Excluido'
GROUP BY l.titulo
ORDER BY 1 DESC
LIMIT 1;

/* 5. Entre os livros disponiveis, qual o que mais teve emprestimo */
SELECT 
	count(l.id) AS 'total',
    l.titulo
FROM
    livros l
    JOIN
    emprestimos e ON l.id=e.livro_id
WHERE
	l.situacao = 'Disponivel'
GROUP BY l.id
ORDER BY 1 desc
limit 1;

/* 6. Qual o usuario que mais emprestou livro que esta excluido */
SELECT 
    COUNT(e.usuario_id) AS 'Quantidade', 
    u.nome
FROM
    usuarios u
        JOIN
    emprestimos e ON e.usuario_id = u.id
        JOIN
    livros l ON e.livro_id = l.id
WHERE
    l.situacao = 'Excluido'
GROUP BY e.usuario_id
ORDER BY 1 DESC
LIMIT 1;
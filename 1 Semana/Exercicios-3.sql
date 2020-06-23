/* 1. Quem mais empresta livro, homem ou mulher ? */
SELECT 
    COUNT(u.genero) as 'total',
    u.genero
FROM
	emprestimos e
        JOIN
    usuarios u ON e.usuario_id = u.id
WHERE
	u.genero <> 'Indefinido'
    AND
    e.data_entrega IS NULL
GROUP BY u.genero
ORDER BY 1 DESC
LIMIT 1;

/* 2. Qual o Estado que mais empresta livros ? */
SELECT 
    count(u.uf) as 'total',
    u.uf
FROM
    emprestimos e
    INNER JOIN
    usuarios u ON e.usuario_id = u.id
WHERE
	u.uf is not null
GROUP BY 2 DESC
ORDER BY 1 DESC
LIMIT 1;

/* Pegando todos atrasados ate os que ja entregam */
SELECT 
    e.data_retirada AS 'data retirada'
FROM
    emprestimos e
WHERE
    (e.data_entrega IS NULL
        AND DATE_ADD(e.data_retirada,
        INTERVAL 3 DAY) < NOW())
        OR DATEDIFF(e.data_entrega, e.data_retirada) > 3


/* 3. Qual o valor da maior multa no sistema */
SELECT 
    e.data_retirada AS 'data retirada',
    e.data_retirada,
    DATEDIFF(e.data_entrega,
            DATE_ADD(e.data_retirada,
                INTERVAL 3 DAY)) AS 'dias de atraso',
    (SELECT 
            t.multa
        FROM
            tarifas t) AS 'multa',
    (SELECT 
            ((DATEDIFF(e.data_entrega,
                        DATE_ADD(e.data_retirada,
                            INTERVAL 3 DAY))) * t.diaria)
        FROM
            tarifas t) AS 'mora',
    (SELECT 
            SUM((DATEDIFF(e.data_entrega,
                        DATE_ADD(e.data_retirada,
                            INTERVAL 3 DAY))) * t.diaria)+t.multa
        FROM
            tarifas t) AS 'Total a pagar'
FROM
    emprestimos e
WHERE
    (e.data_entrega IS NULL
        AND DATE_ADD(e.data_retirada,
        INTERVAL 3 DAY) < NOW())
        OR (DATEDIFF(e.data_entrega, e.data_retirada) > 3
        AND DATEDIFF(e.data_entrega, e.data_retirada) IS NOT NULL)
ORDER BY 6 DESC
LIMIT 1;

/* 4. Qual o usuario com o maior valor de multa em aberto */
SELECT 
    u.nome,
    SUM((SELECT 
            ((t.diaria * (DATEDIFF(NOW(),
                        DATE_ADD(e.data_retirada,
                            INTERVAL 3 DAY)))) + t.multa)
        FROM
            tarifas t)) AS 'multa'
FROM
    usuarios u
        INNER JOIN
    emprestimos e ON u.id = e.usuario_id
WHERE
    e.data_entrega IS NULL
GROUP BY u.nome
ORDER BY 2 DESC
limit 1;

/* 5. Qual o livro que tem o maior numero de multa */
SELECT 
    count(l.id) as 'total',
    l.titulo
FROM
    livros l
    INNER JOIN
    emprestimos e ON l.id=e.livro_id
WHERE
    (e.data_entrega is null
    AND
    DATE_ADD(e.data_retirada, INTERVAL 3 DAY) < NOW())
    OR
    (DATE_ADD(e.data_retirada, interval 3 DAY) < e.data_entrega)
GROUP BY l.titulo
ORDER BY 1 DESC
LIMIT 1
/* 1. Quais sao os usuarios que efetuaram mais de 10 consultas */
SELECT 
    v.*
FROM
    (SELECT 
        COUNT(u.id) AS 'total', u.login
    FROM
        usuarios u
    INNER JOIN consultas c ON u.id = c.usuario_id
    GROUP BY u.id) v
WHERE
	v.total > 10;

/* 2. Quais sao as placas de carro, cujo as letras sao iguais */
SELECT 
    letras_placas.letras
FROM
    (SELECT 
        COUNT(c.placa) AS 'total',
            SUBSTRING_INDEX(c.placa, '-', 1) AS 'letras'
    FROM
        consultas c
    GROUP BY 2) letras_placas
WHERE
	letras_placas.total > 1;

/*Segunda interpretacao*/
SELECT 
    c.placa
FROM
    consultas c
WHERE
	c.placa like 'www%';

/*  3. Quais sao as placas de carro, cujo a numeracao e igual */
SELECT 
    numeros_placas.numeros
FROM
    (SELECT 
        COUNT(c.placa) AS 'total',
            SUBSTRING_INDEX(c.placa, '-', -1) AS 'numeros'
    FROM
        consultas c
    GROUP BY 2) numeros_placas
WHERE
    numeros_placas.total > 1
--CREATE OR REPLACE VIEW dashoff_vended_vendas AS
SELECT vendedores.apelido || ' - ' || vendedores.codvend NOMEVEND,
       NVL(vendido.totvend, 0) - NVL(devolvido.totvend, 0) VLRVENDALIQ,
       NVL(metavenda.prevrec, 0) VLRMETAVENDA
FROM
(
        SELECT codvend,
               apelido
        FROM tgfven
        WHERE /*(*/tipvend = 'V'
        /*OR codvend IN (0, 10))*/
        AND ativo = 'S'
        AND codvend <> 38
) vendedores
LEFT JOIN
(
        SELECT codvend CODVEND,
               SUM(vlrtotcomdesc) TOTVEND
        FROM simples_itens_da_nota
        WHERE statusnota = 'L' AND
        codtipoper IN (1101, 1010) AND
        dtneg BETWEEN TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM') AND LAST_DAY(TO_DATE(SYSDATE, 'DD/MM/YY'))
        GROUP BY codvend
) vendido
ON vendedores.codvend = vendido.codvend
LEFT JOIN
(
        SELECT codvend CODVEND,
               SUM(vlrtotcomdesc) TOTVEND
        FROM simples_itens_da_nota
        WHERE statusnota = 'L' AND
        codtipoper IN (1201, 1202, 1204) AND
        dtmov BETWEEN TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM') AND LAST_DAY(TO_DATE(SYSDATE, 'DD/MM/YY'))
        GROUP BY codvend
) devolvido
ON vendedores.codvend = devolvido.codvend
LEFT JOIN
(
        SELECT codvend,
               dtref,
               SUM(prevrec) PREVREC
        FROM meta_venda_fabricante_vendedor
        WHERE dtref = TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM')
        GROUP BY codvend,
                 dtref
) metavenda
ON vendedores.codvend = metavenda.codvend
ORDER BY 2 DESC;
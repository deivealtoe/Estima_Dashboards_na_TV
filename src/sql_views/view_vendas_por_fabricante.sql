--CREATE OR REPLACE VIEW dashoff_fabric_vendas AS
SELECT fabricantes.fabricante FABRICANTEPROD,
       NVL(vendido.totvend, 0) - NVL(devolvido.totvend, 0) TOTVEND,
       NVL(metavenda.prevrec, 0) METAVENDA
FROM
(
        SELECT DISTINCT fabricante
        FROM tgfpro
        ORDER BY fabricante
) fabricantes
LEFT JOIN
(
        SELECT fabricante,
               SUM(vlrtotcomdesc) TOTVEND,
               SUM(pesoliqtotalneg) PESOLIQVENDIDO,
               SUM(qtdneg) QTDNEG,
               COUNT(DISTINCT codparc) MIXCLI,
               COUNT(DISTINCT codprod) MIXPROD,
               SUM(qtdneg * vlrcusunitimposfret) VLRCUSTO
        FROM simples_itens_da_nota
        WHERE codtipoper IN (1101, 1010)
        AND statusnota = 'L'
        AND dtneg BETWEEN TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM') AND LAST_DAY(TO_DATE(SYSDATE, 'DD/MM/YY'))
        GROUP BY fabricante
) vendido
ON fabricantes.fabricante = vendido.fabricante
LEFT JOIN
(
        SELECT fabricante,
               SUM(vlrtotcomdesc) TOTVEND,
               SUM(pesoliqtotalneg) PESOLIQVENDIDO,
               SUM(qtdneg) QTDNEG,
               COUNT(DISTINCT codparc) MIXCLI,
               COUNT(DISTINCT codprod) MIXPROD,
               SUM(qtdneg * vlrcusunitimposfret) VLRCUSTO
        FROM simples_itens_da_nota
        WHERE codtipoper IN (1201, 1202, 1204)
        AND statusnota = 'L'
        AND dtmov BETWEEN TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM') AND LAST_DAY(TO_DATE(SYSDATE, 'DD/MM/YY'))
        GROUP BY fabricante
) devolvido
ON fabricantes.fabricante = devolvido.fabricante
LEFT JOIN
(
        SELECT fabricante,
               dtref,
               prevrec
        FROM meta_venda_fabricantes_soma
        WHERE dtref = TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM')
) metavenda
ON fabricantes.fabricante = metavenda.fabricante
WHERE NVL(vendido.totvend, 0) - NVL(devolvido.totvend, 0) > 0
AND fabricantes.fabricante IN ('PREMIER PET', 'MERIAL', 'IDEXX', 'CEPAV', 'PET SOCIETY', 'BIOVET', 'ALCON', 'LABYES')
ORDER BY 2 DESC;
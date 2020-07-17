--CREATE OR REPLACE VIEW dashoff_vended_mixes AS
SELECT vendedores.apelido || ' - ' || vendedores.codvend NOMEVEND,
       NVL(mixes.mixprod, 0) MIXPRO,
       NVL(metamixprod.prevrec, 0) METAMIXPROD,
       NVL(mixes.mixcli, 0) MIXCLI,
       NVL(metamixcli.prevrec, 0) METAMIXCLI
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
        SELECT codvend,
               dtref,
               prevrec
        FROM tgfmet
        WHERE codmeta = 9
        AND dtref = TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM')
) metamixcli
ON vendedores.codvend = metamixcli.codvend
LEFT JOIN
(
        SELECT codvend,
               dtref,
               prevrec
        FROM tgfmet
        WHERE codmeta = 8
        AND dtref = TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM')
) metamixprod
ON vendedores.codvend = metamixprod.codvend
LEFT JOIN
(
        SELECT codvend,
               nomevend,
               COUNT(DISTINCT codparc) MIXCLI,
               COUNT(DISTINCT codprod) MIXPROD
        FROM
        (
                SELECT vendido.codvend,
                       vendido.nomevend,
                       vendido.codparc,
                       vendido.nomeparc,
                       vendido.codprod,
                       vendido.descrprod,
                       NVL(vendido.qtdneg, 0) QTDVEND,
                       NVL(devolvido.qtdneg, 0) QTDDEVOL,
                       NVL(vendido.qtdneg, 0) - NVL(devolvido.qtdneg, 0) QTDNEGLIQ
                FROM
                (
                        SELECT codvend,
                               nomevend,
                               codparc,
                               nomeparc,
                               codprod,
                               descrprod,
                               qtdneg
                        FROM simples_itens_da_nota
                        WHERE codtipoper IN (1101, 1010)
                        AND dtneg BETWEEN TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM') AND LAST_DAY(TO_DATE(SYSDATE, 'DD/MM/YY'))
                        AND statusnota = 'L'
                        ORDER BY 1, 2
                ) vendido
                LEFT JOIN
                (
                        SELECT codvend,
                               nomevend,
                               codparc,
                               nomeparc,
                               codprod,
                               descrprod,
                               qtdneg
                        FROM simples_itens_da_nota
                        WHERE codtipoper IN (1201, 1202, 1204)
                        AND dtmov BETWEEN TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM') AND LAST_DAY(TO_DATE(SYSDATE, 'DD/MM/YY'))
                        AND statusnota = 'L'
                        ORDER BY 1, 2
                ) devolvido
                ON vendido.codvend = devolvido.codvend
                AND vendido.codparc = devolvido.codparc
                AND vendido.codprod = devolvido.codprod
                WHERE NVL(vendido.qtdneg, 0) - NVL(devolvido.qtdneg, 0) > 0
        )
        GROUP BY codvend, nomevend
) mixes
ON vendedores.codvend = mixes.codvend
ORDER BY 1;

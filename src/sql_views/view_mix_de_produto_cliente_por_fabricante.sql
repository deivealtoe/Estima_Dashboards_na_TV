--CREATE OR REPLACE VIEW dashoff_fabric_mixes AS
SELECT mixes.fabricante,
       mixes.mixprod,
       metamixprod.prevrec METAMIXPROD,
       mixes.mixcli,
       metamixcli.prevrec METAMIXCLI
FROM
(
	SELECT fabricante,
	       COUNT(DISTINCT codparc) MIXCLI,
	       COUNT(DISTINCT codprod) MIXPROD
	FROM
	(
	        SELECT vendido.fabricante,
	               vendido.codparc,
	               vendido.nomeparc,
	               vendido.codprod,
	               vendido.descrprod,
	               NVL(vendido.qtdneg, 0) QTDVEND,
	               NVL(devolvido.qtdneg, 0) QTDDEVOL,
	               NVL(vendido.qtdneg, 0) - NVL(devolvido.qtdneg, 0) QTDNEGLIQ
	        FROM
	        (
	                SELECT fabricante,
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
	                SELECT fabricante,
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
	        ON vendido.fabricante = devolvido.fabricante
	        AND vendido.codparc = devolvido.codparc
	        AND vendido.codprod = devolvido.codprod
	        WHERE NVL(vendido.qtdneg, 0) - NVL(devolvido.qtdneg, 0) > 0
	)
	GROUP BY fabricante
) mixes
LEFT JOIN
(
        SELECT fabricante,
               dtref,
               prevrec
        FROM meta_mix_produtos_fabricantes
        WHERE dtref = TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM')
) metamixprod
ON mixes.fabricante = metamixprod.fabricante
LEFT JOIN
(
        SELECT fabricante,
               dtref,
               prevrec
        FROM meta_mix_clientes_fabricantes
        WHERE dtref = TRUNC(TO_DATE(SYSDATE, 'DD/MM/YY'), 'MM')
) metamixcli
ON mixes.fabricante = metamixcli.fabricante
WHERE mixes.fabricante IN ('PREMIER PET', 'MERIAL', 'IDEXX', 'CEPAV', 'PET SOCIETY', 'BIOVET', 'ALCON', 'LABYES')
ORDER BY mixes.mixprod DESC, metamixprod.prevrec DESC;

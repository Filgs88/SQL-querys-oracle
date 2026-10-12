select
    mie.sequencia_nf,
	mie.nrnf,
	mie.nroc,
	mie.nr_solicitacao,
	mie.dataentrada_seq,
	mie.cod_material,
	mm.descricao,
	coalesce(mie.quantidade, 0) as quantidade,
	coalesce(mie.qtde_transformada, 0) as qtde_transformada,
	coalesce(mie.qtde_contada, 0) as qtde_contada,
	mie.cod_unidade,
	round(coalesce(mie.valorunitario, 0), 2) as valor_unitario,
	round(coalesce(mie.valortotal, 0), 2) as valor_total

from
    material.itensentrada mie

left join 
    material.material mm on mie.cod_material = mm.cod_material
left join 
    material.solicitacaocompra msc on mie.nr_solicitacao = msc.nr_solicitacao

where
    mie.cod_grupoempresa = 1 and
	mie.cod_empresa = 1 and
	mie.cod_filial = 1 and
    msc.cod_almoxarifado = 8 and
	mie.dataentrada_seq >= to_date(to_char(sysdate - 365, 'dd/mm/yyyy')) and
	mie.cod_unidade <> 'SV' and
	mie.qtde_contada = 0

order by
    mie.sequencia_nf
select mie.sequencia_nf,
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
	coalesce(mie.valorunitario, 0) as valor_unitario,
	coalesce(mie.valortotal, 0) as valor_total,
	msc.cod_almoxarifado

from material.itensentrada mie

inner join material.solicitacaocompra msc on mie.nr_solicitacao = msc.nr_solicitacao
left join material.material mm on mie.cod_material = mm.cod_material

where mie.cod_grupoempresa = 1 and
	mie.cod_empresa = 1 and
	mie.cod_filial = 1 and
	mie.dataentrada_seq >= to_date(to_char(sysdate - 180, 'dd/mm/yyyy')) and
	mie.cod_unidade <> 'SV' and
	mie.qtde_contada = 0 and
	msc.cod_almoxarifado = 8

order by mie.nrnf
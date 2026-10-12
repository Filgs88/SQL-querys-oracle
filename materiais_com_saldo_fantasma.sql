select
    mie.sequencia_nf,
	mie.nrnf,
	mie.nroc,
    irm.nrrequisicao,
	mie.nr_solicitacao,
    sc.cod_funcionario,
	mie.dataentrada_seq,
	mie.cod_material,
	mm.descricao,
	coalesce(mie.qtde_contada, 0) as qtde_contada,
	mie.cod_unidade,
	round(coalesce(mie.valorunitario, 0), 2) as valor_unitario,
	round(coalesce(mie.valortotal, 0), 2) as valor_total

from
    material.itensentrada mie

left join 
    material.material mm on mie.cod_material = mm.cod_material
left join 
    material.solicitacaocompra sc on mie.nr_solicitacao = sc.nr_solicitacao
left join 
    material.itensrequisicaomaterial irm on mie.nr_solicitacao = irm.nr_solicitacao

where
    mie.cod_grupoempresa = 1 and
	mie.cod_empresa = 1 and
	mie.cod_filial = 1 and
	mie.cod_almoxarifado = 8 and
	mie.cod_unidade <> 'SV' and
	mie.dataentrada_seq >= to_date(concat('01/', to_char(sysdate-30, 'mm/yyyy')), 'dd/mm/yyyy') and
    (mie.nr_solicitacao is null or sc.cod_funcionario <> 3331)

order by
    mie.sequencia_nf
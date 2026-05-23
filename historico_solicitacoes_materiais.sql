select
    nroc,
	dataoc,
	nr_solicitacao,
	cod_material,
	descricao,
	qtd_solicitada,
	cod_unidade,
	observacao,
	informacao_fornecedor

from (
    select
        itensordemcompra.nroc,
		ordemcompra.dataoc,
		itensordemcompra.nr_solicitacao,
		itensordemcompra.cod_material,
		mat.descricao,
		coalesce(itensordemcompra.quantidade_solic, 0) as qtd_solicitada,
		mat.cod_unidade,
		solicitacaocompra.observacao,
		solicitacaocompra.informacao_fornecedor,
		row_number() over (partition by itensordemcompra.nr_solicitacao order by itensordemcompra.nroc) as id_sqc

	from
	    material.itensordemcompra

	left join
	    material.solicitacaocompra on itensordemcompra.nr_solicitacao = solicitacaocompra.nr_solicitacao
	left join
	    material.ordemcompra on itensordemcompra.nroc = ordemcompra.nroc
	left join
	    material.itensentrada on itensordemcompra.nr_solicitacao = itensentrada.nr_solicitacao
	left join
		material.material mat on itensordemcompra.cod_material = mat.cod_material

	where
	    ordemcompra.dataoc < date '2026-03-01' and
	    solicitacaocompra.cod_almoxarifado = 8 and
		mat.cod_unidade not like 'SV' and
		solicitacaocompra.observacao not like '%Gerado %'
)

where
    id_sqc = 1

order by
    dataoc desc

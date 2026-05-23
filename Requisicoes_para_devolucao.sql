select irm.nrrequisicao,
	irm.item,
        irm.cod_funcionario_entrega,
	irm.cod_material,
	mm.descricao,
	coalesce(irm.quantidade,0) as quantidade,
	irm.dataretirada,
	coalesce(irm.vrcustounitario,0) as custo_unitario,
	coalesce((irm.quantidade * irm.vrcustounitario),0) as custo_total,
	irm.codigo_cte,
	irm.cod_funcionario_retirar,
	irm.cod_objetocusto_ativo

from material.itensrequisicaomaterial irm

left join material.material mm on irm.cod_material = mm.cod_material

where irm.cod_material = 6228 and 
	irm.cod_almoxarifado = 8 and
        irm.quantidade > 1000

order by irm.dataretirada, irm.nrrequisicao
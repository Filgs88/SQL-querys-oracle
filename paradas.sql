select ocorrencia.cod_ocorrencia,
	ocorrencia.descricao,
	ocorrencia.cod_causa,
	ocorrencia.causas,
	ocorrencia.datahora,
	ocorrencia.horaini,
	ocorrencia.horafim,
	ocorrencia.codigo_cte,
	sistema.codigo_cte_alfa,
	sistema.descricao as nome_cte

from laboratorio.ocorrencia

left join industria.sistema on ocorrencia.codigo_cte = sistema.codigo_cte

where datahora >= to_date('15/03/2025', 'dd/mm/yyyy')

order by ocorrencia.datahora
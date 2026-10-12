select
    cod_funcionario,
	ano,
	mes,
	coalesce(valor, 0) as valor_salario,
	memoria_calculo

from
    rh.basefuncionario

where
    cod_funcionario = 3331 and
    cod_baseacumulo = 3

order by
    mes

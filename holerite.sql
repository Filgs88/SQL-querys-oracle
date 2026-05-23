select cod_funcionario,
	ano,
	mes,
	coalesce(valor, 0) as valor,
	memoria_calculo

from rh.basefuncionario

where cod_funcionario = 4144 and
	ano = 2026 and
	mes = 4

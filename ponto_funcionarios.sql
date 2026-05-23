select 
    ep.data,
    ep.cod_funcionario,
    ep.cod_evento,
    floor(ep.referencia) + ((ep.referencia - floor(ep.referencia)) * 60 / 100) as horas_diarias

from rh.eventosponto ep

join rh.view_dossie vd on vd.cod_funcionario = ep.cod_funcionario

where ep.cod_evento in ('1130','4') and
	nvl(vd.setor_plr, -1) = 14 and
	ep.data between date '2026-03-01' and date '2026-04-01'

order by ep.cod_funcionario, ep.data
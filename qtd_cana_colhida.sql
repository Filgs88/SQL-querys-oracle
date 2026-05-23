select
    sum(pesoliquido) as pesoliquido_hora,
    trunc(data_descarregamento, 'HH24') as hora_descarregamento

from
    agricola.itenscolheita

where
    trunc(data_descarregamento) = date '2026-05-21'

group by
    trunc(data_descarregamento, 'HH24')

order by
    hora_descarregamento

select
    *

from
    laboratorio.ocorrencia

where
    datahora > to_date('01/01/2026', 'dd/mm/yyyy')

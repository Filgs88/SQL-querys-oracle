with tbl_salarios as (
    select 
        cod_grupocargo || '-' || cod_planocargo || '-' || letra as grupo_plano_letra_cargo,
    	valor
    
    from 
        rh.historicoalteracaosalario 
    
    where 
        data_inicio >= to_date('01/01/2026', 'dd/mm/yyyy')
),

tbl_1 as (
    select 
        cod_cargo,
    	datainicio,
    	letra
    
    from (
    	select 
            cod_cargo,
    		datainicio,
    		letra,
    		row_number() over (partition by cod_cargo order by datainicio desc) as rnk
    
    	from 
            rh.HISTORICOCARGO
    )

    where 
        rnk = 1
    
    order by 
        cod_cargo
),

tbl_cargo as (
    select 
        cargo_log.cod_cargo,
    	cargo_log.cod_grupocargo_new,
    	cargo_log.cod_planocargo_new,
    	tbl_1.letra,
    	cargo_log.descricao_new
    	
    from 
        rh.cargo_log
    
    left join 
        tbl_1 on cargo_log.cod_cargo = tbl_1.cod_cargo
    
    where 
        cod_grupocargo_new is not null and
    	cod_planocargo_new is not null and
    	descricao_new is not null
)

select 
    tbl_cargo.cod_cargo,
	tbl_cargo.cod_grupocargo_new,
	tbl_cargo.cod_planocargo_new,
	tbl_cargo.letra,
	tbl_cargo.descricao_new,
    coalesce(tbl_salarios.valor, 0) as valor

from 
    tbl_cargo

left join 
    tbl_salarios on tbl_cargo.cod_grupocargo_new || '-' || tbl_cargo.cod_planocargo_new || '-' || tbl_cargo.letra = tbl_salarios.grupo_plano_letra_cargo

order by 
    tbl_cargo.descricao_new
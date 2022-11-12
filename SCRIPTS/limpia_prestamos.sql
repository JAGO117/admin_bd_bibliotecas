set serveroutput on;
whenever sqlerror exit rollback;

declare
  cursor cur_recurso is
    select recurso_id
    from admin_re.recurso
    where status_recurso_id = 2;
  v_recurso_id number;
  v_num_prestamo number;
  v_prestamo_id number;
begin
  -- Se modifica la bandera con_prestamo del usuario
  update admin_bi_us.usuario
  set con_prestamo=0;

  for r in cur_recurso loop

    -- Se inserta la fecha del prestamo devuelto en el historico
    insert into admin_re.historico_status(historico_status_id, fecha_status,
      status_recurso_id, recurso_id) 
    values (admin_re.seq_historico_status.nextval, sysdate, 1, r.recurso_id);

    -- Se modifica la fecha_status del recurso y el status_recurso_id se cambia a en prestamo
    update admin_re.recurso
    set fecha_status = sysdate,
        status_recurso_id = 1
    where recurso_id = r.recurso_id;
  end loop;
end;
/

commit;
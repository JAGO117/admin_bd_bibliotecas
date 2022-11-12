

declare
  cursor cur_historico is
    select recurso_id, fecha_status
    from admin_re.recurso;
begin
  for r in cur_historico loop
    insert into admin_re.historico_status(historico_status_id, fecha_status,
      status_recurso_id, recurso_id) 
    values (admin_re.seq_historico_status.nextval, r.fecha_status, 1, r.recurso_id);
  end loop;
end;
/
create sequence seq_prestamo
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  order;

declare
  cursor cur_usuario is
    select usuario_id
    from usuario;
  v_recurso_id number;
  v_date date;
  v_num_prestamo number;
  v_prestamo_id number;
begin
  v_date := TO_DATE('2020/01/07', 'yyyy/mm/dd');
  for r in cur_usuario loop
    for i in 1..52 loop
      -- Se obtiene un recurso aleatorio que este disponible
      select recurso_id into v_recurso_id 
      from (select recurso_id 
        from recurso where status_recurso_id=1 
        order by DBMS_RANDOM.RANDOM) 
      where rownum=1;

      -- Se obtiene el num de prestamo del usuario
      select sum(prestamo_id) into v_num_prestamo from prestamo where usuario_id = r.usuario_id;

      -- Se obtiene el prestamo id de la secuencia
      select seq_prestamo.nextval into v_prestamo_id from dual;

      -- Se inserta en prestamo
      insert into prestamo (prestamo_id, usuario_id, num_prestamo, fecha_entrega, importe_multa) 
      values (v_prestamo_id, r.usuario_id, v_num_prestamo + 1, v_date + (i * 7) + 5, null);

      -- Se inserta en  prestamo recurso
      insert into prestamo_recurso (prestamo_id, recurso_id) values (v_prestamo_id, v_recurso_id);

      -- Se inserta la fecha del prestamo en el historico
      insert into historico_status(historico_status_id, fecha_status,
        status_recurso_id, recurso_id) 
      values (seq_historico_status.nextval, v_date + (i * 7), 2, v_recurso_id);

      -- Se inserta la fecha de devolucion en el historico y vuelve a estado disponible
      insert into historico_status(historico_status_id, fecha_status,
        status_recurso_id, recurso_id) 
      values (seq_historico_status.nextval, v_date + (i * 7) + 5, 1, v_recurso_id);

      -- Se modifica la fecha_status del recurso
      update recurso
      set fecha_status = v_date + (i * 7) + 5
      where recurso_id = v_recurso_id;
    end loop;
  end loop;
end;
/
declare
  cursor cur_usuario is
    select usuario_id, foto
    from admin_bi_us.usuario
    where usuario_id<5;
begin
  for r in cur_usuario loop
    update admin_bi_us.usuario
    set foto=loader('profile.jpg')
    where usuario_id=r.usuario_id;
  end loop;
end;
/

declare
  cursor cur_libro is
    select libro_id, pdf
    from admin_re.libro
    where libro_id<5;
begin
  for r in cur_libro loop
    update admin_re.libro
    set pdf=loader('book.pdf')
    where libro_id=r.libro_id;
  end loop;
end;
/

declare
  cursor cur_tesis is
    select tesis_id, pdf
    from admin_re.tesis
    where tesis_id<5;
begin
  for r in cur_tesis loop
    update admin_re.tesis
    set pdf=loader('book.pdf')
    where tesis_id=r.tesis_id;
  end loop;
end;
/
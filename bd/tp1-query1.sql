SELECT i.id_incidente, ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre, o.placa, o.nombre, o.apellido, o.rango, ro.descripcion,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1.incidente i, tp1.tipo_de_incidente ti, tp1.oficial o, tp1.oficial_se_involucro osi, tp1.civil c, tp1.se_involucraron si, tp1.rol_oficial ro, tp1.rol_civil rc, 
tp1.direccion d, tp1.barrio b
WHERE i.id_incidente = osi.id_incidente and i.id_incidente = si.id_incidente and i.id_tipo_incidente = ti.id_tipo_incidente and
i.fecha < '2018-10-07' and i.fecha > '2018-09-15' and osi.placa = o.placa and si.dni = c.dni 
and si.id_rol_civil = rc.id_rol_civil and osi.id_responsabilidad = ro.id_responsabilidad and i.id_direccion = d.id_direccion
and d.id_barrio = b.id_barrio;
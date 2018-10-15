SELECT i.id_incidente, ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1.incidente i, tp1.tipo_de_incidente ti, tp1.direccion d, tp1.barrio b, tp1.se_involucraron si, tp1.rol_civil rc, tp1.civil c, tp1.organizacion_delictiva od,
tp1.esta_compuesta_por ecp
WHERE i.id_incidente = si.id_incidente and i.id_tipo_incidente = ti.id_tipo_incidente and si.dni = c.dni 
and si.id_rol_civil = rc.id_rol_civil and i.id_direccion = d.id_direccion and d.id_barrio = b.id_barrio
and od.id_mafia = 3 and od.id_mafia = ecp.id_mafia and c.dni = ecp.dni ;
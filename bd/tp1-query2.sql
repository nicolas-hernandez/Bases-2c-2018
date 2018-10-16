SELECT i.id_incidente, ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1.incidente i
JOIN tp1.tipo_de_incidente ti ON i.id_tipo_incidente = ti.id_tipo_incidente
JOIN tp1.direccion d ON i.id_direccion = d.id_direccion 
JOIN tp1.barrio b ON d.id_barrio = b.id_barrio 
JOIN tp1.se_involucraron si ON i.id_incidente = si.id_incidente
JOIN tp1.civil c ON si.dni = c.dni
JOIN tp1.rol_civil rc ON si.id_rol_civil = rc.id_rol_civil
JOIN tp1.esta_compuesta_por ecp ON c.dni = ecp.dni
JOIN tp1.organizacion_delictiva od ON od.id_mafia = ecp.id_mafia
WHERE od.id_mafia = 3;

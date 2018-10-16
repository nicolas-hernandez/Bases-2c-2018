SELECT i.id_incidente, ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre, o.placa, o.nombre, o.apellido, o.rango, ro.descripcion,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1.incidente i
JOIN tp1.tipo_de_incidente ti ON i.id_tipo_incidente = ti.id_tipo_incidente
JOIN tp1.oficial_se_involucro osi ON i.id_incidente = osi.id_incidente
JOIN tp1.oficial o ON osi.placa = o.placa
JOIN tp1.se_involucraron si ON i.id_incidente = si.id_incidente
JOIN tp1.civil c ON si.dni = c.dni 
JOIN tp1.rol_oficial ro ON osi.id_responsabilidad = ro.id_responsabilidad
JOIN tp1.rol_civil rc ON si.id_rol_civil = rc.id_rol_civil
JOIN tp1.direccion d ON i.id_direccion = d.id_direccion
JOIN tp1.barrio b ON d.id_barrio = b.id_barrio
WHERE i.fecha < '2018-10-07' and i.fecha > '2018-09-15';

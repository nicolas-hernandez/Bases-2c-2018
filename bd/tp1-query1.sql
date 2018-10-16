SELECT i."idIncidente", ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre, o.placa, o.nombre, o.apellido, o.rango, ro.descripcion,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1.incidente i
JOIN tp1.tipo_de_incidente ti ON i."idTipoInicidente" = ti."idTipoInicidente"
JOIN tp1.oficial_se_involucro osi ON i."idIncidente" = osi."idIncidente"
JOIN tp1.oficial o ON osi.placa = o.placa
JOIN tp1.se_involucraron si ON i."idIncidente" = si."idIncidente"
JOIN tp1.civil c ON si.dni = c.dni 
JOIN tp1.rol_oficial ro ON osi."idResponsabilidad" = ro."idResponsabilidad"
JOIN tp1.rol_civil rc ON si."idRolCivil" = rc."idRolCivil"
JOIN tp1.direccion d ON i."idDireccion" = d."idDireccion"
JOIN tp1.barrio b ON d."idBarrio" = b."idBarrio"
WHERE i.fecha < '2018-10-07' and i.fecha > '2018-09-15';

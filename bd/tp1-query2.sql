SELECT i."idIncidente", ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1.incidente i
JOIN tp1.tipo_de_incidente ti ON i."idTipoInicidente" = ti."idTipoInicidente"
JOIN tp1.direccion d ON i."idDireccion" = d."idDireccion" 
JOIN tp1.barrio b ON d."idBarrio" = b."idBarrio" 
JOIN tp1.se_involucraron si ON i."idIncidente" = si."idIncidente"
JOIN tp1.civil c ON si.dni = c.dni
JOIN tp1.rol_civil rc ON si."idRolCivil" = rc."idRolCivil"
JOIN tp1.esta_compuesta_por ecp ON c.dni = ecp.dni
JOIN tp1.organizacion_delictiva od ON od."idMafia" = ecp."idMafia"
WHERE od."idMafia" = 3;

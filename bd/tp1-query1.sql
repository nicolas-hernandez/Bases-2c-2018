SELECT i."idIncidente", ti.nombre, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre, o.placa, o.nombre, o.apellido, o.rango, ro.descripcion,
c.dni, c.nombre, c.apellido, rc.nombre
FROM tp1."Incidente" i
JOIN tp1."TipoIncidente" ti ON i."idTipoInicidente" = ti."idTipoInicidente"
JOIN tp1."OficialSeInvolucro" osi ON i."idIncidente" = osi."idIncidente"
JOIN tp1."Oficial" o ON osi.placa = o.placa
JOIN tp1."SeInvolucraron" si ON i."idIncidente" = si."idIncidente"
JOIN tp1."Civil" c ON si.dni = c.dni 
JOIN tp1."RolOficial" ro ON osi."idResponsabilidad" = ro."idResponsabilidad"
JOIN tp1."RolCivil" rc ON si."idRolCivil" = rc."idRolCivil"
JOIN tp1."Direccion" d ON i."idDireccion" = d."idDireccion"
JOIN tp1."Barrio" b ON d."idBarrio" = b."idBarrio"
WHERE i.fecha < '2018-10-07' and i.fecha > '2018-09-15';

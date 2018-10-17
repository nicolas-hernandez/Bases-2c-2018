SELECT i."idIncidente",
       ti.nombre as "tipoIncidente",
       i.fecha as "fechaIncidente",
       i.calle_1,
       i.calle_2,
       d.calle as "departamentoCalle",
       d.altura as "alturaDepartamento",
       b.nombre as "nombreBarrio",
       c.dni as "dniCivil",
       c.nombre as "nombreCivil",
       c.apellido as "apellidoCivil",
       rc.nombre as "rolCivil"
FROM tp1."Incidente" i
JOIN tp1."TipoIncidente" ti ON i."idTipoInicidente" = ti."idTipoInicidente"
JOIN tp1."Direccion" d ON i."idDireccion" = d."idDireccion" 
JOIN tp1."Barrio" b ON d."idBarrio" = b."idBarrio" 
JOIN tp1."SeInvolucraron" si ON i."idIncidente" = si."idIncidente"
JOIN tp1."Civil" c ON si.dni = c.dni
JOIN tp1."RolCivil" rc ON si."idRolCivil" = rc."idRolCivil"
JOIN tp1."EstaCompuestaPor" ecp ON c.dni = ecp.dni
JOIN tp1."OrganizacionDelictiva" od ON od."idMafia" = ecp."idMafia"
WHERE od."idMafia" = 3;

SELECT distinct i."idIncidente", i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre
FROM tp1."Incidente" i 
JOIN tp1."SuperParticipo" sp ON i."idIncidente" = sp."idIncidente"
JOIN tp1."Superheroe" sh ON sp."idSuperHeroe" = sh."idSuperHeroe"
JOIN tp1."SeInvolucraron" si ON i."idIncidente" = si."idIncidente"
JOIN tp1."Civil" c ON si.dni = c.dni
JOIN tp1."archienemigoDe" arch ON arch."idSuperHeroe" = sh."idSuperHeroe" 
JOIN tp1."Direccion" d ON i."idDireccion" = d."idDireccion"
JOIN tp1."Barrio" b ON d."idBarrio" = b."idBarrio"
WHERE si."idRolCivil" = 2 and arch.dni = c.dni;

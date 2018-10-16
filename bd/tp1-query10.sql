SELECT distinct i."idIncidente", i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre
FROM tp1.incidente i 
JOIN tp1.super_participo sp ON i."idIncidente" = sp."idIncidente"
JOIN tp1.superheroe sh ON sp."idSuperHeroe" = sh."idSuperHeroe"
JOIN tp1.se_involucraron si ON i."idIncidente" = si."idIncidente"
JOIN tp1.civil c ON si.dni = c.dni
JOIN tp1.archienemigo_de arch ON arch."idSuperHeroe" = sh."idSuperHeroe" 
JOIN tp1.direccion d ON i."idDireccion" = d."idDireccion"
JOIN tp1.barrio b ON d."idBarrio" = b."idBarrio"
WHERE si."idRolCivil" = 2 and arch.dni = c.dni;

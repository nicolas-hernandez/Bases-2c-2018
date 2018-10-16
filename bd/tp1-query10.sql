SELECT distinct i.id_incidente, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre
FROM tp1.incidente i 
JOIN tp1.super_participo sp ON i.id_incidente = sp.id_incidente
JOIN tp1.superheroe sh ON sp.id_sh = sh.id_sh
JOIN tp1.se_involucraron si ON i.id_incidente = si.id_incidente
JOIN tp1.civil c ON si.dni = c.dni
JOIN tp1.archienemigo_de arch ON arch.id_sh = sh.id_sh 
JOIN tp1.direccion d ON i.id_direccion = d.id_direccion
JOIN tp1.barrio b ON d.id_barrio = b.id_barrio
WHERE si.id_rol_civil = 2 and arch.dni = c.dni;

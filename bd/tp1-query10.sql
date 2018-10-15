SELECT distinct i.id_incidente, i.fecha, i.calle_1, i.calle_2, d.calle, d.altura, b.nombre
FROM tp1.incidente i, tp1.super_participo sp, tp1.superheroe sh, tp1.archienemigo_de arch, tp1.civil c, tp1.se_involucraron si,
tp1.direccion d, tp1.barrio b

WHERE i.id_incidente = sp.id_incidente and sp.id_sh = sh.id_sh and i.id_incidente = si.id_incidente and si.dni = c.dni
and si.id_rol_civil = 2 and arch.dni = c.dni and arch.id_sh = sh.id_sh and i.id_direccion = d.id_direccion and d.id_barrio = b.id_barrio;
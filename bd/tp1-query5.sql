SELECT b.id_barrio, b.nombre, COUNT(distinct i.id_incidente)
FROM tp1.incidente i, tp1.direccion d, tp1.barrio b
WHERE d.id_direccion = i.id_direccion and d.id_barrio = b.id_barrio
GROUP BY b.id_barrio, b.nombre
HAVING COUNT(distinct i.id_incidente) = (SELECT MAX(incidentes_count) from 
( SELECT count (distinct i.id_incidente) incidentes_count
FROM tp1.incidente i, tp1.direccion d, tp1.barrio b
WHERE d.id_direccion = i.id_direccion and d.id_barrio = b.id_barrio
GROUP BY b.id_barrio ) inc_count);				


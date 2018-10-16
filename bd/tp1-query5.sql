SELECT b."idBarrio", b.nombre, COUNT(distinct i."idIncidente")
FROM tp1.incidente i
JOIN tp1.direccion d ON d."idDireccion" = i."idDireccion"
JOIN tp1.barrio b ON d."idBarrio" = b."idBarrio"
GROUP BY b."idBarrio", b.nombre
HAVING COUNT(distinct i."idIncidente") = (SELECT MAX(incidentes_count) from 
( SELECT count (distinct i."idIncidente") incidentes_count
FROM tp1.incidente i
JOIN tp1.direccion d ON d."idDireccion" = i."idDireccion"
JOIN tp1.barrio b ON d."idBarrio" = b."idBarrio"
GROUP BY b."idBarrio" ) inc_count);				


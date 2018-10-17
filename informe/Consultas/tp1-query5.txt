SELECT b."idBarrio", b.nombre, COUNT(distinct i."idIncidente")
FROM tp1."Incidente" i
JOIN tp1."Direccion" d ON d."idDireccion" = i."idDireccion"
JOIN tp1."Barrio" b ON d."idBarrio" = b."idBarrio"
GROUP BY b."idBarrio", b.nombre
HAVING COUNT(distinct i."idIncidente") >= ALL (SELECT COUNT(distinct i2."idIncidente") from 
											   FROM tp1."Incidente" i2
											   JOIN tp1."Direccion" d2 ON d2."idDireccion" = i2."idDireccion"
											   JOIN tp1."Barrio" b2 ON d2."idBarrio" = b2."idBarrio"
											   GROUP BY b2."idBarrio");

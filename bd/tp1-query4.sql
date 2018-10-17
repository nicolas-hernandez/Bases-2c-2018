SELECT o.placa, o.dni, o.nombre, o.apellido, COUNT(distinct i."idIncidente")
FROM tp1."Incidente" i
JOIN tp1."OficialSeInvolucro" oci ON oci."idIncidente" = i."idIncidente"
JOIN tp1."Oficial" o ON oci.placa = o.placa
GROUP BY o.placa, o.dni, o.nombre, o.apellido
HAVING COUNT(distinct i."idIncidente") >= ALL (SELECT COUNT(distinct i2."idIncidente")
											   FROM tp1."Incidente" i2
											   JOIN tp1."OficialSeInvolucro" oci2 ON oci2."idIncidente" = i2."idIncidente"
											   JOIN tp1."Oficial" o2 ON oci2.placa = o2.placa
											   GROUP BY o2.placa);

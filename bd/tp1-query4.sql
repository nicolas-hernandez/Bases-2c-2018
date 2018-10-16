SELECT o.placa, o.dni, o.nombre, o.apellido, COUNT(distinct i."idIncidente")
FROM tp1."Incidente" i
JOIN tp1."OficialSeInvolucro" oci ON oci."idIncidente" = i."idIncidente"
JOIN tp1."Oficial" o ON oci.placa = o.placa
GROUP BY o.placa, o.dni, o.nombre, o.apellido
HAVING COUNT(distinct i."idIncidente") = (SELECT MAX(incidentes_count) from 
( SELECT count (distinct i."idIncidente") incidentes_count
FROM tp1."Incidente" i
JOIN tp1."OficialSeInvolucro" oci ON oci."idIncidente" = i."idIncidente"
JOIN tp1."Oficial" o ON oci.placa = o.placa
GROUP BY o.placa ) inc_count);											

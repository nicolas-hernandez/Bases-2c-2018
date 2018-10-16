SELECT o.placa, o.dni, o.nombre, o.apellido, COUNT(distinct i.id_incidente)
FROM tp1.incidente i
JOIN tp1.oficial_se_involucro oci ON oci.id_incidente = i.id_incidente
JOIN tp1.oficial o ON oci.placa = o.placa
GROUP BY o.placa, o.dni, o.nombre, o.apellido
HAVING COUNT(distinct i.id_incidente) = (SELECT MAX(incidentes_count) from 
( SELECT count (distinct i.id_incidente) incidentes_count
FROM tp1.incidente i
JOIN tp1.oficial_se_involucro oci ON oci.id_incidente = i.id_incidente
JOIN tp1.oficial o ON oci.placa = o.placa
GROUP BY o.placa ) inc_count);											

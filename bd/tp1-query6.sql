SELECT distinct o.placa, o.dni, o.nombre, o.apellido, o.rango
FROM tp1.incidente i
JOIN tp1.oficial_se_involucro osi ON i.id_incidente = osi.id_incidente
JOIN tp1.oficial o ON  osi.placa = o.placa
JOIN tp1.asignacion a ON o.placa = a.placa
JOIN tp1.sumario s ON a.id_asignacion = s.id_asignacion

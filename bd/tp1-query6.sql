SELECT distinct o.placa, o.dni, o.nombre, o.apellido, o.rango
FROM tp1.incidente i, tp1.oficial_se_involucro osi, tp1.oficial o, tp1.asignacion a, tp1.sumario s
WHERE i.id_incidente = osi.id_incidente and osi.placa = o.placa and o.placa = a.placa and a.id_asignacion = s.id_asignacion
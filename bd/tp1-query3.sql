SELECT o.placa, o.dni, o.nombre, o.apellido, o.rango, o.fecha_ingreso, o.tipo
FROM tp1.oficial o, tp1.departamento d
WHERE d.id_departamento = 1 and d.id_departamento = o.id_departamento;
SELECT o.placa, o.dni, o.nombre, o.apellido, o.rango, o."fechaIngreso", o.tipo
FROM tp1.oficial o, tp1.departamento d
WHERE d."idDepartamento" = 1 and d."idDepartamento" = o."idDepartamento";

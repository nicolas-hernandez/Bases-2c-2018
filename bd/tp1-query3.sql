SELECT o.placa as "placaOficial",
       o.dni as "dniOficial",
       o.nombre as "nombreOficial",
       o.apellido as "apellidoOficial",
       o.rango as "oficialRango",
       o."fechaIngreso",
       o.tipo as "oficialTipo"
FROM tp1."Oficial" o
INNER JOIN tp1."Departamento" d ON d."idDepartamento" = o."idDepartamento"
WHERE d."idDepartamento" = 1;

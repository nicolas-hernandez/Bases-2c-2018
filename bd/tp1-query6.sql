SELECT distinct o.placa, o.dni, o.nombre, o.apellido, o.rango
FROM tp1."Incidente" i
JOIN tp1."OficialSeInvolucro" osi ON i."idIncidente" = osi."idIncidente"
JOIN tp1."Oficial" o ON  osi.placa = o.placa
JOIN tp1."Asignacion" a ON o.placa = a.placa
JOIN tp1."Sumario" s ON a."idAsignacion" = s."idAsignacion"

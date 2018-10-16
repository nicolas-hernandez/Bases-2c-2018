SELECT distinct sh."idSuperHeroe", sh.nombre, sh.color_capa
FROM tp1.incidente i
JOIN tp1.super_participo sp ON i."idIncidente" = sp."idIncidente"
JOIN tp1.superheroe sh ON sp."idSuperHeroe" = sh."idSuperHeroe";

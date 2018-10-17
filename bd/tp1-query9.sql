SELECT distinct sh."idSuperHeroe",
				sh.nombre,
				sh.color_disfraz
FROM tp1."Incidente" i
JOIN tp1."SuperParticipo" sp ON i."idIncidente" = sp."idIncidente"
JOIN tp1."Superheroe" sh ON sp."idSuperHeroe" = sh."idSuperHeroe";

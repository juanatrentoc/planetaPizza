---
name: cerrar-sesion
description: Cierra una sesión de trabajo en el repo de Planeta Pizza — actualiza CONTEXTO.md, commitea los cambios y los sube (push) al repositorio.
---

Usá este skill al terminar de trabajar en este proyecto, para dejar todo guardado y el contexto al día para la próxima sesión.

Pasos, en orden:

1. Corré `git status` y `git diff --stat` para ver qué cambió en esta sesión.
2. Si no hay ningún cambio real (ni staged, ni sin trackear, ni modificado), avisá que no hay nada para subir y terminá ahí — nunca crees un commit vacío.
3. Si hay cambios, repasalos antes de tocar nada:
   - Revisá que no haya archivos que no deberían subirse (credenciales, archivos temporales del sistema, carpetas de build, etc.). Si aparece algo raro, excluilo y avisale al usuario.
4. Actualizá `CONTEXTO.md` con lo que pasó en esta sesión: qué cambió en el prototipo, qué se decidió, y qué preguntas quedan pendientes para la próxima (sumá o editá, no borres historial que siga siendo válido). Actualizá la fecha en "Última actualización". Si el archivo no existe, creálo.
5. Agregá al staging los archivos relevantes del proyecto (el prototipo, `assets/`, `CONTEXTO.md`, los propios skills si cambiaron, etc.) con `git add <archivos>` — evitá un `git add -A` ciego sin haber mirado `git status` primero.
6. Armá un mensaje de commit corto en español que describa qué cambió y por qué, basado en el diff real (no inventes contenido). Agregá la línea de atribución que correspondan según las instrucciones vigentes del sistema para esta sesión.
7. Hacé el commit.
8. Hacé `git push`.
   - Si el push es rechazado porque el remoto tiene commits que vos no tenés, no fuerces el push (nunca `--force` acá): avisá al usuario y proponé correr `/iniciar-sesion` o un `git pull` para traer esos cambios primero.
9. Confirmale al usuario que se subió, con un resumen corto de qué se guardó y el link al repo (`https://github.com/juanatrentoc/planetaPizza`).

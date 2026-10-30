---
name: iniciar-sesion
description: Arranca una sesión de trabajo en el repo de Planeta Pizza — trae lo último del repositorio (git pull) y carga el contexto del proyecto desde CONTEXTO.md antes de seguir trabajando.
---

Usá este skill al empezar a trabajar en este proyecto, para no perder el hilo entre sesiones.

Pasos, en orden:

1. Confirmá que estás parado en el repo correcto: debe existir `.git` y `prototipo-pedidos.html` en el directorio de trabajo. Si no están, avisá al usuario y no sigas.
2. Corré `git status`. Si hay cambios locales sin commitear (staged o untracked que parezcan trabajo real, no basura), mostralos y preguntá al usuario si quiere guardarlos antes de traer cambios del remoto — no los pises ni los descartes.
3. Corré `git pull --ff-only origin main` para traer lo último.
   - Si falla porque hay cambios locales que chocan, explicá el conflicto puntual y esperá instrucciones — no lo resuelvas por tu cuenta ni fuerces nada.
   - Si el pull no es fast-forward (hay commits divergentes), avisá y preguntá cómo seguir en vez de mergear automáticamente.
4. Leé `CONTEXTO.md` en la raíz del repo.
   - Si no existe, creálo con esta plantilla y avisá que lo creaste:

     ```
     # Contexto — Planeta Pizza

     ## Estado actual
     (completar)

     ## Decisiones tomadas
     (completar)

     ## Pendiente / preguntas para el dueño
     (completar)

     ## Última actualización
     (fecha de hoy)
     ```

5. Con lo que leíste de `CONTEXTO.md` (y, si hace falta más detalle, `git log --oneline -10`), dale al usuario un resumen corto (3-6 líneas) de:
   - en qué quedó el proyecto,
   - si trajiste cambios nuevos del repo en el pull (sí/no, y cuáles),
   - cuál parece ser el próximo paso pendiente.

No hace falta pedir permiso para el `pull` en sí (es de lectura, no destructivo). Sí hay que parar y avisar si aparece cualquier conflicto o divergencia.

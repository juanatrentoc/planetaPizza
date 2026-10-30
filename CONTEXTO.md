# Contexto — Planeta Pizza (web de pedidos)

## Estado actual
Prototipo funcional en `prototipo-pedidos.html`: diseño temático "planeta" (cada pizza
es un planeta con cráteres de ingredientes, sin fotos de stock), pedido en pasos
(carta → carrito → datos → confirmación) y un panel para que el local vea los
pedidos en vivo. Logo real de Planeta Pizza integrado (`assets/logo-planeta.jpg`,
recortado a círculo). Paleta de acentos (botones, pestañas, bordes activos)
ajustada al bordó del logo real (antes era naranja).

Carta cargada desde "Carta OCT2026 (digital).pdf" (Google Drive, cuenta
planetacentro1@gmail.com): 31 pizzas numeradas (1–43, con huecos reales del
menú) en 3 tamaños — Chica (4 porciones, solo entera), Planeta (8 porciones,
mitad/entera) y Grande (12 porciones, mitad/entera) —, línea "Estilo italiano"
(Margherita, Pepperoni, Portobella) y 21 sabores de empanadas con sus precios
reales. Los precios se verificaron cruzando las columnas del PDF (la columna
"Planeta mitad" es exactamente la mitad de "Planeta entera" en los 31 casos).

Direcciones, teléfonos y horarios reales de las dos sucursales (Centro y
Guadalupe) ya están en el pie de página.

## Decisiones tomadas
- Sin WhatsApp: los pedidos entran directo a un panel que ve el local.
- Apto para personas mayores: pasos simples, botón de letra grande, lenguaje claro.
- Sin fotos de stock: todo ilustrado (planetas CSS).
- Objetivo: mostrar el prototipo funcionando en la primera reunión con el dueño,
  con una lista de preguntas preparada.

## Pendiente / preguntas para el dueño
- Precio de las tartas (Jamón y queso, Puerro y panceta, Caprese, Choclo,
  Zapallitos, Atún) — no está claro en el PDF, no se cargó en el prototipo.
- Dirección de Guadalupe: el PDF dice "Av. Gral. Paz 6401", una nota propia dice
  "Gral. Paz 6400" — confirmar el número correcto.
- Qué es la sección "Exclusivo Planeta Centro" con precios sueltos al final de
  la carta digital (¿adicionales? ¿delivery? ¿promos?).
- ¿Los precios son iguales en ambas sucursales?
- Zonas de envío fuera de Centro (solo se vio el mapa de delivery de esa sucursal).
- Medios de pago reales que acepta el local.
- ¿Venden bebidas o postres? No aparecen en la carta digital OCT2026.
- Confirmar si la paleta bordó/dorado debe ser la identidad oficial del sitio.

## Cómo seguir trabajando
Todo el proyecto vive en este repo (`C:\Users\usuario\PlanetaPizza` en la máquina
de Juana) — abrir Claude Code ahí, no en otra carpeta. Incluye:
- `prototipo-pedidos.html` + `assets/logo-planeta.jpg` — el sitio.
- `imagenes/` — material de referencia real del local (logo original, horarios,
  zona de delivery, notas de direcciones), usado para cargar datos reales.
- `.claude/skills/` — dos skills para no perder el hilo entre sesiones:
  - `/iniciar-sesion` — trae lo último del repo (git pull) y lee este archivo
    para retomar el contexto.
  - `/cerrar-sesion` — guarda este archivo actualizado, commitea y sube los
    cambios al repo.

## Última actualización
2026-10-30

# Contexto — Planeta Pizza (web de pedidos)

## Estado actual
Prototipo funcional en `prototipo-pedidos.html`. Flujo cliente: carta → carrito →
datos → confirmación → "Mis pedidos" (seguimiento). Además, ahora es un sistema
**multi-pizzería** real con paneles de administración — ver sección nueva abajo
("Sistema de administración y multi-pizzería") para el detalle completo, es la
parte más grande agregada desde la última actualización de este archivo.

Para probarlo localmente: correr `C:\Users\usuario\PlanetaPizza\serve.ps1` (PowerShell,
sin necesitar Node/Python) y abrir `http://localhost:8123/`.

**Carta:** cargada desde el PDF real "Carta OCT2026 (digital).pdf" (descargado y
verificado página por página — está guardado en `imagenes/CartaOCT2026-original.pdf`
y las páginas renderizadas en `imagenes/carta-paginas/`). Categorías, tal como están
en la carta real:
- **Pizzas**: 31 sabores numerados (1–43, con huecos reales del menú), en 3 tamaños
  reales — **4 porciones** (solo entera), **8 porciones** (mitad/entera) y
  **12 porciones** (mitad/entera). (Antes decía "tamaño Planeta" — eso era solo el
  sello del logo en la hoja, no el nombre del tamaño; ya corregido.)
- **Estilo italiano**: Margherita, Pepperoni, Portobella (8 porciones) — son
  **exclusivas de Planeta Centro**, según dice la carta (esto responde una de las
  preguntas que teníamos pendientes).
- **Empanadas**: dos líneas de precio, no por sabor sino por línea — "Artesanales al
  horno" (10 sabores: carne salada, carne dulce, caprese, árabe, jamón y queso,
  verduras al wok, humita, cebolla y queso, espinaca, mediterráneas) a $3.000 x
  unidad / $17.000 x 1/2 docena / $33.000 x 1 docena; "Gourmet" (6 sabores: pollo a
  las finas hierbas, gallega, lomo al malbec, de hongos, cerdo a la barbacoa*,
  roquefort y nueces* — *edición limitada) a $3.600 / $20.000 / $39.000.
- **Tartas**: 11 sabores, 2 formatos para cualquiera de ellos — Individual $14.000,
  Grande $20.000.
- **Hamburguesas** (categoría nueva, no estaba cargada antes): Halley $14.000, Doble
  Halley $17.000, Cósmica $11.000, Super Cósmica $13.000 (cada una ya incluye papas
  fritas); papas fritas sueltas (sola/cheddar/cheddar y panceta); ingredientes
  adicionales sueltos (carne, cheddar, panceta, huevo, cebolla morada, pepinos
  agridulces) para sumar a cualquier hamburguesa.
- **Promos** (categoría nueva): pizza de 12 porciones con 3 sabores a elección
  ($28.000 — en la carta dice "válida por teléfono o WhatsApp", pero en el sitio se
  pide igual que todo lo demás, por el panel) y "Kit Planeta en casa" ($26.000 — 2
  masas pre cocidas + muzzarella + salsa, para armar en casa). En ambos casos el
  cliente especifica sabores/masa elegidos en el campo de notas del pedido.

**Diseño:** tema "planeta" (cada pizza es un planeta ilustrado con cráteres de
ingredientes, sin fotos de stock) para toda la carta/carrito/datos — blanco/crema
dominante con acentos bordó y dorado, sin celeste. El menú se eligió en pasos
(primero el gusto tocando un recuadrito chico, después tamaño/cantidad en una
ventana modal con desplegable) para que no ocupe tanto lugar en pantalla ni sea
tan largo de scrollear.

**Portada/hero:** es la única parte con tratamiento "elegante"/fotográfico: usa una
foto real de la Margherita de Planeta (de su Instagram @planetapizza.sf, recortada
para sacar el texto quemado y el chrome de Instagram — ver `imagenes/portada.png`
el original y `assets/hero-pizza.jpg` el procesado), con un degradé bordó (no negro)
encima para que el texto se lea bien, y un efecto de zoom lento continuo en CSS
(no es un video real, no había herramientas para generar uno, pero da ese efecto).
Tipografía: se sumó una serif elegante (Playfair Display) para títulos, manteniendo
la sans-serif (Figtree) para todo lo demás por legibilidad.

**Inspiración de estructura:** la referencia visual que mandaste (video de un sitio
llamado "Brace — Stone-Fired", todo oscuro con serif y números en rojo) se usó solo
como inspiración de estructura (tarjetas de producto, pasos numerados, tipografía
elegante), NO como paleta — se decidió explícitamente no ir a fondo negro en todo
el sitio ni sumar las secciones extra que tenía ese video (historia/ingredientes,
reseñas, reserva de mesa con calendario), porque Planeta Pizza es un sitio de
pedidos (delivery/retiro), no una landing de marca con reservas.

## Decisiones tomadas
- Sin WhatsApp para pedidos: entran directo a un panel que ve el local (la promo de
  3 sabores sigue este mismo circuito aunque la carta diga "por teléfono o WhatsApp").
- Apto para personas mayores: pasos simples, botón de letra grande, lenguaje claro,
  configuración de cada producto recién aparece al tocarlo (no todo junto).
- Sin fotos de stock en el menú: todo ilustrado con planetas CSS. La única foto real
  es la de la portada/hero.
- Paleta bordó + blanco/crema dominante, con dorado de acento; nada de celeste.
- Objetivo: mostrar el prototipo funcionando en la primera reunión con el dueño, con
  una lista de preguntas preparada.

## Sistema de administración y multi-pizzería
Agregado en varias sesiones después de la carga inicial de la carta. Todo simulado
con `localStorage` del navegador (sin backend real todavía) para poder mostrar la
demo sin depender de internet ni de una cuenta de Firebase creada.

**Multi-pizzería (tenants):** el mismo archivo puede alojar varias pizzerías
"separadas" — cada una con sus propios pedidos, stock, productos, promos y marca,
sin que ninguna vea los datos de otra. Cada pizzería tiene **su propio link**
(`?p=<id>` en la URL, ej. `http://localhost:8123/?p=planeta`), y pueden estar
varias recibiendo pedidos al mismo tiempo (probado abriendo dos pestañas con dos
links distintos). Importante: esto funciona hoy porque todo vive en el
`localStorage` del mismo navegador/computadora — para que cada pizzería reciba
pedidos de clientes en cualquier dispositivo de internet hace falta el backend
real (Firebase), que sigue pendiente (ver `guia-firebase.html`).

**Paneles de personal** (acceso por usuario/contraseña, cada uno en su propia
ruta con `#`):
- `/admin` — pedidos en vivo de su sucursal (separado por cuenta: Centro y
  Guadalupe no se ven entre sí), historial, marcar "sin stock" por producto
  (bloquea el pedido al cliente, no es solo para cancelar después), aviso sonoro
  al llegar un pedido nuevo, cancelar con motivo, imprimir. El cliente no puede
  cancelar una vez que el pedido pasa a "en preparación" (antes sí).
- `/adminSup` — productos y precios (agregar con varios tamaños/precios, no solo
  uno; deshabilitar sin borrar; imagen opcional por producto, que reemplaza el
  dibujo tipo "planeta" por una foto real si se carga una), extras para
  hamburguesas (se puede elegir a qué hamburguesas específicas aplica cada
  extra), promociones, y un botón "Vaciar la carta actual" para que una
  pizzería nueva empiece de cero y cargue la suya.
- `/adminPizzeriaPrivado` — el único panel que puede crear, elegir o borrar
  pizzerías (sección "Pizzerías registradas", con el link de cada una). También
  edita, pizzería por pizzería: nombre/marca del negocio, paleta de colores (5
  colores clave), sucursales (agregar/editar/eliminar, no solo Centro/Guadalupe),
  horarios, logo e imagen de fondo de portada.
- Cliente: ícono de perfil (registro de contacto opcional, sin contraseña) y
  ícono de "Mis pedidos" (lista todos los pedidos hechos desde ese navegador,
  con estado en vivo — antes solo se veía el último pedido y los anteriores se
  "perdían", ya corregido).

**Usuarios de prueba de Planeta Pizza** (la pizzería que viene precargada por
defecto, id `planeta`): `admincentro` / `centro2026`, `adminguadalupe` /
`guadalupe2026`, `adminsup` / `sup2026`, `adminpizzeriaprivado` / `privado2026`.
Las pizzerías nuevas que se creen desde `/adminPizzeriaPrivado` generan sus
propias cuentas (contraseña al azar, se muestra una sola vez al crearla).

**Documentos de respaldo:** `plan-paneles-admin.html` (plan original revisado
con el dueño/Juana antes de programar) y `guia-firebase.html` (pasos para cuando
se decida conectar el backend real).

## Pendiente / preguntas para el dueño
- ¿Los precios y la disponibilidad de "Estilo italiano" son realmente solo en Centro,
  o también se puede pedir en Guadalupe?
- Dirección de Guadalupe: el PDF de la carta dice "Av. Gral. Paz 6401", una nota
  propia dice "Gral. Paz 6400" — confirmar el número correcto.
- Zonas de envío fuera de Centro (solo se vio el mapa de delivery de esa sucursal).
- Medios de pago reales que acepta el local.
- ¿Siguen vigentes la promo de 3 sabores y el "Kit Planeta en casa"? ¿Algún límite
  de días/horarios para pedirlos online?
- Confirmar si la paleta bordó/dorado debe ser la identidad oficial del sitio, o
  prefieren ajustarla.
- Backend real (Firebase) para que los pedidos sincronicen entre dispositivos
  distintos, no solo dentro del mismo navegador — ver `guia-firebase.html`.
- Posibles mejoras ya conversadas pero no pedidas todavía: nombres de categorías
  editables (por si otra pizzería no vende las mismas categorías) y el texto fijo
  de la sección "Nuestro proceso" (hoy habla específicamente de Planeta Pizza).

## Cómo seguir trabajando
Todo el proyecto vive en este repo (`C:\Users\usuario\PlanetaPizza` en la máquina
de Juana) — abrir Claude Code ahí, no en otra carpeta. Incluye:
- `prototipo-pedidos.html` + `assets/` (logo, foto de portada) — el sitio.
- `serve.ps1` — servidor local simple (PowerShell, sin Node/Python) para probar
  el sitio en `http://localhost:8123/`.
- `plan-paneles-admin.html` y `guia-firebase.html` — documentos de respaldo del
  sistema de administración y del paso pendiente de Firebase.
- `imagenes/` — material de referencia real del local: logo original, horarios,
  zona de delivery, notas de direcciones, el PDF real de la carta y sus páginas
  renderizadas, y el video de referencia de estructura (`imagenes/video/`).
- `.claude/skills/` — dos skills para no perder el hilo entre sesiones:
  - `/iniciar-sesion` — trae lo último del repo (git pull) y lee este archivo
    para retomar el contexto.
  - `/cerrar-sesion` — guarda este archivo actualizado, commitea y sube los
    cambios al repo.

## Última actualización
2026-11-03

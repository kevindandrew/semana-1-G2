# 📜 LABORATORIO PRÁCTICO: OPERACIONES CRUD, FILTROS Y CICLO DE VIDA

**Módulo:** Bases de Datos Relacionales (PostgreSQL)  
**Temas:** CRUD completo, Filtros (`WHERE`, `AND`, `OR`, `LIKE`, `BETWEEN`, `IN`, `IS NULL`, `ORDER BY`, `LIMIT`), Mutaciones (`UPDATE`), `SOFT DELETE` y `HARD DELETE`.  
**Duración estimada:** 60 minutos cronometrados  
**Modalidad:** Individual  
**Entregable:** Archivo de texto/script `solucion_lab_crud.sql` con cada consulta comentada indicando el número de ejercicio.

---

### ⚠️ REGLA DE ORO DE PRODUCCIÓN

**¡ESTÁ ESTRICTAMENTE PROHIBIDO USAR `DROP TABLE`!**  
Tus tablas anteriores (`cazadores`, `misiones`, `mazmorras`, `expediciones`) contienen datos valiosos. En este laboratorio evolucionaremos esas tablas existentes mediante sentencias `ALTER TABLE` para agregar soporte de borrado lógico.

---

## 🛠️ FASE 1: PREPARACIÓN DE AUDITORÍA Y SOFT DELETE (10 minutos)

Antes de registrar o consultar, debemos preparar nuestras tablas para que soporten borrado lógico (_Soft Delete_).

1. **En la tabla `cazadores`:**
   - Agrega una columna `activo` de tipo `BOOLEAN` con valor por defecto `TRUE`.
   - Agrega una columna `fecha_baja` de tipo `DATE` con valor por defecto `NULL`.

2. **En la tabla `misiones`:**
   - Agrega una columna `estado` de tipo `VARCHAR(25)` con valor por defecto `'DISPONIBLE'`.
   - Agrega una columna `activo` de tipo `BOOLEAN` con valor por defecto `TRUE`.

3. **En la tabla `mazmorras`:**
   - Agrega una columna `operativa` de tipo `BOOLEAN` con valor por defecto `TRUE`.
   - Agrega una columna `ultima_limpieza` de tipo `DATE` con valor por defecto `CURRENT_DATE`.
   - Agrega una columna `fecha_clausura` de tipo `TIMESTAMP` con valor por defecto `NULL`.

4. **En la tabla `expediciones`:**
   - Agrega una columna `estado` de tipo `VARCHAR(25)` con valor por defecto `'EN_CURSO'`.
   - Agrega una columna `activa` de tipo `BOOLEAN` con valor por defecto `TRUE`.

---

## 📥 FASE 2: CREATE - INYECCIÓN DE REGISTROS (10 minutos)

Para poder realizar filtros exigentes, necesitamos volumen de datos en **ambos** mundos. Realiza las siguientes inserciones:

1. **Cazadores:** Inserta 4 cazadores nuevos en un solo comando `INSERT`:
   - Uno de rango `'S'`, nivel `85`, apodo `'Sombra_Nocturna'`.
   - Uno de rango `'A'`, nivel `60`, apodo `'Cazador_X'`.
   - Uno de rango `'B'`, nivel `35`, apodo `'Arquero_Verde'`.
   - Uno de rango `'Novato'`, nivel `12`, apodo `'Aprendiz_Lobo'`.
   - _Nota:_ Asegúrate de incluir emails válidos y únicos según tus constraints previos.

2. **Misiones:** Inserta 4 nuevas misiones:
   - 2 misiones con recompensa alta (más de 500 de oro) asignadas a IDs de cazadores existentes.
   - 1 misión con recompensa modesta (menos de 150 de oro) asignada a un cazador novato.
   - 1 misión con título `'Cacería del Dragón Oculto'`, recompensa `1500`, pero sin cazador asignado (`id_cazador = NULL`).

3. **Mazmorras:** Inserta 4 mazmorras nuevas:
   - Mazmorra `'Cripta Maldita'`, región `'Tierras Altas'`, rango `'S'`, profundidad `15` pisos.
   - Mazmorra `'Caverna Rocosa'`, región `'Valle Sombrío'`, rango `'B'`, profundidad `6` pisos.
   - Mazmorra `'Templo Sumergido'`, región `'Costas Negras'`, rango `'A'`, profundidad `10` pisos.
   - Mazmorra `'Túnel Abandonado'`, región `'Valle Sombrío'`, rango `'D'`, profundidad `3` pisos.

4. **Expediciones:** Inserta 4 expediciones asociadas:
   - 2 expediciones con `duracion_horas` de `24` y `48` asignadas a alguna de las mazmorras anteriores.
   - 1 expedición con `duracion_horas` de `6` horas en estado `'EN_CURSO'`.
   - 1 expedición exploratoria libre con `id_mazmorra = NULL` (patrulla sin destino asignado).

---

## 🔍 FASE 3: READ - LABORATORIO DE FILTROS BÁSICOS (20 minutos)

_(Recuerda: **NO uses JOINs**. Cada consulta se ejecuta contra una sola tabla a la vez)._

### Parte A: Consultas del Gremio (Cazadores y Misiones)

1. **Filtro numérico (`BETWEEN`):** Muestra apodo, nivel y rango de los cazadores cuyo nivel esté entre `30` y `70`.
2. **Opciones múltiples (`IN`):** Muestra todos los datos de los cazadores cuyo rango sea `'S'`, `'A'` o `'Veterano'`.
3. **Búsqueda por patrón (`LIKE` / `ILIKE`):** Muestra los cazadores cuyo apodo empiece con `'A'` o contenga un guion bajo `'_'`.
4. **Condiciones mixtas (`AND`, `OR`):** Encuentra a los cazadores que tengan nivel mayor a `40` **Y** rango `'A'`, **O** bien cuyo nivel sea mayor o igual a `80`.
5. **Top de poder (`ORDER BY`, `LIMIT`):** Obtén el Top 3 de cazadores con mayor nivel, ordenados de mayor a menor.
6. **Misiones sin asignar (`IS NULL`):** Consulta el título y recompensa de las misiones huérfanas (`id_cazador IS NULL`).
7. **Patrón de texto final:** Lista las misiones cuyo título termine en `'Oculto'` o contenga la palabra `'Dragón'`.

### Parte B: Consultas de Exploración (Mazmorras y Expediciones)

8. **Profundidad peligrosa (`BETWEEN` / operadores):** Muestra nombre, región y profundidad de las mazmorras que tengan entre `5` y `12` pisos de profundidad.
9. **Descarte de rangos (`NOT IN`):** Muestra todas las mazmorras cuyo rango de peligro **NO** sea ni `'C'` ni `'D'`.
10. **Búsqueda por región (`ILIKE`):** Encuentra las mazmorras cuya región contenga la palabra `'Sombrío'` o `'Valle'`.
11. **Top de Mazmorras profundas:** Muestra las 2 mazmorras más profundas registradas en el sistema ordenadas de forma descendente.
12. **Expediciones largas (`AND`):** Consulta las expediciones cuya duración sea mayor a `12` horas **Y** cuyo estado sea `'EN_CURSO'`.
13. **Expediciones sin rumbo (`IS NULL`):** Muestra el código de misión y duración de las expediciones que no tengan mazmorra vinculada (`id_mazmorra IS NULL`).
14. **Expediciones con asignación (`IS NOT NULL`):** Lista el código de misión y el `id_mazmorra` de todas las expediciones asignadas formalmente.

---

## ✏️ FASE 4: UPDATE - MUTACIONES EN AMBOS MUNDOS (10 minutos)

> 🛑 **Regla de supervivencia:** ¡Jamás ejecutes un `UPDATE` sin la cláusula `WHERE`!

### Actualizaciones en el Gremio:

1. **Bono de emergencia:** Aumenta en `100` de oro la recompensa de todas las misiones que ofrezcan menos de `300` de oro.
2. **Promoción de cazador:** Sube en `10` niveles al cazador `'Aprendiz_Lobo'`.
3. **Asignación de contrato:** Toma la misión `'Cacería del Dragón Oculto'`, asígnala al ID de tu cazador más fuerte y cambia su `estado` a `'EN_PROCESO'`.

### Actualizaciones en Mazmorras y Expediciones:

4. **Derrumbe de niveles:** Incrementa en `2` pisos la profundidad (`piso_profundidad = piso_profundidad + 2`) de la mazmorra `'Cripta Maldita'`.
5. **Completar incursión:** Busca una expedición por su código o ID y cambia su `estado` de `'EN_CURSO'` a `'COMPLETADA'`.
6. **Mantenimiento regional:** Actualiza la fecha de `ultima_limpieza` a `CURRENT_DATE` para todas las mazmorras ubicadas en la región `'Valle Sombrío'`.
7. **Rumbo fijado:** Modifica la expedición que tenía `id_mazmorra IS NULL` y asígnale el ID de la `'Caverna Rocosa'`.

---

## 🗑️ FASE 5: SOFT DELETE VS. HARD DELETE (10 minutos)

Aquí pondrán a prueba ambos métodos tanto en el Gremio como en las Mazmorras.

### 5.1: Soft Delete (Borrado Lógico)

#### En Cazadores:

1. Aplica Soft Delete a `'Sombra_Nocturna'`: pon `activo = FALSE` y `fecha_baja = CURRENT_DATE`.
2. Haz un `SELECT` con `WHERE activo = TRUE` y comprueba que ya no sale en el padrón activo.
3. Haz un `SELECT` con `WHERE activo = FALSE` y comprueba que sigue existiendo en el archivo de bajas.

#### En Mazmorras:

4. La mazmorra `'Túnel Abandonado'` ha colapsado por completo. Aplica Soft Delete: cambia `operativa = FALSE` y `fecha_clausura = CURRENT_TIMESTAMP`.
5. Haz un `SELECT` de mazmorras con `WHERE operativa = TRUE` (comprueba que los exploradores ya no la ven).
6. Haz un `SELECT` de auditoría con `WHERE operativa = FALSE` demostrando que el registro de la mazmorra no se destruyó.

### 5.2: Hard Delete (Purga Física Definitiva)

#### En Misiones:

1. Elimina físicamente una misión que no tenga cazador asignado o una misión de prueba mediante:  
   `DELETE FROM misiones WHERE id = ...;`
2. Ejecuta un `SELECT` buscando ese ID para confirmar que el motor devolvió `0` filas.

#### En Expediciones:

3. Elimina físicamente una expedición de prueba errónea usando:  
   `DELETE FROM expediciones WHERE id = ...;`
4. Comprueba con un `SELECT` que dicha fila desapareció de forma irreversible del almacenamiento.

### 5.3: Pregunta de Análisis Técnico (Comentario en el script)

- ¿Qué diferencia de seguridad para una empresa existe entre marcar una mazmorra como `operativa = FALSE` frente a ejecutar un `DELETE FROM mazmorras WHERE id = ...`?

---

### 📋 CHECKLIST FINAL DE ENTREGA

- [ ] No usé ningún `DROP TABLE`.
- [ ] No usé ningún comando `JOIN`.
- [ ] Practiqué filtros en `cazadores`, `misiones`, `mazmorras` y `expediciones`.
- [ ] Todos mis `UPDATE` y `DELETE` tienen cláusula `WHERE`.
- [ ] Comprobé la diferencia entre borrado lógico (`UPDATE`) y borrado físico (`DELETE`).

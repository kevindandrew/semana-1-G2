# ⚔️ PRÁCTICA DE LABORATORIO: SISTEMA DE GREMIO DE CAZADORES

**Módulo:** Bases de Datos Relacionales (PostgreSQL)  
**Temas:** DDL (`CREATE`, `ALTER`, `CONSTRAINTS`), Integridad Referencial e Inserción (`INSERT`)  
**Modalidad:** Individual | **Tiempo estimado:** 60 minutos  
**Entregable:** Archivo script `practica_ddl_gremio.sql` ejecutable de principio a fin sin errores.

---

### OBJETIVO

Construir y evolucionar un esquema de base de datos relacional para el gremio de cazadores, aplicando restricciones de integridad en tablas existentes e insertando registros coherentes.

---

### MISIÓN 1: Creación del Esquema Base (`CREATE TABLE`)

Crear las siguientes dos tablas en su versión inicial:

1. **Tabla `cazadores`**:
   - `id`: Identificador autoincremental (`SERIAL`), clave primaria (`PRIMARY KEY`).
   - `apodo`: Texto de hasta 80 caracteres (`VARCHAR(80)`), obligatorio (`NOT NULL`).
   - `rango`: Texto de hasta 20 caracteres (`VARCHAR(20)`).

2. **Tabla `misiones`**:
   - `id`: Identificador autoincremental (`SERIAL`), clave primaria (`PRIMARY KEY`).
   - `titulo`: Texto de hasta 120 caracteres (`VARCHAR(120)`), obligatorio (`NOT NULL`).
   - `recompensa_oro`: Número entero (`INT`).

---

### MISIÓN 2: Evolución del Esquema (`ALTER TABLE`)

Sin destruir ni volver a crear las tablas, ejecutar las siguientes modificaciones:

1. **En la tabla `cazadores`**:
   - Agregar columna `email` (`VARCHAR(120)`).
   - Agregar columna `nivel` (`INT`) con valor predeterminado `1`.
   - Establecer una restricción de unicidad (`UNIQUE`) sobre la columna `email`.
   - Agregar una restricción `CHECK` para asegurar que `nivel` esté entre 1 y 100.

2. **En la tabla `misiones`**:
   - Modificar la columna `titulo` para que admita hasta 200 caracteres (`VARCHAR(200)`).
   - Agregar una restricción `CHECK` para que `recompensa_oro` sea estrictamente mayor a 0 (`recompensa_oro > 0`).
   - Agregar columna `id_cazador` (`INT`).
   - Crear la clave foránea (`FOREIGN KEY`) que vincule `misiones.id_cazador` con `cazadores.id`, aplicando la regla `ON DELETE SET NULL`.

---

### MISIÓN 3: Carga de Datos (`INSERT INTO`)

1. **Registrar al menos 3 cazadores** con sus datos completos (apodo, rango, nivel y email único).
2. **Registrar al menos 4 misiones**:
   - 2 misiones asignadas a diferentes cazadores.
   - 1 misión asignada a uno de los cazadores anteriores (demostrando relación 1:N).
   - 1 misión sin cazador asignado (`NULL`).

---

### MISIÓN 4: Pruebas de Integridad (Laboratorio de Errores)

Al final del script, incluir en comentarios (`--`) dos sentencias `INSERT` que fallen intencionalmente, indicando la causa:

1. Un `INSERT` que viole la restricción `CHECK` (oro negativo/cero o nivel fuera de rango).
2. Un `INSERT` que intente asignar una misión a un `id_cazador` inexistente (violación de `FOREIGN KEY`).

---

### MISIÓN 5: Consulta de Verificación

Escribir una consulta con `JOIN` que liste:

- Título de la misión.
- Recompensa en oro.
- Apodo del cazador asignado (o la leyenda `'Disponible'` en caso de misiones sin asignar).

---

**Criterios de Evaluación:** Sintaxis limpia, nombres consistentes en constraints, orden correcto de ejecución y manejo estricto de tipos de datos.

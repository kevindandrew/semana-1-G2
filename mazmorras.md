# 🗝️ PRÁCTICA DE LABORATORIO: SISTEMA DE EXPEDICIONES EN MAZMORRAS

**Módulo:** Bases de Datos Relacionales (PostgreSQL)  
**Temas:** DDL (`CREATE`, `ALTER`, `CONSTRAINTS`), Integridad Referencial e Inserción (`INSERT`)  
**Modalidad:** Individual | **Tiempo estimado:** 60 minutos  
**Entregable:** Archivo script `practica_mazmorras_ddl.sql` ejecutable secuencialmente sin errores.

---

### OBJETIVO

Desarrollar y refactorizar el esquema de base de datos para la gestión y exploración de mazmorras prohibidas, asegurando la consistencia de los datos mediante restricciones a nivel de motor.

---

### ETAPA 1: Creación del Esquema Inicial (`CREATE TABLE`)

Crear las siguientes dos tablas en su diseño base:

1. **Tabla `mazmorras`**:
   - `id`: Identificador autoincremental (`SERIAL`), clave primaria (`PRIMARY KEY`).
   - `nombre`: Texto de hasta 80 caracteres (`VARCHAR(80)`), obligatorio (`NOT NULL`).
   - `region`: Texto de hasta 50 caracteres (`VARCHAR(50)`).

2. **Tabla `expediciones`**:
   - `id`: Identificador autoincremental (`SERIAL`), clave primaria (`PRIMARY KEY`).
   - `codigo_mision`: Texto de hasta 40 caracteres (`VARCHAR(40)`), obligatorio (`NOT NULL`).
   - `duracion_horas`: Número entero (`INT`).

---

### ETAPA 2: Evolución con DDL (`ALTER TABLE`)

El Consejo Arcano exige normativas más estrictas para autorizar exploraciones. Aplicar las siguientes modificaciones **únicamente mediante sentencias `ALTER TABLE`**:

1. **En la tabla `mazmorras`**:
   - Agregar columna `rango_peligro` (`VARCHAR(10)`) con valor predeterminado `'C'`.
   - Agregar columna `piso_profundidad` (`INT`).
   - Establecer restricción de unicidad (`UNIQUE`) sobre el `nombre` de la mazmorra.
   - Agregar restricción `CHECK` para que `piso_profundidad` sea un valor positivo mayor a 0 (`piso_profundidad > 0`).

2. **En la tabla `expediciones`**:
   - Modificar la columna `codigo_mision` para ampliar su tamaño a 100 caracteres (`VARCHAR(100)`).
   - Agregar columna `objetivo` de tipo texto libre (`TEXT`).
   - Agregar restricción `CHECK` para que `duracion_horas` esté en un rango válido entre 1 y 72 horas.
   - Agregar columna `id_mazmorra` (`INT`).
   - Crear la clave foránea (`FOREIGN KEY`) conectando `expediciones.id_mazmorra` con `mazmorras.id`, con la regla `ON DELETE SET NULL`.

---

### ETAPA 3: Carga de Datos (`INSERT INTO`)

1. **Registrar al menos 3 mazmorras** con nombre, región, rango de peligro y profundidad.
2. **Registrar al menos 4 expediciones**:
   - 2 expediciones asignadas a diferentes mazmorras.
   - 1 expedición asignada a una mazmorra que ya tenga otra incursión activa (relación 1:N).
   - 1 expedición de patrulla o reconocimiento sin mazmorra asignada aún (`NULL`).

---

### ETAPA 4: Auditoría de Integridad (Inserciones Fallidas)

Escribir al final del archivo dos sentencias `INSERT` comentadas (`--`) explicando la regla que impide su ejecución:

1. Una inserción que viole el `CHECK` (por ejemplo, una mazmorra con piso `0` o una expedición de `100` horas).
2. Una inserción de una expedición apuntando a un `id_mazmorra` inexistente (violación de `FOREIGN KEY`).

---

### ETAPA 5: Consulta de Monitoreo (`JOIN`)

Escribir una consulta con `JOIN` que liste:

- El código de la misión.
- El objetivo y la duración en horas.
- El nombre y la región de la mazmorra asignada (o la leyenda `'Expedición Libre / Sin Rumbo'` si no tiene mazmorra vinculada).

---

**Criterios de Evaluación:** Creación sin fallos, nombres descriptivos en constraints, orden correcto de operaciones DDL y ausencia de sentencias `DROP` a mitad del script.

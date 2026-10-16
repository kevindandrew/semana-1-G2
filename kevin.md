# ENTIDADES

MASCOTAS, DUEÑO

## Entity: MASCOTA

| Atributo | Tipo          | Notas       |
| -------- | ------------- | ----------- |
| id       | Número Entero | [PK]        |
| nombre   | Texto         | Obligatorio |
| especie  | Texto         | Obligatorio |
| raza     | Texto         | opcional    |
| edad     | Número Entero | Obligatorio |

## Entity: DUEÑO

| Atributo | Tipo          | Notas       |
| -------- | ------------- | ----------- |
| id       | Número Entero | [PK]        |
| nombre   | Texto         | Obligatorio |
| carnet   | Texto         | Obligatorio |
| celular  | Número Entero | opcional    |
| edad     | Número Entero | Obligatorio |

# Relaciones

una mascota puede tener solo un dueño
pero un dueño puede tener muchas mascotas

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ap_paterno VARCHAR(100) NOT NULL,
    celular VARCHAR(100) NOT NULL
)

CREATE TABLE evento (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    cant_per INT NOT NULL CHECK (cant_per > 0),
    lugar VARCHAR(200),
    id_cliente INT NOT NULL,
    CONSTRAINT fk_cliente_evento
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id)
)

CREATE TABLE proveedor(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ap_paterno VARCHAR(100) NOT NULL,
    celular VARCHAR(100) NOT NULL
)

CREATE TABLE servicio(
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(150) NOT NULL,
    costo DECIMAL(9,2) NOT NULL CHECK (costo > 0),
    id_proveedor  INT NOT NULL,
    CONSTRAINT fk_servicio_proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES proveedor(id)
)

CREATE TABLE contrato_servicio(
    id SERIAL PRIMARY KEY,
    costo DECIMAL(9,2) NOT NULL CHECK (costo > 0),
    fecha DATE NOT NULL,
    pagado BOOLEAN DEFAULT ('FALSE'),
    monto_deuda DECIMAL(9,2) NOT NULL CHECK (monto_deuda >= 0),
    id_evento INT NOT NULL,
    CONSTRAINT fk_contrato_evento
    FOREIGN KEY (id_evento)
    REFERENCES evento(id),
    id_servicio INT NOT NULL,
     CONSTRAINT fk_contrato_servicio
    FOREIGN KEY (id_servicio)
    REFERENCES servicio(id)
)

CREATE TABLE pagos (
     id SERIAL PRIMARY KEY,
     cantidad_pagada DECIMAL(9,2) NOT NULL CHECK (cantidad_pagada > 0),
     id_contrato INT NOT NULL,
     CONSTRAINT fk_pagos_contrato
    FOREIGN KEY (id_contrato)
    REFERENCES contrato_servicio(id)
)

CREATE TABLE trabajador(
     id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ap_paterno VARCHAR(100) NOT NULL,
    celular VARCHAR(100) NOT NULL
)

CREATE TABLE asistencia(
   id SERIAL PRIMARY KEY,
   id_evento INT NOT NULL,
   CONSTRAINT fk_asistencia_evento
    FOREIGN KEY (id_evento)
    REFERENCES evento(id),
    id_trabajador INT NOT NULL,
     CONSTRAINT fk_asistencia_trabajador
    FOREIGN KEY (id_trabajador)
    REFERENCES trabajador(id)
)
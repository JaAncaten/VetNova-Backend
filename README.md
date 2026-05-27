# VetNova Backend - Sistema de Clínica Veterinaria con Microservicios

## Descripción del proyecto

VetNova Backend es un sistema desarrollado para una clínica veterinaria utilizando arquitectura de microservicios.

El objetivo del proyecto es permitir la gestión de usuarios, mascotas, citas, atenciones veterinarias, fichas clínicas, catálogo de productos, inventario, ventas, pagos, soporte, valoraciones y notificaciones.

El sistema fue desarrollado como parte de la asignatura Desarrollo FullStack 1, aplicando arquitectura distribuida, persistencia de datos, endpoints REST, seguridad con JWT, control de roles y comunicación entre microservicios.

---

## Integrantes

- Javier Ancaten Gavilan
- Nose si esta vivo 
- Nose si esta vivo x2

---

## Arquitectura del sistema

El proyecto está basado en una arquitectura de microservicios.

Cada microservicio posee una responsabilidad específica, su propia base de datos y se comunica con otros servicios mediante APIs REST.

El acceso principal al sistema se realiza mediante un API Gateway:

```txt
http://localhost:8090
```

El Gateway permite centralizar las peticiones hacia los diferentes microservicios.

---

## Tecnologías utilizadas

- Java 25
- Spring Boot
- Spring Web
- Spring Data JPA
- Spring Security
- JWT
- MySQL
- Maven
- Spring Cloud Gateway
- Git y GitHub
- Git Submodules
- Postman
- XAMPP / phpMyAdmin
- Visual Studio Code

---

## Microservicios implementados

| Microservicio | Puerto | Función principal |
|---|---:|---|
| Auth_Service | 8084 | Registro, login, generación de JWT y roles |
| Usuario_Service | 8081 | Gestión de perfiles de usuario |
| Mascota_Service | 8082 | Gestión de mascotas |
| Atencion_Service | 8083 | Registro de atenciones veterinarias |
| Agenda_Service | 8085 | Gestión de citas veterinarias |
| FichaClinica_Service | 8086 | Gestión de fichas clínicas |
| Catalogo_Service | 8087 | Gestión del catálogo de productos |
| Inventario_Service | 8088 | Control de stock e inventario |
| Ventas_Service | 8089 | Gestión de ventas y detalle de venta |
| Pago_Service | 8091 | Registro de pagos |
| Soporte_Service | 8092 | Gestión de solicitudes de soporte |
| Valoracion_Service | 8093 | Gestión de valoraciones de clientes |
| Notificacion_Service | 8094 | Gestión de notificaciones |
| Gateway_Service | 8090 | Entrada única al sistema |

---

## Bases de datos

Cada microservicio utiliza su propia base de datos MySQL.

| Microservicio | Base de datos |
|---|---|
| Auth_Service | vetnova_auth_db |
| Usuario_Service | vetnova_usuario_db |
| Mascota_Service | vetnova_mascota_db |
| Atencion_Service | vetnova_atencion_db |
| Agenda_Service | vetnova_agenda_db |
| FichaClinica_Service | vetnova_fichaclinica_db |
| Catalogo_Service | vetnova_catalogo_db |
| Inventario_Service | vetnova_inventario_db |
| Ventas_Service | vetnova_ventas_db |
| Pago_Service | vetnova_pago_db |
| Soporte_Service | vetnova_soporte_db |
| Valoracion_Service | vetnova_valoracion_db |
| Notificacion_Service | vetnova_notificacion_db |

Esta separación permite mantener independencia entre microservicios y aplicar persistencia real de datos mediante JPA, Hibernate y MySQL.

---

## Patrón de arquitectura aplicado

Cada microservicio fue organizado siguiendo el patrón:

```txt
Controller → Service → Repository → Model
```

### Controller

Recibe las solicitudes HTTP y expone los endpoints REST.

### Service

Contiene la lógica de negocio del microservicio.

### Repository

Permite el acceso a la base de datos mediante JpaRepository.

### Model

Representa las entidades persistentes del sistema mediante JPA.

---

## Seguridad

El sistema utiliza autenticación con JWT.

### Flujo de seguridad

1. El usuario se registra en Auth_Service.
2. El usuario inicia sesión.
3. Auth_Service genera un token JWT.
4. El token se envía en cada petición protegida.
5. Cada microservicio valida el token.
6. Según el rol del usuario, se permite o bloquea el acceso.

Formato del header:

```txt
Authorization: Bearer TOKEN
```

---

## Roles del sistema

| Rol | Permisos principales |
|---|---|
| ADMIN | Acceso completo al sistema |
| CLIENTE | Mascotas, citas, ventas, pagos, soporte, valoraciones y notificaciones |
| VETERINARIO | Agenda, atenciones y ficha clínica |
| BODEGA | Inventario |
| RECEPCIONISTA | Agenda, ventas y pagos |
| SOPORTE | Soporte y notificaciones |

---

## Rutas principales por Gateway

Todas las rutas principales se consumen desde:

```txt
http://localhost:8090
```

| Ruta | Microservicio |
|---|---|
| /api/auth | Auth_Service |
| /api/usuarios | Usuario_Service |
| /api/mascotas | Mascota_Service |
| /api/atenciones | Atencion_Service |
| /api/citas | Agenda_Service |
| /api/fichas-clinicas | FichaClinica_Service |
| /api/productos | Catalogo_Service |
| /api/inventarios | Inventario_Service |
| /api/ventas | Ventas_Service |
| /api/detalles-venta | Ventas_Service |
| /api/pagos | Pago_Service |
| /api/soporte | Soporte_Service |
| /api/valoraciones | Valoracion_Service |
| /api/notificaciones | Notificacion_Service |

---

## Automatizaciones implementadas

### 1. Creación automática de perfil de usuario

Cuando se registra un usuario en Auth_Service, se crea automáticamente un perfil asociado en Usuario_Service.

Flujo:

```txt
Auth_Service registra usuario
↓
Auth_Service guarda correo, password y rol
↓
Auth_Service llama a Usuario_Service
↓
Usuario_Service crea perfil con datos personales
```

Esto permite separar autenticación y perfil de usuario.

---

### 2. Pago automático de venta

Cuando se registra un pago con estado:

```txt
PAGADO
```

Pago_Service se comunica automáticamente con Ventas_Service y cambia la venta asociada a:

```txt
PAGADA
```

Flujo:

```txt
Pago_Service registra pago
↓
Pago_Service llama a Ventas_Service
↓
Ventas_Service actualiza estado de venta
```

---

### 3. Descuento automático de stock

Cuando se registra un DetalleVenta, Ventas_Service se comunica automáticamente con Inventario_Service para descontar el stock del producto vendido.

Ejemplo:

```txt
Stock inicial: 50
Cantidad vendida: 2
Stock final: 48
```

Si no existe stock suficiente, el sistema no permite registrar el detalle de venta.

---

## Comunicación entre microservicios

El proyecto implementa comunicación entre microservicios mediante consumo de endpoints REST con RestTemplate.

| Servicio origen | Servicio destino | Propósito |
|---|---|---|
| Auth_Service | Usuario_Service | Crear perfil al registrar usuario |
| Pago_Service | Ventas_Service | Actualizar venta a PAGADA |
| Ventas_Service | Inventario_Service | Descontar stock al crear detalle de venta |

---

## Reglas de negocio implementadas

- Un usuario registrado en Auth crea automáticamente un perfil en Usuario.
- El login genera un JWT con correo y rol.
- Los microservicios validan el JWT antes de permitir el acceso.
- Los roles limitan el acceso a funcionalidades específicas.
- Un pago con estado PAGADO actualiza la venta a PAGADA.
- Un detalle de venta descuenta stock automáticamente.
- No se permite registrar un detalle de venta si no hay stock suficiente.
- El inventario cambia de estado según su stock:
  - DISPONIBLE
  - BAJO_STOCK
  - SIN_STOCK

---

## Ejecución del sistema

### 1. Clonar el repositorio

Como el proyecto usa submódulos, se debe clonar con:

```bash
git clone --recurse-submodules https://github.com/JaAncaten/VetNova-Backend.git
```

Si se clona sin submódulos, ejecutar:

```bash
git submodule update --init --recursive
```

---

### 2. Iniciar MySQL

Abrir XAMPP e iniciar:

```txt
MySQL
```

Verificar que MySQL esté corriendo en el puerto:

```txt
3306
```

---

### 3. Crear bases de datos

Desde phpMyAdmin o consola SQL, crear las bases necesarias:

```sql
CREATE DATABASE IF NOT EXISTS vetnova_auth_db;
CREATE DATABASE IF NOT EXISTS vetnova_usuario_db;
CREATE DATABASE IF NOT EXISTS vetnova_mascota_db;
CREATE DATABASE IF NOT EXISTS vetnova_atencion_db;
CREATE DATABASE IF NOT EXISTS vetnova_agenda_db;
CREATE DATABASE IF NOT EXISTS vetnova_fichaclinica_db;
CREATE DATABASE IF NOT EXISTS vetnova_catalogo_db;
CREATE DATABASE IF NOT EXISTS vetnova_inventario_db;
CREATE DATABASE IF NOT EXISTS vetnova_ventas_db;
CREATE DATABASE IF NOT EXISTS vetnova_pago_db;
CREATE DATABASE IF NOT EXISTS vetnova_soporte_db;
CREATE DATABASE IF NOT EXISTS vetnova_valoracion_db;
CREATE DATABASE IF NOT EXISTS vetnova_notificacion_db;
```

---

### 4. Ejecutar los microservicios

Desde la carpeta principal del proyecto se puede utilizar:

```txt
iniciar-servicios.bat
```

Este archivo inicia los microservicios en ventanas CMD separadas.

---

### 5. Cerrar los microservicios

Se pueden cerrar manualmente las ventanas CMD o utilizar:

```txt
cerrar-servicios.bat
```

---

## Pruebas principales en Postman

### Registro de usuario completo

```http
POST http://localhost:8090/api/auth/registro
```

```json
{
  "nombre": "Carlos",
  "apellido": "Muñoz",
  "rut": "11111111-1",
  "correo": "cliente5@vetnova.cl",
  "password": "123456",
  "telefono": "912345678",
  "direccion": "Concepción",
  "rol": "CLIENTE"
}
```

Resultado esperado:

- Se guarda en vetnova_auth_db.
- Se crea perfil en vetnova_usuario_db.

---

### Login

```http
POST http://localhost:8090/api/auth/login
```

```json
{
  "correo": "cliente5@vetnova.cl",
  "password": "123456"
}
```

Resultado esperado:

```json
{
  "token": "TOKEN_JWT",
  "tipo": "Bearer"
}
```

---

### Crear mascota

```http
POST http://localhost:8090/api/mascotas
```

```json
{
  "nombre": "Milo",
  "especie": "Gato",
  "raza": "Siamés",
  "edad": 2,
  "peso": 4.3,
  "usuarioId": 1
}
```

---

### Crear venta

```http
POST http://localhost:8090/api/ventas
```

```json
{
  "usuarioId": 1,
  "fechaVenta": "2026-05-26",
  "total": 49980,
  "metodoPago": "TARJETA",
  "estado": "PENDIENTE"
}
```

---

### Crear pago

```http
POST http://localhost:8090/api/pagos
```

```json
{
  "ventaId": 1,
  "metodoPago": "TARJETA",
  "monto": 49980,
  "estado": "PAGADO",
  "fechaPago": "2026-05-26",
  "referencia": "TXN-001"
}
```

Resultado esperado:

```txt
La venta asociada cambia automáticamente a PAGADA.
```

---

### Crear inventario

```http
POST http://localhost:8090/api/inventarios
```

```json
{
  "productoId": 1,
  "stockActual": 50,
  "stockMinimo": 10,
  "ubicacion": "Bodega central",
  "estado": "DISPONIBLE",
  "fechaActualizacion": "2026-05-26"
}
```

---

### Crear detalle de venta

```http
POST http://localhost:8090/api/detalles-venta
```

```json
{
  "ventaId": 1,
  "productoId": 1,
  "cantidad": 2,
  "precioUnitario": 24990
}
```

Resultado esperado:

```txt
El stock del producto disminuye automáticamente.
```

---

## Pruebas de roles

### CLIENTE

Permitido:

```txt
/api/mascotas
/api/citas
/api/ventas
/api/pagos
/api/soporte
/api/valoraciones
/api/notificaciones
```

Bloqueado:

```txt
/api/inventarios
/api/fichas-clinicas
/api/atenciones
```

---

### VETERINARIO

Permitido:

```txt
/api/citas
/api/atenciones
/api/fichas-clinicas
```

Bloqueado:

```txt
/api/inventarios
/api/pagos
/api/ventas
```

---

### BODEGA

Permitido:

```txt
/api/inventarios
```

Bloqueado:

```txt
/api/pagos
/api/ventas
/api/fichas-clinicas
```

---

### RECEPCIONISTA

Permitido:

```txt
/api/citas
/api/ventas
/api/pagos
```

Bloqueado:

```txt
/api/inventarios
/api/fichas-clinicas
/api/atenciones
```

---

### SOPORTE

Permitido:

```txt
/api/soporte
/api/notificaciones
```

Bloqueado:

```txt
/api/inventarios
/api/ventas
/api/pagos
```

---

### ADMIN

Permitido:

```txt
Acceso completo a todos los servicios.
```

---

## Estado actual del proyecto

El sistema cuenta con:

- Más de 10 microservicios funcionales.
- Persistencia real con MySQL.
- Arquitectura organizada por capas.
- API Gateway.
- Autenticación con JWT.
- Autorización por roles.
- CRUD funcional en los microservicios.
- Comunicación entre microservicios.
- Automatización de pago y stock.
- Repositorio GitHub con submódulos.
- Pruebas realizadas en Postman.

---

## Pendientes y mejoras futuras

- Implementar Docker Compose.
- Implementar Swagger/OpenAPI.
- Agregar ControllerAdvice global en todos los servicios.
- Mejorar ResponseEntity en todos los endpoints.
- Agregar más validaciones con Bean Validation.
- Encriptar contraseñas con BCrypt.
- Implementar Reportes_Service.
- Implementar Sucursales_Service.
- Implementar boleta o comprobante automático.
- Agregar logs estructurados con SLF4J en todos los servicios.

---

## Evidencias recomendadas para defensa

Durante la defensa técnica se recomienda demostrar:

1. Login y generación de JWT.
2. Acceso permitido y denegado según roles.
3. Registro de usuario y creación automática de perfil.
4. Creación de mascota.
5. Creación de venta.
6. Registro de pago y cambio automático de venta a PAGADA.
7. Creación de detalle de venta y descuento automático de stock.
8. Persistencia de datos en MySQL.
9. Código organizado en Controller, Service, Repository y Model.
10. Commits y submódulos en GitHub.

# casino-backend

API principal del **Casino Online** — asignatura **Introducción a Herramientas
DevOps (ISY1101)**. Node.js + Express con PostgreSQL. Emite el **JWT** (HS256)
que validan los demás microservicios, y gestiona auth, juegos, saldo y
transacciones.

## Stack
- Node.js 20 · Express 4
- PostgreSQL 16 (`pg`)
- JWT (`jsonwebtoken`) + `bcryptjs`
- Pruebas: **Jest**

## Variables de entorno (12-factor)
| Variable | Default | Descripción |
|---|---|---|
| `PORT` | `3000` | Puerto HTTP |
| `JWT_SECRET` | `cambiame` | Secreto de firma JWT (compartido con los microservicios) |
| `JWT_EXPIRES_IN` | `8h` | Vigencia del token |
| `DB_HOST` / `DB_PORT` | `localhost` / `5432` | PostgreSQL |
| `DB_USER` / `DB_PASSWORD` / `DB_NAME` | `casino` / `casino` / `casino_db` | Credenciales BD |
| `CORS_ORIGIN` | `*` | Orígenes permitidos (CSV) |

Copia `.env.example` a `.env` y ajusta.

## Endpoints
| Método | Ruta | Descripción |
|---|---|---|
| POST | `/api/auth/register` · `/api/auth/login` | Registro / login (devuelve JWT) |
| GET | `/api/usuarios/me` | Datos y saldo del usuario |
| POST | `/api/usuarios/me/depositar` | Recarga de saldo demo |
| GET | `/api/transacciones?limit=50` | Historial del usuario |
| GET | `/api/juegos` | Catálogo de juegos |
| POST | `/api/juegos/slots/jugar` · `/roulette/jugar` · `/blackjack/iniciar` · `/blackjack/accion` | Jugar |
| GET | `/livez` | Liveness (proceso vivo) |
| GET | `/readyz` | Readiness (verifica BD; 200/503) |

> Las sondas `/livez` y `/readyz` están incluidas como **referencia** de cómo
> distinguir liveness de readiness en Kubernetes.

## Usuarios demo (sembrados al arrancar)
| username | password | rol |
|---|---|---|
| `demo` | `demo1234` | jugador |
| `jugador1` | `demo1234` | jugador |
| `admin` | `admin1234` | admin |

## Ejecutar en local
Requisitos: Node 20 y un PostgreSQL accesible.
```bash
cp .env.example .env
npm ci          # instala dependencias desde package-lock.json
npm start       # API en http://localhost:3000
```

## Pruebas
Este repo **ya incluye pruebas unitarias** (Jest) de la lógica de juegos y del
middleware de autenticación:
```bash
npm ci
npm test
```

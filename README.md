# Lab08_Multiplataforma

Aplicacion multiplataforma desarrollada en Flutter para gestionar productos con un flujo simple de inicio de sesion, menu principal, registro, listado, perfil y cierre de sesion.

## Funcionalidades

- Login con validacion de email y password.
- Menu principal con accesos a las vistas de la aplicacion.
- Registro de productos con 5 campos: marca, nombre, categoria, precio y stock.
- Lista de productos implementada con `ListView`.
- Perfil de usuario con datos mostrados en labels.
- Pantalla de salida para cerrar sesion y volver al login.

## Tecnologias

- Flutter
- Dart
- Material Design

## Ejecutar el proyecto

Primero instala las dependencias:

```bash
flutter pub get
```

Para correrlo en Chrome:

```bash
flutter run -d chrome
```

Para correrlo en un emulador o dispositivo movil:

```bash
flutter devices
flutter run -d <device_id>
```

## Estructura principal

- `lib/main.dart`: configuracion principal de la aplicacion y rutas.
- `lib/screens/login_screen.dart`: pantalla de inicio de sesion.
- `lib/screens/home_screen.dart`: menu, registro, lista, perfil y salida.
- `lib/models/product.dart`: modelo de producto.
- `lib/app_theme.dart`: tema visual de la aplicacion.

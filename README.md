# Reto Automatización QA - Backend (Karate DSL)

## Descripción

Este proyecto contiene casos de pruebas automatizados para la API de Usuarios de ServeRest
(https://serverest.dev/) utilizando Karate DSL.

## Tecnologías
- Java 11
- Maven 3.9.6
- Intellij

## Configuración - Despues de Descargar el proyecto
-  Revisar en Setting del Intellij  
  ✔File-->Settings-->Build, Execution, Deployment-->Build Tools-->Maven: Revisar que este seleccionado el Maven, en Maven Home Path  
  ✔File-->Settings-->Build, Execution, Deployment-->Build Tools-->Maven-->Importing: Revisar q que este seleccionado el JDK, en JDK for importer  
  ✔File-->Settings-->Build, Execution, Deployment-->Build Tools-->Maven-->Runner: Revisar q que este seleccionado el JDK, en JRE  
  ✔File-->Settings-->Pluggins: Instalar el cucumber for java y Gherkin
- Revisar en project structure  
  ✔File-->Project structure-->Project Settings-->Project: Revisar que este seleccionado java en el SDK  
  ✔File-->Project structure-->Platform Settings-->SDKs: Revisar que este seleccionado el java 11 en JDK home path

## Ejecución de todos los escenarios
- 1era Forma: desde la consola de powershell o bash del IDE Intellij usar el comando: **mvn clean test "-Dkarate.options=--tags @serverest"**
- 2da Forma: Anticlic en el archivo java que se encuentra en bdd/runner/**karateRunner.java** y clic en Run 'karateRunner'


## Estructura
✔ Features: organizados por endpoint (GET, POST, PUT, DELETE)  
✔ helpers  
✔ karate-config.js: Configuración global   
✔ runner

## Cobertura
✔ Se validaron todos los codigos exitosos y fallidos que indica el contrato de la API de Usuarios  
✔ Se agregaron casos extras de codigo de error que no estaban en el contrato   
✔ Se hizo validaciones de esquema JSON para las respuestas  
✔ Se hizo uso de un archivo .js para generar data  
✔ Se crearon escenarios reutilizables para hacer el llamado de un feature desde otro feature y hacer validaciones y no estar actualizando la data



## Casos cubiertos
- **Endpoint GET /usuarios - Listar usuarios**   
  ✔ HappyPath - GET - Listar todos los usuarios
  <br><br>
- **Endpoint POST /usuarios - Registrar usuario**  
  ✔ HappyPath - POST - Creacion de usuario  
  ✔ UnHappyPath - POST - No permitir email duplicado
  <br><br>
- **Endpoint GET /usuarios/{_id} - Buscar usuario por ID**  
  ✔ HappyPath - GET - Listar usuario  
  ✔ UnHappyPath - GET - Usuario no encontrado  
  ✔ UnHappyPath - GET - Usuario con 'id' menor a 16 caracteres  
  ✔ UnHappyPath - GET - Usuario con 'id' mayor a 16 caracteres
  <br><br>
- **Endpoint PUT /usuarios/{_id} - Actualizar usuario**  
  ✔ HappyPath - PUT - Usuario Actualizado  
  ✔ HappyPath - PUT - Registro realizado con _id de usuario no existente  
  ✔ UnHappyPath - PUT - Actualizacion fallida con Email existente
  <br><br>
- **Endpoint DELETE /usuarios/{_id} - Eliminar usuario**  
  ✔ HappyPath - PUT - Eliminar Usuario  
  ✔ UnHappyPath - PUT - Eliminacion fallida con Usuario no existente  
  ✔ UnHappyPath - PUT - Eliminacion fallida con Usuario con Carrito de Compra Registrado
  <br><br>



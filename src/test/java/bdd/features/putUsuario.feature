@serverest
Feature: Ejemplo de automatización en APIs
  As un administrador del sistema
  I poder gestionar los usuarios a través de la API
  So administrar la base de datos de usuarios.

  @PUT_actualizarUsuario
  Scenario: HappyPath - PUT - Usuario Actualizado
    #################### CREACION DE USUARIO ####################
    * call read('classpath:bdd/features/postUsuario.feature@REUTILIZABLE_crearUsuario')
    ################### LISTAR USUARIO CREADO ###################
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_listarUsuarioId') { id: "#(userId)" }
    ################## ACTUALIZAR USUARIO CREADO#################
    Given url baseUrl + '/usuarios/' + userId
    * def body = call read('classpath:bdd/helpers/generadorData.js')
    And request body
    When method PUT
    * print body
    * print response
    Then status 200
    And match response.message == "Registro alterado com sucesso"
    ################### VALIDA USUARIO ACTUALIZADO ###################
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_listarUsuarioId') { id: "#(userId)" }

  @PUT_emailUsado
  Scenario: UnHappyPath - PUT - Actualizacion fallida con Email existente
    #################### CREACION DE USUARIO ####################
    * call read('classpath:bdd/features/postUsuario.feature@REUTILIZABLE_crearUsuario')
    ################### LISTAR USUARIO CREADO ###################
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_listarUsuarioId') { id: "#(userId)" }
    ################## PUT - USAR EMAIL EXISTENTE DE OTRO USUARIO #################
    Given url baseUrl + '/usuarios/' + userId
    * def body = call read('classpath:bdd/helpers/generadorData.js')
    * call read('classpath:bdd/features/getUsuarios.feature@REUTILIZABLE_listarUsuarios')
    * set body.email = vEmail
    And request body
    When method PUT
    * print body
    * print response
    Then status 400
    And match response.message == "Este email já está sendo usado"

  @PUT_usuarioNuevoId
  Scenario: HappyPath - PUT - Registro realizado con 'id' de usuario no existente
    * def randomId = java.util.UUID.randomUUID().toString().replace('-', '').substring(0,16)
    Given url baseUrl + '/usuarios/' + randomId
    * def body = call read('classpath:bdd/helpers/generadorData.js')
    And request body
    When method PUT
    * print body
    * print response
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    * def id = response._id
    ################### VALIDA USUARIO CON EL ID GENERADO ###################
    * def vEmail = response.email
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_listarUsuarioId') { id: "#(id)" }
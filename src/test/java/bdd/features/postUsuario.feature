@serverest
Feature: Ejemplo de automatización en APIs
  As un administrador del sistema
  I poder gestionar los usuarios a través de la API
  So administrar la base de datos de usuarios.

  @REUTILIZABLE_crearUsuario @ignore
  Scenario: Reutilizable - Creacion de usuario
    Given url baseUrl + '/usuarios'
    * def body = call read('classpath:bdd/helpers/generadorData.js')
    And request body
    When method POST
    * print body
    * print response
    Then status 201
    * def usuario = response
    * def userId = response._id

  @POST_crearUsuario
  Scenario: HappyPath - POST - Creacion de usuario
    Given url baseUrl + '/usuarios'
    * def body = call read('classpath:bdd/helpers/generadorData.js')
    And request body
    When method POST
    * print body
    * print response
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    And match response._id == '#string'
    * def userId = response._id
    ################## VERIFICAR QUE EL USUARIO ESTE CREADO ###################
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_listarUsuarioId') { id: "#(userId)" }

  @POST_emeailDuplicado
  Scenario: UnHappyPath - POST - No permitir email duplicado
    Given url baseUrl + '/usuarios'
    ############### AGREGAR A LA DATA GENERADA EMEAIL DUPLICADO ###############
    * def body = call read('classpath:bdd/helpers/generadorData.js')
    * call read('classpath:bdd/features/getUsuarios.feature@REUTILIZABLE_listarUsuarios')
    * set body.email = vEmail
    And request body
    When method POST
    Then status 400
    * print response
    And match response.message == "Este email já está sendo usado"
    * print response
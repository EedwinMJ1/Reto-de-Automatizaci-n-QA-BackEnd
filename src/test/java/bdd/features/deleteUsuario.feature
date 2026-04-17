@serverest
Feature: Ejemplo de automatización en APIs
  As un administrador del sistema
  I poder gestionar los usuarios a través de la API
  So administrar la base de datos de usuarios.

  @DELETE_eliminarUsuarioExistente
  Scenario: HappyPath - PUT - Eliminar Usuario
    #################### CREACION DE USUARIO ####################
    * call read('classpath:bdd/features/postUsuario.feature@REUTILIZABLE_crearUsuario')
    ################### LISTAR USUARIO CREADO ###################
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_listarUsuarioId') { id: "#(userId)" }
    ################## ELIMINAR USUARIO CREADO#################
    Given url baseUrl + '/usuarios/' + userId
    When method DELETE
    * print response
    Then status 200
    And match response.message == "Registro excluído com sucesso"
    ################### VALIDA USUARIO ACTUALIZADO ###################
    * call read('classpath:bdd/features/getUsuarioId.feature@REUTILIZABLE_usuarioIdNoEncontrado') { id: "#(userId)" }

  @DELETE_usuarioNoExistente
  Scenario: UnHappyPath - PUT - Eliminacion fallida con Usuario no existente
    * def randomId = java.util.UUID.randomUUID().toString().replace('-', '').substring(0,16)
    Given url baseUrl + '/usuarios/' + randomId
    When method DELETE
    * print response
    Then status 200
    And match response.message == "Nenhum registro excluído"

  @DELETE_usuarioConCarritoCompraRegistrado
  Scenario Outline: UnHappyPath - PUT - Eliminacion fallida con Usuario con Carrito de Compra Registrado
    Given url baseUrl + '/usuarios/' + '<userIdConCarrito>'
    When method DELETE
    * print response
    Then status 400
    And match response.message == "Não é permitido excluir usuário com carrinho cadastrado"
    Examples:
      | userIdConCarrito |
      | 0uxuPY0cbmQhpEz1 |
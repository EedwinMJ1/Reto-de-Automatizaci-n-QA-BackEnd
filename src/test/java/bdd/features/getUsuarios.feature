@serverest
Feature: Ejemplo de automatización en APIs
  As un administrador del sistema
  I poder gestionar los usuarios a través de la API
  So administrar la base de datos de usuarios.

  @REUTILIZABLE_listarUsuarios @ignore
  Scenario: Reutilizable - Listar todos los usuarios
    Given url baseUrl + '/usuarios'
    When method GET
    Then status 200
    * print response
    * def vEmail = response.usuarios[0].email

  @GET_listarUsuarios
  Scenario: HappyPath - GET - Listar todos los usuarios
    Given url baseUrl + '/usuarios'
    When method GET
    Then status 200
    * def userSchema =
    """
    {
      nome: '#string',
      email: '#string',
      password: '#string',
      administrador: '#string',
      _id: '#string'
    }
    """
    * def responseSchema =
    """
    {
      quantidade: '#number',
      usuarios: '#[] userSchema'
    }
    """
    * match response == responseSchema
    * print response

@serverest
Feature: Ejemplo de automatización en APIs
  As un administrador del sistema
  I poder gestionar los usuarios a través de la API
  So administrar la base de datos de usuarios.

  @REUTILIZABLE_listarUsuarioId @ignore
  Scenario: Reutilizable - Listar usuario
    Given url baseUrl + '/usuarios/' + id
    When method GET
    Then status 200
    * print response
    * def vEmail = response.email

  @REUTILIZABLE_usuarioIdNoEncontrado @ignore
  Scenario: Reutilizable - Usuario no encontrado
    Given url baseUrl + '/usuarios/' + id
    When method GET
    Then status 400
    * print response
    And match response.message contains "Usuário não encontrado"

  @GET_listarUsuarioId
  Scenario Outline: HappyPath - GET - Listar usuario
    Given url baseUrl + '/usuarios/' + '<id>'
    When method GET
    Then status 200
    * def responseSchema =
    """
    {
      nome: '#string',
      email: '#string',
      password: '#string',
      administrador: '#string',
      _id: '#string'
    }
    """
    * match response == responseSchema
    * print response
    Examples:
      | id               |
      | 0uxuPY0cbmQhpEz1 |

  @GET_usuarioIdNoEncontrado
  Scenario Outline: UnHappyPath - GET - Usuario no encontrado
    Given url baseUrl + '/usuarios/' + '<id>'
    When method GET
    Then status 400
    * print response
    And match response.message contains "Usuário não encontrado"
    Examples:
      | id               |
      | AhiywOzbk716pEJ4 |

  @GET_usuarioIdCaracteresDiferenteTamaño
  Scenario Outline: UnHappyPath - GET - Usuario con 'id' <case>
    Given url baseUrl + '/usuarios/' + '<id>'
    When method GET
    Then status 400
    * print response
    And match response.id contains "id deve ter exatamente 16 caracteres alfanuméricos"
    Examples:
      | case                  | id                |
      | menor a 16 caracteres | AhiywOzbk716pEJ   |
      | mayor a 16 caracteres | AhiywOzbk716pEJ34 |
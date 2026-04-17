function generadorData() {
  var random = Date.now();
  return {
    nome: "prueba " + random,
    email: "prueba" + random + "@gmail.com",
    password: "123456",
    administrador: "true"
  };
}
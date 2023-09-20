class UserModel {
  final int id;
  final String name;
  final String apellido;
  final int telefono;
  final String direccion;
  final String ciudad;
  final int cedula;
  final String zona;
  final String email;
  final int estado;
  final int idRol;
  final int idContrato;

  UserModel({
    required this.id,
    required this.name,
    required this.apellido,
    required this.telefono,
    required this.direccion,
    required this.ciudad,
    required this.cedula,
    required this.zona,
    required this.email,
    required this.estado,
    required this.idRol,
    required this.idContrato,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      apellido: json["apellido"],
      telefono: json["telefono"],
      direccion: json["direccion"],
      ciudad: json["ciudad"],
      cedula: json["cedula"],
      zona: json["zona"],
      email: json["email"],
      estado: json["estado"],
      idRol: json["idRol"],
      idContrato: json["idContrato"],
    );
  }
}

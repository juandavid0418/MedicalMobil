class PacienteModel {
  final int id;
  final String nombre;
  final String apellido;
  final String correo;
  final int telefono;
  final String direccion;
  final String ciudad;
  final int documento;
  final int estado;
  final int idContrato;
  final DateTime createdAt;
  final DateTime updatedAt;

  PacienteModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.telefono,
    required this.direccion,
    required this.ciudad,
    required this.documento,
    required this.estado,
    required this.idContrato,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PacienteModel.fromJson(Map<String, dynamic> json) {
    return PacienteModel(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      ciudad: json['ciudad'],
      documento: json['documento'],
      estado: json['estado'],
      idContrato: json['idContrato'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

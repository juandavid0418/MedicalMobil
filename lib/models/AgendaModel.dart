class AgendaModel {
  final int id;
  final int estado;
  final int idContrato;
  final String fecha_inicio;
  final String fecha_fin;
  final String hora;
  final String hora_fin;
  final int id_pacientes;
  final int id_user;
  final String created_at;
  final String updated_at;

  AgendaModel({
    required this.id,
    required this.estado,
    required this.idContrato,
    required this.fecha_inicio,
    required this.fecha_fin,
    required this.hora,
    required this.hora_fin,
    required this.id_pacientes,
    required this.id_user,
    required this.created_at,
    required this.updated_at,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel(
      id: json['id'],
      estado: json['estado'],
      idContrato: json['idContrato'],
      fecha_inicio: json['fecha_inicio'],
      fecha_fin: json['fecha_fin'],
      hora: json['hora'],
      hora_fin: json['hora_fin'],
      id_pacientes: json['id_pacientes'],
      id_user: json['id_user'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

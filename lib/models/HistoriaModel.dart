class HistoriaModel {
  int id;
  String diagnostico;
  String signosvitales;
  String antecedentesalergicos;
  String evolucion;
  String tratamiento;
  int pacientes_id;
  DateTime? created_at;

  HistoriaModel({
    required this.id,
    required this.diagnostico,
    required this.signosvitales,
    required this.antecedentesalergicos,
    required this.evolucion,
    required this.tratamiento,
    required this.pacientes_id,
    this.created_at,
  });

  factory HistoriaModel.fromJson(Map<String, dynamic> json) {
    return HistoriaModel(
      id: json['id'],
      diagnostico: json['diagnostico'],
      signosvitales: json['signosvitales'],
      antecedentesalergicos: json['antecedentesalergicos'],
      evolucion: json['evolucion'],
      tratamiento: json['tratamiento'],
      pacientes_id: json['pacientes_id'],
      created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,

    );
  }

  static List<HistoriaModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => HistoriaModel.fromJson(item)).toList();
  }
}

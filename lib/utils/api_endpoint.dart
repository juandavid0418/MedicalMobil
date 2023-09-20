class ApiEndPoints {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  final _AuthEndPoints authEndpoints = _AuthEndPoints();
  final _Apipaciente apiPaciente = _Apipaciente();
  final _Apihistoria apiHistoria = _Apihistoria();
  final _Crearhistoria crearHistoria = _Crearhistoria();
  final _ApiAgenda apiAgenda = _ApiAgenda();
  final _UserEmail apiUserEmail = _UserEmail();
  final _PacienteXcontrato pacienteXcontrato = _PacienteXcontrato();
}

class _AuthEndPoints {
  final String loginEmail = 'auth/login';
}

class _Apipaciente {
  final String getAllPacientesEndpoint = 'paciente';
}
class _PacienteXcontrato {
  final String pacientexContrato = 'agendas/contract/';
}


class _Apihistoria {
  final String historiaBaseEndpoint = 'historia/paciente';
}

class _Crearhistoria {
  final String crearHistoriaEndpoint = 'historia';
}

class _ApiAgenda {
  final String agendaBaseEndPoint = 'agendas';
}

class _UserEmail {
  final String historiaBaseEndpoint = 'user/email';
}



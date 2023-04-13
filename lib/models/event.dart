/*class Event {
  int? idEvento;
  String? dscEvento;
  String? ttlEvento;
  String? fechaEvento;
  bool? completado;

  Event(
      {this.idEvento,
      this.dscEvento,
      this.fechaEvento,
      this.completado,
      this.ttlEvento});
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      idEvento: map['idEvento'],
      dscEvento: map['dscEvento'],
      fechaEvento: map['fechaEvento'],
      completado: map['completado'],
      ttlEvento: map['ttlEvento'],
    );
  }
}*/

import 'package:flutter/foundation.dart';

class Event {
  int? idEvento;
  String? dscEvento;
  String? titlEvento;
  String? fechaEvento;
  bool? completado;

  Event(
      {this.idEvento,
      this.dscEvento,
      this.fechaEvento,
      this.completado,
      this.titlEvento});
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      idEvento: map['idEvento'],
      dscEvento: map['dscEvento'],
      fechaEvento: map['fechaEvento'],
      completado: map['completado'],
      titlEvento: map['titlEvento'],
    );
  }
}

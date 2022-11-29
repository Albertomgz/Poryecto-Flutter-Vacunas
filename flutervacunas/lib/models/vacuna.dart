class vacuna {
  int? _idvacuna;
  String? _nombreVacuna;
  String? _num_dosis;
  String? _descripcion;
  String? _tipo;

  /*vacuna(this._idvacuna,this._nombreVacuna,this._num_dosis,this._descripcion,this._tipo,this._rango);*/
  //vacuna();
  /*vacuna(this._nombreVacuna, this._num_dosis, this._descripcion, this._tipo,
      this._rango);*/
  int? get idvacuna => _idvacuna;

  set idvacuna(int? idvacuna) {
    _idvacuna = idvacuna;
  }

  String? get nombreVacuna => _nombreVacuna;

  set nombreVacuna(String? nombreVacuna) {
    _nombreVacuna = nombreVacuna;
  }

  String? get num_dosis => _num_dosis;

  set num_dosis(String? num_dosis) {
    _num_dosis = num_dosis;
  }

  String? get descripcion => _descripcion;

  set descripcion(String? descripcion) {
    _descripcion = descripcion;
  }

  String? get tipo => _tipo;

  set tipo(String? tipo) {
    _tipo = tipo;
  }
}

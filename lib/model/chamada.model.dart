import 'package:tg_app/model/atirador.model.dart';

class ChamadaModel {
  String id;
  String nome;
  String pelotao;
  bool presenca;
  AtiradorModel model;

  ChamadaModel(this.id, this.nome, this.pelotao, this.presenca, this.model);
}

class AtiradorModel {
  String? id;
  String? nome;

  AtiradorModel(this.id, this.nome);

  AtiradorModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }
}

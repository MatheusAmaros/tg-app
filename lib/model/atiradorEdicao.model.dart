class AtiradorModel {
  final uid;
  final nome;
  final email;
  final funcao;
  final numero;
  final pelotao;
  final cpf;
  final telefone;
  final anoIngresso;


  const AtiradorModel(
    {
    required this.email, 
    required this.uid,
    required this.nome,
    required this.funcao,
    required this.numero,
    required this.pelotao,
    required this.cpf,
    required this.telefone,
    required this.anoIngresso,
  });
  
}

var allAtiradores = [
  AtiradorModel(
      uid: '1',
   nome: 'andre',
   email: 'andre@email.com',
   funcao: 'cabo',
   numero: '12',
   pelotao: 'pelotao4',
   cpf: '201544654646',
   telefone: '11588',
   anoIngresso: '2022',
  ),

    AtiradorModel(
      uid: '2',
   nome: 'anderson',
   email: 'anderson@email.com',
   funcao: 'comandante',
   numero: '15',
   pelotao: 'pelotao2',
   cpf: '201544654646',
   telefone: '11588',
   anoIngresso: '2022',
  ),

    AtiradorModel(
      uid: '3',
   nome: 'Maicon',
   email: 'Maicon@email.com',
   funcao: 'sentinela',
   numero: '20',
   pelotao: 'pelotao3',
   cpf: '201544654646',
   telefone: '11588',
   anoIngresso: '2022',
  )
];

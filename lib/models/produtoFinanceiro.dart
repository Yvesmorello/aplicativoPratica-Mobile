import 'categoriaProduto.dart';

class ProdutoFinanceiro {
  String nome;
  String tipo;
  double precoAtual;
  double variacao;
  CategoriaProduto categoria;

  ProdutoFinanceiro({
    required this.nome,
    required this.tipo,
    required this.precoAtual,
    required this.variacao,
    required this.categoria,
  });
}

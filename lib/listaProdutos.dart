import 'package:flutter/material.dart';
import './models/produtoFinanceiro.dart';

class ListaProdutos extends StatelessWidget {
  final List<ProdutoFinanceiro> produtos;

  ListaProdutos({required this.produtos});

  Color _getBackgroundColor(String tipo) {
    switch (tipo) {
      case 'Ação':
        return Colors.blue[50]!; // Cor para Ações
      case 'FII':
        return Colors.amber[50]!; // Cor para FIIs
      default:
        return Colors.grey[50]!; // Cor para ETFs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Produtos Financeiros')),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: _getBackgroundColor(produto.categoria.nome), 
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Deslocamento da sombra
                  ),
                ],
                border: Border.all(color: Colors.blueAccent, width: 1),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  produto.nome,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Preço: R\$${produto.precoAtual.toStringAsFixed(2)} | Variação: ${produto.variacao}%',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: Text(
                  produto.categoria.nome,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


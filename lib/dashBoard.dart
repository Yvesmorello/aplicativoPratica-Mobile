import 'package:flutter/material.dart';
import './models/produtoFinanceiro.dart';
import './models/categoriaProduto.dart';

class DashboardScreen extends StatelessWidget {

  final List<ProdutoFinanceiro> produtos = [
    ProdutoFinanceiro(
      nome: 'Petrobras',
      tipo: 'Ação',
      precoAtual: 28.50,
      variacao: 1.2,
      categoria: CategoriaProduto(nome: 'Ações', descricao: 'Ações de empresas'),
    ),
    ProdutoFinanceiro(
      nome: 'Vale',
      tipo: 'Ação',
      precoAtual: 68.75,
      variacao: -0.5,
      categoria: CategoriaProduto(nome: 'Ações', descricao: 'Ações de empresas'),
    ),
    ProdutoFinanceiro(
      nome: 'HGLG11',
      tipo: 'FII',
      precoAtual: 130.45,
      variacao: 0.8,
      categoria: CategoriaProduto(nome: 'FIIs', descricao: 'Fundos Imobiliários'),
    ),
    ProdutoFinanceiro(
      nome: 'VISC11',
      tipo: 'FII',
      precoAtual: 110.00,
      variacao: -0.2,
      categoria: CategoriaProduto(nome: 'FIIs', descricao: 'Fundos Imobiliários'),
    ),
    ProdutoFinanceiro(
      nome: 'BCFF11',
      tipo: 'FII',
      precoAtual: 9.60,
      variacao: 0.5,
      categoria: CategoriaProduto(nome: 'FIIs', descricao: 'Fundos Imobiliários'),
    ),
    ProdutoFinanceiro(
      nome: 'BOVA11',
      tipo: 'ETF',
      precoAtual: 98.20,
      variacao: 0.3,
      categoria: CategoriaProduto(nome: 'ETFs', descricao: 'Exchange Traded Funds'),
    ),
    ProdutoFinanceiro(
      nome: 'IVVB11',
      tipo: 'ETF',
      precoAtual: 240.50,
      variacao: 1.1,
      categoria: CategoriaProduto(nome: 'ETFs', descricao: 'Exchange Traded Funds'),
    ),
    ProdutoFinanceiro(
      nome: 'HASH11',
      tipo: 'ETF',
      precoAtual: 46.00,
      variacao: 0.7,
      categoria: CategoriaProduto(nome: 'ETFs', descricao: 'Exchange Traded Funds'),
    ),
    ProdutoFinanceiro(
      nome: 'Magazine Luiza',
      tipo: 'Ação',
      precoAtual: 3.50,
      variacao: 5.0,
      categoria: CategoriaProduto(nome: 'Ações', descricao: 'Ações de empresas'),
    ),
    ProdutoFinanceiro(
      nome: 'Bradesco',
      tipo: 'Ação',
      precoAtual: 12.80,
      variacao: -3.4,
      categoria: CategoriaProduto(nome: 'Ações', descricao: 'Ações de empresas'),
    ),
  ];

  List<ProdutoFinanceiro> get maioresAltas {
    produtos.sort((a, b) => b.variacao.compareTo(a.variacao));
    return produtos.where((p) => p.variacao > 0).take(5).toList();
  }

  List<ProdutoFinanceiro> get maioresBaixas {
    produtos.sort((a, b) => a.variacao.compareTo(b.variacao));
    return produtos.where((p) => p.variacao < 0).take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Altas do Dia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildAltasBaixasList(maioresAltas, true),
              SizedBox(height: 20),
              Text(
                'Baixas do Dia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildAltasBaixasList(maioresBaixas, false),
              SizedBox(height: 20),
              Text(
                'Cotações de Ações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildCotacoesList(produtos.where((p) => p.tipo == 'Ação').toList()),
              SizedBox(height: 20),
              Text(
                'Cotações de FIIs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildCotacoesList(produtos.where((p) => p.tipo == 'FII').toList()),
              SizedBox(height: 20),
              Text(
                'Cotações de ETFs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildCotacoesList(produtos.where((p) => p.tipo == 'ETF').toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAltasBaixasList(List<ProdutoFinanceiro> produtos, bool isAlta) {
    return Column(
      children: produtos.map((produto) {
        return Card(
          color: isAlta ? Colors.green[50] : Colors.red[50],
          child: ListTile(
            title: Text(produto.nome),
            subtitle: Text(
                'Preço: R\$ ${produto.precoAtual.toStringAsFixed(2)} | Variação: ${produto.variacao}%'),
            trailing: Icon(
              isAlta ? Icons.arrow_upward : Icons.arrow_downward,
              color: isAlta ? Colors.green : Colors.red,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Método para construir as listas de cotações por categoria.
  Widget buildCotacoesList(List<ProdutoFinanceiro> produtos) {
    return Column(
      children: produtos.map((produto) {
        return Card(
          child: ListTile(
            title: Text(produto.nome),
            subtitle: Text(
                'Preço: R\$ ${produto.precoAtual.toStringAsFixed(2)} | Variação: ${produto.variacao}%'),
            trailing: Icon(
              produto.variacao >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
              color: produto.variacao >= 0 ? Colors.green : Colors.red,
            ),
          ),
        );
      }).toList(),
    );
  }
}

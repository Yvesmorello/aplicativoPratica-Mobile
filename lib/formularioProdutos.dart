import 'package:appatividade/models/categoriaProduto.dart';
import 'package:appatividade/models/produtoFinanceiro.dart';
import 'package:flutter/material.dart';

class FormularioProduto extends StatefulWidget {
  final Function(ProdutoFinanceiro) onAddProduto;

  FormularioProduto({required this.onAddProduto});

  @override
  FormularioProdutoState createState() => FormularioProdutoState();
}

class FormularioProdutoState extends State<FormularioProduto> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final precoController = TextEditingController();
  final variacaoController = TextEditingController();

  CategoriaProduto? categoriaSelecionada;
  String tipoSelecionado = 'Ação';

  final List<CategoriaProduto> categorias = [
    CategoriaProduto(nome: 'Ação', descricao: 'Ações de empresas'),
    CategoriaProduto(nome: 'FII', descricao: 'Fundos Imobiliários'),
    CategoriaProduto(nome: 'ETF', descricao: 'Exchange Traded Funds'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: precoController,
                decoration: InputDecoration(labelText: 'Preço Atual'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço atual';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Insira um número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: variacaoController,
                decoration: InputDecoration(labelText: 'Variação (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a variação';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Insira um número válido';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<CategoriaProduto>(
                value: categoriaSelecionada,
                onChanged: (categoria) {
                  setState(() {
                    categoriaSelecionada = categoria;
                  });
                },
                items: categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria.nome),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Categoria'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final novoProduto = ProdutoFinanceiro(
                      nome: nomeController.text,
                      tipo: tipoSelecionado,
                      precoAtual: double.parse(precoController.text),
                      variacao: double.parse(variacaoController.text),
                      categoria: categoriaSelecionada!,
                    );
                    widget.onAddProduto(novoProduto);
                  }
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


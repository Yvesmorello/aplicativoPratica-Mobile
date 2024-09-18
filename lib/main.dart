import 'package:flutter/material.dart';
import './models/produtoFinanceiro.dart';
import './listaProdutos.dart';
import './formularioProdutos.dart';
import './dashBoard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Análise de Produtos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/listaProdutos': (context) => ListaProdutos(produtos: []), 
        '/adicionarProduto': (context) => FormularioProduto(onAddProduto: (produto) {}), 
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProdutoFinanceiro> _produtos = [];

  void _addProduto(ProdutoFinanceiro produto) {
    setState(() {
      _produtos.add(produto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Análise de Produtos')),
      body: DashboardScreen(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Lista de Produtos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaProdutos(produtos: _produtos),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Adicionar Produto'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioProduto(
                      onAddProduto: (produto) {
                        _addProduto(produto);
                        Navigator.pop(context); 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaProdutos(produtos: _produtos),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

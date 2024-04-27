import 'package:bytebank/screens/contato/contact_form.dart';
import 'package:flutter/material.dart';

import '../../database/dao/contato_dao.dart';
import '../../models/contato.dart';

class ContactsList extends StatefulWidget {
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final List<Contato> lista = snapshot.data!;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final Contato contato = lista[index];
                return _ContatoItem(contato, _atualizarLista);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(contato: Contato.empty()),
                ),
              ).then((value) => _atualizarLista() );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _atualizarLista() {
    setState(() {});
  }

}

class _ContatoItem extends  StatelessWidget {
  final Contato contato;
  final Function() onUpdate;

  _ContatoItem(this.contato, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactForm(contato: contato),
            ),
        ).then((value) => onUpdate());
      },
      child: Card(
        child: ListTile(
          title: Text(
            contato.nome,
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(
            contato.fone,
            style: TextStyle(fontSize: 14.0, color: Colors.white60),
          ),
        ),
      ),
    );
  }
}

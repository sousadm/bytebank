import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

import '../../database/dao/contato_dao.dart';

class ContactForm extends StatefulWidget {
  final Contato contato;
  const ContactForm({super.key, required this.contato});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final phoneNumberRegex = RegExp(r'^\+\d+$');
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _foneController = TextEditingController();
  late TextEditingController _idadeController = TextEditingController();
  late TextEditingController _nascimentoController = TextEditingController();
  DateTime?
      _selectedDate; // Adicione uma variável para armazenar a data selecionada

  final ContatoDao _dao = ContatoDao();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contato.nome);
    _foneController = TextEditingController(text: widget.contato.fone);
    _idadeController =
        TextEditingController(text: widget.contato.idade.toString());
    _nascimentoController =
        TextEditingController(text: widget.contato.nascimento);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato.id == null ? 'Novo Contato' : 'Edição'),
        actions: [
          if (widget.contato.id != null)
            IconButton(
                onPressed: () async {
                  if (await confirm(
                    context,
                    title: const Text('Confirma'),
                    content: const Text('Excluir contato?'),
                    textOK: const Text('Ok'),
                    textCancel: const Text('Cancela'),
                  )) {
                    _dao
                        .delete(widget.contato)
                        .then((_) => Navigator.pop(context));
                  }
                },
                icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () => salvar(context), icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'nome completo'),
              style: const TextStyle(fontSize: 24.0),
              //autofocus: true,
            ),
            TextField(
              controller: _foneController,
              decoration: const InputDecoration(labelText: 'Celular'),
              style: const TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _idadeController,
              decoration: const InputDecoration(labelText: 'Idade'),
              style: const TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.number,
            ),
            InkWell(
              onTap: () {
                _selectDate(context, _nascimentoController);
              },
              child: IgnorePointer(
                child: TextField(
                  controller: _nascimentoController,
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  style: const TextStyle(fontSize: 24.0),
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void salvar(BuildContext context) {
    final String nome = _nameController.text;
    final String fone = _foneController.text;
    final int idade = int.tryParse(_idadeController.text) ?? 0;
    final String nascimento = _nascimentoController.text;

    if (widget.contato.id == null) {
      final newContato =
          Contato(nome: nome, fone: fone, idade: idade, nascimento: nascimento);
      _dao.save(newContato).then((id) => Navigator.pop(context));
    } else {
      final updateContato = Contato(
          id: widget.contato.id,
          nome: nome,
          fone: fone,
          idade: idade,
          nascimento: nascimento);
      _dao.update(updateContato).then((id) => Navigator.pop(context));
    }
  }

  // Método para exibir o seletor de data
  Future<void> _selectDate(
      BuildContext context, TextEditingController selectedController) async {
    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime dateTime = format.parse(selectedController.text);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _nascimentoController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }
}

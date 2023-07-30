import 'dart:developer';

import 'package:app/core/components/garbo_input_field.dart';
import 'package:app/core/constants/application_constants.dart';
import 'package:app/core/components/garbo_button.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: const BackButton(color: Colors.grey),
            title: const Text(
              "Entre em Contato",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Dispomos aqui de uma forma facilitada para entrarem em contacto connosco.\n\nQualquer duvida que possa ter, não hesite, temos colaboradores especializados prontos para o esclarecer.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GarboInputField(
                          key: const Key('nameField'),
                          inputController: _nameController,
                          labelText: "Nome",
                          inputFieldType: InputFieldType.username,
                        ),
                        const SizedBox(height: defaultPadding),
                        GarboInputField(
                          key: const Key('emailField'),
                          inputController: _emailController,
                          labelText: "Email",
                          inputFieldType: InputFieldType.email,
                        ),
                        const SizedBox(height: defaultPadding),
                        GarboInputField(
                          key: const Key('subjectField'),
                          inputController: _subjectController,
                          labelText: "Assunto",
                          inputFieldType: InputFieldType.username,
                        ),
                        const SizedBox(height: defaultPadding),
                        GarboInputField(
                          key: const Key('messageField'),
                          inputController: _messageController,
                          labelText: "Mensagem",
                          inputFieldType: InputFieldType.username,
                        ),
                        const SizedBox(height: 32),
                        GarboButton(
                          text: 'Enviar',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              log('Name: ${_nameController.text}');
                              log('Email: ${_emailController.text}');
                              log('Subject: ${_subjectController.text}');
                              log('Message: ${_messageController.text}');
                            } else {
                              log('Form is invalid');
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Ou visite-nos na nossa loja física',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          elevation: 1,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Garbo - Comércio E Confecção De Vestuário, Lda.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Zona Industrial De Pocinhos, Pav. B-7 Oliveira de São Mateus, 4765-052 Vila Nova de Famalicão',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                    onPressed: () =>
                                        MapsLauncher.launchCoordinates(
                                          storeLocationCoordinates.values.first,
                                          storeLocationCoordinates.values.last,
                                        ),
                                    child: const Text(
                                      'Ver no mapa',
                                      style: TextStyle(
                                          color: Colors.cyan,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _pinController = TextEditingController();
  final String _correctPin = '1610';
  bool verificado = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPinDialog();
    });
  }

  void _showPinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Ingrese su PIN'),
          content: TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'PIN',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _checkPin();
              },
              child: const Text('Verificar'),
            ),
          ],
        );
      },
    );
  }

  void _checkPin() {
    if (_pinController.text == _correctPin) {
      Navigator.of(context).pop();
      setState(() {
        verificado = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN incorrecto, inténtalo de nuevo')),
      );
      _pinController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (verificado) {
      return Center(
        child: Container(
          width: 350,
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(76, 89, 153, 1),
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hay una canción que dice que te doy una parte de mi corazón para que nunca estés sola. La programación es una parte de mi corazón, y espero que te guste.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              TextButton(
                  onPressed: () {
                    showDialogChatGPT(context);
                  },
                  child: const Text(
                    'No es un botón',
                    style: TextStyle(
                        color: Color.fromRGBO(76, 89, 153, 1), fontSize: 6),
                  ))
            ],
          ),
        ),
      );
    }
    return Container();
  }

  void showDialogChatGPT(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.white,
            elevation: 0,
            content: Text(
              'La idea del mensaje fue mía desde el principio pero no sé escribir entonces escribió Chat GPT por eso seguro suena raro jiji.',
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}

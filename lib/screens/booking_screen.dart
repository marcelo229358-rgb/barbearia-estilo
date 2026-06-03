import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? barbeiro;
  String? servico;

  final List<String> barbeiros = [
    'Alberto',
    'Gabriel',
  ];

  final List<String> servicos = [
    'Corte Masculino',
    'Barba',
    'Corte + Barba',
    'Sobrancelha',
    'Pigmentação',
    'Hidratação',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Horário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Escolha o Barbeiro',
              ),
              value: barbeiro,
              items: barbeiros.map((b) {
                return DropdownMenuItem(
                  value: b,
                  child: Text(b),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  barbeiro = valor;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Escolha o Serviço',
              ),
              value: servico,
              items: servicos.map((s) {
                return DropdownMenuItem(
                  value: s,
                  child: Text(s),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  servico = valor;
                });
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Agendamento registrado!',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'CONFIRMAR AGENDAMENTO',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
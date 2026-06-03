import 'package:flutter/material.dart';
import 'agendamento_screen.dart';
import 'meus_agendamentos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Barbearia Estilo'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // HEADER
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  '💈 BARBEARIA ESTILO',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BOTÃO AGENDAR
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgendamentoScreen(),
                    ),
                  );
                },
                child: const Text(
                  'AGENDAR HORÁRIO',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // BOTÃO MEUS AGENDAMENTOS
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeusAgendamentosScreen(),
                    ),
                  );
                },
                child: const Text(
                  'MEUS AGENDAMENTOS',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // SERVIÇOS
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Serviços',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Card(child: ListTile(leading: Icon(Icons.content_cut), title: Text('Corte Masculino'))),
            const Card(child: ListTile(leading: Icon(Icons.face), title: Text('Barba'))),
            const Card(child: ListTile(leading: Icon(Icons.star), title: Text('Corte + Barba'))),
            const Card(child: ListTile(leading: Icon(Icons.remove_red_eye), title: Text('Sobrancelha'))),

            const SizedBox(height: 25),

            // BARBEIROS
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Barbeiros',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Alberto'))),
            const Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Gabriel'))),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
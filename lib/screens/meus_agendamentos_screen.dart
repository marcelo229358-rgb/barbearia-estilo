import 'package:flutter/material.dart';
import '../data/agendamentos_data.dart';

class MeusAgendamentosScreen extends StatefulWidget {
  const MeusAgendamentosScreen({super.key});

  @override
  State<MeusAgendamentosScreen> createState() =>
      _MeusAgendamentosScreenState();
}

class _MeusAgendamentosScreenState extends State<MeusAgendamentosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Agendamentos"),
      ),
      body: agendamentos.isEmpty
          ? const Center(
              child: Text("Nenhum agendamento ainda"),
            )
          : ListView.builder(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                final ag = agendamentos[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("${ag.servico} - ${ag.barbeiro}"),
                    subtitle: Text(
                      "${ag.data.day}/${ag.data.month}/${ag.data.year} às ${ag.hora}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Cancelar agendamento?"),
                            content: const Text(
                                "Tem certeza que deseja excluir este horário?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Não"),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    agendamentos.removeAt(index);
                                  });

                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text("Agendamento cancelado"),
                                    ),
                                  );
                                },
                                child: const Text("Sim"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
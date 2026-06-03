import 'package:flutter/material.dart';
import '../data/agendamentos_data.dart';
import '../models/agendamento.dart';

class AgendamentoScreen extends StatefulWidget {
  const AgendamentoScreen({super.key});

  @override
  State<AgendamentoScreen> createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
  String? barbeiroSelecionado;
  String? servicoSelecionado;

  DateTime? dataSelecionada;
  TimeOfDay? horaSelecionada;

  final List<String> barbeiros = ["Alberto", "Gabriel"];
  final List<String> servicos = [
    "Corte",
    "Barba",
    "Corte + Barba",
    "Sobrancelha"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendar Horário"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Escolha o serviço",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: servicoSelecionado,
              items: servicos
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  servicoSelecionado = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Escolha o barbeiro",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: barbeiroSelecionado,
              items: barbeiros
                  .map((b) => DropdownMenuItem(
                        value: b,
                        child: Text(b),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  barbeiroSelecionado = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final data = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                  );

                  if (data != null) {
                    setState(() {
                      dataSelecionada = data;
                    });
                  }
                },
                child: Text(
                  dataSelecionada == null
                      ? "Escolher data"
                      : "Data: ${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}",
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final hora = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (hora != null) {
                    setState(() {
                      horaSelecionada = hora;
                    });
                  }
                },
                child: Text(
                  horaSelecionada == null
                      ? "Escolher hora"
                      : "Hora: ${horaSelecionada!.format(context)}",
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (servicoSelecionado == null ||
                      barbeiroSelecionado == null ||
                      dataSelecionada == null ||
                      horaSelecionada == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Preencha todos os campos"),
                      ),
                    );
                    return;
                  }

                  agendamentos.add(
                    Agendamento(
                      servico: servicoSelecionado!,
                      barbeiro: barbeiroSelecionado!,
                      data: dataSelecionada!,
                      hora: horaSelecionada!.format(context),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Agendamento realizado com sucesso!"),
                    ),
                  );

                  setState(() {
                    servicoSelecionado = null;
                    barbeiroSelecionado = null;
                    dataSelecionada = null;
                    horaSelecionada = null;
                  });
                },
                child: const Text(
                  "CONFIRMAR AGENDAMENTO",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
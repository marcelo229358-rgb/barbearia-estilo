import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgendamentoScreen extends StatefulWidget {
  const AgendamentoScreen({super.key});

  @override
  State<AgendamentoScreen> createState() => _AgendamentoScreenState();
}

class _AgendamentoScreenState extends State<AgendamentoScreen> {
  int _passo = 0;

  String? servicoSelecionado;
  String? barbeiroSelecionado;
  DateTime? dataSelecionada;
  String? horaSelecionada;

  final List<Map<String, dynamic>> servicos = [
    {'nome': 'Corte Masculino', 'tempo': '30 min', 'preco': 'R\$ 40,00', 'icone': Icons.content_cut},
    {'nome': 'Barba', 'tempo': '20 min', 'preco': 'R\$ 30,00', 'icone': Icons.face},
    {'nome': 'Corte + Barba', 'tempo': '45 min', 'preco': 'R\$ 60,00', 'icone': Icons.star},
    {'nome': 'Pigmentação', 'tempo': '60 min', 'preco': 'R\$ 80,00', 'icone': Icons.brush},
    {'nome': 'Sobrancelha', 'tempo': '15 min', 'preco': 'R\$ 20,00', 'icone': Icons.remove_red_eye},
    {'nome': 'Hidratação', 'tempo': '30 min', 'preco': 'R\$ 35,00', 'icone': Icons.water_drop},
  ];

  final List<Map<String, dynamic>> barbeiros = [
    {'nome': 'Alberto', 'especialidade': 'Especialista em cortes', 'nota': '4.9'},
    {'nome': 'Gabriel', 'especialidade': 'Especialista em barba', 'nota': '4.8'},
  ];

  final List<String> horarios = [
    '09:00', '10:00', '11:00',
    '13:00', '14:00', '15:00',
    '16:00', '17:00', '18:00',
    '19:00', '20:00',
  ];

  final List<String> passos = ['Serviço', 'Barbeiro', 'Data e Hora', 'Confirmar'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Agendar Horário'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_passo > 0) {
              setState(() => _passo--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          _buildIndicadorPassos(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildPasso(),
            ),
          ),
          _buildBotaoContinuar(),
        ],
      ),
    );
  }

  Widget _buildIndicadorPassos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(passos.length, (i) {
          final ativo = i == _passo;
          final concluido = i < _passo;
          return Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ativo || concluido ? Colors.amber : Colors.grey[800],
                      ),
                      child: Center(
                        child: concluido
                            ? const Icon(Icons.check, size: 16, color: Colors.black)
                            : Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: ativo ? Colors.black : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      passos[i],
                      style: TextStyle(
                        color: ativo ? Colors.amber : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                if (i < passos.length - 1)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.only(bottom: 18),
                      color: i < _passo ? Colors.amber : Colors.grey[800],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPasso() {
    switch (_passo) {
      case 0:
        return _buildEscolhaServico();
      case 1:
        return _buildEscolhaBarbeiro();
      case 2:
        return _buildEscolhaDataHora();
      case 3:
        return _buildConfirmacao();
      default:
        return const SizedBox();
    }
  }

  Widget _buildEscolhaServico() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escolha o serviço',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...servicos.map((s) {
          final selecionado = servicoSelecionado == s['nome'];
          return GestureDetector(
            onTap: () => setState(() => servicoSelecionado = s['nome']),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selecionado ? Colors.amber : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(s['icone'] as IconData, color: Colors.amber, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['nome'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${s['tempo']} · ${s['preco']}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (selecionado)
                    const Icon(Icons.check_circle, color: Colors.amber),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEscolhaBarbeiro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escolha o barbeiro',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...barbeiros.map((b) {
          final selecionado = barbeiroSelecionado == b['nome'];
          return GestureDetector(
            onTap: () => setState(() => barbeiroSelecionado = b['nome']),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selecionado ? Colors.amber : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.grey[700],
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b['nome'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          b['especialidade'],
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              b['nota'],
                              style: const TextStyle(color: Colors.amber, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selecionado ? Colors.amber : Colors.grey,
                        width: 2,
                      ),
                      color: selecionado ? Colors.amber : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEscolhaDataHora() {
    final hoje = DateTime.now();
    final dias = List.generate(7, (i) => hoje.add(Duration(days: i)));
    final nomesDias = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escolha a data',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dias.length,
            itemBuilder: (context, i) {
              final dia = dias[i];
              final selecionado = dataSelecionada != null &&
                  dataSelecionada!.day == dia.day &&
                  dataSelecionada!.month == dia.month;
              return GestureDetector(
                onTap: () => setState(() => dataSelecionada = dia),
                child: Container(
                  width: 56,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: selecionado ? Colors.amber : Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nomesDias[dia.weekday % 7],
                        style: TextStyle(
                          color: selecionado ? Colors.black : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${dia.day}',
                        style: TextStyle(
                          color: selecionado ? Colors.black : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Escolha o horário',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: horarios.length,
          itemBuilder: (context, i) {
            final selecionado = horaSelecionada == horarios[i];
            return GestureDetector(
              onTap: () => setState(() => horaSelecionada = horarios[i]),
              child: Container(
                decoration: BoxDecoration(
                  color: selecionado ? Colors.amber : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    horarios[i],
                    style: TextStyle(
                      color: selecionado ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildConfirmacao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirme seu agendamento',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              _linhaConfirmacao(Icons.content_cut, 'Serviço', servicoSelecionado ?? ''),
              const Divider(color: Colors.grey),
              _linhaConfirmacao(Icons.person, 'Barbeiro', barbeiroSelecionado ?? ''),
              const Divider(color: Colors.grey),
              _linhaConfirmacao(
                Icons.calendar_today,
                'Data',
                dataSelecionada != null
                    ? '${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}'
                    : '',
              ),
              const Divider(color: Colors.grey),
              _linhaConfirmacao(Icons.access_time, 'Horário', horaSelecionada ?? ''),
            ],
          ),
        ),
      ],
    );
  }

  Widget _linhaConfirmacao(IconData icone, String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icone, color: Colors.amber, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(
            valor,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBotaoContinuar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () async {
            if (_passo == 0 && servicoSelecionado == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Selecione um serviço')));
              return;
            }
            if (_passo == 1 && barbeiroSelecionado == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Selecione um barbeiro')));
              return;
            }
            if (_passo == 2 && (dataSelecionada == null || horaSelecionada == null)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Selecione data e horário')));
              return;
            }

            if (_passo < 3) {
              setState(() => _passo++);
              return;
            }

            try {
              await FirebaseFirestore.instance.collection('agendamentos').add({
                'servico': servicoSelecionado,
                'barbeiro': barbeiroSelecionado,
                'data': '${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}',
                'hora': horaSelecionada,
                'createdAt': Timestamp.now(),
              });

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Agendamento confirmado!'),
                  backgroundColor: Colors.green,
                ));

              Navigator.pop(context);
            } catch (e) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red));
            }
          },
          child: Text(
            _passo < 3 ? 'CONTINUAR' : 'CONFIRMAR AGENDAMENTO',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

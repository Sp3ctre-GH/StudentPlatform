import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

void main() => runApp(const MaterialApp(home: StudentHome()));

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  List schedule = [];

  Future<void> fetchSchedule() async {
    String host = kIsWeb ? 'localhost' : '10.0.2.2';
    final url = Uri.parse('http://$host:8080/api/schedule');

    print("Спроба підключення до: $url");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          schedule = json.decode(utf8.decode(response.bodyBytes));
        });
      }
    } catch (e) {
      print("Помилка мережі: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не вдалося з’єднатися з сервером ($host)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Платформа студента'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: fetchSchedule,
              child: const Text('Оновити розклад з сервера'),
            ),
          ),
          Expanded(
            child: schedule.isEmpty
                ? const Center(child: Text('Натисніть кнопку, щоб отримати дані'))
                : ListView.builder(
              itemCount: schedule.length,
              itemBuilder: (context, i) => ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(schedule[i]['subject']),
                subtitle: Text('Ауд: ${schedule[i]['room']} | Час: ${schedule[i]['time']}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
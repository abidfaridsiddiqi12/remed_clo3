import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CollectionReference habitCollection;
  late Stream<QuerySnapshot> habitStream;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    habitCollection = FirebaseFirestore.instance.collection('habits');
    habitStream = habitCollection.snapshots();
  }

  Future<void> addHabit(String habitName, String habitDescription) async {
    await habitCollection.add({
      'completed': false,
      'habitName': habitName,
      'habitDescription': habitDescription,
    });
  }

  Future<void> toggleHabitCompletion(String habitId, bool completed) async {
    await habitCollection.doc(habitId).update({'completed': completed});
  }

  Future<void> deleteHabit(String habitId) async {
    await habitCollection.doc(habitId).delete();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // Existing code...

      body: StreamBuilder<QuerySnapshot>(
        stream: habitStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Terjadi kesalahan: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final habitList = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: habitList.length,
            itemBuilder: (context, index) {
              final habit = habitList[index].data() as Map<String, dynamic>;
              final habitId = habitList[index].id;

              return ListTile(
                title: Text(habit['habitName']),
                subtitle: Text(habit['habitDescription']),
                trailing: Icon(Icons.abc),
                leading: Checkbox(
                  value: habit['completed'],
                  onChanged: (value) {
                    setState(() {
                      toggleHabitCompletion(habitId, value ?? false);
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

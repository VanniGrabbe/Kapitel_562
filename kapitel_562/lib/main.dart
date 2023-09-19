import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  String gespeicherterText = 'Oh schade. Es regnet';

  String dataKey = 'myData';
  String data = '';
  String text = '';

  loadGespeicherterText() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    setState(() {
      gespeicherterText = store.getString(gespeicherterText) ?? '';
    });
  }
  saveGespeicherterText() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    store.setString(gespeicherterText, textController.text);
  }

  void speichern(){
    saveGespeicherterText();
  }

  void einfuegen(){
    setState(() {
      textController.text = gespeicherterText;
    });
  }


  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(dataKey, 'It is Party Time');
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      data = prefs.getString(dataKey) ?? 'Keine Daten gefunden';
      text = data;
    });
   
  }
  void updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(dataKey, 'Yes, on App Akademie');
  }
  void deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(dataKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('CRUD Operation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text(text),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: saveData, 
              child: Text('Speichern'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: loadData, 
              child: Text('Lesen'),
            ),
             SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: updateData, 
              child: Text('Aktualisieren'),
            ),
             SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: deleteData, 
              child: Text('Löschen'),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: TextField(
                controller: textController, 
                decoration: InputDecoration(labelText: 'Text eingeben'),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: speichern, 
              child: Text('Text speichern'),
              ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: einfuegen, 
              child: Text('Einfügen'),
              ),
          ],
        ),
      ),
    );
  }
}
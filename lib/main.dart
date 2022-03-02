import 'package:flutter/material.dart';

import 'DatabaseSupport.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MuleSoft Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Ref to DB Manager
  final dbHelper = DatabaseHelper.instance;
  // Data Visiblity Boolean
  bool isVisible = false;
  // Final List of All Rows
  List<Map<String, dynamic>>? fl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MuleSoft DB Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                " Application Framework: Flutter",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "DB : SQFlite",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text(
                  'Query Data',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _query();
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              isVisible && fl != null
                  ? Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                          itemCount: fl?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Text("Name: ${fl![index]['name']}", style: const TextStyle(
                                  fontSize: 15
                                ),),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Actor: ${fl![index]['actor']}", style: const TextStyle(
                                    fontSize: 15
                                ),),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Actress: ${fl![index]['actress']}", style: const TextStyle(
                                    fontSize: 15
                                ),),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                        ),
                    ),
                  )
                  : Container(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _insert,
          tooltip: 'Create Table & Insert',
          child: const Icon(Icons.add),
        ));
  }

  // Button onPressed methods
  void _insert() async {
    // Data's to insert
    Iterable<Map<String, dynamic>> rl;
    rl = [
      {
        DatabaseHelper.columnName: 'EthirNeechal',
        DatabaseHelper.columnActor: "Sivakarthikeyan",
        DatabaseHelper.columnActress: "Priya",
        DatabaseHelper.columnDirector: "Senthil",
        DatabaseHelper.columnYor: 2013
      },
      {
        DatabaseHelper.columnName: 'Darling',
        DatabaseHelper.columnActor: "G V Prakash",
        DatabaseHelper.columnActress: "Nikki",
        DatabaseHelper.columnDirector: "Sam",
        DatabaseHelper.columnYor: 2015
      },
      {
        DatabaseHelper.columnName: 'Dia',
        DatabaseHelper.columnActor: "Prithuvi",
        DatabaseHelper.columnActress: "Shetty",
        DatabaseHelper.columnDirector: "Ashok",
        DatabaseHelper.columnYor: 2020
      },
    ];
    // Loop to Interate each data in List and Insert It
    for (Map<String, dynamic> t in rl) {
      dbHelper.insert(t);
    }
  }

  // Get All Data
  void _query() async {
    List<Map<String, Object?>> allRows = (await dbHelper.queryAllRows())!;
    fl = allRows;
    print('query all rows:');
    // allRows!.forEach(print);
  }
}

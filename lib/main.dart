import 'package:flutter/material.dart';
import 'package:load_file/fetch_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Load file'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  Future<String>? textFromFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textController,
                  autofocus: false,
                  decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Material(
                        color: Colors.black,
                        shadowColor: Colors.black,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                textFromFile =
                                    readFile('assets/${textController.text}');
                              });
                            },
                            child: const Text('Найти',
                                style: TextStyle(color: Colors.white))),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.0)),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.0))),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: FutureBuilder<String>(
                future: textFromFile,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text('NONE'),
                      );
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());

                    case ConnectionState.done:
                      return SingleChildScrollView(child: Text(snapshot.data));

                    default:
                      return const SingleChildScrollView(
                        child: Text('Default'),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

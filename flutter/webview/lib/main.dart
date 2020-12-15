import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(
      todos: List.generate(
        20,
        (i) => Todo(
          'Todo $i',
          'A description of what needs to be done for Todo $i',
        ),
      ),
    ),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // Cuando un usuario pulsa en el ListTile, navega al DetailScreen.
            // Tenga en cuenta que no solo estamos creando un DetailScreen,
            // también le pasamos el objeto Todo actual!
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  WebViewController webViewController;
  final Todo todo;
  MyApp({Key key, @required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutt',
      home: Scaffold(
          appBar: AppBar(
          title: Text('Welcome to Flutt'),
        ), 
        //https://www.pagol.online/
        //http://192.168.0.184:4200
        body:   WebView(
          initialUrl:
              "http://34.67.8.179/payments/index.php?serviceid=10&period=20200201&amount=300.00&userid=4&clientno=3423",  //+ todo.description,
          javascriptMode: JavascriptMode.unrestricted,
     
          javascriptChannels: 
           Set.from([
            JavascriptChannel(
                name: 'Print',
                onMessageReceived: (JavascriptMessage message) {
                  print(message.message);
                  if(message.message == "1"){
                    Navigator.pop(context);
                  }
                })
          ]),
          onWebViewCreated: (WebViewController w) {
            webViewController = w;
          },
        ),
      ),
    );
  }
}

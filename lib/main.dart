import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapi/providers/ApiProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiProvider>(
      create: (context) => ApiProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late ApiProvider apiProvider;
  void _incrementCounter() async {}

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getAllData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, apiProvider, child) => Center(
            child: (apiProvider.isLoading)
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: apiProvider.foodItems.products!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(apiProvider.foodItems.products![index].price
                            .toString()),
                        leading: Text(apiProvider.foodItems.products![index].id
                            .toString()),
                        subtitle: Text(apiProvider
                            .foodItems.products![index].description
                            .toString()),
                        trailing: Text(apiProvider
                            .foodItems.products![index].rating
                            .toString()),
                      );
                    },
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

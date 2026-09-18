import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/counter_bloc.dart';

class Counterscreen extends StatefulWidget {
  const Counterscreen({super.key});

  @override
  State<Counterscreen> createState() => _CounterscreenState();
}

class _CounterscreenState extends State<Counterscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter Screen"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterStatus) {
                  int current = (state as CounterStatus).count;
                  return Text(current.toString(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              BlocProvider.of<CounterBloc>(context)
                  .add(DecrementButtonPressed());
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              BlocProvider.of<CounterBloc>(context)
                  .add(IncrementButtonPressed());
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/click_cubit.dart';
import 'cubit/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<theme_cubit>(
          create: (BuildContext context) => theme_cubit(),
        ),
        BlocProvider<ClickCubit>(
          create: (BuildContext context) => ClickCubit(),
        ),
      ],
      child: BlocBuilder<theme_cubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: state,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: BlocBuilder<ClickCubit, ClickState>(
                  builder: (context, state) {
                    if (state is Click) {
                      return Text(state.count.toString());
                    }
                    return const Text("");
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => context.read<ClickCubit>().minus(),
                    tooltip: '-',
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () => context.read<ClickCubit>().plus(),
                    tooltip: '+',
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      context.read<ClickCubit>().changeTheme();
                      context.read<theme_cubit>().changeTheme();
                    },
                    tooltip: 'theme',
                    child: const Icon(Icons.sunny),
                  ),
                  FloatingActionButton(
                    onPressed: () => context.read<ClickCubit>().delete(),
                    tooltip: 'delete share',
                    child: const Icon(Icons.restore_from_trash),
                  ),
                ],
              ),
              Center(
                child: BlocBuilder<ClickCubit, ClickState>(
                  builder: (context, state) {
                    List<Text> elements = [];
                    if (state is Click) {
                      for (var log in state.logs) {
                        elements.add(
                          Text(
                            log,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: elements,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

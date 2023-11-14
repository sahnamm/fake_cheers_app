import 'package:fake_cheers_app/enum.dart';
import 'package:fake_cheers_app/network/blocs/luckyPerson/lucky_person_bloc.dart';
import 'package:fake_cheers_app/network/provider/lucky_person_provider.dart';
import 'package:fake_cheers_app/network/repository/lucky_person_repository.dart';
import 'package:fake_cheers_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LuckyPersonProvider>(
          create: (context) => LuckyPersonProvider(),
        ),
        Provider<Util>(
          create: (context) => Util(),
        ),
      ],
      child: Provider<LuckyPersonRepository>(
        create: (context) => LuckyPersonRepository(
          context.read<LuckyPersonProvider>(),
          context.read<Util>(),
        ),
        child: BlocProvider(
          create: (context) => LuckyPersonBloc(
            context.read<LuckyPersonRepository>(),
          ),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fake Cheers App'),
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _yearBornCtr = TextEditingController();
  Mood? _selectedMood;
  List<bool> _moodSelectStatus = [false, false, false];
  bool _isMoodValid = false;
  bool _isMoodError = false;

  String? _cheerUpWords;
  Util util = Util();

  void _updateMood(int index, bool? status, Mood? mood) {
    _moodSelectStatus = _moodSelectStatus.map((e) => e = false).toList();
    if (status == true) {
      _selectedMood = mood;
      _moodSelectStatus[index] = status!;
    }
    _isMoodValid = _moodSelectStatus.any((element) => true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Name: '),
                    TextFormField(
                      key: const Key('text-field-name'),
                      controller: _nameCtr,
                      decoration: const InputDecoration(hintText: 'John Doe'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Year Born: '),
                    TextFormField(
                      key: const Key('text-field-year-born'),
                      controller: _yearBornCtr,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: '2000'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Cmon don\'t shy :)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Current Mood: '),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: Mood.values.length,
                      itemBuilder: (context, index) {
                        final mood = Mood.values[index];
                        return CheckboxListTile(
                          title: Text(mood.name),
                          value: _moodSelectStatus[index],
                          onChanged: (value) => _updateMood(index, value, mood),
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: VisualDensity.compact,
                        );
                      },
                    ),
                    Visibility(
                      visible: _isMoodError,
                      child: Container(
                        key: const Key('mood-error'),
                        child: const Text(
                          'Pick one!',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    key: const Key('button-submit'),
                    onPressed: () {
                      // debugPrint("_isMoodValid [$_isMoodValid]");
                      if (_formKey.currentState?.validate() == false ||
                          !_isMoodValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ups, Try Again!')),
                        );
                        setState(() {
                          if (!_isMoodValid) _isMoodError = true;
                        });
                      } else {
                        setState(() {
                          _isMoodError = false;
                          _cheerUpWords = util.doCheerMeUp(
                            _nameCtr.text,
                            int.parse(_yearBornCtr.text),
                            _selectedMood!,
                          );
                        });
                      }
                    },
                    child: const Text('Cheer Me Up'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    key: const Key('button-reset'),
                    onPressed: () {
                      setState(() {
                        _formKey.currentState?.reset();
                        _nameCtr.clear();
                        _yearBornCtr.clear();
                        _moodSelectStatus[0] = false;
                        _moodSelectStatus[1] = false;
                        _moodSelectStatus[2] = false;
                        _isMoodValid = false;
                        _isMoodError = false;
                        _cheerUpWords = null;
                      });
                      context.read<LuckyPersonBloc>().add(LuckyPersonReset());
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('button-lucky-person'),
                onPressed: () {
                  context.read<LuckyPersonBloc>().add(LuckyPersonFetched());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    textAlign: TextAlign.center,
                    "Stick to this person to get lucky today, find out!",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible:
                    _cheerUpWords != null && _cheerUpWords?.isNotEmpty == true,
                child: Container(
                  key: const Key('text-cheer-up'),
                  child: Text(
                    _cheerUpWords ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              BlocBuilder(
                key: const Key('bloc-builder'),
                bloc: BlocProvider.of<LuckyPersonBloc>(context),
                builder: (context, state) {
                  if (state is LuckPersonFetchedInProgress) {
                    return const CircularProgressIndicator();
                  } else if (state is LuckPersonFetchedSuccess) {
                    return Container(
                        key: const Key("lucky-person-text"),
                        child: Text(state.name));
                  } else if (state is LuckPersonFetchedFailure) {
                    return const Text('Opps, no lucky person today :(');
                  }

                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hancod_theme/hancod_theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Example',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _inputDecoration = const InputDecoration(border: OutlineInputBorder());
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello Hancod!')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextForm<String>(
                  name: 'text',
                  label: 'Text Form',
                  decoration: _inputDecoration,
                ),
                const SizedBox(height: 8),
                AppPhoneNumberForm(
                  name: 'phone',
                  label: 'Phone No.',
                  decoration: _inputDecoration,
                ),
                const SizedBox(height: 8),
                AppTypeAheadForm<int>(
                  name: 'age',
                  label: 'Age',
                  decoration: _inputDecoration,
                  suggestionsCallback: (search) =>
                      List.generate(100, (index) => index)
                          .where((element) => '$element'.contains(search))
                          .toList(),
                  itemBuilder: (context, suggestion) => ListTile(
                    title: Text('$suggestion'),
                  ),
                  selectionToTextTransformer: (suggestion) => '$suggestion',
                ),
                const SizedBox(height: 8),
                AppDateTimeForm(
                  name: 'date',
                  label: 'Date',
                  decoration: _inputDecoration,
                ),
                const SizedBox(height: 18),
                AppButton(
                  onPress: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {}
                  },
                  label: const Text('Primary'),
                ),
                const SizedBox(height: 8),
                AppButton(
                  style: ButtonStyles.secondary,
                  onPress: () {},
                  label: const Text('Secondary'),
                ),
                const SizedBox(height: 8),
                AppButton(
                  style: ButtonStyles.cancel,
                  onPress: () {},
                  label: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

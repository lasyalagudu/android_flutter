import 'package:flutter/material.dart';
void main() {
  runApp(const UnitConverterApp());
}
class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UnitConverterHomePage(),
    );
  }
}

class UnitConverterHomePage extends StatefulWidget {
  const UnitConverterHomePage({super.key});
  @override
  UnitConverterHomePageState createState() => UnitConverterHomePageState();
}

class UnitConverterHomePageState extends State<UnitConverterHomePage> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'Centimeters';
  String _toUnit = 'Meters';
  String _result = '';

  final List<String> _units = ['Centimeters', 'Meters', 'Grams', 'Kilograms'];

  void _convert() {
    double input = double.tryParse(_inputController.text) ?? 0;
    double result;

    switch (_fromUnit) {
      case 'Centimeters':
        result = _toUnit == 'Meters' ? input / 100 : input;
        break;
      case 'Meters':
        result = _toUnit == 'Centimeters' ? input * 100 : input;
        break;
      case 'Grams':
        result = _toUnit == 'Kilograms' ? input / 1000 : input;
        break;
      case 'Kilograms':
        result = _toUnit == 'Grams' ? input * 1000 : input;
        break;
      default:
        result = input;
    }

    setState(() {
      _result = '$input $_fromUnit = $result $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                    });
                  },
                  items: _units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _toUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toUnit = newValue!;
                    });
                  },
                  items: _units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(LoanCalculatorApp());
}

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _percentController = TextEditingController();
  double _numMonths = 1;
  double _monthlyPayment = 0;

  void _calculateLoan() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double interestRate = double.tryParse(_percentController.text) ?? 0;
    double totalMonths = _numMonths;

    if (amount > 0 && interestRate > 0 && totalMonths > 0) {
      double monthlyRate = interestRate / 100;
      _monthlyPayment = amount * monthlyRate / (1 - (1 / (1 + monthlyRate)));
    } else {
      _monthlyPayment = 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Loan calculator',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),
            Text(
              'Enter amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Amount',
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Enter number of months',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10.0,   // Adjust the height of the slider track
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), // Customize the thumb size
              ),
              child: Slider(
                value: _numMonths,
                onChanged: (newMonths) {
                  setState(() {
                    _numMonths = newMonths;
                  });
                },
                min: 1,
                max: 60,
                divisions: 59,
                label: _numMonths.toStringAsFixed(0),
                activeColor: Colors.blue[700],   // Dark blue color for active track
                inactiveColor: Colors.grey,      // Grey color for inactive track
                thumbColor: Colors.blue[900],    // Dark blue color for thumb (dot)
              ),
            ),

            Text(
              '${_numMonths.toStringAsFixed(0)} luni',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Enter % per month',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _percentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Percent',
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'You will pay the approximate amount monthly:',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10), // Add some spacing
            Text(
              '${_monthlyPayment.toStringAsFixed(2)}€',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              textAlign: TextAlign.center, // Move the payment text outside the box
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateLoan,
              child: Text(
                'Calculate',
                style: TextStyle(color: Colors.white), // Change text color to white
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.blue[900]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
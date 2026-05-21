import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiCurrencyConverter extends StatefulWidget {
  const MultiCurrencyConverter({super.key});

  @override
  State<MultiCurrencyConverter> createState() => _MultiCurrencyConverterState();
}

class _MultiCurrencyConverterState extends State<MultiCurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'INR';
  String _result = '0.00';

  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
  'INR': 96.29,  
  'EUR': 0.86,   
  'GBP': 0.74,   
  'JPY': 158.94, 
  'AUD': 1.40,   
  'CAD': 1.38,
  };

  void _convertCurrency() {
    double? inputAmount = double.tryParse(_amountController.text);
    if (inputAmount == null || inputAmount <= 0) {
      setState(() => _result = "0.00");
      return;
    }
    double amountInUSD = inputAmount / _exchangeRates[_fromCurrency]!;
    double convertedAmount = amountInUSD * _exchangeRates[_toCurrency]!;
    setState(() {
      _result = convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Background
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F2F1), Color(0xFFB2EBF2)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Universal Currency\nConverter',
                  style: TextStyle(
                    fontFamily: 'FinlandicaHeadline', // Match the name in YAML
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263238),
                    ),
                  ),
                const SizedBox(height: 40),
                
                // Main Input Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Amount", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: "0.00",
                          prefixText: "\$ ",
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCurrencySelector("From", _fromCurrency, (val) => setState(() => _fromCurrency = val!)),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: Color(0xFFD1E3FF), shape: BoxShape.circle),
                            child: const Icon(Icons.swap_horiz, color: Colors.blueAccent),
                          ),
                          _buildCurrencySelector("To", _toCurrency, (val) => setState(() => _toCurrency = val!)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      
                      // Gradient Convert Button
                      InkWell(
                        onTap: _convertCurrency,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF90CAF9), Color(0xFF80DEEA)]),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text("Convert", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Result Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Converted Amount", 
                        style: TextStyle(
                          fontSize: 16, 
                          color: Color(0xFF263238), 
                          fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        "$_result $_toCurrency",
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF37474F)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Exchange Rate: 1 $_fromCurrency = ${(_exchangeRates[_toCurrency]! / _exchangeRates[_fromCurrency]!).toStringAsFixed(4)} $_toCurrency",
                        style:  TextStyle(
                          fontSize: 12, 
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencySelector(String label, String value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, 
        style: TextStyle(
          color: Colors.blueGrey[900], 
          fontSize: 14, 
          fontWeight: FontWeight.bold
          ),
        ),
        DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: _exchangeRates.keys.map((String curr) {
            return DropdownMenuItem(value: curr, child: Text(curr, style: const TextStyle(fontWeight: FontWeight.bold)));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
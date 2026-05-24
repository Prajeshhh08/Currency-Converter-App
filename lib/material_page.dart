import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  double _currentRate = 0.0;
  
  List<String> _currencies = ['USD', 'INR', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD'];

  // This runs when the app starts to get the full list of currencies from apiiiii
  @override
  void initState() {
    super.initState();
    _fetchCurrencies(); 
  }

  Future<void> _fetchCurrencies() async {
    print("Step 1: Starting API Call...");
    const String apiKey = '63cab0b58067bda1157d53eb';
    final String url = 'https://v6.exchangerate-api.com/v6/$apiKey/codes';

    try {
      final response = await http.get(Uri.parse(url));
      print("Step 2: Response Received! Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Step 3: Data decoded successfully.");
        List<String> tempCodes = [];
        for (var code in data['supported_codes']) {
          tempCodes.add(code[0]); 
        }
        setState(() {
          _currencies = tempCodes;
        });
      }
    } catch (e) {
      debugPrint("Could not fetch codes, using defaults.");
    }
  }

  Future<void> _convertCurrency() async {
    const String apiKey = 'API_KEY_HERE'; 
    final String url = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/$_fromCurrency';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        double rate = data['conversion_rates'][_toCurrency].toDouble();

        setState(() {
          _currentRate = rate; 
          double inputAmount = double.tryParse(_amountController.text) ?? 0.0;
          _result = (inputAmount * _currentRate).toStringAsFixed(2);
        });
      } else {
        setState(() => _result = "Error: API Side");
      }
    } catch (e) {
      setState(() => _result = "Check Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currencies.length <= 7) { 
    return const Scaffold(
      backgroundColor: Color(0xFFE0F2F1), 
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F2F1), Color(0xFFB2EBF2)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Universal Currency\nConverter',
                    style: TextStyle(
                      fontFamily: 'FinlandicaHeadline', 
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                      ),
                    ),
                  const SizedBox(height: 40),
                  // actual inputcard
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
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
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _buildCurrencySelector("From", _fromCurrency, (val) {
                                if (val != null) {
                                  setState(() {
                                    _fromCurrency = val;
                                    });
                                    _convertCurrency(); 
                                  }
                                }),
                              ), 
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(color: Color(0xFFD1E3FF), shape: BoxShape.circle),
                              child: const Icon(Icons.swap_horiz, color: Colors.blueAccent),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildCurrencySelector("To", _toCurrency, (val) {
                                if (val != null) {
                                  setState(() {
                                    _toCurrency = val;
                                  });
                                  _convertCurrency(); // <--- AND ADD IT HERE
                                }
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        
                        // convert button
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
                  // result 
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0F7FA).withValues(alpha: 0.7),
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
                          "Exchange Rate: 1 $_fromCurrency = ${_currentRate.toStringAsFixed(4)} $_toCurrency",
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
      ),
    );
  }

Widget _buildCurrencySelector(String label, String value, ValueChanged<String?> onSelected) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: Colors.blueGrey[900], fontSize: 14, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      DropdownMenu<String>(
        width: constraints.maxWidth, 
        menuHeight: 300,
        initialSelection: value,
        enableFilter: true, 
        requestFocusOnTap: true,
        label: Text(label),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.5),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        dropdownMenuEntries: _currencies.map((String curr) {
          return DropdownMenuEntry<String>(
            value: curr,
            label: curr,
            style: MenuItemButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          );
        }).toList(),
        onSelected: onSelected,
      ),
    ],
  );
  }
    );
  }
}

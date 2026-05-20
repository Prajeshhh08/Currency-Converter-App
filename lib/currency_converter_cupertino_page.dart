import 'package:flutter/cupertino.dart';

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() => _CurrencyConverterCupertinoPageState();
}

class _CurrencyConverterCupertinoPageState extends State<CurrencyConverterCupertinoPage> {
    double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  void convert(){
    result = double.parse(textEditingController.text) * 92.73 ;
    setState(() {});
  }
   
  @override
  Widget build(BuildContext context) {

  return CupertinoPageScaffold(
    backgroundColor:Color.fromARGB(255, 170, 228, 255),
    navigationBar: CupertinoNavigationBar(
      backgroundColor:Color.fromARGB(255, 170, 228, 255),
      middle: const Text('Currency Converter'),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              'Rs.${result !=0 ? result.toStringAsFixed(3) : result.toStringAsFixed(0)}',
              style:const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold, 
                color: Color.fromARGB(255, 1, 1, 1)
              ),
            ),
            CupertinoTextField(
              controller: textEditingController,
              style: const TextStyle(
                color: Color.fromARGB(200, 0, 0, 0)
              ),
              decoration:BoxDecoration(
                color: Color.fromARGB(200, 0, 0, 0),
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              placeholder: 'Enter amount in USD:',
              prefix: const Icon(CupertinoIcons.money_dollar),
              keyboardType: const TextInputType.numberWithOptions()
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              onPressed: convert,
              color: Color.fromARGB(200, 0, 0, 0),
              child: Text("Convert!"),
            )
          ],
        ),
      ),
    ),
  );  }
}
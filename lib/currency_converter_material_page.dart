import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget{
  const CurrencyConverterMaterialPage({super.key});
 
 @override
  State<CurrencyConverterMaterialPage> createState() => _CurrencyConverterMaterialPageState();
  }

class _CurrencyConverterMaterialPageState extends
 State<CurrencyConverterMaterialPage>{ 
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  void convert(){
    result = double.parse(textEditingController.text) * 92.73 ;
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }//used to dsipose useless controllers which i havent used!!

   @override
  Widget build(BuildContext context){
    final myBorder = OutlineInputBorder( 
     borderSide: const BorderSide(
       color: Colors.black,
       width: 2.0,
       style: BorderStyle.solid,         
     ),
     borderRadius: BorderRadius.all(
       Radius.circular(10),)
   );
  return Scaffold(
    backgroundColor:Color.fromARGB(255, 170, 228, 255),
    appBar: AppBar(
      backgroundColor:Color.fromARGB(255, 170, 228, 255),
      title: const Text('Currency Converter'),
      centerTitle: true,
    ),
    body: Center(
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
            TextField(
              controller: textEditingController,
              style: const TextStyle(
                color: Color.fromARGB(200, 0, 0, 0)
              ),
              decoration: InputDecoration(
                hintText: 'Enter amount in USD:',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(200, 0, 0, 0)
                ),
                prefixIcon: const Icon(Icons.attach_money),
                prefixIconColor: Color.fromARGB(200, 0, 0, 0),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: myBorder,
                enabledBorder: myBorder,
              ),
              keyboardType: const TextInputType.numberWithOptions()
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: convert,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: const Size(370, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(10),
                ),
              ),
              child: Text("Convert!"),
            )
          ],
        ),
      ),
    ),
  );
 }
}


import 'package:flutter/material.dart';
import 'package:measure_convertor/util/conver_util.dart';

class MeasureConvertor extends StatefulWidget {
  @override
  MeasureConvertorState createState() => MeasureConvertorState();
}

class MeasureConvertorState extends State<MeasureConvertor> {
  double _numberFrom = 0;
  String _startMeasure ;
  String _convertedMeasure ;
  double _result = 0;
  String _resultMessage = '';
  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.black,
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.black,
    );

    final spacer = Padding(padding: EdgeInsets.only(bottom: sizeY/40));
    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
    ];
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(title: Text(
        'Measure Convertor', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        width: sizeX,
        padding: EdgeInsets.all(sizeX/20),
        child: SingleChildScrollView(child: Column(
          children: [
            Text('Value', style: labelStyle,),
            spacer,
            TextField(
              style: inputStyle,
              decoration: InputDecoration(
                     labelText: "Enter Measure to be Converted",
                     labelStyle: TextStyle(color: Colors.black),
                     fillColor: Colors.black,
                     focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
              onChanged: (text) {
                setState(() {
                  _numberFrom = double.parse(text);
                });
              },
            ),
            spacer,
            Text('From', style: labelStyle,),
            spacer,
            DropdownButtonHideUnderline(
            child: Container(
            width: 400,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: ShapeDecoration(
            color: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
            Radius.circular(10)))
            ),
                    child: DropdownButton(
                      isExpanded: true,
                      style: inputStyle,
                      value: _startMeasure,
                      items: _measures.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: inputStyle,),
                        );
                      }).toList(),
                      onChanged: (value) {
                        onStartMeasureChanged(value);
                      },
                    ),)
            ),
            spacer,
            Text('To', style: labelStyle,),
            spacer,
        DropdownButtonHideUnderline(
        child: Container(
        width: 400,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: ShapeDecoration(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
        Radius.circular(10)))
        ),
          child: DropdownButton(
              isExpanded: true,
              style: inputStyle,
              value: _convertedMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onConvertedMeasureChanged(value);
              },
            ),
        )),
            spacer,
            SizedBox(height: 20,),
            ButtonTheme(
              buttonColor: Colors.black,
              minWidth: 400.0,
              child: RaisedButton(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Convert',style: TextStyle(color: Colors.white)),
                ),
                onPressed: ()=>convert(),
              )),
            spacer,
            SizedBox(height: 20,),
            Text(_resultMessage, style: labelStyle,)
          ],
        )),
      ),
    );
  }

  void onStartMeasureChanged(String value) {
    setState(() {
      _startMeasure = value;
    });
  }
  void onConvertedMeasureChanged(String value) {
    setState(() {
      _convertedMeasure = value;
    });
  }

  void convert() {
    if (_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom==0) {
      return;
    }
    Conversion c = Conversion();
    double result = c.convert(_numberFrom, _startMeasure, _convertedMeasure);
    setState(() {
      _result = result;
      if (result == 0) {
        _resultMessage = 'This conversion cannot be performed';
      }
      else {
        _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${_result.toString()} $_convertedMeasure';
      }

    });
  }
  
}

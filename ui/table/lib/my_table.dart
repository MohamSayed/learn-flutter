import 'package:flutter/material.dart';


class MyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(  
            defaultColumnWidth: FixedColumnWidth(100.0),  
            columnWidths: {1: FractionColumnWidth(.5)},
            border: TableBorder.all(width: 2.1, color: Colors.greenAccent, style: BorderStyle.solid),
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            textBaseline: TextBaseline.alphabetic,
            children: [
              TableRow(
                children: [
                  Container(
                    height: 50.0,
                    child: Material(                    
                      color: Colors.blueAccent,
                      child: Icon(Icons.ac_unit),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: Material(                    
                      color: Colors.yellowAccent,
                      child: Icon(Icons.ac_unit),
                    ),
                  )
                ]
              ),

              TableRow(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: Material(
                      color: Colors.greenAccent,
                      child: 
                        Center(
                          child: 
                          Text("Text")),),
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: Material(
                      color: Colors.redAccent,
                      child: 
                        Center(
                          child: 
                          Text("Text")),),
                  )
                ]
              ),
            
            ]
        ),
    );
  }
}
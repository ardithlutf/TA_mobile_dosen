import 'package:flutter/material.dart';
import 'package:lima_enam/src/ui/sprint/create_sprint.dart';

class ButtomNavBar extends StatefulWidget {
  @override
  _ButtomNavBarState createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Tambah Sprint',
        onPressed: () {
          openAddPage();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: 'Menu',
              icon: Icon(Icons.menu),
              onPressed: () {
                dropdownWidget();
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  openAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CreateSprint();
      }),
    );
  }

  Widget dropdownWidget() {
    final List<String> _dropdownValues = [
      "One",
      "Two",
      "Three",
      "Four",
      "Five"
    ]; //The list of values we want on the dropdown
    String _currentlySelected = "";

    return DropdownButton(
      //map each value from the lIst to our dropdownMenuItem widget
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
        child: Text(value),
        value: value,
      ))
          .toList(),
      onChanged: (String value) {
        //once dropdown changes, update the state of out currentValue
        setState(() {
          _currentlySelected = value;
        });
      },
      //this wont make dropdown expanded and fill the horizontal space
      isExpanded: false,
      //make default value of dropdown the first value of our list
      value: _dropdownValues.first,
    );
  }
}

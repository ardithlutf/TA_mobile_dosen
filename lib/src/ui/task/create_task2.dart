import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/widgets.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:lima_enam/src/models/sprint_model.dart';

class BuatTask extends StatefulWidget {
  @override
  _BuatTaskState createState() => _BuatTaskState();
}

class _BuatTaskState extends State<BuatTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: blocSprint.allSprints,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Text("ada datanya");
            return DropDownField(
              controller: projectDipilih,
              hintText: 'Pilih Project',
              enabled: true,
              items: snapshot.data,
              onValueChanged: (value) {
                setState(() {
                  pilihproject = value;
                  blocTask.insertSprintID(int.parse(value));
                });
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

String pilihproject = "";
final projectDipilih = TextEditingController();

List<String> project = ["oke", "siap"];

// class BuatSprint extends StatefulWidget {
//   @override
//   _BuatSprintState createState() => _BuatSprintState();
// }
//
// class _BuatSprintState extends State<BuatSprint> {
//   var _currencies = [
//     "Food",
//     "Transport",
//     "Personal",
//     "Shopping",
//     "Medical",
//     "Rent",
//     "Movie",
//     "Salary"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30),
//           child: FormField<String>(
//             builder: (FormFieldState<String> state) {
//               return InputDecorator(
//                 decoration: InputDecoration(
//                   labelStyle: textStyle,
//                     errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//                     hintText: 'Please select expense',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
//                 isEmpty: _currentSelectedValue == '',
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: _currentSelectedValue,
//                     isDense: true,
//                     onChanged: (String newValue) {
//                       setState(() {
//                         _currentSelectedValue = newValue;
//                         state.didChange(newValue);
//                       });
//                     },
//                     items: _currencies.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Item {
//   const Item(this.name, this.icon);
//   final String name;
//   final Icon icon;
// }
//
// class DropdownSprint extends StatefulWidget {
//   @override
//   _DropdownSprintState createState() => _DropdownSprintState();
// }
//
// class _DropdownSprintState extends State<DropdownSprint> {
//   Item selectedUser;
//   List<Item> users = <Item>[
//     const Item(
//         'Android',
//         Icon(
//           Icons.android,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Flutter',
//         Icon(
//           Icons.flag,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'ReactNative',
//         Icon(
//           Icons.format_indent_decrease,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'iOS',
//         Icon(
//           Icons.mobile_screen_share,
//           color: const Color(0xFF167F67),
//         )),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: DropdownButton<Item>(
//       hint: Text("Select item"),
//       value: selectedUser,
//       onChanged: (Item Value) {
//         setState(() {
//           selectedUser = Value;
//         });
//       },
//       items: users.map((Item user) {
//         return DropdownMenuItem<Item>(
//             child: Row(
//           children: <Widget>[
//             user.icon,
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               user.name,
//               style: TextStyle(color: Colors.black),
//             ),
//           ],
//         ));
//       }).toList(),
//     ));
//   }
// }

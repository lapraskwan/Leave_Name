import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Check the list of font-awesome-icons here: https://fontawesome.com/icons?d=gallery

class Choices extends StatelessWidget {
  final Map<String, IconData> coreFunctions = {
    'Team': FontAwesomeIcons.volleyballBall,
    'Floor': Icons.group,
    
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          ...coreFunctions.keys
              .toList()
              .map((iconKey) => GridTile(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(bottom: 5),
                          child: Material(
                            color: Colors.white,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                            child: Center(
                              child: Ink(
                                // decoration: ShapeDecoration(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //   ),
                                //   color: Colors.grey[200],
                                // ),
                                child: InkWell(
                                    onTap: () {/* ... */},
                                    child: Center(
                                      child: Icon(
                                        coreFunctions[iconKey],
                                        size: 50,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Text(iconKey),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/nhl.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'NHL',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Stanly Cup Final',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Container(
            // child: Column(
            //   children: [
            //     Container(
            //       width: double.infinity,
            //       color: Colors.black,
            //       child: Padding(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //         child: Text(
            //           'Stanly Cup Final',
            //           style: TextStyle(
            //             fontWeight: FontWeight.normal,
            //             color: Colors.white60,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            ));
  }
}

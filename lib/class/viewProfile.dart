import 'package:flutter/material.dart';
import 'package:nuol_research/views/home.dart';

class ViewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Home.data == null
              ? Text(
                  'ບໍ່ມີຮູບພາບ',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
              : Home.data['profile'] == 'no profile'
                  ? Text(
                      'ບໍ່ມີຮູບພາບ',
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )
                  : InteractiveViewer(
                      child: Image.network(Home.data['profile']),
                      panEnabled: true,
                      minScale: 1,
                      maxScale: 3,
                    ),
        ),
      ),
    );
  }
}

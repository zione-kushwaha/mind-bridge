import 'package:flutter/material.dart';

class LearnAlphabetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: Text(
              'LEARN ALPHABETS',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(800),
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.42,
                  child: Row(
                    children: [
                      Text(
                        'a',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text(
                        'A',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.38,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      'A simple explanation to the audience regarding the header',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(
                  'assets/first/15.png',
                  width: MediaQuery.of(context).size.height * 0.1,
                ),
              )
            ],
          ),
          Image.asset(
              height: MediaQuery.of(context).size.height * 0.3,
              'assets/first/14.png')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {},
        child: Icon(Icons.forward, color: Colors.white),
      ),
    );
  }
}

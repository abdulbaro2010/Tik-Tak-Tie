import 'package:flutter/material.dart';
import 'package:game/HomePage.dart';


class Lobby extends StatelessWidget {
  const Lobby({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage(
              "assets/images/p1.png",
            ),
            ),
        
            SizedBox(height: 50.0),
            Text("Tik Tak Toe",
            style: TextStyle(
              fontSize: 50.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
            ),

            SizedBox(height: 190.0),

          Container(
           
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
            ),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => HomePage()));
                }, 
                child: Text("Start Game",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
                color: Colors.redAccent,
                ),
              ],
            ),
          ),
          ],
        ),
      ),  
       
    );
  }
}
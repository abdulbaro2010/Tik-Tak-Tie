import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game/cutom_dialog.dart';
import 'package:game/game_button.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

late List <Gamebutton> buttonsLists;
 var player1;
 var player2;
 var activePlayer;

@override
  void initState() {
    super.initState();
    buttonsLists = doInit();
  }

  List<Gamebutton> doInit(){
    
    player1 = List.empty();
    player2 = List.empty();
    activePlayer =  1;

    var gameButtons = <Gamebutton>[
    new Gamebutton(id: 1),
    new Gamebutton(id: 2),
    new Gamebutton(id: 3),
    new Gamebutton(id: 4),
    new Gamebutton(id: 5),
    new Gamebutton(id: 6),
    new Gamebutton(id: 7),
    new Gamebutton(id: 8),
    new Gamebutton(id: 9),
    ];
    return gameButtons;
  } 

  void playGame(Gamebutton gb){
    setState(() {
      if (activePlayer == 1){
        gb.text ="X";
        gb.bg = Colors.red;
        activePlayer = 2;
        player1 = (gb.id);
      }else{
        gb.text = "0";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2 = (gb.id);
      }
      gb.enabled = false;
     int winner = checkWinner();
     if(winner == -1){
       if (buttonsLists.every((p) => p.text !="")){
         showDialog(
          context: context,
          builder: (_) => CustomDialog("Game Tied", "Press the reset button to start again", resetGame),
            
         );
       }else{
         // ignore: unnecessary_statements
         activePlayer == 2? autoPlay() :null;
         }
     }
    });
  }
  void  autoPlay(){
    var emptyCells =  new List.empty();
    var list = List.generate(9 , (i) => i + 1);
     for (var cellID in list ){
       if (!(player1.contains(cellID)|| player2.contains(cellID))){
         emptyCells.add(cellID);
       }
     }
     var r = Random();
     var randIndex= r.nextInt(emptyCells.length-1);
     var cellID = emptyCells[randIndex];
     int i = buttonsLists.indexWhere((p) => p.id == cellID);
     playGame(buttonsLists[i]);
  }
  int checkWinner(){
    // ignore: non_constant_identifier_names
    var Winner = -1;

    //row 1

    if (player1.contains(1) && player1.contains(2) && player1.contains(3)){
      Winner = 1;
    }
     if (player2.contains(1) && player2.contains(2) && player2.contains(3)){
      Winner = 2;
    }

    //row 2

    if (player1.contains(4) && player1.contains(5) && player1.contains(6)){
      Winner = 1;
    }
     if (player2.contains(4) && player2.contains(5) && player2.contains(6)){
      Winner = 2;
    }
    
    //row 3

    if (player1.contains(7) && player1.contains(8) && player1.contains(9)){
      Winner = 1;
    }
     if (player2.contains(7) && player2.contains(8) && player2.contains(9)){
      Winner = 2;
    }

    //col 1

    if (player1.contains(1) && player1.contains(4) && player1.contains(7)){
      Winner = 1;
    }
     if (player2.contains(1) && player2.contains(4) && player2.contains(7)){
      Winner = 2;
    }

    //col 2

       if (player1.contains(2) && player1.contains(5) && player1.contains(8)){
      Winner = 1;
    }
     if (player2.contains(2) && player2.contains(5) && player2.contains(8)){
      Winner = 2;
    }

    //col 3

       if (player1.contains(3) && player1.contains(6) && player1.contains(9)){
      Winner = 1;
    }
     if (player2.contains(3) && player2.contains(6) && player2.contains(9)){
      Winner = 2;
    }

    //diag 1

    if (player1.contains(1) && player1.contains(5) && player1.contains(9)){
      Winner = 1;
    }
     if (player2.contains(1) && player2.contains(5) && player2.contains(9)){
      Winner = 2;
    }

    //dia 2

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)){
      Winner = 1;
    }
     if (player2.contains(3) && player2.contains(5) && player2.contains(7)){
      Winner = 2;
    }

    if (Winner != -1){
      if (Winner == 1){
        showDialog(
        context: context,
        builder: (_) => CustomDialog(
        "Player 1 Won",
        "Press the reset button to restart", 
        resetGame
        ));
      }else{ 
         showDialog(
        context: context,
        builder: (_) => CustomDialog(
        "Player 2 Won",
        "Press the reset button to restart", 
        resetGame
        ));

      }
    }
    return Winner;
  }

  void resetGame(){
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsLists = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Expanded(
          child: GridView.builder(
           padding: EdgeInsets.all(10.0),
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 3,
             childAspectRatio: 1.0,
             crossAxisSpacing: 9.0,
             mainAxisSpacing: 9.0,
           ),
           itemCount: buttonsLists.length,
           itemBuilder: (context, i) => SizedBox(
             width: 100.0,
             height: 100.0,
             // ignore: deprecated_member_use
             child: RaisedButton(
               padding: EdgeInsets.all(8.0),
               onPressed: buttonsLists[i].enabled?() =>playGame(buttonsLists[i]):null,
               child: Text(buttonsLists[i].text,
               style: TextStyle(
               color: Colors.white,
               fontSize: 20.0,
               ),
               ),
               color: buttonsLists[i].bg,
               disabledColor: buttonsLists[i].bg,
             ),
           ),
              
          ),
        ),
        // ignore: deprecated_member_use
        RaisedButton(
          child: Text("Reset",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          ),
          color: Colors.redAccent,
          padding: EdgeInsets.all(20.0),
          onPressed: resetGame,
        ),
        ],
      ),
    );
  }
}

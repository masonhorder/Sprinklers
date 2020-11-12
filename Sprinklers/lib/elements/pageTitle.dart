import 'package:flutter/material.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:Sprinklers/screens/settings.dart';

pageTitle(BuildContext context, String pageHeaderTitle, bool homePage, bool back){
  if(homePage == true){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        IconButton(
          icon: Icon(Icons.play_circle_filled, color: darkGrey,),
          iconSize: 36,

        ),
        SizedBox(width: 10,),
        Container(
          child: Text(pageHeaderTitle, style: pageTitleStyle),
        ),
        SizedBox(width: 10,),
        IconButton(
          icon: Icon(Icons.settings, color: darkGrey,),
          iconSize: 36,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
      ]
    );
  }else{
    if(back == true){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Container(
            width:50,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: darkFontColor,),
              iconSize: 36,
              onPressed: (){
                Navigator.pop(context,);
              },
            ),
          ),
          SizedBox(width: 10,),
          Container(
            child: Text(pageHeaderTitle, style: pageTitleStyle),
          ),
          SizedBox(width: 10,),
          SizedBox(width:50)
          // IconButton(
          //   icon: Icon(Icons.settings, color: darkFontColor,),
          //   iconSize: 36,

          // ),
        ]
      );
    }
    else{
      return Container(child: Text(pageHeaderTitle, style: pageTitleStyle),);
    }
  }
  

}
import 'package:flutter/material.dart';
import 'package:intro_ui/pages/home_page.dart';
import 'package:intro_ui/utils/Strings.dart';

import 'home_page.dart';
class IntroPage extends StatefulWidget{
  static final String id='intro_page';
  @override
  _IntroPageState createState()=>_IntroPageState();
}
class _IntroPageState extends State<IntroPage>{
  PageController _controller;
  int _pageIndex=0;
  @override
  void initState(){
    super.initState();
    _controller=PageController(
      initialPage:0,
    );
  }
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.white,
      body:Stack(
        alignment:Alignment.bottomCenter,
        children:[
          //pages
          PageView(
            controller:_controller,
            onPageChanged:(int index){
              setState((){
                _pageIndex=index;
              });
            },
            children:[
              //first page
              makePage(
                title:Str.firstTitle,
                content:Str.firstContent,
                image:'assets/images/image_1.png',
              ),
              //second page
              makePage(
                title:Str.secondTitle,
                content:Str.secondContent,
                image:'assets/images/image_2.png',
              ),
              //third page
              makePage(
                title:Str.thirdTitle,
                content:Str.thirdContent,
                image:'assets/images/image_3.png',
              ),
            ],
          ),
          Container(
            margin:EdgeInsets.only(bottom:50),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:<Widget>[...?_indicatorBuilder()],
            ),
          ),
          //#SKIP BUTTON
          if(_pageIndex==2)Container(
            margin:EdgeInsets.only(right:30,bottom:43),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children:[
                _skipButton(title:'Skip'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget makePage({title,content,image}){
    //page elements
    return Container(
      padding:EdgeInsets.only(left:50,right:50,top:50),
      child:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children:[
          //first text
          Text(
            title,
            textAlign:TextAlign.center,
            style:TextStyle(fontSize:30,color:Colors.deepOrange,fontWeight:FontWeight.w700,),
          ),
          //second text
          SizedBox(height:20),
          Text(
            content,
            textAlign:TextAlign.center,
            style:TextStyle(fontSize:20,color:Colors.black26,fontWeight:FontWeight.w500),
          ),
          //page image
          Padding(
            padding:EdgeInsets.all(18),
            child:Image.asset(image),
          ),
        ],
      ),
    );
  }
  Widget _indicator(bool isActive){
    return AnimatedContainer(
      duration:Duration(milliseconds:200),
      height:6,
      margin:EdgeInsets.only(right:5),
      width:isActive ? 30:6,
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(5),
        color:Colors.deepOrange,
      ),
    );
  }
  List<Widget> _indicatorBuilder(){
    List<Widget> indicator=new List();
    for(int i=0;i<3;i++){
      if(_pageIndex==i){
        indicator.add(_indicator(true));
      }else{
        indicator.add(_indicator(false));
      }
    }
    return indicator;
  }
  //Widget type funk for create button
  Widget _skipButton({title}){
    return Container(
      child:GestureDetector(
        onTap:()async{
          await Navigator.pushReplacementNamed(context,HomePage.id);
        },
        child:Text(title,style:TextStyle(color:Colors.deepOrange,fontSize:20),),
      ),
    );
  }
}
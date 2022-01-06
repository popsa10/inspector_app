import 'dart:io';

import 'package:facegraph_task/cubits/app_cubit/cubit.dart';
import 'package:facegraph_task/cubits/app_cubit/states.dart';
import 'package:facegraph_task/modules/add_chair_screen.dart';
import 'package:facegraph_task/modules/edit_chair_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChairsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chairs"),
        centerTitle: true,
        actions: [
          IconButton(icon:Icon(Icons.add),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddChairScreen(),));
          },)
        ],

      ),
      body: BlocBuilder<AppCubit,AppStates>(
        builder: (context, state){
          AppCubit cubit = AppCubit.get(context);
          if(cubit.chairs.length > 0){
            return ListView.separated(
              padding: EdgeInsets.all(10),
                itemBuilder: (context, index){
                  return  Dismissible(
                    key: Key("${cubit.chairs[index].id}"),
                    onDismissed: (direction) {
                      cubit.deleteData(cubit.chairs[index].id);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Item Deleted Successfully")));
                    },
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditChairScreen(model: cubit.chairs[index],),));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.file(File("${cubit.chairs[index].img}"),fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${cubit.chairs[index].title}"),
                                SizedBox(height: 10,),
                                Text("${cubit.chairs[index].desc}"),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(DateFormat('yyyy-MM-dd \n kk:mm a').format(DateTime.parse("${cubit.chairs[index].time}"),),textAlign: TextAlign.center,),
                              SizedBox(height: 10,),
                              Text("${cubit.chairs[index].status}"),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (context, index) => Divider(), itemCount: cubit.chairs.length);
          }else{
            return Center(child: Text("Please Add Item"),);
          }
        },
      )
    );
  }
}

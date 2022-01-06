import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:facegraph_task/cubits/app_cubit/cubit.dart';
import 'package:facegraph_task/cubits/app_cubit/states.dart';
import 'package:facegraph_task/shared/custom_button.dart';
import 'package:facegraph_task/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChairScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).title.clear();
    AppCubit.get(context).desc.clear();
    AppCubit.get(context).status.clear();
    AppCubit.get(context).imageFile  = null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Chair"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                AppCubit cubit = AppCubit.get(context);
                return DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  dashPattern: [12, 3],
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    child: InkWell(
                      onTap: () async {
                        await cubit.pickImage();
                      },
                      child: cubit.imageFile == null
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pick Chair Image",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff186983)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.cloud_upload,
                            color: Color(0xff186983),
                          )
                        ],
                      )
                          : Image.file(File(cubit.imageFile!.path),fit: BoxFit.cover,),
                    ),
                  ),
                );
              },

            ),
            SizedBox(height: 10,),
            CustomTextField(
              hintText: "Add Title",
              textEditingController: AppCubit.get(context).title,
              validator: (String? value) {
                if(value!.isEmpty){
                  return "Title Must Not Be Empty";
                }
              },
            ),
            CustomTextField(
              hintText: "Add Description",
              textEditingController: AppCubit.get(context).desc,
              maxLines: 5,
              validator: (String? value) {
                if(value!.isEmpty){
                  return "Description Must Not Be Empty";
                }
              },
            ),
            CustomTextField(
              hintText: "Add Status",
              validator: (String? value) {
                if(value!.isEmpty){
                  return "Status Must Not Be Empty";
                }
              },
              textEditingController: AppCubit.get(context).status,
            ),
            CustomButton(onPressed: (){
              if(formKey.currentState!.validate()){
                if(AppCubit.get(context).imageFile != null){
                  AppCubit.get(context).insertIntoDatabase();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Item Added Successfully")));
                }else{
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Please Add An Image")));
                }
              }


            },text: "Add Chair",)




          ],
        ),
      ),

    );
  }
}

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:facegraph_task/cubits/app_cubit/cubit.dart';
import 'package:facegraph_task/cubits/app_cubit/states.dart';
import 'package:facegraph_task/models/chair_model.dart';
import 'package:facegraph_task/shared/custom_button.dart';
import 'package:facegraph_task/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditChairScreen extends StatelessWidget {
final ChairModel? model;
  const EditChairScreen({Key? key,this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).title.text = "${model!.title}";
    AppCubit.get(context).desc.text = "${model!.desc}";
    AppCubit.get(context).status.text = "${model!.status}";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Chair"),
      ),
      body: ListView(
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
                        ? Image.file(File("${model!.img}"),fit: BoxFit.cover,)
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
          ),
          CustomTextField(
            hintText: "Add Description",
            textEditingController: AppCubit.get(context).desc,
            maxLines: 5,
          ),
          CustomTextField(
            hintText: "Add Status",
            textEditingController: AppCubit.get(context).status,
          ),
          CustomButton(onPressed: (){
            AppCubit.get(context).updateData(model!.id);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Item Edited Successfully")));
          },text: "Edit Chair",)




        ],
      ),

    );
  }
}

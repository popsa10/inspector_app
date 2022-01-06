
import 'package:facegraph_task/cubits/app_cubit/states.dart';
import 'package:facegraph_task/models/chair_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);
  XFile? imageFile;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController status = TextEditingController();
  Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    imageFile  = await _picker.pickImage(source: ImageSource.camera);
    emit(PickImageSuccessState());
  }

  Database? database;
  void createDatabase() async {
    database = await openDatabase(
      "chairs.db",
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db.execute(
            "CREATE TABLE chairs (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, img TEXT , time TEXT , status TEXT)");
        print("database created");
      },
      onOpen: (database) {
        getFromDatabase(database);
      },
    );
    emit(CreateDatabaseState());
  }

   void insertIntoDatabase() async {
    var time = DateTime.now();
     await database!.transaction((txn) async {
      var result = await txn.rawInsert(
        'INSERT INTO chairs(title, desc, img , time , status) VALUES("${title.text}","${desc.text}","${imageFile!.path}","$time","${status.text}")',
      );
      print("$result inserted successfully");
      emit(InsertIntoDatabaseState());
      getFromDatabase(database!);
    });
  }
  List<ChairModel> chairs = [];
  void getFromDatabase(Database database) async {
    emit(GetFromDatabaseLoadingState());
    var result = await database.rawQuery("SELECT * FROM chairs");
    chairs = result.map((e) => ChairModel.fromMap(e)).toList();
      emit(GetFromDatabaseState());
    }

  void updateData(int? id) async {
    var time = DateTime.now();
    await database!.rawUpdate('UPDATE chairs SET status = ?, title = ?, img = ?, desc = ?, time = ? WHERE id = ?', [
      status.text,
      title.text,
      imageFile!.path,
      desc.text,
      "$time",
      id,
    ]);
    getFromDatabase(database!);
    emit(UpdateDataBaseState());
  }

  void deleteData(int? id) async {
    await database!
        .rawDelete('DELETE FROM chairs WHERE id = ?', [id]);
    getFromDatabase(database!);
    emit(DeleteDataBaseState());
  }
}

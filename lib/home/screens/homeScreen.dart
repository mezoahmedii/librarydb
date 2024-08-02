import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarydb/core/widgets/customBackground.dart';
import 'package:librarydb/home/logic/homeCubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library Home"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: CustomBackground(
            child: Center(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  HomeCubit cubit = HomeCubit.get(context);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Choose a category:", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.categories.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {Navigator.pushNamed(context, "/categoryScreen", arguments: cubit.categories[i]);},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: const EdgeInsets.all(20),
                                  child: Text(cubit.categories[i]),
                                ),
                              );
                            }
                        ),
                      )
                    ],
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}

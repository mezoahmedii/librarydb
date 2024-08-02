import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarydb/core/widgets/customBackground.dart';
import 'package:librarydb/home/logic/homeCubit.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Library Books"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getBooks(context, category),
        child: CustomBackground(
            child: Center(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  HomeCubit cubit = HomeCubit.get(context);
                  return (state is HomeLoading) ? const Center(child: CircularProgressIndicator()) : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.books.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: (cubit.books[i].thumbnail == null) ? Container(height: 100, width: 200, color: Colors.white12,) : Image.network(cubit.books[i].thumbnail!, height: 100),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (cubit.books[i].title == null) ? const Text("No Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) : Text(cubit.books[i].title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    (cubit.books[i].subtitle == null) ? const Text("No Subtitle") : Text(cubit.books[i].subtitle!),
                                    (cubit.books[i].authors == null) ? const Text("Unknown Author(s)") : Text("By ${cubit.books[i].authors!.join(", ")}"),
                                    ElevatedButton(onPressed: () {Navigator.pushNamed(context, "/bookScreen", arguments: cubit.books[i].id!);}, child: const Text("Learn More")),

                                    (cubit.books[i].link == null) ? ElevatedButton(onPressed: () {launchUrl(Uri.parse("https://books.google.com/ebooks?id=${cubit.books[i].id}"));}, child: (cubit.books[i].price == null || cubit.books[i].priceCurrency == null) ? const Text("Buy Now") : Text("Buy now for ${cubit.books[i].priceCurrency} ${cubit.books[i].price}")) :
                                        ElevatedButton(onPressed: () {launchUrl(Uri.parse(cubit.books[i].link!));}, child: (cubit.books[i].price == null || cubit.books[i].priceCurrency == null) ? const Text("Buy Now") : Text("Buy now for ${cubit.books[i].priceCurrency} ${cubit.books[i].price}"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}

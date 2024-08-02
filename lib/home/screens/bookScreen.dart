import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarydb/core/widgets/customBackground.dart';
import 'package:librarydb/home/logic/homeCubit.dart';
import 'package:url_launcher/url_launcher.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Info"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getBook(context, id),
        child: CustomBackground(
            child: Center(
              child: SingleChildScrollView(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    HomeCubit cubit = HomeCubit.get(context);
                    return (state is HomeLoading) ? const CircularProgressIndicator() :
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           (cubit.currentBook.thumbnail != null) ? Image.network(cubit.currentBook.thumbnail!) : const SizedBox(),
                
                           (cubit.currentBook.title == null) ? const Text("No Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) : Text(cubit.currentBook.title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                           (cubit.currentBook.subtitle == null) ? const Text("No Subtitle") : Text(cubit.currentBook.subtitle!),
                           (cubit.currentBook.authors == null) ? const Text("Unknown Author(s)") : Text("By ${cubit.currentBook.authors!.join(", ")}"),
                           const SizedBox(height: 20,),
                           (cubit.currentBook.description == null) ? const Text("No Description") : Text(cubit.currentBook.description!),
                           const SizedBox(height: 20,),
                           (cubit.currentBook.date == null) ? const Text("Unknown Publish Date") : Text("Published at ${cubit.currentBook.date}"),
                           (cubit.currentBook.pageCount == null) ? const Text("Unknown Page Count") : Text("${cubit.currentBook.pageCount} Pages"),
                           (cubit.currentBook.maturityRating == null) ? const Text("Unknown Maturity Rating") : Text("Maturity Rating: ${cubit.currentBook.maturityRating}"),
                           const SizedBox(height: 20,),
                           (cubit.currentBook.link == null) ? ElevatedButton(onPressed: () {launchUrl(Uri.parse("https://books.google.com/ebooks?id=${cubit.currentBook.id}"));}, child: (cubit.currentBook.price == null || cubit.currentBook.priceCurrency == null) ? const Text("Buy Now") : Text("Buy now for ${cubit.currentBook.priceCurrency} ${cubit.currentBook.price}")) :
                           ElevatedButton(onPressed: () {launchUrl(Uri.parse(cubit.currentBook.link!));}, child: (cubit.currentBook.price == null || cubit.currentBook.priceCurrency == null) ? const Text("Buy Now") : Text("Buy now for ${cubit.currentBook.priceCurrency} ${cubit.currentBook.price}"))
                         ],
                       );
                    },
                ),
              ),
            )
        ),
      ),
    );
  }
}

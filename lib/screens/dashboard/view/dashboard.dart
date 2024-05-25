import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:livingtechassignment/constants/method_constant.dart';
import 'package:livingtechassignment/screens/auth/view/login_screen.dart';
import 'package:livingtechassignment/screens/dashboard/model/news_model.dart';
import 'package:livingtechassignment/screens/dashboard/provider/dashboard_provider.dart';
import 'package:livingtechassignment/screens/dashboard/view/component/news_card.dart';
import 'package:livingtechassignment/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<DashboardProvider>().initFetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text(
            'Hi ${capitalizeFirstLetter(LocalStorageService.getUserValue(
              UserField.username,
            ))}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  LocalStorageService.deleteUserData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: const Icon(
                  Icons.logout,
                ))
          ],
          leading: const Icon(
            Icons.menu,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Here's the top headlines for you",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: PagedListView<int, NewsModel>(
                  physics: const BouncingScrollPhysics(),
                  pagingController:
                      context.read<DashboardProvider>().newsPagingController,
                  builderDelegate: PagedChildBuilderDelegate<NewsModel>(
                    noItemsFoundIndicatorBuilder: (_) => const Center(
                      child: Text('No articles found'),
                    ),
                    itemBuilder: (context, item, index) {
                      return NewsCard(news: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

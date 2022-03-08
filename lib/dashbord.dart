import 'package:flutter/material.dart';
import 'package:flutter_project/login.dart';
import 'package:flutter_project/v2/screen/loan/add.loan.dart';
import 'package:flutter_project/v2/screen/loan/show.loan.dart';
import 'package:flutter_project/v2/screen/member/show.member.dart';
import 'package:get/get.dart';

import 'drawer_header.dart';

import 'v2/screen/book/show.book.dart';
import 'v2/screen/category/show.category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.category;
  @override
  Widget build(BuildContext context) {
    var container;
    var text;
    if (currentPage == DrawerSections.category) {
      container = CategoriesListPage();
      text = const Text("Category");
    } else if (currentPage == DrawerSections.books) {
      container = BooksListPage();
      text = const Text("Books");
    } else if (currentPage == DrawerSections.members) {
      container = MembesrsListPage();
      text = const Text("Members");
    } else if (currentPage == DrawerSections.loans) {
      container = AddLoanPage();
      text = const Text("Loans");
    } else if (currentPage == DrawerSections.loanedBooks) {
      container = LoansListPage();
      text = const Text("LoanedBooks");
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(currentPage.name),
        ),
        backgroundColor: Colors.orange[700],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "category", Icons.dashboard_outlined,
              currentPage == DrawerSections.category ? true : false),
          menuItem(2, "books", Icons.people_alt_outlined,
              currentPage == DrawerSections.books ? true : false),
          menuItem(3, "members", Icons.event,
              currentPage == DrawerSections.members ? true : false),
          menuItem(4, "loans", Icons.notes,
              currentPage == DrawerSections.loans ? true : false),
          menuItem(5, "loaned Bookss", Icons.settings_outlined,
              currentPage == DrawerSections.loanedBooks ? true : false),
          const Divider(),
          menuItem(6, "Logout", Icons.settings_outlined,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.category;
            } else if (id == 2) {
              currentPage = DrawerSections.books;
            } else if (id == 3) {
              currentPage = DrawerSections.members;
            } else if (id == 4) {
              currentPage = DrawerSections.loans;
            } else if (id == 5) {
              currentPage = DrawerSections.loanedBooks;
            }
            if (id == 6) {
              Get.to(const Login());
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  category,
  books,
  members,
  loans,
  loanedBooks,
  logout,
}

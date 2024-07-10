import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/contactPage.dart';

import 'contact.dart';

class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  TextEditingController searchQueryController = TextEditingController();
  List<Contact> contacts = allContacts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter - Search & Filter on List'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: searchQueryController,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus!.unfocus(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search),
                  hintText: 'Enter Contact name E.g. Divyansh',
                ),
                onChanged: searchContacts,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final singleContact = contacts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Contactpage(
                              contact: singleContact,
                            ),
                          ),
                        ),
                        leading: Hero(
                          tag: singleContact.urlImage,
                          child: SizedBox(
                            child: ClipOval(
                              child: Image.network(
                                singleContact.urlImage,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(singleContact.name),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchContacts(String query) {
    final suggestions = contacts.where((contact) {
      final contactTitle = contact.name.toLowerCase();
      final input = query.toLowerCase();
      return contactTitle.contains(input);
    }).toList();
    setState(() {
      query.isEmpty ? contacts = allContacts : contacts = suggestions;
    });
  }
}

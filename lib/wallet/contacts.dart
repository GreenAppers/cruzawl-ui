// Copyright 2019 cruzawl developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

/// Widgets for managing [Contact]s.
library wallet_contacts;

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:cruzawl/currency.dart';
import 'package:cruzawl/preferences.dart';
import 'package:cruzawl/util.dart';
import 'package:cruzawl/wallet.dart';

import 'package:cruzawl_ui/localization.dart';
import 'package:cruzawl_ui/model.dart';
import 'package:cruzawl_ui/ui.dart';

/// Select or modify [CruzawlPreferences.contacts].
class ContactsWidget extends StatefulWidget {
  /// If editing or selecting.
  final bool editing;

  ContactsWidget({this.editing = false});

  @override
  _ContactsWidgetState createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  List<Contact> contacts;
  int selectedContactIndex;

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final ThemeData theme = Theme.of(context);

    contacts = appState.preferences.contacts.values.toList();

    return ScopedModel<SimpleScaffoldActions>(
        model: SimpleScaffoldActions(<Widget>[
          selectedContactIndex != null
              ? IconButton(
                  icon: Icon(Icons.remove,
                      color: theme.primaryTextTheme.title.color),
                  onPressed: removeSelectedContact,
                )
              : IconButton(
                  icon: Icon(Icons.add,
                      color: theme.primaryTextTheme.title.color),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/addContact'),
                ),
        ], searchBar: false),
        child: SimpleScaffold(
          ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = contacts[index];
              return Container(
                  child: AddressListTile(appState.currency, contact.addressText,
                      appState.createIconImage(contact.addressText),
                      name: contact.name,
                      onTap: widget.editing
                          ? () => setState(() => selectedContactIndex =
                              index == selectedContactIndex ? null : index)
                          : null),
                  decoration: index == selectedContactIndex
                      ? BoxDecoration(
                          color: Colors.black38,
                          border: Border.all(color: Colors.black))
                      : BoxDecoration());
            },
          ),
          title: Localization.of(context).contacts,
        ));
  }

  Future<void> removeSelectedContact() async {
    if (selectedContactIndex == null) return voidResult;
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    Map<String, Contact> newContacts = appState.preferences.contacts;
    newContacts.remove(contacts[selectedContactIndex].addressText);
    await appState.preferences.setContacts(newContacts);
    setState(() => selectedContactIndex = null);
  }
}

/// Adds new [Contact] to [CruzawlPreferences.contacts].
class AddContactWidget extends StatefulWidget {
  @override
  _AddContactWidgetState createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String name, address, icon;

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    final Localization l10n = Localization.of(context);
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    final Currency currency = appState.currency;
    final Map<String, Contact> contacts = appState.preferences.contacts;

    return Form(
      key: formKey,
      child: ListView(children: <Widget>[
        ListTile(
          subtitle: PastableTextFormField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            controller: nameController,
            decoration: InputDecoration(
              labelText: l10n.name,
            ),
            validator: (value) {
              if (value.isEmpty) return l10n.nameMustBeUnique;
              for (Contact contact in contacts.values) {
                if (contact.name == value) return l10n.nameMustBeUnique;
              }
              return null;
            },
            onSaved: (val) => name = val,
          ),
        ),
        ListTile(
          subtitle: PastableTextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: addressController,
            decoration: InputDecoration(
              labelText: l10n.address,
            ),
            validator: (value) {
              value = value.trim();
              try {
                if (contacts[value] != null) {
                  return l10n.addressMustBeUnique;
                }
                if (appState.currency.fromPublicAddressJson(value) == null) {
                  return l10n.invalidAddress;
                }
              } on Exception {
                return l10n.invalidAddress;
              }
              return null;
            },
            onSaved: (value) => address = value.trim(),
          ),
        ),
        RaisedGradientButton(
          labelText: l10n.create,
          padding: EdgeInsets.all(32),
          onPressed: () async {
            if (!formKey.currentState.validate()) return;
            formKey.currentState.save();
            formKey.currentState.reset();
            nameController.clear();
            addressController.clear();
            FocusScope.of(context).requestFocus(FocusNode());
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(l10n.creating)));

            contacts[address] =
                Contact(name, null, null, currency.ticker, '', address);
            await appState.preferences.setContacts(contacts);

            appState.setState(() {});
            Navigator.of(context).pop();
          },
        ),
      ]),
    );
  }
}

/// Selects a [Wallet] [Address] to send a [Transcation] from.
class SendFromWidget extends StatelessWidget {
  final Wallet wallet;
  final VoidCallback onTap;
  final List<Address> addresses;
  SendFromWidget(this.wallet, {this.onTap})
      : addresses = wallet.addresses.values.where((v) => v.balance > 0).toList()
          ..sort(Address.compareBalance);

  @override
  Widget build(BuildContext context) {
    final Cruzawl appState = ScopedModel.of<Cruzawl>(context);
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (BuildContext context, int index) {
        Address address = addresses[index];
        String addressText = address.publicKey.toJson();
        return AddressListTile(appState.currency, addressText,
            appState.createIconImage(addressText),
            balance: address.balance, onTap: onTap);
      },
    );
  }
}

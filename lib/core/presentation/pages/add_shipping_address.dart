import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({super.key});

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final _formKey = GlobalKey<FormState>();

  final _addressController = TextEditingController();
  final _addressFocusNode = FocusNode();

  final _cityController = TextEditingController();
  final _cityFocusNode = FocusNode();

  final _stateController = TextEditingController();
  final _stateFocusNode = FocusNode();

  final _zipCodeController = TextEditingController();
  final _zipCodeFocusNode = FocusNode();

  final _countryController = TextEditingController();
  final _countryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Shipping Address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                      controller: _addressController,
                      focusNode: _addressFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_cityFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your address' : null,
                      decoration: const InputDecoration(
                        labelText: "Address",
                      )),
                  TextFormField(
                      controller: _cityController,
                      focusNode: _cityFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_stateFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your city' : null,
                      decoration: const InputDecoration(
                        labelText: "City",
                      )),
                  TextFormField(
                      controller: _stateController,
                      focusNode: _stateFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_zipCodeFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your state' : null,
                      decoration: const InputDecoration(
                        labelText: "State",
                      )),
                  TextFormField(
                      controller: _zipCodeController,
                      focusNode: _zipCodeFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_countryFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your zip code' : null,
                      decoration: const InputDecoration(
                        labelText: "Zip code",
                      )),
                  TextFormField(
                      controller: _countryController,
                      focusNode: _countryFocusNode,
                      onEditingComplete: () {},
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your country' : null,
                      decoration: const InputDecoration(
                        labelText: "Country",
                      )),
                  MainButton(
                      ontap: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      text: "SAVE ADDRESS")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

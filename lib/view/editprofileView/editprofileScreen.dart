import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/models/user_model.dart';
import 'package:masrofy/l10n/app_localizations.dart';
import '../../widgets/TextFieldProfile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String selectedCurrency = "EGP";
  UserModel? currentUser;

  void loadUser() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (doc.exists) {
      currentUser = UserModel.fromJson(doc.data()!);
      nameController.text = currentUser!.name;
      emailController.text = currentUser!.email;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void saveProfile() async {
    final loc = AppLocalizations.of(context)!;

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.fillAllFields)),
      );
      return;
    }

    UserModel updatedUser = UserModel(
      uid: FirebaseAuth.instance.currentUser!.uid,
      name: nameController.text,
      email: emailController.text,
      photoUrl: currentUser?.photoUrl,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(updatedUser.uid)
        .update(updatedUser.toJson());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(loc.profileUpdated)),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.editProfile,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF6155F5),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextFieldProfile(
              label: loc.fullName,
              hint: "puerto Rico",
              controller: nameController,
              fillColor: Colors.grey,
              textColor: Colors.black,
            ),
            SizedBox(height: 20),
            TextFieldProfile(
              label: loc.email,
              hint: "youremail@domain.com",
              controller: emailController,
              fillColor: Colors.grey,
              textColor: Colors.black,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: selectedCurrency,
                    items: const [
                      DropdownMenuItem(value: "EGP", child: Text("EGP")),
                      DropdownMenuItem(value: "USD", child: Text("USD")),
                      DropdownMenuItem(value: "EUR", child: Text("EUR")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCurrency = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: loc.changeCurrency,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFieldProfile(
                    label: loc.changeAmount,
                    hint: "3000 EGP",
                    controller: amountController,
                    fillColor: Colors.grey,
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6155F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
                onPressed: saveProfile,
                child: Text(
                  loc.save,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

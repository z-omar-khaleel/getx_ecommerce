import 'package:ecommerce_getx/controller/hare_pref_controller.dart';
import 'package:ecommerce_getx/utils/components/custom_text.dart';
import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                currentUser?.pic == null || currentUser!.pic!.isEmpty
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/Avatar.jpg'),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(currentUser!.pic!),
                      ),
                SizedBox(
                  width: 17,
                ),
                Expanded(
                    child: Column(
                  children: [
                    CustomText(
                      txt: currentUser!.name!,
                      color: Colors.black,
                      fontsize: 25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      txt: currentUser!.email!,
                      color: Colors.grey.withOpacity(.9),
                      fontWeight: FontWeight.bold,
                      fontsize: 15,
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: Get.height * .11,
            ),
            Column(
              children: [
                InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/images/Icon_Edit-Profile.jpg'),
                    title: CustomText(
                      txt: 'Edit Profile',
                      color: Colors.black.withOpacity(.7),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 9,
                ),
                InkWell(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/Icon_Location.jpg',
                    ),
                    title: CustomText(
                      txt: 'Shipping Address',
                      color: Colors.black.withOpacity(.7),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 9,
                ),
                InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/images/Icon_History.jpg'),
                    title: CustomText(
                      txt: 'Order History',
                      color: Colors.black.withOpacity(.7),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 9,
                ),
                InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/images/Icon_Payment.jpg'),
                    title: CustomText(
                      txt: 'Cards',
                      color: Colors.black.withOpacity(.7),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 9,
                ),
                InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/images/Icon_Alert.jpg'),
                    title: CustomText(
                      txt: 'Notifications',
                      color: Colors.black.withOpacity(.7),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 9,
                ),
                InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/images/Icon_Exit.jpg'),
                    title: CustomText(
                      txt: 'Log Out',
                      color: Colors.black.withOpacity(.7),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  onTap: () async {
                    final control = Get.find<SharePrefController>();
                    await control.removeKey('uid');
                  },
                ),
                SizedBox(
                  height: 9,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

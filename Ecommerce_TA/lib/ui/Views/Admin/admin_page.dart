// import 'dart:io';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/ui/Views/Admin/shopping/shopping_page.dart';
import 'package:e_commers/ui/Views/Profile/PaymentPage.dart';
import 'package:e_commers/ui/Views/Admin/category/ListCategoryPage.dart';
import 'package:e_commers/ui/Views/Admin/category/add_category_page.dart';
import 'package:e_commers/ui/Views/Admin/product/add_product_page.dart';
import 'package:e_commers/ui/Views/Profile/card/credit_card_page.dart';
import 'package:e_commers/ui/Views/Profile/information_page.dart';
import 'package:e_commers/ui/Views/Admin/product/ListProductsPage.dart';
import 'package:e_commers/ui/Views/Profile/shopping/shopping_page.dart';
import 'package:e_commers/ui/Views/Start/start_home_page.dart';
import 'package:e_commers/ui/Views/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/Views/Profile/widgets/card_item_profile.dart';
import 'package:e_commers/ui/Views/Profile/widgets/divider_line.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Stack(
          children: [
            ListProfile(),
          ],
        ),
      ),
    );
  }
}

class ListProfile extends StatefulWidget {
  @override
  _ListProfileState createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  late ScrollController _scrollController;
  double scrollPrevious = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(addListenerScroll);

    super.initState();
  }

  void addListenerScroll() {
    if (_scrollController.offset > scrollPrevious) {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: false));
    } else {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: true));
    }
    scrollPrevious = _scrollController.offset;
  }

  @override
  void dispose() {
    _scrollController.removeListener(addListenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.only(top: 35.0, bottom: 20.0),
      children: [
        BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => state.user != null
                ? Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: state.user != null && state.user?.image == ''
                              ? GestureDetector(
                                  onTap: () => modalSelectPicture(
                                        context: context,
                                        onPressedImage: () async {
                                          Navigator.pop(context);
                                          AccessPermission()
                                              .permissionAccessGalleryOrCameraForProfile(
                                                  await Permission.storage
                                                      .request(),
                                                  context,
                                                  ImageSource.gallery);
                                        },
                                        onPressedPhoto: () async {
                                          Navigator.pop(context);
                                          AccessPermission()
                                              .permissionAccessGalleryOrCameraForProfile(
                                                  await Permission.camera
                                                      .request(),
                                                  context,
                                                  ImageSource.camera);
                                        },
                                      ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        ColorsFrave.primaryColorFrave,
                                    child: TextFrave(
                                        text: state.user!.users
                                            .substring(0, 2)
                                            .toUpperCase(),
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : GestureDetector(
                                  onTap: () => modalSelectPicture(
                                    context: context,
                                    onPressedImage: () async {
                                      Navigator.pop(context);
                                      AccessPermission()
                                          .permissionAccessGalleryOrCameraForProfile(
                                              await Permission.storage
                                                  .request(),
                                              context,
                                              ImageSource.gallery);
                                    },
                                    onPressedPhoto: () async {
                                      Navigator.pop(context);
                                      AccessPermission()
                                          .permissionAccessGalleryOrCameraForProfile(
                                              await Permission.camera.request(),
                                              context,
                                              ImageSource.camera);
                                    },
                                  ),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(URLS.baseUrl +
                                                state.user!.image))),
                                  ),
                                )),
                      const SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BounceInRight(
                            child: Align(
                                alignment: Alignment.center,
                                child: TextFrave(
                                    text: state.user!.users,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500)),
                          ),
                          FadeInRight(
                            child: Align(
                                alignment: Alignment.center,
                                child: TextFrave(
                                    text: state.user!.email,
                                    fontSize: 18,
                                    color: Colors.grey)),
                          ),
                        ],
                      ),
                    ],
                  )
                : const ShimmerFrave()),
        const SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: const TextFrave(
            text: 'Umum',
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 310,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            children: [
              CardItemProfile(
                text: 'Informasi Personal',
                borderRadius: BorderRadius.circular(50.0),
                icon: Icons.person_outline_rounded,
                backgroundColor: Color(0xff7882ff),
                onPressed: () => Navigator.push(
                    context, routeSlide(page: InformationPage())),
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Notifikasi',
                borderRadius: BorderRadius.zero,
                backgroundColor: Color(0xffE87092),
                icon: Icons.notifications_none_rounded,
                onPressed: () {},
              ),
              // DividerLine(size: size),
              // CardItemProfile(
              //   text: 'Tambah Kategori',
              //   backgroundColor: Color(0xff0716A5),
              //   icon: Icons.shopping_bag_outlined,
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30),
              //       bottomRight: Radius.circular(30.0)),
              //   onPressed: () => Navigator.push(
              //       context, routeSlide(page: AddCategoryPage())),
              // ),
              // DividerLine(size: size),
              // CardItemProfile(
              //   text: 'Tambah Produk',
              //   backgroundColor: Color(0xff0716A5),
              //   icon: Icons.shopping_bag_outlined,
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30),
              //       bottomRight: Radius.circular(30.0)),
              //   onPressed: () =>
              //       Navigator.push(context, routeSlide(page: AddProductPage())),
              // ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Daftar Kategori',
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50.0)),
                backgroundColor: Color(0xff458bff),
                icon: Icons.description_outlined,
                // onPressed: () {},
                onPressed: () => Navigator.push(
                    context, routeSlide(page: ListCategoryPage())),
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Daftar Produk',
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50.0)),
                backgroundColor: Color(0xff0716A5),
                icon: Icons.shopping_bag_outlined,
                // onPressed: () {},
                onPressed: () => Navigator.push(
                    context, routeSlide(page: ListProductsPage())),
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Validasi Pembayaran',
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50.0)),
                backgroundColor: Color(0xff458bff),
                icon: Icons.checklist_rounded,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: ShoppingPageAdmin())),
              ),
            ],
          ),
        ),
        SizedBox(height: 25.0),
        CardItemProfile(
          text: 'Sign Out',
          borderRadius: BorderRadius.circular(50.0),
          icon: Icons.power_settings_new_sharp,
          backgroundColor: Colors.red,
          // onPressed: () {},
          onPressed: () {
            authBloc.add(LogOutEvent());
            Navigator.pushAndRemoveUntil(
                context, routeFade(page: StartHomePage()), (route) => false);
          },
        ),
      ],
    );
  }
}

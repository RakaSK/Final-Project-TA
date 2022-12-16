part of 'widgets.dart';

class BottomNavigationFrave extends StatelessWidget {
  final int index;

  BottomNavigationFrave({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralBloc, GeneralState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => AnimatedOpacity(
        duration: Duration(milliseconds: 350),
        opacity: (state.showMenuHome) ? 1 : 0,
        child: Container(
          height: 70,
          width: 395,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 30, spreadRadius: -5)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ItemButtom(
                i: 1,
                index: index,
                iconString: 'assets/svg/home.svg',
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, routeSlide(page: HomePage()), (_) => false),
              ),
              _ItemButtom(
                i: 2,
                index: index,
                iconString: 'assets/svg/Heart Icon.svg',
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, routeSlide(page: FavoritePage()), (_) => false),
              ),
              _ItemButtom(
                i: 3,
                index: index,
                iconString: 'assets/svg/Cart Icon.svg',
                onPressed: () =>
                    Navigator.push(context, routeSlide(page: CartPage())),
              ),
              // _ItemButtom(
              //   i: 4,
              //   index: index,
              //   iconString: 'assets/svg/search.svg',
              //   onPressed: () {},
              // ),
              _ItemProfile()
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushAndRemoveUntil(
          context, routeSlide(page: ProfilePage()), (_) => false),
      child: BlocBuilder<UserBloc, UserState>(
          builder: (_, state) => state.user != null
              ? state.user?.image != ''
                  ? CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(URLS.baseUrl + state.user!.image))
                  : CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorsFrave.primaryColorFrave,
                      child: TextFrave(
                        text: state.user!.users.substring(0, 1).toUpperCase(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
              : const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorsFrave.primaryColorFrave,
                  child: CircularProgressIndicator(strokeWidth: 2))),
    );
  }
}

// class CenterIcon extends StatelessWidget {
//   final int index;
//   final String iconString;
//   final Function() onPressed;

//   const CenterIcon(
//       {Key? key,
//       required this.index,
//       required this.iconString,
//       required this.onPressed})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: CircleAvatar(
//         backgroundColor: ColorsFrave.primaryColorFrave,
//         radius: 26,
//         child: SvgPicture.asset(iconString,
//             height: 26, color: index == 3 ? Colors.white : Colors.black87),
//       ),
//     );
//   }
// }

class _ItemButtom extends StatelessWidget {
  final int i;
  final int index;
  final String iconString;
  final Function() onPressed;

  const _ItemButtom(
      {Key? key,
      required this.i,
      required this.index,
      required this.onPressed,
      required this.iconString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          child: SvgPicture.asset(iconString,
              height: 25,
              color:
                  (i == index) ? ColorsFrave.primaryColorFrave : Colors.black)),
    );
  }
}

part of 'helpers.dart';

void modalDeleteCategory(
    BuildContext context, String name, String uidCategory) {
  final categoryBloc = BlocProvider.of<CategoryBloc>(context);

  showDialog(
    context: context,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 196,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    TextFrave(
                        text: 'DNI ',
                        color: ColorsFrave.primaryColorFrave,
                        fontWeight: FontWeight.w500),
                    TextFrave(text: 'Shop', fontWeight: FontWeight.w500),
                  ],
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close))
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            const TextFrave(text: 'Hapus kategori ini?'),
            const SizedBox(height: 20.0),
            Row(
              children: [
                // Container(
                //   height: 40,
                //   width: 40,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           scale: 7, image: NetworkImage(URLS.baseUrl + image))),
                // ),
                const SizedBox(width: 10.0),
                TextFrave(
                  text: '\Kategori = ${name}',
                  maxLines: 2,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            BtnFrave(
              height: 45,
              text: 'DELETE',
              fontWeight: FontWeight.bold,
              onPressed: () {
                categoryBloc.add(OnDeleteCategoryEvent(uidCategory));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}

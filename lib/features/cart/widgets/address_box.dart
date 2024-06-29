import '../../../lib.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppPreference.instance.getUserModel;

    return Container(
      height: 40.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: EdgeInsets.only(left: 10.w),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              top: 2.h,
            ),
            child: const Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}

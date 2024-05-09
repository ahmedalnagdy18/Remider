import 'package:flutter/material.dart';

class AlertDialogWiget extends StatelessWidget {
  const AlertDialogWiget({super.key, this.yesOnPressed, this.noOnPressed});
final void Function()? yesOnPressed;
final void Function()? noOnPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Are you sure you want to delete the item ?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                height: 20,
                color: Colors.transparent,
                elevation: 0,
                onPressed: yesOnPressed,
                child: const Text(
                  'yes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              MaterialButton(
                height: 20,
                color: Colors.transparent,
                elevation: 0,
                onPressed: noOnPressed,
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

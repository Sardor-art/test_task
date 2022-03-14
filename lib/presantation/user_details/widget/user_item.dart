import 'package:flutter/material.dart';
import 'package:test_task/data/model/user_data_response.dart';

class UserItem extends StatelessWidget {
  final UserDataResponse user;
  final String? phone;

  const UserItem({Key? key, required this.user, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        RichText(
          text: TextSpan(
            text: 'email: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
            children: <TextSpan>[
              TextSpan(
                text: user.email,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: 'phone: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
            children: <TextSpan>[
              TextSpan(
                text: (phone?.isNotEmpty ?? false) ? phone : user.phone,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: 'phone: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
            children: <TextSpan>[
              TextSpan(
                text: user.phone,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: 'webSite: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
            children: <TextSpan>[
              TextSpan(
                text: user.website,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: 'address: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                    '${user.address?.city ?? ''} ${user.address?.street ?? ''} ${user.address?.suite ?? ''}'
                        .trim(),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

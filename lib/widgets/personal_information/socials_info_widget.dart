import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:volunteer/models/social_media_type.dart';

class SocialsInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Соціальні мережі",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child:
                  _buildInputControllerSocialNetwork(SocialMediaType.INSTAGRAM),
            ),
            Row(
              children: [
                Container(
                  height: 1,
                  width: 23,
                  color: Colors.blueGrey[50],
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey[400],
                )),
                Container(
                  height: 1,
                  width: 23,
                  color: Colors.blueGrey[50],
                )
              ],
            ),
            SizedBox(
              height: 50,
              child:
                  _buildInputControllerSocialNetwork(SocialMediaType.TELEGRAM),
            ),
            Row(
              children: [
                Container(
                  height: 1,
                  width: 23,
                  color: Colors.blueGrey[50],
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey[400],
                )),
                Container(
                  height: 1,
                  width: 23,
                  color: Colors.blueGrey[50],
                )
              ],
            ),
            SizedBox(
              height: 50,
              child:
                  _buildInputControllerSocialNetwork(SocialMediaType.FACEBOOK),
            ),
            Row(
              children: [
                Container(
                  height: 1,
                  width: 23,
                  color: Colors.blueGrey[50],
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey[400],
                )),
                Container(
                  height: 1,
                  width: 23,
                  color: Colors.blueGrey[50],
                )
              ],
            ),
            SizedBox(
              height: 50,
              child: _buildInputControllerSocialNetwork(SocialMediaType.TIKTOK),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildInputControllerSocialNetwork(SocialMediaType socialMediaType) {
    return TextField(
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.grey[850],
            ),
            onPressed: () {
              log("button Edit ${socialMediaType.name} was pressed");
            },
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelText: socialMediaType.name),
    );
  }
}

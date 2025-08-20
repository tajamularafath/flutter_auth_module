import 'package:authication_module/constants/image_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';

class AuthContainerWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final Widget? fillChild;
  final Widget? child;

  const AuthContainerWidget({
    super.key,
    this.onBackPressed,
    this.fillChild,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 140,
            collapsedHeight: 140,
            backgroundColor: AppColors.redLight,
            leading: Visibility(
              visible: onBackPressed != null,
              child: IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                color: Colors.black,
                onPressed: onBackPressed,
              ),
            ),

            flexibleSpace: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 108,
                    height: 100,
                    child: SvgPicture.asset(
                      ImageNames.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Image(
                  image: AssetImage(ImageNames.authAppbarBack),
                  fit: BoxFit.cover,
                ),
              ],
            ),

            bottom: PreferredSize(
              preferredSize: Size(20.0, 20.0),
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: (child == null) ? SizedBox.shrink() : child,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: (fillChild == null) ? SizedBox.shrink() : fillChild,
          ),
        ],
      ),
    );
  }
}

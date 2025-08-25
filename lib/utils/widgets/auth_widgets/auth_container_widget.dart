import 'package:authication_module/constants/image_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/spacing.dart';

class AuthContainerWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final Widget? child;
  final Widget? fillChild;

  const AuthContainerWidget({
    super.key,
    this.onBackPressed,
    this.child,
    this.fillChild,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: Spacing.medium),
                    child: SizedBox(
                      height: 108,
                      width: 96,
                      child: SvgPicture.asset(
                        ImageNames.logo,
                        fit: BoxFit.contain,
                      ),
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
              preferredSize: Size(20, 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
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

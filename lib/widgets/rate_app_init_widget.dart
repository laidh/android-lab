import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppInitWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;

  const RateAppInitWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _RateAppInitWidgetState createState() => _RateAppInitWidgetState();
}

class _RateAppInitWidgetState extends State<RateAppInitWidget> {
  RateMyApp? rateMyApp;

  static const playStoreId = 'com.olegnovosad.volunteer';
  static const appstoreId = 'com.apple.olegnovosad.volunteer';

  @override
  Widget build(BuildContext context) => RateMyAppBuilder(
    rateMyApp: RateMyApp(
      googlePlayIdentifier: playStoreId,
      appStoreIdentifier: appstoreId,

    ),
    onInitialized: (context, rateMyApp) {
      setState(() => this.rateMyApp = rateMyApp);

      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(context);
      }
    },
    builder: (context) => rateMyApp == null
        ? Center(child: CircularProgressIndicator())
        : widget.builder(rateMyApp!),
  );
}
Fetch Tag: 68
Notable changes in version 68:

* temporarily disable support for 4:3 aspect ratio video recording added in version 67 due to breaking on devices where it's not supported

A full list of changes from the previous release (version 67) is available through the [Git commit log between the releases](https://github.com/GrapheneOS/Camera/compare/67...68).

----

This app is [available through the Play Store with the `app.grapheneos.camera.play` app id](https://play.google.com/store/apps/details?id=app.grapheneos.camera.play). Play Store releases go through review and it usually takes around 1 to 3 days before the Play Store pushes out the update to users. Play Store releases use Play Signing, so we use a separate app id from the releases we publish ourselves to avoid conflicts and to distinguish between them. Each release is initially pushed out through the Beta channel followed by the Stable channel.

Releases of the app signed by GrapheneOS with the `app.grapheneos.camera` app id are published in the GrapheneOS app repository and on GitHub. You can use the [GrapheneOS app repository client](https://github.com/GrapheneOS/Apps/releases) on Android 12 or later for automatic updates. Each release is initially pushed out through the Alpha channel, followed by the Beta channel and then finally the Stable channel.

**GrapheneOS users must either obtain GrapheneOS app updates through our app repository or install it with `adb install-multiple` with both the APK and fs-verity metadata since fs-verity metadata is now required for out-of-band system app updates on GrapheneOS as part of extending verified boot to them.**

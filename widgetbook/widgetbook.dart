import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_screenutil_error_example/main.dart';

const List<Device> devices = [
  Apple.iPhone13,
  Apple.iPadPro12inch,
  Samsung.s21ultra,
  Apple.iPhone7,
];

class WidgetbookHotReload extends StatelessWidget {
  const WidgetbookHotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DefaultDeviceFrame deviceFrameBuilder = DefaultDeviceFrame(
      setting: DeviceSetting.firstAsSelected(devices: devices),
    );

    final WidgetbookFrame activeFrameBuilder = WidgetbookFrame(
      setting: DeviceSetting.firstAsSelected(devices: devices),
    );

    return Widgetbook(
      addons: [
        FrameAddon(
          setting: FrameSetting.firstAsSelected(
            frames: [
              deviceFrameBuilder,
              activeFrameBuilder,
              NoFrame(),
            ],
          ),
        ),
        TextScaleAddon(
          setting: TextScaleSetting.firstAsSelected(
            textScales: [
              1.00,
              0.9,
              0.8,
              0.7,
            ],
          ),
        ),
        CustomThemeAddon<ThemeData>(
          setting: CustomThemeSetting.firstAsSelected(
            themes: [
              WidgetbookTheme(
                name: 'Dark',
                data: ThemeData.dark(useMaterial3: true),
              ),
              WidgetbookTheme(
                name: 'Light',
                data: ThemeData.light(),
              ),
            ],
          ),
        ),
      ],
      directories: [
        WidgetbookComponent(
          name: 'Example',
          useCases: [
            WidgetbookUseCase(
              name: 'Example',
              builder: (context) => const MyHomePage(
                title: 'Example',
              ),
            ),
          ],
        ),
      ],
      appBuilder: (context, child) {
        final frameBuilder = context.frameBuilder;
        final theme = context.theme<ThemeData>();

        final builder = Builder(
          builder: (context) {
            return ScreenUtilInit(
              minTextAdapt: true,
              designSize: const Size(375, 812),
              // Enable this property so the [MediaQuery] of the [FrameAddon] is used.
              useInheritedMediaQuery: true,
              builder: (context, child) {
                return MaterialApp(
                  theme: theme,
                  locale: context.localization?.activeLocale,
                  supportedLocales: context.localization?.locales ??
                      const <Locale>[
                        Locale('en', 'US'),
                      ],
                  localizationsDelegates: context.localization?.localizationsDelegates,
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: context.textScale,
                      ),
                      child: child!,
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );

        // Note, that the ScreenUtilInit [Widget] only works properly iff the
        // [FrameAddon] is active!
        return frameBuilder == null
            ? builder
            : frameBuilder(
                context,
                builder,
              );
      },
    );
  }
}

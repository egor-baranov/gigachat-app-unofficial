import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/SolarIcons.dart';

class Info extends StatefulWidget {
  const Info(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.externalLink,
      required this.buttonLabel,
      required this.customBody});

  final String title;
  final String subtitle;
  final String description;
  final String externalLink;
  final String buttonLabel;
  final Widget? customBody;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                widget.title,
              ),
              padding: EdgeInsetsDirectional.only(start: 8),
              leading: GestureDetector(
                child: SolarIcons.getOutlineWithSize('Arrows/Alt Arrow Left', 32),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      widget.customBody != null
                          ? Column(
                              children: [
                                const SizedBox(height: 32),
                                widget.customBody!,
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black,
                          onPressed: () {},
                          child: Text(
                            widget.buttonLabel,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmssdk_flutter_example/common/util/app_color.dart';
import 'package:hmssdk_flutter_example/hls-streaming/util/hls_subtitle_text.dart';
import 'package:hmssdk_flutter_example/hls-streaming/util/hls_title_text.dart';
import 'package:provider/provider.dart';
import '../../data_store/meeting_store.dart';

class HLSMessageOrganism extends StatelessWidget {
  final String message;
  final bool isLocalMessage;
  final String? senderName;
  final String date;
  final String role;
  const HLSMessageOrganism({
    Key? key,
    required this.isLocalMessage,
    required this.message,
    required this.senderName,
    required this.date,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: isLocalMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: width - (role == "" ? 80 : 60),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: themeSurfaceColor),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    role != "" ? width * 0.25 : width * 0.5),
                            child: HLSTitleText(
                              text: senderName ?? "Anonymous",
                              fontSize: 14,
                              letterSpacing: 0.1,
                              lineHeight: 20,
                              textColor: themeDefaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          HLSSubtitleText(
                              text: date, textColor: themeSubHeadingColor),
                        ],
                      ),
                      (role != "" || isLocalMessage)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: role != ""
                                          ? Border.all(
                                              color: borderColor, width: 1)
                                          : Border.symmetric()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (role != "PRIVATE")
                                          Text(
                                            (isLocalMessage ? "" : "TO"),
                                            style: GoogleFonts.inter(
                                                fontSize: 10.0,
                                                color: themeSubHeadingColor,
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        (isLocalMessage || (role == "PRIVATE"))
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                child: Text(
                                                  "|",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 10.0,
                                                      color: borderColor,
                                                      letterSpacing: 1.5,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                        role != ""
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: isLocalMessage
                                                            ? width * 0.25
                                                            : width * 0.15),
                                                    child: Text(
                                                      "${role.toUpperCase()} ",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 10.0,
                                                          color:
                                                              themeDefaultColor,
                                                          letterSpacing: 1.5,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    message,
                    style: GoogleFonts.inter(
                        fontSize: 14.0,
                        color: themeDefaultColor,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            if (role == "")
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: PopupMenuButton(
                  color: themeSurfaceColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (context) {
                    return List.generate(1, (index) {
                      return PopupMenuItem(
                        child: Text('Pin Message'),
                        onTap: () => context
                            .read<MeetingStore>()
                            .setSessionMetadata(senderName! + ": " + message),
                      );
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/icons/more.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey,
        direction: ShimmerDirection.ltr,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width -
                            162, // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10.0,
                              width: 100.0,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 5.0, 10.0, 5.0),
                              height: 25,
                              child: Container(
                                height: 10.0,
                                width: 50.0,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 5.0, 0.0, 10.0),
                              child: Container(
                                height: 10.0,
                                width: 70.0,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0, bottom: 5.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 10.0,
                                    width: 30.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 10.0,
                                    width: 50.0,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ]),
            );
          },
        ));
  }
}

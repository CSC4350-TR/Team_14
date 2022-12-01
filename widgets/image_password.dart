import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fun_PasswordImages(List _index, List Images, callback) {
  return Images.isNotEmpty
      ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    callback(0);
                  },
                  child: _index[0] == 0
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[0],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[0],
                          width: 70,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    callback(1);
                  },
                  child: _index[1] == 1
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[1],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[1],
                          width: 70,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    callback(2);
                  },
                  child: _index[2]== 2
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[2],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[2],
                          width: 70,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    callback(3);
                  },
                  child: _index[3] == 3
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[3],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[3],
                          width: 70,
                        ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    callback(4);
                  },
                  child: _index[4] == 4
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[4],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[4],
                          width: 70,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    callback(5);
                  },
                  child: _index[5] == 5
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[5],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[5],
                          width: 70,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    callback(6);
                  },
                  child: _index[6]== 6
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[6],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[6],
                          width: 70,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    callback(7);
                  },
                  child: _index[7] == 7
                      ? Container(
                          color: Colors.blue,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            Images[7],
                            width: 60,
                          ),
                        )
                      : Image.network(
                          Images[7],
                          width: 70,
                        ),
                )
              ],
            )
          ],
        )
      : Container(child: const CircularProgressIndicator());
}

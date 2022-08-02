// ignore_for_file: prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/modules/web_view/web_view_screen.dart';
// import 'package:flutter_first_app/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUppercase = true,
  double borderRadius = 0.0,
  double height = 50.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      // ignore: sort_child_properties_last
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: background,
      ),
    );

Widget defaultTextField({
  double width = double.infinity,
  double height = 50.0,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String hintText,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit();
        }
      },
      onChanged: (String value) {
        if (onChange != null) {
          onChange(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return validate(value);
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            if (suffixIcon != null) {
              suffixPressed!();
            }
          },
          icon: Icon(
            suffixIcon,
          ),
        ),
        border: OutlineInputBorder(),
      ),
    );

// Widget buildTaskItem(Map model, context) => Dismissible(
//       key: UniqueKey(),
//       onDismissed: (direction) {
//         NewsCubit.get(context).deleteDataFromDatabase(id: model['id']);
//       },
//       confirmDismiss: (direction) async {
//         return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Are you sure?'),
//             content: Text('Do you want to delete this task?'),
//             actions: <Widget>[
//               IconButton(
//                 icon: Text('No'),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//               ),
//               IconButton(
//                 icon: Text('Yes'),
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(children: [
//           CircleAvatar(
//             radius: 35.0,
//             child: Text('${model['time']}'),
//           ),
//           SizedBox(width: 20.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('${model['title']}',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     )),
//                 Text('${model['date']}',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     )),
//               ],
//             ),
//           ),
//           SizedBox(width: 20.0),
//           IconButton(
//               icon: Icon(Icons.check_box_outlined),
//               color: Colors.green,
//               onPressed: () {
//                 NewsCubit.get(context)
//                     .updateDataFromDatabase(status: 'done', id: model['id']);
//               }),
//           IconButton(
//               icon: Icon(Icons.archive_outlined),
//               color: Colors.grey,
//               onPressed: () {
//                 NewsCubit.get(context).updateDataFromDatabase(
//                     status: 'archived', id: model['id']);
//               }),
//         ]),
//       ),
//     );

// Widget tasksBuilder({
//   required List<Map> tasks,
// }) =>
//     ConditionalBuilder(
//       condition: tasks.length > 0,
//       fallback: (context) => Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Icon(
//             Icons.menu,
//             size: 100.0,
//             color: Colors.grey,
//           ),
//           Text(
//             'No Tasks Yet',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 20.0,
//             ),
//           ),
//         ]),
//       ),
//       builder: (BuildContext context) => ListView.separated(
//         itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//         separatorBuilder: (context, index) => Padding(
//           padding: const EdgeInsetsDirectional.only(
//             start: 20.0,
//             end: 20.0,
//           ),
//           child: Container(
//             width: double.infinity,
//             height: 1.0,
//             color: Colors.grey[300],
//           ),
//         ),
//         itemCount: tasks.length,
//       ),
//     );

Widget itemDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        end: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: article['urlToImage'] != null
                      ? NetworkImage('${article['urlToImage']}')
                      : NetworkImage(
                          'https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('${article['title']}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    Text('${article['publishedAt']}',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => itemDivider(),
        itemCount: list.length),
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()));

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

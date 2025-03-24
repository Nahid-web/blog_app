import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/models/picked_image.dart';
import 'package:blog_app/core/routes/routes.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> selectedTopics = [];
  PickedImage? image;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    debugPrint(pickedImage.toString());
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final appUserState = context.read<AppUserCubit>().state;
      if (appUserState is AppUserLoggeedIn) {
        final posterId = appUserState.user.id;

        final imageFile = image!.file as File;

        context.read<BlogBloc>().add(
          BlogUpload(
            posterId: posterId,
            title: titleController.text.trim(),
            content: contentController.text.trim(),
            image: imageFile,
            topics: selectedTopics,
          ),
        );
      } else {
        showSnackBar(context, 'You must be logged in to upload a blog.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadBlog();
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadedSuccess) {
            context.pushReplacement(RouteNames.blog);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:
                          selectImage, // This is fine since selectImage is a valid method
                      child:
                          image != null
                              ? SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      image!.isWeb
                                          ? Image.network(
                                            image!.path,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.file(
                                            image!.file as File,
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              )
                              : DottedBorder(
                                color: AppPalette.borderColor,
                                dashPattern: const [10, 4],
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.folder_open, size: 40),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            Constants.topics
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.all(5),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (mounted) {
                                          // Check if widget is still mounted
                                          setState(() {
                                            if (selectedTopics.contains(e)) {
                                              selectedTopics.remove(e);
                                            } else {
                                              selectedTopics.add(e);
                                            }
                                          });
                                        }
                                      },
                                      child: Chip(
                                        label: Text(e),
                                        color:
                                            selectedTopics.contains(e)
                                                ? const MaterialStatePropertyAll(
                                                  AppPalette.gradient1,
                                                )
                                                : null,
                                        side:
                                            selectedTopics.contains(e)
                                                ? null
                                                : const BorderSide(
                                                  color: AppPalette.borderColor,
                                                ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Blog Title',
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog Content',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

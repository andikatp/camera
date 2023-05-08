import 'dart:io';

import 'package:camera/main/cubit/camera_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MainPageWrapperProvider extends StatelessWidget {
  const MainPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit(),
      child: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.read<CameraCubit>().selectImage(context),
              child: DottedBorder(
                color: theme.colorScheme.primary,
                strokeWidth: 1,
                child: BlocBuilder<CameraCubit, CameraState>(
                  builder: (context, state) {
                    if (state is CameraLoaded) {
                      return Image.file(
                        File(state.image.path),
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      );
                    }

                    return const SizedBox(
                      height: 300,
                      width: 300,
                      child: Center(child: Text('No Image Yet')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Save Data')),
          ],
        ),
      ),
    );
  }
}

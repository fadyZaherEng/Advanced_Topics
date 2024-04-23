Future<void> shareImage(String imageUrl, String shareLink) async {
  try {
    // Fetch the image bytes from the network
    http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      Uint8List imageBytes = response.bodyBytes;

      // Save the image to a temporary file
      Directory tempDir;
      if (Platform.isIOS) {
        tempDir = await getApplicationDocumentsDirectory();
      } else {
        tempDir = await getTemporaryDirectory();
      }
      File tempFile = File('${tempDir.path}/image.png');
      await tempFile.writeAsBytes(imageBytes);

      // Use the share function to share the image
      await Share.shareXFiles([XFile(tempFile.path)], text: shareLink);
    } else {
      showMassageDialogWidget(
          context: context,
          text: S.of(context).failedToShareImage,
          icon: ImagePaths.error,
          buttonText: S.of(context).ok,
          onTap: () {
            Navigator.pop(context);
          });
    }
  } catch (e) {
    showMassageDialogWidget(
        context: context,
        text: S.of(context).failedToShareImage,
        icon: ImagePaths.error,
        buttonText: S.of(context).ok,
        onTap: () {
          Navigator.pop(context);
        });
    // Handle the error as needed
  }
}

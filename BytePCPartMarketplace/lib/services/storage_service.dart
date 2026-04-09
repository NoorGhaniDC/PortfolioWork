import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PickedImage {
  final XFile xFile;
  final Uint8List bytes;
  PickedImage({required this.xFile, required this.bytes});
}

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  /// Pick a single image from gallery. Returns null if cancelled.
  Future<PickedImage?> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
    if (picked == null) return null;
    final bytes = await picked.readAsBytes();
    return PickedImage(xFile: picked, bytes: bytes);
  }

  /// Pick multiple images from gallery (max [limit]). Returns empty list if cancelled.
  Future<List<PickedImage>> pickMultipleImages({int limit = 5}) async {
    final picked = await _picker.pickMultiImage(
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
    if (picked.isEmpty) return [];
    final limited = picked.take(limit).toList();
    final results = await Future.wait(
      limited.map((xFile) async {
        final bytes = await xFile.readAsBytes();
        return PickedImage(xFile: xFile, bytes: bytes);
      }),
    );
    return results;
  }

  /// Uploads listing images to listings/{listingId}/{index}.jpg
  /// Returns list of download URLs in order.
  Future<List<String>> uploadListingImages(
      String listingId,
      List<Uint8List> imageBytesList,
      ) async {
    final urls = <String>[];
    for (int i = 0; i < imageBytesList.length; i++) {
      final ref = _storage
          .ref()
          .child('listings/$listingId/$i.jpg');
      final uploadTask = await ref.putData(
        imageBytesList[i],
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final url = await uploadTask.ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  /// Deletes all images for a listing from Storage.
  /// Safe to call even if no images exist.
  Future<void> deleteListingImages(String listingId) async {
    try {
      final ref = _storage.ref().child('listings/$listingId');
      final listResult = await ref.listAll();
      await Future.wait(listResult.items.map((item) => item.delete()));
    } on FirebaseException catch (e) {
      if (e.code != 'object-not-found') rethrow;
    }
  }

  /// Deletes specific images by their download URLs.
  Future<void> deleteImagesByUrls(List<String> urls) async {
    await Future.wait(
      urls.map((url) async {
        try {
          final ref = _storage.refFromURL(url);
          await ref.delete();
        } on FirebaseException catch (e) {
          if (e.code != 'object-not-found') rethrow;
        }
      }),
    );
  }
}
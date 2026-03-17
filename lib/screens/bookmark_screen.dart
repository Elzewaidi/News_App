import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Used to format the publishedAt ISO string
import '/cubit/bookmark_cubit.dart';
import 'package:new_app/cubit/bookmark_state.dart';
import 'article_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger data fetch when screen initializes
    context.read<BookmarkCubit>().fetchBookmarks();
  }

  String _formatDate(String? isoString) {
    if (isoString == null) return '';
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text(
            'News',
            style: TextStyle(
              color: Color(0xFF1E2022),
              fontWeight: FontWeight.w700,
              fontSize: 32,
              letterSpacing: 0.5,
            )
        ),
        backgroundColor: const Color(0xFFF6F8FA),
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocConsumer<BookmarkCubit, BookmarkState>(
        listener: (context, state) {
          if (state is BookmarkError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is BookmarkLoading || state is BookmarkInitial) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF2E5BCC)));
          } else if (state is BookmarkError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E5BCC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      onPressed: () => context.read<BookmarkCubit>().fetchBookmarks(),
                      child: const Text('Retry', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is BookmarkSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: state.bookmarks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final item = state.bookmarks[index];
                return InkWell(
                  onTap: () {
                    // Navigate to article details using the URL as uniquely identifying ID
                    if (item.url != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArticleScreen(articleUrl: item.url!),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E2022),
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.sourceName ?? 'Uncategorized',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Hero(
                        tag: 'article_image_${item.url}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 100,
                            height: 75,
                            color: Colors.grey[300],
                            child: item.urlToImage != null && item.urlToImage!.isNotEmpty
                                ? Image.network(item.urlToImage!, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image))
                                : const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

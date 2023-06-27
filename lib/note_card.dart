import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  final String title;
  final String content;
  final DateTime date;

  const NoteCard({super.key, required this.title, required this.content, required this.date});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              widget.content,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.date.toString(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,)
          ),
        ],
      )
    );
  }
}
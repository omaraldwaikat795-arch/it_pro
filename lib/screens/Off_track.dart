import 'package:flutter/material.dart';

class OffTrack extends StatefulWidget {
  const OffTrack({super.key});

  @override
  State<OffTrack> createState() => _OffTrackState();
}

class _OffTrackState extends State<OffTrack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Off track",style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E5AA8),

      ),
    );
  }
}

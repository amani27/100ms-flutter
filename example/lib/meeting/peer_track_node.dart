import 'package:flutter/foundation.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';

class PeerTrackNode extends ChangeNotifier {
  HMSPeer peer;

  String uid;

  HMSVideoTrack? track;
  HMSAudioTrack? audioTrack;

  bool isOffscreen;

  PeerTrackNode({
    required this.peer,
    this.track,
    this.audioTrack,
    required this.uid,
    this.isOffscreen = false,
  });

  @override
  String toString() {
    return 'PeerTrackNode{peerId: ${peer.peerId}, name: ${peer.name}, track: $track}, isVideoOn: $isOffscreen }';
  }

  @override
  int get hashCode => peer.peerId.hashCode;

  void notify() {
    notifyListeners();
  }

  void setOffScreenStatus(bool currentState) {
    this.isOffscreen = currentState;
    notify();
  }
}

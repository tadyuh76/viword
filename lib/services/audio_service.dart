import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:viword/utils/enums.dart';

class AudioService {
  void playSound(Sound sound) {
    late final String fileDir;

    switch (sound) {
      case Sound.tapped:
        fileDir = 'assets/sounds/tap.mp3';

        AssetsAudioPlayer.playAndForget(Audio(fileDir));
        break;
      case Sound.flipCards:
        fileDir = 'assets/sounds/flip_card.mp3';

        for (int i = 0; i < 6; i++) {
          Future.delayed(
            Duration(milliseconds: i * 150),
            () => AssetsAudioPlayer.playAndForget(Audio(fileDir)),
          );
        }
        break;
      default:
    }
  }
}

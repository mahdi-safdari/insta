import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryDataProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  StoryDataProvider(this._prefs);

  static const String viewStoryKey = "viewStory";
  static const String reachKey = "reach";
  static const String followerChartKey = "followerChart";
  static const String nonFollowerChartKey = "nonFollowerChart";
  static const String impressionKey = "impression";
  static const String engagedKey = "engaged";
  static const String shareKey = "share";
  static const String repliesKey = "replies";
  static const String linkKey = "link";
  static const String stickerTapKey = "stickerTap";
  static const String tap1Key = "tap1";
  static const String tap2Key = "tap2";
  static const String tap3Key = "tap3";
  static const String nameTap1Key = "nameTap1";
  static const String nameTap2Key = "nameTap2";
  static const String nameTap3Key = "nameTap3";
  static const String forwardKey = "forward";
  static const String exitedKey = "exited";
  static const String nextStoryKey = "nextStory";
  static const String backKey = "back";
  static const String profileVisitKey = "profileVisit";
  static const String followsKey = "follows";
  static const String activityKey = "activity";
  static const String intractionKey = "intraction";
  static const String navigationKey = "navigation";

  List<int> viewStory = List.generate(100, (index) => 0);
  List<int> reach = List.generate(100, (index) => 0);
  List<int> followerChart = List.generate(100, (index) => 0);
  List<int> nonFollowerChart = List.generate(100, (index) => 0);
  List<int> impression = List.generate(100, (index) => 0);
  List<int> engaged = List.generate(100, (index) => 0);
  List<int> share = List.generate(100, (index) => 0);
  List<int> replies = List.generate(100, (index) => 0);
  List<int> link = List.generate(100, (index) => 0);
  List<int> stickerTap = List.generate(100, (index) => 0);
  List<int> tap1 = List.generate(100, (index) => 0);
  List<int> tap2 = List.generate(100, (index) => 0);
  List<int> tap3 = List.generate(100, (index) => 0);
  List<String> nameTap1 = List.generate(100, (index) => 'sticker_Tap1');
  List<String> nameTap2 = List.generate(100, (index) => 'sticker_Tap2');
  List<String> nameTap3 = List.generate(100, (index) => 'sticker_Tap3');
  List<int> forward = List.generate(100, (index) => 0);
  List<int> exited = List.generate(100, (index) => 0);
  List<int> nextStory = List.generate(100, (index) => 0);
  List<int> back = List.generate(100, (index) => 0);
  List<int> profileVisit = List.generate(100, (index) => 0);
  List<int> follows = List.generate(100, (index) => 0);
  List<int> activity = List.generate(100, (index) => 0);
  List<int> intraction = List.generate(100, (index) => 0);
  List<int> navigation = List.generate(100, (index) => 0);

  Future<void> getData() async {
    for (int i = 0; i < 100; i++) {
      if (_prefs.containsKey('${viewStoryKey}_$i')) {
        viewStory[i] = _prefs.getInt('${viewStoryKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${reachKey}_$i')) {
        reach[i] = _prefs.getInt('${reachKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${followerChartKey}_$i')) {
        followerChart[i] = _prefs.getInt('${followerChartKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${nonFollowerChartKey}_$i')) {
        nonFollowerChart[i] = _prefs.getInt('${nonFollowerChartKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${impressionKey}_$i')) {
        impression[i] = _prefs.getInt('${impressionKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${engagedKey}_$i')) {
        engaged[i] = _prefs.getInt('${engagedKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${shareKey}_$i')) {
        share[i] = _prefs.getInt('${shareKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${repliesKey}_$i')) {
        replies[i] = _prefs.getInt('${repliesKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${linkKey}_$i')) {
        link[i] = _prefs.getInt('${linkKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${stickerTapKey}_$i')) {
        stickerTap[i] = _prefs.getInt('${stickerTapKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${tap1Key}_$i')) {
        tap1[i] = _prefs.getInt('${tap1Key}_$i') ?? 0;
      }

      if (_prefs.containsKey('${tap2Key}_$i')) {
        tap2[i] = _prefs.getInt('${tap2Key}_$i') ?? 0;
      }

      if (_prefs.containsKey('${tap3Key}_$i')) {
        tap3[i] = _prefs.getInt('${tap3Key}_$i') ?? 0;
      }

      if (_prefs.containsKey('${nameTap1Key}_$i')) {
        nameTap1[i] = _prefs.getString('${nameTap1Key}_$i') ?? 'Sticker_tap1';
      }

      if (_prefs.containsKey('${nameTap2Key}_$i')) {
        nameTap2[i] = _prefs.getString('${nameTap2Key}_$i') ?? 'Sticker_tap2';
      }

      if (_prefs.containsKey('${nameTap3Key}_$i')) {
        nameTap3[i] = _prefs.getString('${nameTap3Key}_$i') ?? 'Sticker_tap3';
      }

      if (_prefs.containsKey('${forwardKey}_$i')) {
        forward[i] = _prefs.getInt('${forwardKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${exitedKey}_$i')) {
        exited[i] = _prefs.getInt('${exitedKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${nextStoryKey}_$i')) {
        nextStory[i] = _prefs.getInt('${nextStoryKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${backKey}_$i')) {
        back[i] = _prefs.getInt('${backKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${profileVisitKey}_$i')) {
        profileVisit[i] = _prefs.getInt('${profileVisitKey}_$i') ?? 0;
      }

      if (_prefs.containsKey('${followsKey}_$i')) {
        follows[i] = _prefs.getInt('${followsKey}_$i') ?? 0;
      }
      if (_prefs.containsKey('${activityKey}_$i')) {
        activity[i] = _prefs.getInt('${activityKey}_$i') ?? 0;
      }
      if (_prefs.containsKey('${intractionKey}_$i')) {
        intraction[i] = _prefs.getInt('${intractionKey}_$i') ?? 0;
      }
      if (_prefs.containsKey('${navigationKey}_$i')) {
        navigation[i] = _prefs.getInt('${navigationKey}_$i') ?? 0;
      }
    }

    notifyListeners();
  }

  saveViewStory({required int value, required int index}) {
    String key = '${viewStoryKey}_$index';
    viewStory[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveReach({required int value, required int index}) {
    String key = '${reachKey}_$index';
    reach[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveFollowerChart({required int value, required int index}) {
    String key = '${followerChartKey}_$index';
    followerChart[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveNonFollowerChart({required int value, required int index}) {
    String key = '${nonFollowerChartKey}_$index';
    nonFollowerChart[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveImpression({required int value, required int index}) {
    String key = '${impressionKey}_$index';
    impression[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveEngaged({required int value, required int index}) {
    String key = '${engagedKey}_$index';
    engaged[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveShare({required int value, required int index}) {
    String key = '${shareKey}_$index';
    share[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveReplies({required int value, required int index}) {
    String key = '${repliesKey}_$index';
    replies[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveLink({required int value, required int index}) {
    String key = '${linkKey}_$index';
    link[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveStickerTap({required int value, required int index}) {
    String key = '${stickerTapKey}_$index';
    stickerTap[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveTap1({required int value, required int index}) {
    String key = '${tap1Key}_$index';
    tap1[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveTap2({required int value, required int index}) {
    String key = '${tap2Key}_$index';
    tap2[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveTap3({required int value, required int index}) {
    String key = '${tap3Key}_$index';
    tap3[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveNameTap1({required String value, required int index}) {
    String key = '${nameTap1Key}_$index';
    nameTap1[index] = value;
    _prefs.setString(key, value);
    notifyListeners();
  }

  saveNameTap2({required String value, required int index}) {
    String key = '${nameTap2Key}_$index';
    nameTap2[index] = value;
    _prefs.setString(key, value);
    notifyListeners();
  }

  saveNameTap3({required String value, required int index}) {
    String key = '${nameTap3Key}_$index';
    nameTap3[index] = value;
    _prefs.setString(key, value);
    notifyListeners();
  }

  saveForward({required int value, required int index}) {
    String key = '${forwardKey}_$index';
    forward[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveExited({required int value, required int index}) {
    String key = '${exitedKey}_$index';
    exited[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveNextStory({required int value, required int index}) {
    String key = '${nextStoryKey}_$index';
    nextStory[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveBack({required int value, required int index}) {
    String key = '${backKey}_$index';
    back[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveProfileVisit({required int value, required int index}) {
    String key = '${profileVisitKey}_$index';
    profileVisit[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveFollows({required int value, required int index}) {
    String key = '${followsKey}_$index';
    follows[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveActivity({required int value, required int index}) {
    String key = '${activityKey}_$index';
    activity[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveIntraction({required int value, required int index}) {
    String key = '${intractionKey}_$index';
    intraction[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }

  saveNavigation({required int value, required int index}) {
    String key = '${navigationKey}_$index';
    navigation[index] = value;
    _prefs.setInt(key, value);
    notifyListeners();
  }
}

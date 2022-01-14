import 'package:ynotes/core/logic/models_exporter.dart';
import 'package:ynotes/core/offline/offline.dart';
import 'package:ynotes/core/utils/logging_utils/logging_utils.dart';

class PollsOffline {
  late Offline parent;
  PollsOffline(Offline _parent) {
    parent = _parent;
  }
  Future<List<PollInfo>?> get() async {
    try {
      return await parent.offlineBox?.get("polls")?.cast<PollInfo>();
    } catch (e) {
      Logger.log("POLLS", "An error occured while returning polls");
      Logger.error(e, stackHint: "NDU=");
      return null;
    }
  }

  ///Update existing polls (clear old data) with passed data
  update(List<PollInfo>? newData) async {
    Logger.log("POLLS", "Update offline polls (length : ${newData!.length})");
    try {
      await parent.offlineBox?.delete("polls");
      await parent.offlineBox?.put("polls", newData);
    } catch (e) {
      Logger.log("POLLS", "An error occured while updating polls");
      Logger.error(e, stackHint: "NDY=");
    }
  }
}

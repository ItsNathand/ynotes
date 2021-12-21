library app;

import 'dart:io';
import 'package:background_fetch/background_fetch.dart';
import 'package:collection/collection.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ynotes/core/logic/app_config/controller.dart';
import 'package:ynotes/core/logic/models_exporter.dart';
import 'package:ynotes/core/services/background.dart';
import 'package:ynotes/core/services/notifications.dart';
import 'package:ynotes/core/utils/bugreport_utils.dart';
import 'package:ynotes/core/utils/file_utils.dart';
import 'package:ynotes/core/utils/kvs.dart';
import 'package:ynotes/core/utils/logging_utils/logging_utils.dart';
import 'package:ynotes/core/utils/ui.dart';
import 'package:ynotes/ui/components/hive_life_cycle_manager.dart';
import 'package:ynotes/ui/screens/agenda/agenda.dart';
import 'package:ynotes/ui/screens/cloud/cloud.dart';
import 'package:ynotes/ui/screens/downloads/downloads.dart';
import 'package:ynotes/ui/screens/error/error.dart';
import 'package:ynotes/ui/screens/grades/grades.dart';
import 'package:ynotes/ui/screens/home/routes.dart';
import 'package:ynotes/ui/screens/homework/homework.dart';
import 'package:ynotes/ui/screens/intro/routes.dart';
import 'package:ynotes/ui/screens/loading/loading.dart';
import 'package:ynotes/ui/screens/login/routes.dart';
import 'package:ynotes/ui/screens/mailbox/mailbox.dart';
import 'package:ynotes/ui/screens/polls/routes.dart';
import 'package:ynotes/ui/screens/school_life/routes.dart';
import 'package:ynotes/ui/screens/settings/routes.dart';
import 'package:ynotes/ui/screens/terms/terms.dart';
import 'package:ynotes/ui/themes/themes.dart';
import 'package:ynotes/ui/themes/utils/fonts.dart';
import 'package:ynotes_packages/config.dart';
import 'package:ynotes_packages/theme.dart';

part 'src/app.dart';
part 'src/backward_compatibility.dart';
part 'src/config.dart';
part 'src/globals.dart';
part 'src/init.dart';
part 'src/router.dart';

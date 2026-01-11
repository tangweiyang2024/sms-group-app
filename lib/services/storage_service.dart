import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/group_rule.dart';
import '../models/sms_group.dart';

class StorageService {
  static final StorageService instance = StorageService._internal();
  factory StorageService() => instance;
  StorageService._internal();

  Database? _database;
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sms_group.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE group_rules(
            id TEXT PRIMARY KEY,
            group_name TEXT NOT NULL,
            match_type TEXT NOT NULL,
            patterns TEXT NOT NULL,
            priority INTEGER DEFAULT 0,
            is_enabled INTEGER DEFAULT 1,
            color TEXT DEFAULT '#2196F3'
          )
        ''');

        await db.execute('''
          CREATE TABLE sms_groups(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            message_ids TEXT NOT NULL,
            rule_id TEXT NOT NULL,
            color TEXT NOT NULL,
            message_count INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<void> saveRule(GroupRule rule) async {
    final db = await database;
    await db.insert(
      'group_rules',
      {
        'id': rule.id,
        'group_name': rule.groupName,
        'match_type': rule.matchType.name,
        'patterns': rule.patterns.join(','),
        'priority': rule.priority,
        'is_enabled': rule.isEnabled ? 1 : 0,
        'color': rule.color,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<GroupRule>> getRules() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('group_rules');
    
    return List.generate(maps.length, (i) {
      return GroupRule(
        id: maps[i]['id'] as String,
        groupName: maps[i]['group_name'] as String,
        matchType: MatchType.fromString(maps[i]['match_type'] as String),
        patterns: (maps[i]['patterns'] as String).split(','),
        priority: maps[i]['priority'] as int,
        isEnabled: (maps[i]['is_enabled'] as int) == 1,
        color: maps[i]['color'] as String,
      );
    });
  }

  Future<void> deleteRule(String id) async {
    final db = await database;
    await db.delete(
      'group_rules',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> saveGroup(SMSGroup group) async {
    final db = await database;
    await db.insert(
      'sms_groups',
      {
        'id': group.id,
        'name': group.name,
        'message_ids': group.messageIds.join(','),
        'rule_id': group.ruleId,
        'color': group.color,
        'message_count': group.messageCount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SMSGroup>> getGroups() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sms_groups');
    
    return List.generate(maps.length, (i) {
      return SMSGroup(
        id: maps[i]['id'] as String,
        name: maps[i]['name'] as String,
        messageIds: (maps[i]['message_ids'] as String).split(','),
        ruleId: maps[i]['rule_id'] as String,
        color: maps[i]['color'] as String,
        messageCount: maps[i]['message_count'] as int,
      );
    });
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('group_rules');
    await db.delete('sms_groups');
  }

  Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await _prefs?.setBool('first_launch', isFirstLaunch);
  }

  Future<bool> isFirstLaunch() async {
    return _prefs?.getBool('first_launch') ?? true;
  }
}
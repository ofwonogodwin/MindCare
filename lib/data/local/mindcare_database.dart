import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MindCareDatabase {
  const MindCareDatabase._();

  static Database? _database;

  static Future<Database> instance() async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mindcare.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT UNIQUE,
            phone TEXT,
            password_hash TEXT,
            is_anonymous INTEGER DEFAULT 0,
            anonymous_id TEXT,
            created_at TEXT,
            last_active TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE counselors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            specialization TEXT,
            bio TEXT,
            credentials TEXT,
            profile_image TEXT,
            is_available INTEGER DEFAULT 1,
            email TEXT,
            phone TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE counselor_availability (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            counselor_id INTEGER,
            day_of_week INTEGER,
            start_time TEXT,
            end_time TEXT,
            is_recurring INTEGER DEFAULT 1
          )
        ''');

        await db.execute('''
          CREATE TABLE appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_reference TEXT UNIQUE,
            user_id INTEGER,
            counselor_id INTEGER,
            appointment_date TEXT,
            appointment_time TEXT,
            duration_minutes INTEGER DEFAULT 50,
            appointment_type TEXT,
            reason TEXT,
            status TEXT,
            created_at TEXT,
            cancelled_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE chat_sessions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            counselor_id INTEGER,
            started_at TEXT,
            ended_at TEXT,
            is_active INTEGER DEFAULT 1
          )
        ''');

        await db.execute('''
          CREATE TABLE chat_messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            session_id INTEGER,
            sender_id INTEGER,
            sender_type TEXT,
            message_text TEXT,
            is_read INTEGER DEFAULT 0,
            sent_at TEXT,
            delivered_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE mood_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            mood_level INTEGER,
            note TEXT,
            factors TEXT,
            log_date TEXT,
            log_time TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE articles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            category TEXT,
            summary TEXT,
            content TEXT,
            image_url TEXT,
            author TEXT,
            read_time_minutes INTEGER,
            published_date TEXT,
            is_featured INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE saved_articles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            article_id INTEGER,
            saved_at TEXT,
            UNIQUE(user_id, article_id)
          )
        ''');

        await db.execute('''
          CREATE TABLE crisis_resources (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            resource_name TEXT,
            description TEXT,
            phone_number TEXT,
            text_number TEXT,
            website TEXT,
            location TEXT,
            is_national INTEGER DEFAULT 1,
            country TEXT DEFAULT "Uganda"
          )
        ''');

        await db.execute('''
          CREATE TABLE notifications (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            type TEXT,
            title TEXT,
            message TEXT,
            is_read INTEGER DEFAULT 0,
            created_at TEXT,
            action_data TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE user_settings (
            user_id INTEGER PRIMARY KEY,
            theme TEXT DEFAULT "light",
            font_size TEXT DEFAULT "medium",
            notification_enabled INTEGER DEFAULT 1,
            reminder_times TEXT,
            anonymous_mode INTEGER DEFAULT 0,
            data_sharing_consent INTEGER DEFAULT 0
          )
        ''');
      },
    );

    return _database!;
  }
}

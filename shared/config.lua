-- =====================================================
-- 🚔 ARREST SYSTEM - CONFIGURATION
-- =====================================================

Config = {}

-- الإحداثيات
Config.Locations = {
    -- مركز الشرطة
    PoliceStation = {
        x = 425.1,
        y = -979.5,
        z = 29.4,
        heading = 0.0
    },
    
    -- السجن
    Jail = {
        x = 1679.66,
        y = 2476.11,
        z = 45.55,
        heading = 230.0
    },
    
    -- نقطة الإفراج عن السجناء
    JailRelease = {
        x = 1680.0,
        y = 2500.0,
        z = 45.55,
        heading = 0.0
    },
    
    -- منطقة السجن (نطاق)
    JailZone = {
        x = 1680.0,
        y = 2480.0,
        z = 45.55,
        radius = 150.0
    }
}

-- مدد العقوبات بالدقائق
Config.SentenceTimes = {
    minor = 5,      -- مخالفة بسيطة
    medium = 15,    -- مخالفة متوسطة
    serious = 30,   -- جريمة خطيرة
    extreme = 60    -- جريمة شديدة جداً
}

-- الغرامات بالدولار
Config.Fines = {
    speeding = 250,
    reckless_driving = 500,
    fleeing_police = 1000,
    assault = 2000,
    drug_possession = 5000,
    murder = 10000
}

-- مجموعات الشرطة المسموحة بالتوقيف
Config.PoliceGroups = {
    "policia",
    "police",
    "cop"
}

-- الأسلحة المحظورة
Config.IllegalWeapons = {
    "WEAPON_SNIPER_RIFLE",
    "WEAPON_RAILGUN",
    "WEAPON_HOMINGARKS",
    "WEAPON_MINIGUN"
}

-- رسائل النظام
Config.Messages = {
    arrested = "تم توقيفك من قبل الشرطة! 🚨",
    released = "تم الإفراج عنك من السجن! ✅",
    fine_paid = "تم دفع الغرامة بنجاح! 💰",
    jail_time = "مدة السجن: %d دقيقة",
    not_police = "⛔ أنت لست شرطياً! ليس لديك صلاحيات التوقيف.",
    already_arrested = "⚠️ هذا الشخص موقوف بالفعل!",
    no_target = "❌ لم تختر هدفاً!",
    too_far = "❌ أنت بعيد جداً عن الشخص!",
    successful_arrest = "✅ تم التوقيف بنجاح!",
    release_success = "✅ تم الإفراج عن اللاعب!"
}

-- الألوان
Config.Colors = {
    police = {0, 100, 200},
    success = {0, 255, 0},
    error = {255, 0, 0},
    warning = {255, 255, 0}
}

-- =====================================================
-- 🚔 ARREST SYSTEM - DATABASE
-- =====================================================

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- جدول لتخزين بيانات الموقوفين
ArrestedPlayers = {}

-- =====================================================
-- دالة: حفظ بيانات التوقيف في قاعدة البيانات
-- =====================================================
function SaveArrestData(userId, arrestData)
    local query = "INSERT INTO vrp_arrest_history (user_id, arrest_date, sentence_time, reason, arrested_by) VALUES (?, ?, ?, ?, ?)"
    
    vRP.execute(query, {
        userId,
        os.date("%Y-%m-%d %H:%M:%S"),
        arrestData.sentenceTime,
        arrestData.reason,
        arrestData.arrestedBy
    })
end

-- =====================================================
-- دالة: استرجاع بيانات التوقيف
-- =====================================================
function GetArrestData(userId)
    local query = "SELECT * FROM vrp_arrest_history WHERE user_id = ? ORDER BY arrest_date DESC LIMIT 1"
    local result = vRP.query(query, {userId})
    
    if result and result[1] then
        return result[1]
    end
    return nil
end

-- =====================================================
-- دالة: إضافة لاعب لقائمة الموقوفين
-- =====================================================
function AddArrestedPlayer(userId, sourceId, sentenceTime, reason, arrestedBy)
    ArrestedPlayers[userId] = {
        sourceId = sourceId,
        sentenceTime = sentenceTime,
        reason = reason,
        arrestedBy = arrestedBy,
        arrestTime = os.time(),
        remainingTime = sentenceTime * 60 -- تحويل الدقائق إلى ثوان
    }
    
    SaveArrestData(userId, {
        sentenceTime = sentenceTime,
        reason = reason,
        arrestedBy = arrestedBy
    })
end

-- =====================================================
-- دالة: إزالة لاعب من قائمة الموقوفين
-- =====================================================
function RemoveArrestedPlayer(userId)
    if ArrestedPlayers[userId] then
        ArrestedPlayers[userId] = nil
        return true
    end
    return false
end

-- =====================================================
-- دالة: التحقق من حالة التوقيف
-- =====================================================
function IsPlayerArrested(userId)
    return ArrestedPlayers[userId] ~= nil
end

-- =====================================================
-- دالة: الحصول على بيانات الموقوف
-- =====================================================
function GetArrestedPlayerData(userId)
    if ArrestedPlayers[userId] then
        return ArrestedPlayers[userId]
    end
    return nil
end

-- =====================================================
-- دالة: تحديث الوقت المتبقي
-- =====================================================
function UpdateRemainingTime(userId)
    if ArrestedPlayers[userId] then
        local elapsed = os.time() - ArrestedPlayers[userId].arrestTime
        ArrestedPlayers[userId].remainingTime = (ArrestedPlayers[userId].sentenceTime * 60) - elapsed
        
        if ArrestedPlayers[userId].remainingTime <= 0 then
            return false -- انتهت مدة الحبس
        end
        return true
    end
    return false
end

-- =====================================================
-- دالة: الحصول على الوقت المتبقي بالدقائق
-- =====================================================
function GetRemainingTime(userId)
    if ArrestedPlayers[userId] then
        local remaining = ArrestedPlayers[userId].remainingTime
        return math.ceil(remaining / 60)
    end
    return 0
end

-- =====================================================
-- دالة: إنشاء جداول قاعدة البيانات (عند التثبيت الأول)
-- =====================================================
function CreateDatabase()
    local createTable = [[
        CREATE TABLE IF NOT EXISTS vrp_arrest_history (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT NOT NULL,
            arrest_date DATETIME DEFAULT CURRENT_TIMESTAMP,
            sentence_time INT NOT NULL,
            reason VARCHAR(255) NOT NULL,
            arrested_by VARCHAR(50),
            FOREIGN KEY (user_id) REFERENCES vrp_users(id)
        );
        
        CREATE TABLE IF NOT EXISTS vrp_arrest_records (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT NOT NULL,
            total_arrests INT DEFAULT 0,
            total_time_served INT DEFAULT 0,
            FOREIGN KEY (user_id) REFERENCES vrp_users(id)
        );
    ]]
    
    vRP.execute(createTable, {})
    print("^2[Arrest System]^7 Database tables created successfully!")
end

-- =====================================================
-- دالة: إضافة سجل جديد للاعب
-- =====================================================
function AddArrestRecord(userId)
    local query = "INSERT INTO vrp_arrest_records (user_id, total_arrests) VALUES (?, 1) ON DUPLICATE KEY UPDATE total_arrests = total_arrests + 1"
    vRP.execute(query, {userId})
end

-- =====================================================
-- دالة: الحصول على السجل الكامل للاعب
-- =====================================================
function GetPlayerArrestRecord(userId)
    local query = "SELECT * FROM vrp_arrest_records WHERE user_id = ?"
    local result = vRP.query(query, {userId})
    
    if result and result[1] then
        return result[1]
    end
    return nil
end

-- =====================================================
-- تهيئة قاعدة البيانات عند بدء السكريبت
-- =====================================================
CreateDatabase()

print("^2[Arrest System]^7 Database module loaded!")

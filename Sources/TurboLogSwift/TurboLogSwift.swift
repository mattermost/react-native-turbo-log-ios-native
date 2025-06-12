import Foundation

public enum TurboLoggerLevel: Int, CaseIterable {
    case debug = 0
    case info = 1
    case warning = 2
    case error = 3

    var objcLevel: TurboLogLevel {
        return TurboLogLevel(rawValue: self.rawValue) ?? TurboLogLevel(rawValue: 0)!
    }
}

public class TurboLogger {
    public static func configure(
        dailyRolling: Bool,
        maximumFileSize: UInt,
        maximumNumberOfFiles: UInt,
        logsDirectory: String,
        logsFilename: String
    ) throws {
        var error: NSError?
        TurboLog.configure(withDailyRolling: dailyRolling,
                          maximumFileSize: maximumFileSize,
                          maximumNumberOfFiles: maximumNumberOfFiles,
                          logsDirectory: logsDirectory,
                          logsFilename: logsFilename,
                          error: &error)
        if let error = error {
            throw error
        }
    }
    
    public static func deleteLogFiles() throws {
        try TurboLog.deleteFiles()
    }
    
    public static func getLogFilePaths() -> [String] {
        return TurboLog.getFilePaths()
    }
    
    public static func write(level: TurboLoggerLevel, message: Any...) {
        TurboLog.write(with: level.objcLevel, message: message)
    }
}

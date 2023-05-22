using System;
using System.IO;
using System.Threading;

namespace RMLibs.Logging;

public class Logger
{
    public const int VERBOSE = 0;
    public const int DEBUG = 1;
    public const int INFO = 2;
    public const int ERROR = 3;
    private readonly Mutex _mutex = new(false);

    private int _level;

    public Logger()
    {
        _level = VERBOSE;
        LogName = string.Empty;
        LogPath = string.Empty;
    }

    protected Logger(string logName)
    {
        _level = VERBOSE;
        LogName = logName;
        LogPath = string.Empty;
    }

    public Logger(string logName, int level)
    {
        Level = level;
        LogName = logName;
        LogPath = string.Empty;
    }

    public string LogName { set; get; }
    public string LogPath { set; get; }

    public int Level
    {
        get => _level;
        set
        {
            if (value < VERBOSE || value > ERROR)
                throw new ArgumentOutOfRangeException("Invalid Level value: " + value);
            _level = value;
        }
    }

    private static string ComposeMessage(string msg, string level)
    {
        return $"[{DateTime.Now:yyyyMMdd-HHmm}] - {level} - {msg}";
    }

    private void WriteLog(string msg, bool error = false)
    {
        var pathLog = error
            ? $"{LogPath}{LogName}ErrorLog_{DateTime.Now:yyyyMMdd}.log"
            : $"{LogPath}{LogName}GeneralLog_{DateTime.Now:yyyyMMdd}.log";

        _mutex.WaitOne();
        using (var sw = new StreamWriter(pathLog, true))
        {
            sw.WriteLine(msg);
        }

        _mutex.ReleaseMutex();
    }

    public void DebugVerbose(string msg)
    {
        if (_level == VERBOSE)
        {
            var message = ComposeMessage(msg, "VERBOSE");
            WriteLog(message);
        }
    }

    public void Debug(string msg)
    {
        if (_level <= DEBUG)
        {
            var message = ComposeMessage(msg, "DEBUG");
            WriteLog(message);
        }
    }

    public void Info(string msg)
    {
        if (_level <= INFO)
        {
            var message = ComposeMessage(msg, "INFO");
            WriteLog(message);
        }
    }

    public void Error(string msg)
    {
        var message = ComposeMessage(msg, "ERROR");
        WriteLog(message, true);
    }
}
using System;
using System.IO;
using System.Threading;

namespace RMLibs.Logging
{
    public class Logger
    {
        public const int VERBOSE = 0;
        public const int DEBUG = 1;
        public const int INFO = 2;
        public const int ERROR = 3;

        private int _level;
        private readonly Mutex _mutex = new Mutex(false);

        public string LogName { set; get; }
        public string LogPath { set; get; }

        private static string ComposeMessage(string msg, string level)
        {
            return $"[{DateTime.Now:yyyyMMdd-HHmm}] - {level} - {msg}";
        }

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
            LogPath = String.Empty;
        }

        public int Level
        {
            get => _level;
            set
            {
                if (value < VERBOSE || value > ERROR)
                {
                    throw new ArgumentOutOfRangeException("Invalid Level value: " + value);
                }
                _level = value;
            }
        }

        private void WriteLog(string msg, bool error = false)
        {
            string pathLog = error ? $"{LogPath}{LogName}ErrorLog_{DateTime.Now:yyyyMMdd}.log"
                : $"{LogPath}{LogName}GeneralLog_{DateTime.Now:yyyyMMdd}.log";
            
            _mutex.WaitOne();
            using (StreamWriter sw = new StreamWriter(pathLog, true))
            {
                sw.WriteLine(msg);
            }
            _mutex.ReleaseMutex();
        }

        public void DebugVerbose(string msg)
        {
            if (_level == VERBOSE)
            {
                string message = ComposeMessage(msg, "VERBOSE");
                WriteLog(message);
            }
        }

        public void Debug(string msg)
        {
            if (_level <= DEBUG)
            {
                string message = ComposeMessage(msg, "DEBUG");
                WriteLog(message);
            }
        }

        public void Info(string msg)
        {
            if (_level <= INFO)
            {
                string message = ComposeMessage(msg, "INFO");
                WriteLog(message);
            }
        }

        public void Error(string msg)
        {
            string message = ComposeMessage(msg, "ERROR");
            WriteLog(message, true);
        }
    }
}


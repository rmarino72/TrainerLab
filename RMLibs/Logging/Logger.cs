using System;
using System.IO;

namespace RMLibs.Logging
{
    public class Logger
    {
        public const int VERBOSE = 0;
        public const int DEBUG = 1;
        public const int INFO = 2;
        public const int ERROR = 3;

        private int level;

        public string LogName { set; get; }
        public string LogPath { set; get; }

        private string ComposeMessage(string msg, string level)
        {
            return string.Format("[{0}] - {1} - {2}", DateTime.Now.ToString("yyyyMMdd-HHmm"), level, msg);
        }

        public Logger()
        {
            level = VERBOSE;
            LogName = String.Empty;
            LogPath = String.Empty;
        }

        public Logger(string logName)
        {
            level = VERBOSE;
            LogName = logName;
            LogPath = String.Empty;

        }

        public Logger(string logName, int level)
        {
            Level = level;
            LogName = logName;
            LogPath = String.Empty;
        }

        public int Level
        {
            get => level;
            set
            {
                if (value < VERBOSE || value > ERROR)
                {
                    throw new ArgumentOutOfRangeException("Invalid Level value: " + value);
                }
                level = value;
            }
        }

        public void WriteLog(string msg, bool error = false)
        {
            string pathLog = error ?
                String.Format("{0}{1}ErrorLog_{2}.log", LogPath, LogName, DateTime.Now.ToString("yyyyMMdd")) :
                String.Format("{0}{1}GeneralLog_{2}.log", LogPath, LogName, DateTime.Now.ToString("yyyyMMdd"));
            using (StreamWriter sw = new StreamWriter(pathLog, true))
            {
                sw.WriteLine(msg);
            }
        }

        public void DebugVerbose(string msg)
        {
            if (level == VERBOSE)
            {
                string message = ComposeMessage(msg, "VERBOSE");
                WriteLog(message);
            }
        }

        public void Debug(string msg)
        {
            if (level <= DEBUG)
            {
                string message = ComposeMessage(msg, "DEBUG");
                WriteLog(message);
            }
        }

        public void Info(string msg)
        {
            if (level <= INFO)
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


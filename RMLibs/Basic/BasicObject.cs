using System;
using RMLibs.Logging;
using System.Runtime.CompilerServices;
using Newtonsoft.Json;

namespace RMLibs.basic
{
    public class BasicObject : IDisposable
    {
        [JsonIgnore]
        protected Logger Logger { set; get; }

        private string FormatLogMsg(string msg, string method)
        {
            return $"{GetType()}.{method} - {msg}";
        }

        protected void DebugVerbose(string msg, [CallerMemberName] string method = "")
        {
            if (Logger != null) Logger.DebugVerbose(FormatLogMsg(msg, method));
            Console.WriteLine(FormatLogMsg(msg, method));
        }

        protected void Debug(string msg, [CallerMemberName] string method = "")
        {
            if (Logger != null) Logger.Debug(FormatLogMsg(msg, method));
            Console.WriteLine(FormatLogMsg(msg, method));
        }

        protected void Info(string msg, [CallerMemberName] string method = "")
        {
            if (Logger != null) Logger.Info(FormatLogMsg(msg, method));
            Console.WriteLine(FormatLogMsg(msg, method));
        }

        protected void Error(string msg, string stackTrace = null, [CallerMemberName] string method = "")
        {
            string message = string.IsNullOrEmpty(stackTrace) ? msg : $"{msg} - {stackTrace}";
            if (Logger != null) Logger.Error(FormatLogMsg(message, method));
            Console.WriteLine(FormatLogMsg(message, method));
        }

        protected void Error(Exception ex, [CallerMemberName] string method = "")
        {
            string message = string.IsNullOrEmpty(ex.StackTrace) ? ex.Message : $"{ex.Message} - {ex.StackTrace}";
            if (Logger != null) Logger.Error(FormatLogMsg(message, method));
            Console.WriteLine(FormatLogMsg(message, method));
        }

        public string ToJson()
        {
            try
            {
                return JsonConvert.SerializeObject(this, Formatting.Indented);
            }
            catch (Exception ex)
            {
               Error(ex);
               return null;
            }
        }

        public BasicObject Clone()
        {
            return (BasicObject)this.MemberwiseClone();
        }

        public void Dispose()
        {
        }
    }
}


using System;

namespace Arthas
{
    [Serializable]
    public class Message
    {
        public string code;
        public string msg;
        public bool status;
        public Data data;
    }
    
    [Serializable]
    public class Data
    {
        public string env;
        public string version;
        public string resources_uri;
        public string apk_uri;
        public string desc;
    }
}
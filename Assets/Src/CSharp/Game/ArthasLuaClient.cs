using UnityEngine;
using System.IO;
using LuaInterface;

public class ArthasLuaClient : LuaClient 
{
//    protected override LuaFileUtils InitLoader()
//    {
//        return new LuaResLoader();
//    }

    new void Awake()
    {
        base.Awake();
    }

    new void OnApplicationQuit()
    {
        base.OnApplicationQuit();
    }
}
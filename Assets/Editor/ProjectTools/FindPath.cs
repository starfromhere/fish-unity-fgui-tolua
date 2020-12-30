using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;
using System.IO;
 
 
 
public class FindPath
{
    public static List<string> filelist = new List<string>();
    public static List<string> deallist = new List<string>();
	public static string filepath;
	// Use this for initialization
    [MenuItem("Tools/FindPath")]
 
    public static void GetPath()
    {
        clearmemory();
        recursiveFind(Selection.activeGameObject.gameObject);
       
        printinScreen();
        clearmemory();
    }
 
    public static void recursiveFind(GameObject go)
    {
        if (go != null)
        {
            filelist.Add(go.name);
            if (go.transform.parent != null)
            {
                recursiveFind(go.transform.parent.gameObject);
            }
           
        }
        
        
    }
 
 
    public static void clearmemory()
    {
        filelist.Clear();
        deallist.Clear();
    }
 
    public static void printinScreen()
    {
 
        for(int i = filelist.Count -1 ; i >= 0 ; i --)
        {
            string str = filelist[i];
            if(i != 0)
            {
                str = str +"/";
            }
            deallist.Add(str);
        }
        string showstr = "";
        foreach(var list in deallist)
        {
            showstr += list;
           
        }
        Debug.Log(showstr);
 
        TextEditor te = new TextEditor();
        te.content = new GUIContent(showstr);
        te.SelectAll();
        te.Copy();
 
        
    }
    
    
}
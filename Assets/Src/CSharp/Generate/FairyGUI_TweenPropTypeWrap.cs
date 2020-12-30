﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class FairyGUI_TweenPropTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(FairyGUI.TweenPropType));
		L.RegVar("None", get_None, null);
		L.RegVar("X", get_X, null);
		L.RegVar("Y", get_Y, null);
		L.RegVar("Z", get_Z, null);
		L.RegVar("XY", get_XY, null);
		L.RegVar("Position", get_Position, null);
		L.RegVar("Width", get_Width, null);
		L.RegVar("Height", get_Height, null);
		L.RegVar("Size", get_Size, null);
		L.RegVar("ScaleX", get_ScaleX, null);
		L.RegVar("ScaleY", get_ScaleY, null);
		L.RegVar("Scale", get_Scale, null);
		L.RegVar("Rotation", get_Rotation, null);
		L.RegVar("RotationX", get_RotationX, null);
		L.RegVar("RotationY", get_RotationY, null);
		L.RegVar("Alpha", get_Alpha, null);
		L.RegVar("Progress", get_Progress, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<FairyGUI.TweenPropType>.Check = CheckType;
		StackTraits<FairyGUI.TweenPropType>.Push = Push;
	}

	static void Push(IntPtr L, FairyGUI.TweenPropType arg)
	{
		ToLua.Push(L, arg);
	}

	static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(FairyGUI.TweenPropType), L, pos);
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_None(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.None);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_X(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.X);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Y(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Y);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Z(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Z);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_XY(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.XY);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Position(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Position);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Width(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Width);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Height(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Height);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Size(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Size);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ScaleX(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.ScaleX);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ScaleY(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.ScaleY);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Scale(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Scale);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Rotation(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Rotation);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_RotationX(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.RotationX);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_RotationY(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.RotationY);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Alpha(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Alpha);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Progress(IntPtr L)
	{
		ToLua.Push(L, FairyGUI.TweenPropType.Progress);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IntToEnum(IntPtr L)
	{
		int arg0 = (int)LuaDLL.lua_tonumber(L, 1);
		FairyGUI.TweenPropType o = (FairyGUI.TweenPropType)arg0;
		ToLua.Push(L, o);
		return 1;
	}
}

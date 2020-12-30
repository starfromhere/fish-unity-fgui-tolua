### Base

* 基于FairyGUI SDK 4.0.1

### Change 定制化改动
* 【ADD】 DisplayObjects.cs、GObject.cs 新增接口 **public void ChangeBlendMode(int mode)**

* 【Change】 FontManager.cs，增加非Resources目录默认字体的读取，**static public BaseFont GetFont(string name)**

* 【Change】 UIPackage.cs，修改了非编辑器下载入fgui包体代码，**LoadFromResPath**

  


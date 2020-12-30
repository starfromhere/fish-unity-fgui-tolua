//
// Versions.cs
//
// Author:
//       fjy <jiyuan.feng@live.com>
//
// Copyright (c) 2020 fjy
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation bundles (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace libx
{
    public enum VerifyBy
    {
        Size,
        CRC
    }

    [Serializable]
    public class Patch
    {
        public string name = string.Empty;
        public List<int> files = new List<int>();

        public void Serialize(BinaryWriter writer)
        {
            writer.Write(name);
            writer.Write(files.Count);
            foreach (var file in files)
            {
                writer.Write(file);
            }
        }

        public void Deserialize(BinaryReader reader)
        {
            name = reader.ReadString();
            var count = reader.ReadInt32();
            for (var i = 0; i < count; i++)
            {
                var file = reader.ReadInt32();
                files.Add(file);
            }
        }

        public override string ToString()
        {
            return string.Format("name={0}, files={1}", name, string.Join(",", files.ConvertAll(input => input.ToString()).ToArray()));
        }
    }

    [Serializable]
    public class AssetRef
    {
        public string name;
        public int bundle;
        public int dir;

        public void Serialize(BinaryWriter writer)
        {
            writer.Write(name);
            writer.Write(bundle);
            writer.Write(dir);
        }

        public void Deserialize(BinaryReader reader)
        {
            name = reader.ReadString();
            bundle = reader.ReadInt32();
            dir = reader.ReadInt32();
        }

        public override string ToString()
        {
            return string.Format("name={0}, bundle={1}, dir={2}", name, bundle, dir);
        }
    }

    [Serializable]
    public class BundleRef
    {
        public string name;
        public int[] children = new int[0];
        public long len;
        public string hash;
        public string crc;
        public int id { get; set; }

        public bool Equals(BundleRef other)
        {
            return name == other.name &&
                   len == other.len &&
                   hash.Equals(other.hash, StringComparison.OrdinalIgnoreCase) &&
                   crc.Equals(other.crc, StringComparison.OrdinalIgnoreCase);
        }

        public void Serialize(BinaryWriter writer)
        {
            writer.Write(len);
            writer.Write(name);
            writer.Write(hash);
            writer.Write(crc);
            var clen = children.Length;
            writer.Write(clen);
            foreach (var child in children)
            {
                writer.Write(child);
            }
        }

        public void Deserialize(BinaryReader reader)
        {
            len = reader.ReadInt64();
            name = reader.ReadString();
            hash = reader.ReadString();
            crc = reader.ReadString();
            var clen = reader.ReadInt32();
            children = new int[clen];
            for (var i = 0; i < clen; i++)
            {
                children[i] = reader.ReadInt32();
            }
        }

        public override string ToString()
        {
            return string.Format("id={0}, name={1}, hash={2}, crc={3}, children={4}", id, name, hash, crc,
                string.Join(",", Array.ConvertAll(children, input => input.ToString())));
        }
    }

    public class Versions
    {
        public string ver;
        public string[] activeVariants = new string[0];
        public string[] dirs = new string[0];
        public List<AssetRef> assets = new List<AssetRef>();
        public List<BundleRef> bundles = new List<BundleRef>();
        public List<Patch> patches = new List<Patch>();
        public List<string> patchesInBuild = new List<string>();
        public bool allAssetsToBuild;

        private readonly Dictionary<string, BundleRef> _bundles = new Dictionary<string, BundleRef>();
        private readonly Dictionary<string, Patch> _patches = new Dictionary<string, Patch>();

        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.AppendLine("ver:\n" + ver);
            sb.AppendLine("activeVariants:\n" + string.Join(",", activeVariants));
            sb.AppendLine("dirs:\n" + string.Join("\n", dirs));
            sb.AppendLine("assets:\n" + string.Join("\n", assets.ConvertAll(input => input.ToString()).ToArray()));
            sb.AppendLine("bundles:\n" + string.Join("\n", bundles.ConvertAll(input => input.ToString()).ToArray()));
            sb.AppendLine("patches:\n" + string.Join("\n", patches.ConvertAll(input => input.ToString()).ToArray()));
            sb.AppendLine("patchesInBuild:\n" +
                          string.Join(",", patchesInBuild.ConvertAll(input => input.ToString()).ToArray()));
            return sb.ToString();
        }

        public bool Contains(BundleRef bundle)
        {
            BundleRef file;
            if (_bundles.TryGetValue(bundle.name, out file))
            {
                if (file.Equals(bundle))
                {
                    if (patchesInBuild.Count == 0)
                    {
                        return true;
                    }
                    else
                    {
                        foreach (var item in patchesInBuild)
                        {
                            Patch patch;
                            if (_patches.TryGetValue(item, out patch))
                            {
                                if (patch.files.Contains(file.id))
                                {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }

            return false;
        }

        public BundleRef GetBundle(string name)
        {
            BundleRef file;
            if (_bundles.TryGetValue(name, out file))
            {
                if (patchesInBuild.Count == 0)
                {
                    return file;
                }
                else
                {
                    foreach (var item in patchesInBuild)
                    {
                        Patch patch;
                        if (_patches.TryGetValue(item, out patch))
                        {
                            if (patch.files.Contains(file.id))
                            {
                                return file;
                            }
                        }
                    }
                }
            }

            return file;
        }

        public List<BundleRef> GetFiles(string patchName)
        {
            var list = new List<BundleRef>();
            Patch patch;
            if (_patches.TryGetValue(patchName, out patch))
            {
                if (patch.files.Count > 0)
                {
                    foreach (var file in patch.files)
                    {
                        var item = bundles[file];
                        list.Add(item);
                    }
                }
            }

            return list;
        }
        
        public List<BundleRef> GetFilesInBuild()
        {
            if (allAssetsToBuild)
            {
                return bundles;
            }
            var list = new List<BundleRef>();
            foreach (var patchName in patchesInBuild)
            {
                Patch patch;
                if (_patches.TryGetValue(patchName, out patch))
                {
                    if (patch.files.Count > 0)
                    {
                        foreach (var file in patch.files)
                        {
                            var item = bundles[file];
                            if (!list.Contains(item))
                            {
                                list.Add(item);
                            }
                        }
                    }
                }
            } 
            return list;
        }

        public void Serialize(BinaryWriter writer)
        {
            writer.Write(ver);

            writer.Write(dirs.Length);
            foreach (var dir in dirs)
                writer.Write(dir);

            writer.Write(activeVariants.Length);
            foreach (var variant in activeVariants)
                writer.Write(variant);

            writer.Write(assets.Count);
            foreach (var asset in assets)
                asset.Serialize(writer);

            writer.Write(bundles.Count);
            foreach (var file in bundles)
                file.Serialize(writer);

            writer.Write(patches.Count);
            foreach (var patch in patches)
                patch.Serialize(writer);

            writer.Write(patchesInBuild.Count);
            foreach (var patch in patchesInBuild)
                writer.Write(patch);
        }

        public void Deserialize(BinaryReader reader)
        {
            ver = reader.ReadString();
            var count = reader.ReadInt32();
            dirs = new string[count];
            for (var i = 0; i < count; i++)
            {
                dirs[i] = reader.ReadString();
            }

            count = reader.ReadInt32();
            activeVariants = new string[count];
            for (var i = 0; i < count; i++)
            {
                activeVariants[i] = reader.ReadString();
            }

            count = reader.ReadInt32();
            for (var i = 0; i < count; i++)
            {
                var file = new AssetRef();
                file.Deserialize(reader);
                assets.Add(file);
            }

            count = reader.ReadInt32();
            for (var i = 0; i < count; i++)
            {
                var file = new BundleRef();
                file.Deserialize(reader);
                file.id = bundles.Count;
                bundles.Add(file);
                _bundles[file.name] = file;
            }

            count = reader.ReadInt32();
            for (var i = 0; i < count; i++)
            {
                var patch = new Patch();
                patch.Deserialize(reader);
                patches.Add(patch);
                _patches[patch.name] = patch;
            }

            count = reader.ReadInt32();
            for (var i = 0; i < count; i++)
            {
                var patch = reader.ReadString();
                patchesInBuild.Add(patch);
            }
        }

        public void Save(string path)
        {
            if (File.Exists(path))
            {
                File.Delete(path);
            }

            using (var writer = new BinaryWriter(File.OpenWrite(path)))
            {
                Serialize(writer);
            }
        }
    }
}
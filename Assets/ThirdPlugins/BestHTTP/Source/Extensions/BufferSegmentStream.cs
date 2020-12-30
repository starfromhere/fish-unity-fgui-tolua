using System;
using System.Collections.Generic;
using System.IO;

using BestHTTP.PlatformSupport.Memory;

namespace BestHTTP.Extensions
{
    public sealed class BufferSegmentStream : Stream
    {
        public override bool CanRead { get { return false; } }

        public override bool CanSeek { get { return false; } }

        public override bool CanWrite { get { return false; } }

        public override long Length { get { return this._length; } }
        private long _length;

        public override long Position { get { return 0; } set { } }

        List<BufferSegment> bufferList = new List<BufferSegment>();
        int subBufferPosition = -1;

        public override int Read(byte[] buffer, int offset, int count)
        {
            int readCount = 0;

            while (count > 0 && bufferList.Count > 0)
            {
                BufferSegment buff = this.bufferList[0];

                if (this.subBufferPosition < 0)
                    this.subBufferPosition = buff.Offset;

                int tempReadCount = Math.Min(count, buff.Count - subBufferPosition - buff.Offset);

                Array.Copy(buff.Data, subBufferPosition, buffer, offset, tempReadCount);

                readCount += tempReadCount;
                offset += tempReadCount;
                count -= tempReadCount;

                subBufferPosition += tempReadCount;

                if (subBufferPosition - buff.Offset >= buff.Count)
                {
                    this.bufferList.RemoveAt(0);
                    BufferPool.Release(buff.Data);
                    subBufferPosition = -1;
                }
            }

            return readCount;
        }

        public override void Write(byte[] buffer, int offset, int count)
        {
            this.Write(new BufferSegment(buffer, offset, count));
        }

        public void Write(BufferSegment bufferSegment)
        {
            this.bufferList.Add(bufferSegment);
            this._length += bufferSegment.Count;
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);

            this._length = 0;
            this.subBufferPosition = -1;
        }

        public override void Flush() { }

        public override long Seek(long offset, SeekOrigin origin)
        {
            throw new NotImplementedException();
        }

        public override void SetLength(long value)
        {
            throw new NotImplementedException();
        }
    }
}

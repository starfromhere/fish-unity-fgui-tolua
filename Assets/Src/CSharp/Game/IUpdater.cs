namespace Arthas
{
    public interface IUpdater
    {
        void OnMessage(string msg);

        void OnProgress(float progress);

        void OnClear();
        
        void OnUpdateApk(string msg);
    }
}
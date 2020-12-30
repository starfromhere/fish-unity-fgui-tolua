using System;

namespace Arthas
{
    public class Game
    {
        private static Game instance = null;

        public enum Step
        {
            Start,
            Wait,
            ChangeScene,
            LuaLoad,
            LuaCompleted,
            None,
        };

        private Step _gameStep;
        private float _pregressValue;
        
        public static Game Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new Game();
                }
        
                return instance;
            }

            protected set
            {
                instance = value;
            }
        }

        public Step GameStep
        {
            get => _gameStep;
            set => _gameStep = value;
        }

        public float ProgressValue
        {
            get => _pregressValue;
            set => _pregressValue = value;
        }

        Game()
        {
        }

        public void Init()
        {
            GameStep = Step.Start;
        }

        public void Clear()
        {
            // TODO
        }
    }
}
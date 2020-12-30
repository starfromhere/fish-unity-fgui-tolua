using UnityEngine;
using System.Collections;

public class DeemoUvAnimation: MonoBehaviour
{
    public float fTilingX = 1.0f;
    public float fTilingY = 1.0f;
    public float fStartOffsetX = 0.0f;
    public float fStartOffsetY = 0.0f;
    public float fScrollSpeedX = 0.0f;
    public float fScrollSpeedY = 0.0f;
    public float fDurationTime = 0.0f;
    public AnimationCurve scrollCurve = AnimationCurve.Linear(0, 0, 1, 1);

    private float offsetX = 0.0f;
    private float offsetY = 0.0f;
	

    private bool _isEnable = true;
    public bool isEnable
    {
        get { return _isEnable; }
        set {
            _isEnable = value;
            if (value) enabled = true;
        }
    }
    void Awake()
    {   
		foreach (Material i in GetComponent<Renderer>().materials)
        {   
            i.mainTextureScale = new Vector2(fTilingX, fTilingY);           
        }
    }

    /// <summary>
    /// Update用于普通更新的情况，与enable和isEnable搭配使用；与UpdateFrame互斥
    /// </summary>
    void Update()
    {
        if (_isEnable) _OnUpdate();
        else this.enabled = false;
    }

    public void UpdateFrame()
    {
        _OnUpdate();
    }

    private void _OnUpdate()
    {
        if (fDurationTime < 0.0f)
        {
            Debug.Log("'fDurationTime' is wrong!");
        }
        else if (fDurationTime == 0.0f)
        {
            offsetX += fScrollSpeedX * Time.deltaTime;
            offsetY += fScrollSpeedY * Time.deltaTime;
            foreach (Material i in GetComponent<Renderer>().materials)
            {
                i.mainTextureOffset = new Vector2(fStartOffsetX + offsetX, fStartOffsetY + offsetY);
            }
        }
        else {
            offsetX += fScrollSpeedX * scrollCurve.Evaluate(Time.time / fDurationTime);
            offsetY += fScrollSpeedY * scrollCurve.Evaluate(Time.time / fDurationTime);
            foreach (Material i in GetComponent<Renderer>().materials)
            {
                i.mainTextureOffset = new Vector2(fStartOffsetX + offsetX, fStartOffsetY + offsetY);
            }
        }
        
    }
    

}

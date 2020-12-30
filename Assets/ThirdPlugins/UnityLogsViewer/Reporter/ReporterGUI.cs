using UnityEngine;
using System.Collections;

public class ReporterGUI : MonoBehaviour
{
	Reporter reporter;
	void Awake()
	{
#if PROJECT_DEBUG
		reporter = gameObject.GetComponent<Reporter>();
#endif
	}

	void OnGUI()
	{
#if PROJECT_DEBUG
		reporter.OnGUIDraw();
#endif
	}
}

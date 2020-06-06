using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AlterShaderProperty : MonoBehaviour
{
    [SerializeField]
    private Renderer[] rend;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    public void SetProperty(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_Radius", newValue);
        }
    }
}

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

    public void SetMosaicResolution(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_MosaicResolution", newValue);
        }
    }

    public void SetMosaicResolutionX(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_MosaicResolutionX", newValue);
        }
    }

    public void SetMosaicResolutionY(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_MosaicResolutionY", newValue);
        }
    }

    public void SetWarpUJump(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_UJump", newValue);
        }
    }

    public void SetWarpVJump(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_VJump", newValue);
        }
    }

    public void SetWarpSpeed(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_Speed", newValue);
        }
    }

    public void SetWarpFlowStrength(float newValue)
    {
        foreach (var r in rend)
        {
            r.material.SetFloat("_FlowStrength", newValue);
        }
    }
}

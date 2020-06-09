using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderSwapper : MonoBehaviour
{
    [SerializeField]
    private Shader[] shaders;
    private int shaderIndex = 0;

    private Renderer renderer;
    // Start is called before the first frame update
    void Start()
    {
        renderer = GetComponent<Renderer>();
        renderer.material.shader = shaders[shaderIndex];
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown("space"))
        {
            ChangeShader();
        }
    }

    private void ChangeShader()
    {
        shaderIndex++;
        if(shaderIndex >= shaders.Length)
        {
            shaderIndex = 0;
        }
        renderer.material.shader = shaders[shaderIndex];
    }
}

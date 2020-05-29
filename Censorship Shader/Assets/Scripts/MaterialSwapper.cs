using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialSwapper : MonoBehaviour
{
    [SerializeField]
    private Material[] materials;
    private int materialIndex = 0;

    private Renderer renderer;
    // Start is called before the first frame update
    void Start()
    {
        renderer = GetComponent<Renderer>();
        renderer.material = materials[materialIndex];
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown("space"))
        {
            ChangeMaterial();
        }
    }

    private void ChangeMaterial()
    {
        materialIndex++;
        if(materialIndex >= materials.Length)
        {
            materialIndex = 0;
        }
        renderer.material = materials[materialIndex];
    }
}

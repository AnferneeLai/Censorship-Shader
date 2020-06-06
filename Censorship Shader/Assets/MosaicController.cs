using UnityEngine;
using UnityEngine.UI;

public class MosaicController : MonoBehaviour
{
    Renderer rend;
    Transform tran;
    public Slider mainSlider;
    // Start is called before the first frame update
    void Start()
    {
        rend = GetComponent<Renderer>();
        rend.material.shader = Shader.Find("Custom/NewSurfaceShader");
        tran = GetComponent<Transform>();
        Debug.Log(rend.material.shader.ToString());
    }

    // Update is called once per frame
    public void UpdateObject()
    {
        Debug.Log(mainSlider.value);
        Debug.Log(rend.materials[0].color);
        for(int i = 0; i < rend.materials.Length; i++)
        {
            rend.materials[i].SetVector("_Color", new Vector4(1, 1, 1, mainSlider.value));
            //tran.position = new Vector3(0, 0, mainSlider.value);
        }
        //Debug.Log(tran.position);

    }
}

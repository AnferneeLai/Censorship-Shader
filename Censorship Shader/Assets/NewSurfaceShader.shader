Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader {
        Tags { "Queue" = "Transparent"  "RenderType"="Transparent" } // queue tag important
        LOD 200

        UsePass "Transparent/Diffuse/FORWARD" // important
    }

    FallBack "Diffuse"
}

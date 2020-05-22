Shader "Custom/BoxBlur"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Radius ("Radius", Float) = 20.0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            const float _Radius;

            fixed4 frag (v2f i) : SV_Target
            {
                // fixed4 col = tex2D(_MainTex, i.uv);
                float2 uv = i.uv;
                // Apply blur in x direction
                float2 direction = float2(0.0, 1.0 / uv.x);

                // Sample from image
                float4 sampleColor = float4(0.0, 0.0, 0.0, 0.0);
                float j = 0.0;
                for(float n = -_Radius; n <= _Radius; n++)
                {
                    sampleColor += tex2D(_MainTex, uv + (n * direction));
                    j++;
                }

                return sampleColor / j;
            }

            // void mainImage( out float4 fragColor, in float2 fragCoord )
            // {
            //     // Normalized pixel coordinates (from 0 to 1)
            //     float2 iResolution = float2(_MainTex.width, height);
            //     float2 uv = fragCoord/iResolution.xy;

            //     // Vertical
            //     float2 direction = float2( 0.0, 1.0 / iResolution.y );

            //     // Sample
            //     float4 sampleColor = float4( 0.0 );
            //     float j = 0.0;
            //     for ( float i = -radius; i <= radius; i++ )
            //     {
            //         sampleColor += texture( iChannel0, uv + ( i * direction ) );
            //         j++;
            //     }

            //     // Output to screen
            //     fragColor = sampleColor / j;
            // }
            ENDCG
        }
    }
}

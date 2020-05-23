Shader "Custom/BoxBlurImageEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Radius ("Radius", Range(0, 100)) = 20
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
            uniform float4 _MainTex_TexelSize;
            const float _Radius;

            fixed4 frag (v2f IN) : SV_Target
            {
                // Apply blur in x direction
                float2 direction = float2(1.0 / _ScreenParams.x, 0.0);

                // Sample from image
                float4 sampleColor = float4(0.0, 0.0, 0.0, 0.0);
                float j = 0.0;
                for(float i = -_Radius; i <= _Radius; i++)
                {
                    sampleColor += tex2D(_MainTex, IN.uv + (i * direction));
                    j++;
                }

                // Apply blur in y direction
                direction = float2(0.0, 1.0 / _ScreenParams.y);
                for(float n = -_Radius; n <= _Radius; n++)
                {
                    sampleColor += tex2D(_MainTex, IN.uv + (n * direction));
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

Shader "Swirl" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_Radius("Radius", Range(0,2500)) = 1000
		_OffsetX("OffsetX", Range(-1000,1000)) = 0
		_OffsetY("OffsetY", Range(-1000,1000)) = 0
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows

			#pragma target 3.0

			sampler2D _MainTex;

			struct Input {
				float2 uv_MainTex;
			};

			half _Glossiness;
			half _Metallic;
			fixed4 _Color;


			UNITY_INSTANCING_BUFFER_START(Props)
			UNITY_INSTANCING_BUFFER_END(Props)

				float _Radius, _OffsetX, _OffsetY;

				fixed4 Swirl(sampler2D tex, inout float2 uv, float time) {
					float radius = _Radius;
					float2 center = float2(_ScreenParams.x + _OffsetX, _ScreenParams.y + _OffsetY);
					float2 texSize = float2(_ScreenParams.x / 0.5, _ScreenParams.y / 0.5);
					float2 tc = uv * texSize;
					tc -= center;
					float dist = length(tc);
					float angle = sin(_Time.y * 0.15);
					if (dist < radius)
					{
						float percent = (radius - dist) / radius;
						float theta = percent * percent * angle * 28.0;
						float s = sin(theta);
						float c = cos(theta);
						tc = float2(dot(tc, float2(c, -s)), dot(tc, float2(s, c)));
					}
					tc += center;
					float3 color = tex2D(tex, tc / texSize).rgb;
					return fixed4(color, 1.0);
				}

				void surf(Input IN, inout SurfaceOutputStandard o) {

					fixed4 c = Swirl(_MainTex, IN.uv_MainTex.xy, 1) * _Color;
					o.Albedo = c.rgb;
					o.Metallic = _Metallic;
					o.Smoothness = _Glossiness;
					o.Alpha = c.a;
				}
				ENDCG
		}
			FallBack "Diffuse"
}


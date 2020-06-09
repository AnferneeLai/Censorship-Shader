// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

// Ref: http://www.geeks3d.com/20110428/shader-library-swirl-post-processing-filter-in-glsl/
// Swirl Effect for Unity

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
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard fullforwardshadows

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

			sampler2D _MainTex;

			struct Input {
				float2 uv_MainTex;
			};

			half _Glossiness;
			half _Metallic;
			fixed4 _Color;

			// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
			// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
			// #pragma instancing_options assumeuniformscaling
			UNITY_INSTANCING_BUFFER_START(Props)
				// put more per-instance properties here
			UNITY_INSTANCING_BUFFER_END(Props)

				// possibly add interactivity
				float _Radius, _OffsetX, _OffsetY;
				//uniform float angle;
				//uniform float2 center;

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
					//color.r = 1.0;
					return fixed4(color, 1.0);
				}

				void surf(Input IN, inout SurfaceOutputStandard o) {
					// Albedo comes from a texture tinted by color
					//fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
					fixed4 c = Swirl(_MainTex, IN.uv_MainTex.xy, 1) * _Color;
					o.Albedo = c.rgb;
					// Metallic and smoothness come from slider variables
					o.Metallic = _Metallic;
					o.Smoothness = _Glossiness;
					o.Alpha = c.a;
				}
				ENDCG
		}
			FallBack "Diffuse"
}

/*
vec4 PostFX(sampler2D tex, vec2 uv, float time)
{
	vec2 texSize = vec2(rt_w, rt_h);
	vec2 tc = uv * texSize;
	tc -= center;
	float dist = length(tc);
	if (dist < radius)
	{
		float percent = (radius - dist) / radius;
		float theta = percent * percent * angle * 8.0;
		float s = sin(theta);
		float c = cos(theta);
		tc = vec2(dot(tc, vec2(c, -s)), dot(tc, vec2(s, c)));
	}
	tc += center;
	vec3 color = texture2D(tex0, tc / texSize).rgb;
	return vec4(color, 1.0);
}
*/
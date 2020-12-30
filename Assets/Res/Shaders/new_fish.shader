
Shader "Custom/new_01"
{
	Properties
	{
		_matcup("matcup", 2D) = "white" {}
		_nm("nm", 2D) = "white" {}
		_G("G", CUBE) = "white" {}
		_tex("tex", 2D) = "white" {}
		_mask("mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma multi_compile_instancing
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow nofog 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldRefl;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		uniform sampler2D _tex;
		uniform float4 _tex_ST;
		uniform sampler2D _matcup;
		uniform sampler2D _nm;
		uniform float4 _nm_ST;
		uniform sampler2D _mask;
		uniform float4 _mask_ST;
		uniform samplerCUBE _G;

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			UNITY_SETUP_INSTANCE_ID(i);
			o.Normal = float3(0,0,1);
			float2 uv_tex = i.uv_texcoord * _tex_ST.xy + _tex_ST.zw;
			float2 uv_nm = i.uv_texcoord * _nm_ST.xy + _nm_ST.zw;
			float3 tex2DNode9 = UnpackNormal( tex2D( _nm, uv_nm ) );
			float2 uv_mask = i.uv_texcoord * _mask_ST.xy + _mask_ST.zw;
			float4 lerpResult11 = lerp( tex2D( _tex, uv_tex ) , tex2D( _matcup, ( ( mul( UNITY_MATRIX_V, float4( WorldNormalVector( i , tex2DNode9 ) , 0.0 ) ).xyz * 0.5 ) + 0.5 ).xy ) , tex2D( _mask, uv_mask ).r);
			o.Emission = ( lerpResult11 + texCUBE( _G, WorldReflectionVector( i , tex2DNode9 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
}

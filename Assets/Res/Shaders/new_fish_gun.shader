
Shader "Custom/newgun_02"
{
	Properties
	{
		_tex("tex", 2D) = "white" {}
		_tex_Color("tex_Color", Color) = (1,1,1,0)
		_normal("normal", 2D) = "bump" {}
		_normalpower("normal power", Range( 0 , 3)) = 0
		_GI("GI", CUBE) = "black" {}
		[HDR]_GI_color("GI_color", Color) = (0,0,0,0)
		_GI_power("GI_power", Range( 0 , 2)) = 2
		_matcap_a("matcap_a", 2D) = "white" {}
		[HDR]_Color_a("Color _a", Color) = (0,0,0,0)
		_matcap_b("matcap_b", 2D) = "white" {}
		[HDR]_Color_b("Color _b", Color) = (0,0,0,0)
		_Rmc_aBmc_b("R=mc_a B=mc_b", 2D) = "white" {}
		[HDR]_fresnel("fresnel", Color) = (0,0,0,0)
		_FR_power("FR_power", Range( 0 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow nofog 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldRefl;
			float3 worldPos;
		};

		uniform sampler2D _matcap_b;
		uniform float _normalpower;
		uniform sampler2D _normal;
		uniform float4 _normal_ST;
		uniform float4 _tex_Color;
		uniform sampler2D _tex;
		uniform float4 _tex_ST;
		uniform float4 _Color_b;
		uniform sampler2D _matcap_a;
		uniform float4 _Color_a;
		uniform sampler2D _Rmc_aBmc_b;
		uniform float4 _Rmc_aBmc_b_ST;
		uniform samplerCUBE _GI;
		uniform float _GI_power;
		uniform float4 _GI_color;
		uniform float _FR_power;
		uniform float4 _fresnel;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_normal = i.uv_texcoord * _normal_ST.xy + _normal_ST.zw;
			float3 noraml21 = UnpackScaleNormal( tex2D( _normal, uv_normal ), _normalpower );
			float3 world45 = normalize( (WorldNormalVector( i , noraml21 )) );
			float4 matcap_b135 = tex2D( _matcap_b, ( ( mul( UNITY_MATRIX_V, float4( world45 , 0.0 ) ).xyz * 0.5 ) + 0.5 ).xy );
			float2 uv_tex = i.uv_texcoord * _tex_ST.xy + _tex_ST.zw;
			float4 tex2DNode10 = tex2D( _tex, uv_tex );
			float4 tex19 = ( _tex_Color * tex2DNode10 );
			float4 matcap_a117 = tex2D( _matcap_a, ( ( mul( UNITY_MATRIX_V, float4( world45 , 0.0 ) ).xyz * 0.5 ) + 0.5 ).xy );
			float2 uv_Rmc_aBmc_b = i.uv_texcoord * _Rmc_aBmc_b_ST.xy + _Rmc_aBmc_b_ST.zw;
			float4 tex2DNode16 = tex2D( _Rmc_aBmc_b, uv_Rmc_aBmc_b );
			float qita149 = tex2DNode16.g;
			float4 lerpResult150 = lerp( ( matcap_b135 * tex19 * _Color_b ) , ( matcap_a117 * tex19 * _Color_a ) , qita149);
			float4 TT152 = lerpResult150;
			float jj155 = tex2DNode16.b;
			float4 lerpResult11 = lerp( TT152 , tex19 , jj155);
			float matcapmask_01108 = tex2DNode16.r;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV38 = dot( world45, ase_worldViewDir );
			float fresnelNode38 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV38, _FR_power ) );
			float4 e86 = ( lerpResult11 + ( texCUBE( _GI, WorldReflectionVector( i , noraml21 ) ) * _GI_power * _GI_color * matcapmask_01108 ) + ( fresnelNode38 * _fresnel ) );
			o.Emission = e86.rgb;
			float apple29 = tex2DNode10.a;
			o.Alpha = apple29;
		}

		ENDCG
	}

}

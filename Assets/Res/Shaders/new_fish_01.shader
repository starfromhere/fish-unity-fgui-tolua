
Shader "fish/new_01"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_matcup("matcup", 2D) = "white" {}
		_nm("nm", 2D) = "white" {}
		_G("G", CUBE) = "white" {}
		_tex("tex", 2D) = "white" {}
		_mask("mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		 //*********************绘制阴影的参数****************************
        _ShadowPlane ("Shadow Plane", Vector) = (0,0,2.8,77.2)
        _ShadowColor("Shadow Color",Color) = (0.1, 0.1, 0.1, 1)
        _ShadowPara("Shadow Param",Vector) = (0,0,0.77,-0.87)
        _lightDirection("LightDir",Vector) = (0,0.31,-3.94,-3.73)
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow nofog 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldRefl;
		};

		uniform sampler2D _tex;
		uniform float4 _tex_ST;
		uniform sampler2D _matcup;
		uniform sampler2D _nm;
		uniform float4 _nm_ST;
		uniform sampler2D _mask;
		uniform float4 _mask_ST;
		uniform samplerCUBE _G;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_tex = i.uv_texcoord * _tex_ST.xy + _tex_ST.zw;
			float4 tex2DNode10 = tex2D( _tex, uv_tex );
			float2 uv_nm = i.uv_texcoord * _nm_ST.xy + _nm_ST.zw;
			float4 tex2DNode9 = tex2D( _nm, uv_nm );
			float2 uv_mask = i.uv_texcoord * _mask_ST.xy + _mask_ST.zw;
			float4 lerpResult11 = lerp( tex2DNode10 , tex2D( _matcup, ( ( mul( UNITY_MATRIX_V, float4( (WorldNormalVector( i , tex2DNode9.rgb )) , 0.0 ) ).xyz * 0.5 ) + 0.5 ).xy ) , tex2D( _mask, uv_mask ));
			o.Emission = ( lerpResult11 + texCUBE( _G, WorldReflectionVector( i , tex2DNode9.rgb ) ) ).rgb;
			o.Alpha = tex2DNode10.a;
			clip( tex2DNode10.a - _Cutoff );
		}

		ENDCG
		     //*******************绘制阴影的参数pass 只需要在你原来的shader里面加入这个pass就可以绘制出实时阴影了******************************
        pass{
            Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
            ZWrite Off
            Fog { Mode Off }
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct v2f { 
                float4 pos : SV_POSITION;
                half3 texcord0 : TEXCOORD0;
                half3 texcord1 : TEXCOORD1;
            };
            uniform fixed4 _ShadowPlane;
            uniform fixed4 _ShadowPara;
            uniform fixed3 _lightDirection;
            uniform fixed4 _ShadowColor;
            v2f vert(appdata_tan v)
            {
                  v2f o;
                  fixed3 vt;
                  vt = mul(unity_ObjectToWorld , v.vertex).xyz;
                  fixed3 tmpvar_3;
                  tmpvar_3 = (vt - (( (dot (_ShadowPlane.xyz, vt) - _ShadowPlane.w) / dot (_ShadowPlane.xyz, _lightDirection)) * _lightDirection));
                  fixed4 tmpvar_4;
                  tmpvar_4.w = 1.0;
                  tmpvar_4.xyz = tmpvar_3;
                  o.pos = mul(UNITY_MATRIX_VP , tmpvar_4);
                  o.texcord0 = mul(unity_ObjectToWorld,float4(0, 0, 0, 1));
                  o.texcord1 = mul(unity_ObjectToWorld,float4(0, 0, 0, 1));
                  return o;
            }

            float4 frag(v2f inData) : COLOR
            {
                fixed3 posToPlane = inData.texcord0-inData.texcord1;
                fixed4 f = _ShadowColor;
                fixed v = pow (1.0 - clamp ((( sqrt( dot(posToPlane,posToPlane) ) * _ShadowPara.w) - _ShadowPara.x),0,1),_ShadowPara.y) * _ShadowPara.z;
                f.w = v * _ShadowColor.a;
                return f;
            }
            ENDCG
        }
        //*************************************************

    } 
    FallBack "Diffuse"
}
	


Shader "Custom/newfish_shader"
{
	Properties
	{
		_tex("tex", 2D) = "white" {}
		_tex_Color("tex_Color", Color) = (1,1,1,0)
		_normal("normal", 2D) = "bump" {}
		_normalpower("normal power", Range( 0 , 3)) = 0
		_GI("GI", CUBE) = "black" {}
		_GI_power("GI_power", Range( 0 , 2)) = 0
		_matcaptex("matcap tex", 2D) = "white" {}
		[HDR]_matcapcolor("matcapcolor", Color) = (0,0,0,0)
		_RmatcapGGI("R=matcap G=GI", 2D) = "white" {}
		[HDR]_fresnel("fresnel", Color) = (0,0,0,0)
		[Toggle(_BOWEN_ON)] _bowen("bowen", Float) = 0
		_CoverageLevel("Coverage Level", Range( 0 , 1)) = 0
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1

		_ShadowPlane ("Shadow Plane", Vector) = (0,0,2.8,77.2)
        _ShadowColor("Shadow Color",Color) = (0.1, 0.1, 0.1, 1)
        _ShadowPara("Shadow Param",Vector) = (0,0,0.77,-0.87)
        _lightDirection("LightDir",Vector) = (0,0.31,-3.94,-3.73)
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
		#pragma shader_feature_local _BOWEN_ON
		#pragma surface surf Standard keepalpha noshadow nofog 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldRefl;
			float3 worldPos;
		};

		uniform float4 _tex_Color;
		uniform sampler2D _tex;
		uniform float4 _tex_ST;
		uniform sampler2D _matcaptex;
		uniform float _normalpower;
		uniform sampler2D _normal;
		uniform float4 _normal_ST;
		uniform float4 _matcapcolor;
		uniform sampler2D _RmatcapGGI;
		uniform float4 _RmatcapGGI_ST;
		uniform samplerCUBE _GI;
		uniform float _GI_power;
		uniform float4 _fresnel;
		uniform float2 _Vector0;
		uniform float _CoverageLevel;


		float2 voronoihash79( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi79( float2 v, float time, inout float2 id, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash79( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		float2 voronoihash83( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi83( float2 v, float time, inout float2 id, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash83( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_tex = i.uv_texcoord * _tex_ST.xy + _tex_ST.zw;
			float4 tex2DNode10 = tex2D( _tex, uv_tex );
			float4 tex19 = ( _tex_Color * tex2DNode10 );
			float2 uv_normal = i.uv_texcoord * _normal_ST.xy + _normal_ST.zw;
			float3 noraml21 = UnpackScaleNormal( tex2D( _normal, uv_normal ), _normalpower );
			float3 world45 = normalize( (WorldNormalVector( i , noraml21 )) );
			float2 uv_RmatcapGGI = i.uv_texcoord * _RmatcapGGI_ST.xy + _RmatcapGGI_ST.zw;
			float4 tex2DNode16 = tex2D( _RmatcapGGI, uv_RmatcapGGI );
			float matcapmask108 = tex2DNode16.r;
			float4 lerpResult11 = lerp( tex19 , ( tex19 * tex2D( _matcaptex, ( ( mul( UNITY_MATRIX_V, float4( world45 , 0.0 ) ).xyz * 0.5 ) + 0.5 ).xy ) * _matcapcolor ) , matcapmask108);
			float GImask110 = tex2DNode16.g;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV38 = dot( world45, ase_worldViewDir );
			float fresnelNode38 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV38, 3.0 ) );
			float4 e86 = ( lerpResult11 + ( texCUBE( _GI, WorldReflectionVector( i , noraml21 ) ) * _GI_power * GImask110 ) + ( fresnelNode38 * _fresnel ) );
			float time79 = 0.0;
			float2 uv_TexCoord81 = i.uv_texcoord * _Vector0;
			float2 panner80 = ( 1.0 * _Time.y * float2( 1,-1 ) + uv_TexCoord81);
			float2 coords79 = panner80 * 1.0;
			float2 id79 = 0;
			float voroi79 = voronoi79( coords79, time79,id79, 0 );
			float time83 = 0.0;
			float2 panner82 = ( 1.0 * _Time.y * float2( 1,1 ) + uv_TexCoord81);
			float2 coords83 = panner82 * 1.0;
			float2 id83 = 0;
			float voroi83 = voronoi83( coords83, time83,id83, 0 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			#ifdef _BOWEN_ON
				float staticSwitch75 = saturate( pow( ( 1.0 - ( ase_worldNormal.z + _CoverageLevel ) ) , 4.77 ) );
			#else
				float staticSwitch75 = 0.0;
			#endif
			float CoverageMask74 = staticSwitch75;
			float4 lerpResult85 = lerp( e86 , ( e86 + pow( ( voroi79 + voroi83 ) , 3.0 ) ) , CoverageMask74);
			float4 em91 = lerpResult85;
			o.Emission = em91.rgb;
			float apple29 = tex2DNode10.a;
			o.Alpha = apple29;
		}

		ENDCG

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
	}

}

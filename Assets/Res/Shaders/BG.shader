
Shader "Custom/Bg"
{
	Properties
	{
		_tex("tex", 2D) = "white" {}
		_Tex_color("Tex_color", Color) = (1,1,1,0)
		_Color0("Color 0", Color) = (1,1,1,0)
		_Ripple_Tiling("Ripple_Tiling", Vector) = (0,0,0,0)
		[HDR]_Ripple_color("Ripple_color", Color) = (0,0,0,0)
		_time("time", Float) = 20
		_power("power", Range( 0 , 0.1)) = 0.03162915
		_Disturbance_Tiling("Disturbance_Tiling", Vector) = (0,0,0,0)
		_depth("depth", 2D) = "white" {}
		[HDR]_light("light", Color) = (0,0,0,0)
		_Dimming("Dimming", Range( 0 , 2)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows nofog 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _tex;
		uniform float _time;
		uniform float2 _Disturbance_Tiling;
		uniform float _power;
		uniform float4 _Color0;
		uniform float4 _Tex_color;
		uniform sampler2D _depth;
		uniform float2 _Ripple_Tiling;
		uniform float4 _Ripple_color;
		uniform float4 _light;
		uniform float _Dimming;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float2 voronoihash59( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi59( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash59( n + g );
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


		float2 voronoihash58( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi58( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash58( n + g );
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


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float temp_output_68_0 = ( _Time.x * _time );
			float2 uv_TexCoord96 = i.uv_texcoord * _Disturbance_Tiling;
			float2 panner95 = ( temp_output_68_0 * float2( 1,-1 ) + uv_TexCoord96);
			float simplePerlin2D98 = snoise( panner95 );
			simplePerlin2D98 = simplePerlin2D98*0.5 + 0.5;
			float2 panner94 = ( temp_output_68_0 * float2( 1,1 ) + uv_TexCoord96);
			float simplePerlin2D93 = snoise( panner94 );
			simplePerlin2D93 = simplePerlin2D93*0.5 + 0.5;
			float4 temp_output_76_0 = ( ase_screenPosNorm + ( pow( ( simplePerlin2D98 + simplePerlin2D93 ) , 3.75 ) * _power ) );
			float4 tex2DNode5 = tex2D( _tex, temp_output_76_0.xy );
			float4 tex2DNode114 = tex2D( _depth, temp_output_76_0.xy );
			float G116 = tex2DNode114.g;
			float4 lerpResult110 = lerp( ( tex2DNode5 * _Color0 ) , ( tex2DNode5 * _Tex_color ) , G116);
			float time59 = 0.0;
			float2 uv_TexCoord55 = i.uv_texcoord * _Ripple_Tiling;
			float2 panner57 = ( temp_output_68_0 * float2( 1,-1 ) + uv_TexCoord55);
			float2 coords59 = panner57 * 1.0;
			float2 id59 = 0;
			float voroi59 = voronoi59( coords59, time59,id59, 0 );
			float time58 = 0.0;
			float2 panner56 = ( temp_output_68_0 * float2( 1,1 ) + uv_TexCoord55);
			float2 coords58 = panner56 * 1.0;
			float2 id58 = 0;
			float voroi58 = voronoi58( coords58, time58,id58, 0 );
			float R108 = tex2DNode114.r;
			float B117 = tex2DNode114.b;
			float A122 = tex2DNode114.a;
			o.Emission = ( ( lerpResult110 + ( ( pow( ( voroi59 + voroi58 ) , 3.54 ) * R108 ) * _Ripple_color ) + ( _light * B117 ) ) * pow( A122 , _Dimming ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"

}

Shader "Custom/ShadowAllphaBlendDepth"
{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        //*********************绘制阴影的参数****************************
        _ShadowPlane ("Shadow Plane", Vector) = (0,0,2.8,77.2)
        _ShadowColor("Shadow Color",Color) = (0.1, 0.1, 0.1, 1)
        _ShadowPara("Shadow Param",Vector) = (0,0,0.77,-0.87)
        _lightDirection("LightDir",Vector) = (0,0.11,-3.94,-3.73)
        //*************************************************
        
        [HDR]_Main_Color ("Main_Color", Color) = (0.5,0.5,0.5,1)
        _tex("tex", 2D) = "white" {}
        _Brightness ("_Brightness", float) = 1.8
        _Saturation("Saturation", Float) = 1
		_Contrast("Contrast", Float) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    
    SubShader {
        Tags { 
//            "RenderType"="Opaque"
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent" 
        }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
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
        
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform float4 _Main_Color;
            uniform float _Brightness;
            half _Saturation;
            half _Contrast;
            uniform sampler2D _tex; 
            uniform float4 _tex_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 _Main_Tex_var = tex2D(_tex,TRANSFORM_TEX(i.uv0, _tex));
                float3 emissive = (_Main_Tex_var.rgb*_Main_Color.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive*_Brightness;
                
					//saturation饱和度：首先根据公式计算同等亮度情况下饱和度最低的值：
                fixed gray = 0.2125 * emissive.r + 0.7154 * emissive.g + 0.0721 * emissive.b;
                fixed3 grayColor = fixed3(gray, gray, gray);
                //根据Saturation在饱和度最低的图像和原图之间差值
                finalColor = lerp(grayColor, finalColor, _Saturation);
                //contrast对比度：首先计算对比度最低的值
                fixed3 avgColor = fixed3(0.5, 0.5, 0.5);
                //根据Contrast在对比度最低的图像和原图之间差值
                finalColor = lerp(avgColor, finalColor, _Contrast);
                return fixed4(finalColor,(_Main_Tex_var.a*_Main_Color.a*i.vertexColor.a));
            }
            ENDCG
        }

    } 
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
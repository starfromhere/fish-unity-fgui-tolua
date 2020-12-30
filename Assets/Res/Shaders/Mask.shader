// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32624,y:31942,varname:node_4795,prsc:2|emission-5581-OUT;n:type:ShaderForge.SFN_Multiply,id:2393,x:32213,y:31853,varname:node_2393,prsc:2|A-3848-RGB,B-797-RGB,C-5097-OUT,D-797-A;n:type:ShaderForge.SFN_Color,id:797,x:31985,y:31881,ptovrint:True,ptlb:MainTex_Color,ptin:_TintColor,varname:_TintColor,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5581,x:32419,y:32042,varname:node_5581,prsc:2|A-2393-OUT,B-835-OUT;n:type:ShaderForge.SFN_Multiply,id:835,x:32200,y:32348,varname:node_835,prsc:2|A-1478-OUT,B-1768-RGB,C-6936-OUT,D-1768-A;n:type:ShaderForge.SFN_Color,id:1768,x:31991,y:32360,ptovrint:False,ptlb:Mask_Color,ptin:_Mask_Color,varname:node_1768,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:6936,x:31991,y:32515,ptovrint:False,ptlb:Mask_Intensity,ptin:_Mask_Intensity,varname:node_6936,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_ValueProperty,id:5097,x:31985,y:32049,ptovrint:False,ptlb:MainTex_Intensity,ptin:_MainTex_Intensity,varname:node_5097,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:9928,x:31796,y:32141,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_9928,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Power,id:1478,x:31991,y:32215,varname:node_1478,prsc:2|VAL-9928-RGB,EXP-1687-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1687,x:31796,y:32331,ptovrint:False,ptlb:Side,ptin:_Side,varname:node_1687,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Tex2d,id:3848,x:31985,y:31703,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_3848,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;proporder:797-3848-5097-1768-9928-6936-1687;pass:END;sub:END;*/

Shader "Lx/Mask" {
    Properties {
        [HDR]_TintColor ("MainTex_Color", Color) = (0.5,0.5,0.5,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _MainTex_Intensity ("MainTex_Intensity", Float ) = 1
        [HDR]_Mask_Color ("Mask_Color", Color) = (0.5,0.5,0.5,1)
        _Mask ("Mask", 2D) = "white" {}
        _Mask_Intensity ("Mask_Intensity", Float ) = 2
        _Side ("Side", Float ) = 3
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform float4 _TintColor;
            uniform float4 _Mask_Color;
            uniform float _Mask_Intensity;
            uniform float _MainTex_Intensity;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float _Side;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                float3 emissive = ((_MainTex_var.rgb*_TintColor.rgb*_MainTex_Intensity*_TintColor.a)*(pow(_Mask_var.rgb,_Side)*_Mask_Color.rgb*_Mask_Intensity*_Mask_Color.a));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}

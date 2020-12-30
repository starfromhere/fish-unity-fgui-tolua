// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:2,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:7952,x:32347,y:32914,varname:node_7952,prsc:2|emission-5122-OUT,alpha-9718-OUT;n:type:ShaderForge.SFN_Tex2d,id:2260,x:31494,y:33050,ptovrint:False,ptlb:Mask_1,ptin:_Mask_1,varname:node_2260,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:fc5f6513e937c0b45b7124772b9eec7d,ntxv:0,isnm:False|UVIN-841-OUT;n:type:ShaderForge.SFN_Tex2d,id:2980,x:31134,y:33138,ptovrint:False,ptlb:Noise,ptin:_Noise,varname:node_2980,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:221e1d2c917bac646ab98ee187766f03,ntxv:0,isnm:False|UVIN-7092-OUT;n:type:ShaderForge.SFN_TexCoord,id:2216,x:30477,y:33125,varname:node_2216,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:841,x:31315,y:33050,varname:node_841,prsc:2|A-8018-UVOUT,B-2980-R;n:type:ShaderForge.SFN_TexCoord,id:8018,x:31134,y:32963,varname:node_8018,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_OneMinus,id:6986,x:31689,y:32992,varname:node_6986,prsc:2|IN-2260-R;n:type:ShaderForge.SFN_Multiply,id:9718,x:31874,y:32903,varname:node_9718,prsc:2|A-3763-R,B-6986-OUT;n:type:ShaderForge.SFN_Tex2d,id:3763,x:31689,y:32828,ptovrint:False,ptlb:Mask_2,ptin:_Mask_2,varname:node_3763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f87f22a6fdef2024c980e353f9b311df,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7528,x:31866,y:33233,varname:node_7528,prsc:2|A-7014-OUT,B-3882-RGB;n:type:ShaderForge.SFN_Color,id:3882,x:31689,y:33333,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_3882,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_OneMinus,id:7014,x:31689,y:33151,varname:node_7014,prsc:2|IN-2260-R;n:type:ShaderForge.SFN_Fresnel,id:4910,x:31517,y:33617,varname:node_4910,prsc:2|EXP-9039-OUT;n:type:ShaderForge.SFN_Multiply,id:5122,x:32071,y:33212,varname:node_5122,prsc:2|A-9718-OUT,B-7528-OUT,C-8888-OUT;n:type:ShaderForge.SFN_OneMinus,id:1586,x:31690,y:33617,varname:node_1586,prsc:2|IN-4910-OUT;n:type:ShaderForge.SFN_Multiply,id:8888,x:31863,y:33571,varname:node_8888,prsc:2|A-298-OUT,B-1586-OUT;n:type:ShaderForge.SFN_Vector1,id:298,x:31690,y:33539,varname:node_298,prsc:2,v1:2;n:type:ShaderForge.SFN_Vector1,id:9039,x:31346,y:33640,varname:node_9039,prsc:2,v1:0.15;n:type:ShaderForge.SFN_Append,id:7092,x:30957,y:33138,varname:node_7092,prsc:2|A-8941-OUT,B-498-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3701,x:30477,y:33051,ptovrint:False,ptlb:U_Speed,ptin:_U_Speed,varname:node_3701,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7829,x:30477,y:33334,ptovrint:False,ptlb:V_Speed,ptin:_V_Speed,varname:node_7829,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:7234,x:30639,y:32943,varname:node_7234,prsc:2|A-7065-TSL,B-3701-OUT;n:type:ShaderForge.SFN_Multiply,id:2658,x:30643,y:33334,varname:node_2658,prsc:2|A-7829-OUT,B-4665-T;n:type:ShaderForge.SFN_Time,id:7065,x:30477,y:32835,varname:node_7065,prsc:2;n:type:ShaderForge.SFN_Time,id:4665,x:30477,y:33438,varname:node_4665,prsc:2;n:type:ShaderForge.SFN_Add,id:8941,x:30795,y:33075,varname:node_8941,prsc:2|A-7234-OUT,B-2216-U;n:type:ShaderForge.SFN_Add,id:498,x:30795,y:33224,varname:node_498,prsc:2|A-2216-V,B-2658-OUT;proporder:3882-2980-3701-7829-2260-3763;pass:END;sub:END;*/

Shader "Lx/Fire" {
    Properties {
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Noise ("Noise", 2D) = "white" {}
        _U_Speed ("U_Speed", Float ) = 0
        _V_Speed ("V_Speed", Float ) = 1
        _Mask_1 ("Mask_1", 2D) = "white" {}
        _Mask_2 ("Mask_2", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
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
            uniform sampler2D _Mask_1; uniform float4 _Mask_1_ST;
            uniform sampler2D _Noise; uniform float4 _Noise_ST;
            uniform sampler2D _Mask_2; uniform float4 _Mask_2_ST;
            uniform float4 _Color;
            uniform float _U_Speed;
            uniform float _V_Speed;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Mask_2_var = tex2D(_Mask_2,TRANSFORM_TEX(i.uv0, _Mask_2));
                float4 node_7065 = _Time;
                float4 node_4665 = _Time;
                float2 node_7092 = float2(((node_7065.r*_U_Speed)+i.uv0.r),(i.uv0.g+(_V_Speed*node_4665.g)));
                float4 _Noise_var = tex2D(_Noise,TRANSFORM_TEX(node_7092, _Noise));
                float2 node_841 = (i.uv0+_Noise_var.r);
                float4 _Mask_1_var = tex2D(_Mask_1,TRANSFORM_TEX(node_841, _Mask_1));
                float node_9718 = (_Mask_2_var.r*(1.0 - _Mask_1_var.r));
                float3 emissive = (node_9718*((1.0 - _Mask_1_var.r)*_Color.rgb)*(2.0*(1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),0.15))));
                float3 finalColor = emissive;
                return fixed4(finalColor,node_9718);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

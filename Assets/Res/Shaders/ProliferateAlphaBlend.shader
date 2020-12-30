// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32760,y:32657,varname:node_4795,prsc:2|emission-2393-OUT,alpha-1186-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:31674,y:32861,ptovrint:False,ptlb:Main_Tex,ptin:_Main_Tex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:2b464600fca21fd46bb33278677370c2,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:2393,x:32261,y:32808,varname:node_2393,prsc:2|A-414-OUT,B-2053-RGB,C-797-RGB;n:type:ShaderForge.SFN_VertexColor,id:2053,x:32019,y:32834,varname:node_2053,prsc:2;n:type:ShaderForge.SFN_Color,id:797,x:32030,y:32990,ptovrint:True,ptlb:Main_Color,ptin:_TintColor,varname:_TintColor,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:798,x:32261,y:32964,varname:node_798,prsc:2|A-5404-OUT,B-2053-A,C-797-A;n:type:ShaderForge.SFN_TexCoord,id:4385,x:30271,y:32586,varname:node_4385,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:414,x:31861,y:32744,varname:node_414,prsc:2|A-9195-OUT,B-6074-RGB;n:type:ShaderForge.SFN_ComponentMask,id:5404,x:32089,y:32602,varname:node_5404,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-414-OUT;n:type:ShaderForge.SFN_Slider,id:2653,x:30298,y:32941,ptovrint:False,ptlb:Mask_Wide,ptin:_Mask_Wide,varname:node_2653,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Subtract,id:8016,x:30466,y:32637,varname:node_8016,prsc:2|A-4385-UVOUT,B-7714-OUT;n:type:ShaderForge.SFN_Vector1,id:7714,x:30271,y:32805,varname:node_7714,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Divide,id:601,x:30639,y:32708,varname:node_601,prsc:2|A-8016-OUT,B-2653-OUT;n:type:ShaderForge.SFN_Add,id:8281,x:30804,y:32578,varname:node_8281,prsc:2|A-4385-UVOUT,B-601-OUT;n:type:ShaderForge.SFN_Lerp,id:7955,x:30970,y:32689,varname:node_7955,prsc:2|A-8281-OUT,B-7714-OUT,T-2653-OUT;n:type:ShaderForge.SFN_Clamp01,id:3686,x:31144,y:32689,varname:node_3686,prsc:2|IN-7955-OUT;n:type:ShaderForge.SFN_Tex2d,id:8309,x:31320,y:32689,ptovrint:False,ptlb:Mask_Tex,ptin:_Mask_Tex,varname:node_8309,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:34d5e4a7c519461458cc01a50db9f60f,ntxv:0,isnm:False|UVIN-3686-OUT;n:type:ShaderForge.SFN_Multiply,id:9195,x:31674,y:32689,varname:node_9195,prsc:2|A-2737-OUT,B-8309-A;n:type:ShaderForge.SFN_Desaturate,id:2737,x:31498,y:32689,varname:node_2737,prsc:2|COL-8309-RGB;n:type:ShaderForge.SFN_Power,id:1186,x:32527,y:33000,varname:node_1186,prsc:2|VAL-798-OUT,EXP-976-OUT;n:type:ShaderForge.SFN_ValueProperty,id:976,x:32261,y:33164,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_976,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:7;proporder:797-6074-8309-2653-976;pass:END;sub:END;*/

Shader "Custom/Proliferate Alpha Blend" {
    Properties {
        [HDR]_TintColor ("Main_Color", Color) = (1,1,1,1)
        _Main_Tex ("Main_Tex", 2D) = "white" {}
        _Mask_Tex ("Mask_Tex", 2D) = "white" {}
        _Mask_Wide ("Mask_Wide", Range(0, 1)) = 1
        _Opacity ("Opacity", Float ) = 7
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
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
            uniform sampler2D _Main_Tex; uniform float4 _Main_Tex_ST;
            uniform float4 _TintColor;
            uniform float _Mask_Wide;
            uniform sampler2D _Mask_Tex; uniform float4 _Mask_Tex_ST;
            uniform float _Opacity;
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
                float node_7714 = 0.5;
                float2 node_3686 = saturate(lerp((i.uv0+((i.uv0-node_7714)/_Mask_Wide)),float2(node_7714,node_7714),_Mask_Wide));
                float4 _Mask_Tex_var = tex2D(_Mask_Tex,TRANSFORM_TEX(node_3686, _Mask_Tex));
                float4 _Main_Tex_var = tex2D(_Main_Tex,TRANSFORM_TEX(i.uv0, _Main_Tex));
                float3 node_414 = ((dot(_Mask_Tex_var.rgb,float3(0.3,0.59,0.11))*_Mask_Tex_var.a)*_Main_Tex_var.rgb);
                float3 emissive = (node_414*i.vertexColor.rgb*_TintColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,pow((node_414.r*i.vertexColor.a*_TintColor.a),_Opacity));
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}

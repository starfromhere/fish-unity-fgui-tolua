// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33129,y:32665,varname:node_3138,prsc:2|emission-8542-OUT,alpha-7450-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32586,y:32712,ptovrint:False,ptlb:Main_Color,ptin:_Main_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_UVTile,id:9451,x:32416,y:32878,varname:node_9451,prsc:2|UVIN-5031-UVOUT,WDT-2232-OUT,HGT-42-OUT,TILE-9018-OUT;n:type:ShaderForge.SFN_TexCoord,id:5031,x:32237,y:32725,varname:node_5031,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:2232,x:32237,y:32898,ptovrint:False,ptlb:Width,ptin:_Width,varname:node_2232,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:42,x:32237,y:32991,ptovrint:False,ptlb:Height,ptin:_Height,varname:node_42,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:999,x:31736,y:32902,varname:node_999,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:5604,x:31736,y:33090,ptovrint:False,ptlb:Speed&Places,ptin:_SpeedPlaces,varname:node_5604,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:5389,x:31906,y:32993,varname:node_5389,prsc:2|A-999-T,B-5604-OUT;n:type:ShaderForge.SFN_Floor,id:9018,x:32237,y:33072,varname:node_9018,prsc:2|IN-4395-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:4395,x:32070,y:33072,ptovrint:False,ptlb:Switch,ptin:_Switch,varname:node_4395,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5389-OUT,B-5604-OUT;n:type:ShaderForge.SFN_Tex2d,id:3925,x:32586,y:32879,ptovrint:False,ptlb:Main_Main_Tex,ptin:_Main_Main_Tex,varname:node_3925,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9451-UVOUT;n:type:ShaderForge.SFN_Multiply,id:8542,x:32793,y:32777,varname:node_8542,prsc:2|A-7241-RGB,B-3925-RGB,C-4487-RGB;n:type:ShaderForge.SFN_Multiply,id:7450,x:32793,y:32934,varname:node_7450,prsc:2|A-7241-A,B-3925-A,C-4487-A;n:type:ShaderForge.SFN_VertexColor,id:4487,x:32586,y:33041,varname:node_4487,prsc:2;proporder:7241-3925-2232-42-4395-5604;pass:END;sub:END;*/

Shader "Lx/FlipBook" {
    Properties {
        [HDR]_Main_Color ("Main_Color", Color) = (1,1,1,1)
        _Main_Main_Tex ("Main_Main_Tex", 2D) = "white" {}
        _Width ("Width", Float ) = 1
        _Height ("Height", Float ) = 0
        [MaterialToggle] _Switch ("Switch", Float ) = 0
        _SpeedPlaces ("Speed&Places", Float ) = 1
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
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform float4 _Main_Color;
            uniform float _Width;
            uniform float _Height;
            uniform float _SpeedPlaces;
            uniform fixed _Switch;
            uniform sampler2D _Main_Main_Tex; uniform float4 _Main_Main_Tex_ST;
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
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_999 = _Time;
                float node_9018 = floor(lerp( (node_999.g*_SpeedPlaces), _SpeedPlaces, _Switch ));
                float2 node_9451_tc_rcp = float2(1.0,1.0)/float2( _Width, _Height );
                float node_9451_ty = floor(node_9018 * node_9451_tc_rcp.x);
                float node_9451_tx = node_9018 - _Width * node_9451_ty;
                float2 node_9451 = (i.uv0 + float2(node_9451_tx, node_9451_ty)) * node_9451_tc_rcp;
                float4 _Main_Main_Tex_var = tex2D(_Main_Main_Tex,TRANSFORM_TEX(node_9451, _Main_Main_Tex));
                float3 emissive = (_Main_Color.rgb*_Main_Main_Tex_var.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,(_Main_Color.a*_Main_Main_Tex_var.a*i.vertexColor.a));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

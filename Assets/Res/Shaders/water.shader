// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32611,y:32775,varname:node_2865,prsc:2|diff-6909-OUT,spec-9933-OUT,gloss-7952-OUT,normal-914-OUT,alpha-374-OUT;n:type:ShaderForge.SFN_Vector1,id:9933,x:32414,y:32836,varname:node_9933,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:7952,x:32257,y:32926,ptovrint:False,ptlb:Glossiness,ptin:_Glossiness,varname:node_7952,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5235627,max:1;n:type:ShaderForge.SFN_Color,id:1784,x:31146,y:31475,ptovrint:False,ptlb:Color Deep,ptin:_ColorDeep,varname:node_1784,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.3,c3:0.2,c4:1;n:type:ShaderForge.SFN_Color,id:5323,x:31146,y:31647,ptovrint:False,ptlb:Color shallow,ptin:_Colorshallow,varname:node_5323,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4,c2:0.8,c3:1,c4:1;n:type:ShaderForge.SFN_Lerp,id:4927,x:31335,y:31624,varname:node_4927,prsc:2|A-1784-RGB,B-5323-RGB,T-8307-OUT;n:type:ShaderForge.SFN_Fresnel,id:8307,x:31146,y:31792,varname:node_8307,prsc:2|NRM-6894-OUT,EXP-4841-OUT;n:type:ShaderForge.SFN_NormalVector,id:6894,x:30942,y:31714,prsc:2,pt:True;n:type:ShaderForge.SFN_ValueProperty,id:3335,x:30772,y:31872,ptovrint:False,ptlb:Color Fresnel,ptin:_ColorFresnel,varname:node_3335,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.336;n:type:ShaderForge.SFN_ConstantClamp,id:4841,x:30942,y:31872,varname:node_4841,prsc:2,min:0,max:4|IN-3335-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:6540,x:30577,y:33700,ptovrint:False,ptlb:Normal Map,ptin:_NormalMap,varname:node_6540,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:7941,x:30803,y:33532,varname:node_7941,prsc:2,ntxv:0,isnm:False|UVIN-7079-OUT,TEX-6540-TEX;n:type:ShaderForge.SFN_Tex2d,id:6170,x:30803,y:33777,varname:node_6170,prsc:2,ntxv:0,isnm:False|UVIN-2342-OUT,TEX-6540-TEX;n:type:ShaderForge.SFN_Lerp,id:8234,x:31569,y:33739,varname:node_8234,prsc:2|A-5549-OUT,B-6946-OUT,T-702-OUT;n:type:ShaderForge.SFN_Slider,id:702,x:31191,y:33944,ptovrint:False,ptlb:Normal Blend Strength,ptin:_NormalBlendStrength,varname:node_702,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_FragmentPosition,id:8005,x:31050,y:32105,varname:node_8005,prsc:2;n:type:ShaderForge.SFN_Append,id:9118,x:31260,y:32130,varname:node_9118,prsc:2|A-8005-X,B-8005-Y;n:type:ShaderForge.SFN_ValueProperty,id:4659,x:31260,y:32303,ptovrint:False,ptlb:UV Scale,ptin:_UVScale,varname:node_4659,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Divide,id:2079,x:31455,y:32206,varname:node_2079,prsc:2|A-9118-OUT,B-4659-OUT;n:type:ShaderForge.SFN_Set,id:5150,x:31656,y:32206,varname:_worldUV,prsc:2|IN-2079-OUT;n:type:ShaderForge.SFN_Get,id:4499,x:30583,y:32795,varname:node_4499,prsc:2|IN-5150-OUT;n:type:ShaderForge.SFN_Set,id:2583,x:31712,y:32648,varname:_UV1,prsc:2|IN-7103-OUT;n:type:ShaderForge.SFN_Set,id:8977,x:31725,y:33078,varname:_UV2,prsc:2|IN-6729-OUT;n:type:ShaderForge.SFN_Vector4Property,id:2601,x:30841,y:32653,ptovrint:False,ptlb:UV 1 Animator,ptin:_UV1Animator,varname:node_2601,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Vector4Property,id:4530,x:30841,y:33071,ptovrint:False,ptlb:UV 2 Aniamtor,ptin:_UV2Aniamtor,varname:node_4530,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_ComponentMask,id:7835,x:31064,y:32795,varname:node_7835,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8702-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9449,x:31064,y:32923,varname:node_9449,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-1365-OUT;n:type:ShaderForge.SFN_Multiply,id:7872,x:31064,y:32544,varname:node_7872,prsc:2|A-2601-X,B-8437-TSL;n:type:ShaderForge.SFN_Time,id:8437,x:30841,y:33227,varname:node_8437,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2969,x:31064,y:32674,varname:node_2969,prsc:2|A-2601-Y,B-8437-TSL;n:type:ShaderForge.SFN_Add,id:5845,x:31286,y:32579,varname:node_5845,prsc:2|A-7872-OUT,B-7835-R;n:type:ShaderForge.SFN_Add,id:670,x:31286,y:32728,varname:node_670,prsc:2|A-2969-OUT,B-7835-G;n:type:ShaderForge.SFN_Append,id:7103,x:31505,y:32648,varname:node_7103,prsc:2|A-5845-OUT,B-670-OUT;n:type:ShaderForge.SFN_Multiply,id:7753,x:31064,y:33071,varname:node_7753,prsc:2|A-4530-X,B-8437-TSL;n:type:ShaderForge.SFN_Multiply,id:2200,x:31064,y:33201,varname:node_2200,prsc:2|A-4530-Y,B-8437-TSL;n:type:ShaderForge.SFN_Add,id:3085,x:31316,y:32987,varname:node_3085,prsc:2|A-9449-R,B-7753-OUT;n:type:ShaderForge.SFN_Add,id:1102,x:31316,y:33158,varname:node_1102,prsc:2|A-9449-G,B-2200-OUT;n:type:ShaderForge.SFN_Append,id:6729,x:31510,y:33078,varname:node_6729,prsc:2|A-3085-OUT,B-1102-OUT;n:type:ShaderForge.SFN_Multiply,id:8702,x:30841,y:32795,varname:node_8702,prsc:2|A-4499-OUT,B-2145-OUT;n:type:ShaderForge.SFN_Multiply,id:1365,x:30841,y:32923,varname:node_1365,prsc:2|A-4499-OUT,B-8492-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2145,x:30604,y:32887,ptovrint:False,ptlb:UV 1 Tiling,ptin:_UV1Tiling,varname:node_2145,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8492,x:30604,y:32978,ptovrint:False,ptlb:UV 2 Tiling,ptin:_UV2Tiling,varname:node_8492,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Get,id:2342,x:30556,y:33595,varname:node_2342,prsc:2|IN-8977-OUT;n:type:ShaderForge.SFN_Get,id:7079,x:30556,y:33530,varname:node_7079,prsc:2|IN-2583-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8379,x:30994,y:33522,varname:node_8379,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7941-RGB;n:type:ShaderForge.SFN_ComponentMask,id:3503,x:30994,y:33777,varname:node_3503,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-6170-RGB;n:type:ShaderForge.SFN_Multiply,id:8635,x:31173,y:33543,varname:node_8635,prsc:2|A-8379-OUT,B-3878-OUT;n:type:ShaderForge.SFN_Slider,id:3878,x:30837,y:33695,ptovrint:False,ptlb:Normal Map 1 Strength,ptin:_NormalMap1Strength,varname:node_3878,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:5871,x:30837,y:33941,ptovrint:False,ptlb:Normal map 2 strength,ptin:_Normalmap2strength,varname:node_5871,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Append,id:5549,x:31348,y:33612,varname:node_5549,prsc:2|A-8635-OUT,B-4557-OUT;n:type:ShaderForge.SFN_Vector1,id:4557,x:31173,y:33679,varname:node_4557,prsc:2,v1:1;n:type:ShaderForge.SFN_Append,id:6946,x:31348,y:33755,varname:node_6946,prsc:2|A-1655-OUT,B-4557-OUT;n:type:ShaderForge.SFN_Multiply,id:1655,x:31173,y:33782,varname:node_1655,prsc:2|A-3503-OUT,B-5871-OUT;n:type:ShaderForge.SFN_Set,id:9732,x:31772,y:33739,varname:_normalMapping,prsc:2|IN-8234-OUT;n:type:ShaderForge.SFN_Get,id:914,x:32393,y:33012,varname:node_914,prsc:2|IN-9732-OUT;n:type:ShaderForge.SFN_Set,id:1689,x:31512,y:31624,varname:_baseColor,prsc:2|IN-4927-OUT;n:type:ShaderForge.SFN_Get,id:6909,x:32393,y:32775,varname:node_6909,prsc:2|IN-1689-OUT;n:type:ShaderForge.SFN_Slider,id:374,x:32257,y:33106,ptovrint:False,ptlb:Normal Alpha strength,ptin:_NormalAlphastrength,varname:node_374,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;proporder:1784-5323-3335-7952-6540-374-702-4659-2145-2601-8492-4530-3878-5871;pass:END;sub:END;*/

Shader "Shader Forge/water" {
    Properties {
        _ColorDeep ("Color Deep", Color) = (0,0.3,0.2,1)
        _Colorshallow ("Color shallow", Color) = (0.4,0.8,1,1)
        _ColorFresnel ("Color Fresnel", Float ) = 1.336
        _Glossiness ("Glossiness", Range(0, 1)) = 0.5235627
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalAlphastrength ("Normal Alpha strength", Range(0, 1)) = 1
        _NormalBlendStrength ("Normal Blend Strength", Range(0, 1)) = 0
        _UVScale ("UV Scale", Float ) = 0
        _UV1Tiling ("UV 1 Tiling", Float ) = 0
        _UV1Animator ("UV 1 Animator", Vector) = (0,0,0,0)
        _UV2Tiling ("UV 2 Tiling", Float ) = 0
        _UV2Aniamtor ("UV 2 Aniamtor", Vector) = (0,0,0,0)
        _NormalMap1Strength ("Normal Map 1 Strength", Range(0, 1)) = 0
        _Normalmap2strength ("Normal map 2 strength", Range(0, 1)) = 0
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
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform float _Glossiness;
            uniform float4 _ColorDeep;
            uniform float4 _Colorshallow;
            uniform float _ColorFresnel;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _NormalBlendStrength;
            uniform float _UVScale;
            uniform float4 _UV1Animator;
            uniform float4 _UV2Aniamtor;
            uniform float _UV1Tiling;
            uniform float _UV2Tiling;
            uniform float _NormalMap1Strength;
            uniform float _Normalmap2strength;
            uniform float _NormalAlphastrength;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                UNITY_FOG_COORDS(6)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_8437 = _Time;
                float2 _worldUV = (float2(i.posWorld.r,i.posWorld.g)/_UVScale);
                float2 node_4499 = _worldUV;
                float2 node_7835 = (node_4499*_UV1Tiling).rg;
                float2 _UV1 = float2(((_UV1Animator.r*node_8437.r)+node_7835.r),((_UV1Animator.g*node_8437.r)+node_7835.g));
                float2 node_7079 = _UV1;
                float3 node_7941 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7079, _NormalMap)));
                float node_4557 = 1.0;
                float2 node_9449 = (node_4499*_UV2Tiling).rg;
                float2 _UV2 = float2((node_9449.r+(_UV2Aniamtor.r*node_8437.r)),(node_9449.g+(_UV2Aniamtor.g*node_8437.r)));
                float2 node_2342 = _UV2;
                float3 node_6170 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_2342, _NormalMap)));
                float3 _normalMapping = lerp(float3((node_7941.rgb.rg*_NormalMap1Strength),node_4557),float3((node_6170.rgb.rg*_Normalmap2strength),node_4557),_NormalBlendStrength);
                float3 normalLocal = _normalMapping;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Glossiness;
                float perceptualRoughness = 1.0 - _Glossiness;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = 0.0;
                float specularMonochrome;
                float3 _baseColor = lerp(_ColorDeep.rgb,_Colorshallow.rgb,pow(1.0-max(0,dot(normalDirection, viewDirection)),clamp(_ColorFresnel,0,4)));
                float3 diffuseColor = _baseColor; // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,_NormalAlphastrength);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform float _Glossiness;
            uniform float4 _ColorDeep;
            uniform float4 _Colorshallow;
            uniform float _ColorFresnel;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _NormalBlendStrength;
            uniform float _UVScale;
            uniform float4 _UV1Animator;
            uniform float4 _UV2Aniamtor;
            uniform float _UV1Tiling;
            uniform float _UV2Tiling;
            uniform float _NormalMap1Strength;
            uniform float _Normalmap2strength;
            uniform float _NormalAlphastrength;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_8437 = _Time;
                float2 _worldUV = (float2(i.posWorld.r,i.posWorld.g)/_UVScale);
                float2 node_4499 = _worldUV;
                float2 node_7835 = (node_4499*_UV1Tiling).rg;
                float2 _UV1 = float2(((_UV1Animator.r*node_8437.r)+node_7835.r),((_UV1Animator.g*node_8437.r)+node_7835.g));
                float2 node_7079 = _UV1;
                float3 node_7941 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7079, _NormalMap)));
                float node_4557 = 1.0;
                float2 node_9449 = (node_4499*_UV2Tiling).rg;
                float2 _UV2 = float2((node_9449.r+(_UV2Aniamtor.r*node_8437.r)),(node_9449.g+(_UV2Aniamtor.g*node_8437.r)));
                float2 node_2342 = _UV2;
                float3 node_6170 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_2342, _NormalMap)));
                float3 _normalMapping = lerp(float3((node_7941.rgb.rg*_NormalMap1Strength),node_4557),float3((node_6170.rgb.rg*_Normalmap2strength),node_4557),_NormalBlendStrength);
                float3 normalLocal = _normalMapping;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Glossiness;
                float perceptualRoughness = 1.0 - _Glossiness;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = 0.0;
                float specularMonochrome;
                float3 _baseColor = lerp(_ColorDeep.rgb,_Colorshallow.rgb,pow(1.0-max(0,dot(normalDirection, viewDirection)),clamp(_ColorFresnel,0,4)));
                float3 diffuseColor = _baseColor; // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * _NormalAlphastrength,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
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
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform float _Glossiness;
            uniform float4 _ColorDeep;
            uniform float4 _Colorshallow;
            uniform float _ColorFresnel;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : SV_Target {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float3 _baseColor = lerp(_ColorDeep.rgb,_Colorshallow.rgb,pow(1.0-max(0,dot(normalDirection, viewDirection)),clamp(_ColorFresnel,0,4)));
                float3 diffColor = _baseColor;
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, 0.0, specColor, specularMonochrome );
                float roughness = 1.0 - _Glossiness;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

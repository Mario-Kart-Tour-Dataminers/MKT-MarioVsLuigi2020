//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/ドライバー/Character_16bit" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_TransparencyLM ("AlphaMask(UV0)", 2D) = "black" { }
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Dot Character)] _DotSplitU ("U方向：コマ割り数", Range(1, 32)) = 1
_DotSplitV ("V方向：コマ割り数", Range(1, 32)) = 1
_DotStarHueSpeed ("スター：色相遷移速度", Float) = 1
_DotStarLightnessSpeed ("スター：明度遷移速度", Float) = 1
_DotStarMinLightness ("スター：最小加算明度", Range(0, 1)) = 0.5
_DotStarMaxLightness ("スター：最大加算明度", Range(0, 1)) = 0.75
_DotStarAddedSaturation ("スター：加算される彩度", Range(0, 1)) = 0.75
_Cutout ("カットアウト値", Range(0, 1)) = 0.5
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 2
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" }
 Pass {
  Name "FORWARD"
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" }
  Cull Off
  GpuProgramID 25833
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat12 = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat12);
    u_xlat12 = u_xlat12 / VGlobals._ProjectionParams.y;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * VGlobals._ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = fma(u_xlat12, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb1 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat1.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat12 = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat12);
    u_xlat12 = u_xlat12 / VGlobals._ProjectionParams.y;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * VGlobals._ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = fma(u_xlat12, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb1 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat1.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat12 = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat12);
    u_xlat12 = u_xlat12 / VGlobals._ProjectionParams.y;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * VGlobals._ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = fma(u_xlat12, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb1 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat1.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat12 = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat12);
    u_xlat12 = u_xlat12 / VGlobals._ProjectionParams.y;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * VGlobals._ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = fma(u_xlat12, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb1 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat1.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat12 = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat12);
    u_xlat12 = u_xlat12 / VGlobals._ProjectionParams.y;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * VGlobals._ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = fma(u_xlat12, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb1 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat1.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat12 = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat12);
    u_xlat12 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat12);
    u_xlat12 = u_xlat12 / VGlobals._ProjectionParams.y;
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 * VGlobals._ProjectionParams.z;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = fma(u_xlat12, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb1 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb1) ? u_xlat12 : 1.0;
    u_xlat12 = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat12 = floor(u_xlat12);
    u_xlat1.y = (-u_xlat12);
    u_xlat1.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat1.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 unity_LightmapST;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_10.xyz);
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_10.xyz);
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    bool2 u_xlatb2;
    float4 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_10;
    float2 u_xlat12;
    half3 u_xlat16_16;
    float u_xlat20;
    half u_xlat16_20;
    bool u_xlatb20;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat32;
    half u_xlat16_35;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_20 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat16_20) + half(1.0);
    u_xlat16_1.x = u_xlat16_20 + (-FGlobals._Cutout);
    u_xlatb20 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat2.xyz = float3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb20 = u_xlat20<9.99999975e-06;
    u_xlat20 = (u_xlatb20) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat20 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat20 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat20 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * FGlobals._NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat20), float3(u_xlat16_1.xyz));
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb20 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat20 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * input.TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = fma(u_xlat3.xyz, (-float3(u_xlat20)), u_xlat2.xyz);
    u_xlat16_35 = half((-u_xlat32) + 1.0);
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.x = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + half(1.0);
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_16.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_16.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_20), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat7.xyz = float3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_8.xyz = half3(float3(u_xlat16_8.xyz) * u_xlat2.xxx);
    u_xlat16_6.xyz = fma(u_xlat16_16.xyz, half3(u_xlat16_35), u_xlat16_8.xyz);
    u_xlat16_2.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(float3(u_xlat20) * float3(u_xlat16_2.xyz));
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    u_xlat16_6.xyz = fma((-u_xlat16_5.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_10 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_6.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = (float2(u_xlat30)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
    u_xlatb20 = u_xlat10.x<0.0;
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = fma(u_xlat10.x, 0.166666672, u_xlat20);
    u_xlat10.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat10.x);
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = (float4(u_xlat20)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb2.x = u_xlat20<5.0;
    u_xlat10.x = fma(u_xlat10.x, 6.0, (-u_xlat20));
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat20 = fma(u_xlat0.x, u_xlat10.x, (-u_xlat0.x));
    u_xlat10.x = fma((-u_xlat0.x), u_xlat10.x, 1.0);
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + float3(u_xlat16_5.xyz);
    u_xlatb30 = 0.0>=FGlobals._DotParams.w;
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD3.z;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_9;
    float u_xlat11;
    float2 u_xlat12;
    half3 u_xlat16_15;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    float u_xlat20;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_18 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat16_1.x = u_xlat16_18 + (-FGlobals._Cutout);
    u_xlatb18 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xyz = float3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat18 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb18 = u_xlat18<9.99999975e-06;
    u_xlat18 = (u_xlatb18) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat18 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat18 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat3.xyz = float3(u_xlat18) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat18 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat18 = sin(u_xlat18);
    u_xlat18 = u_xlat18 * FGlobals._NormalRand.w;
    u_xlat18 = fract(u_xlat18);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat18), float3(u_xlat16_1.xyz));
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat3.xyz = float3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb29 = u_xlat18<0.00499999989;
    u_xlat30 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat29 = u_xlat18 * u_xlat18;
    u_xlat16_32 = half(u_xlat18 * u_xlat29);
    u_xlat18 = fma(u_xlat18, u_xlat18, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat16_32 = half((-u_xlat30) + 1.0);
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_15.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_15.x = u_xlat16_15.x + half(1.0);
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0h, 1.0h);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_15.xyz = u_xlat16_15.xxx + (-u_xlat16_8.xyz);
    u_xlat16_15.xyz = fma(half3(u_xlat16_32), u_xlat16_15.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_15.xyz;
    u_xlat4.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat30), u_xlat2.xyz);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat30);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat11 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat20 = max(u_xlat30, 0.319999993);
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = fma(u_xlat29, u_xlat29, -1.0);
    u_xlat2.x = fma(u_xlat2.x, u_xlat20, 1.00001001);
    u_xlat18 = u_xlat18 * u_xlat2.x;
    u_xlat18 = u_xlat29 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat2.xzw = float3(u_xlat16_8.xyz) * float3(u_xlat18);
    u_xlat2.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_6), u_xlat2.xzw);
    u_xlat16_3.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat2.xzw = u_xlat2.xzw * float3(u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xzw, float3(u_xlat11), float3(u_xlat16_5.xyz));
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_9 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_9), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat27 = max(u_xlat0.y, u_xlat0.x);
    u_xlat27 = max(u_xlat27, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat27)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat12.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat27;
    u_xlat9.x = u_xlat3.x / u_xlat0.x;
    u_xlat9.x = u_xlat9.x + u_xlat3.y;
    u_xlatb18 = u_xlat9.x<0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat9.x = fma(u_xlat9.x, 0.166666672, u_xlat18);
    u_xlat9.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat9.x);
    u_xlat9.x = fract(u_xlat9.x);
    u_xlat18 = u_xlat9.x * 6.0;
    u_xlat18 = floor(u_xlat18);
    u_xlatb1 = (float4(u_xlat18)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb29 = u_xlat18<5.0;
    u_xlat9.x = fma(u_xlat9.x, 6.0, (-u_xlat18));
    u_xlat18 = max(u_xlat27, 0.00100000005);
    u_xlat3.z = u_xlat27 + u_xlat27;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat18;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat18 = fma(u_xlat0.x, u_xlat9.x, (-u_xlat0.x));
    u_xlat9.x = fma((-u_xlat0.x), u_xlat9.x, 1.0);
    u_xlat3.y = u_xlat9.x * u_xlat3.z;
    u_xlat9.x = u_xlat18 + 1.0;
    u_xlat3.w = u_xlat9.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb29)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat9.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat9.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat9.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb27 = 0.0>=FGlobals._DotParams.w;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat27 = input.TEXCOORD3.z;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_9;
    float u_xlat11;
    float2 u_xlat12;
    half3 u_xlat16_15;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    float u_xlat20;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_18 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat16_1.x = u_xlat16_18 + (-FGlobals._Cutout);
    u_xlatb18 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xyz = float3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat18 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb18 = u_xlat18<9.99999975e-06;
    u_xlat18 = (u_xlatb18) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat18 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat18 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat3.xyz = float3(u_xlat18) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat18 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat18 = sin(u_xlat18);
    u_xlat18 = u_xlat18 * FGlobals._NormalRand.w;
    u_xlat18 = fract(u_xlat18);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat18), float3(u_xlat16_1.xyz));
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat3.xyz = float3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb29 = u_xlat18<0.00499999989;
    u_xlat30 = u_xlat18 * 8.29800034;
    u_xlat16_1.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat29 = u_xlat18 * u_xlat18;
    u_xlat16_32 = half(u_xlat18 * u_xlat29);
    u_xlat18 = fma(u_xlat18, u_xlat18, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat16_32 = half((-u_xlat30) + 1.0);
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_15.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_15.x = u_xlat16_15.x + half(1.0);
    u_xlat16_15.x = clamp(u_xlat16_15.x, 0.0h, 1.0h);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_15.xyz = u_xlat16_15.xxx + (-u_xlat16_8.xyz);
    u_xlat16_15.xyz = fma(half3(u_xlat16_32), u_xlat16_15.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_15.xyz;
    u_xlat4.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat30), u_xlat2.xyz);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat30);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat11 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat20 = max(u_xlat30, 0.319999993);
    u_xlat18 = u_xlat18 * u_xlat20;
    u_xlat20 = fma(u_xlat29, u_xlat29, -1.0);
    u_xlat2.x = fma(u_xlat2.x, u_xlat20, 1.00001001);
    u_xlat18 = u_xlat18 * u_xlat2.x;
    u_xlat18 = u_xlat29 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat2.xzw = float3(u_xlat16_8.xyz) * float3(u_xlat18);
    u_xlat2.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_6), u_xlat2.xzw);
    u_xlat16_3.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat2.xzw = u_xlat2.xzw * float3(u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xzw, float3(u_xlat11), float3(u_xlat16_5.xyz));
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_9 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_9), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat27 = max(u_xlat0.y, u_xlat0.x);
    u_xlat27 = max(u_xlat27, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat27)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat12.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat27;
    u_xlat9.x = u_xlat3.x / u_xlat0.x;
    u_xlat9.x = u_xlat9.x + u_xlat3.y;
    u_xlatb18 = u_xlat9.x<0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat9.x = fma(u_xlat9.x, 0.166666672, u_xlat18);
    u_xlat9.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat9.x);
    u_xlat9.x = fract(u_xlat9.x);
    u_xlat18 = u_xlat9.x * 6.0;
    u_xlat18 = floor(u_xlat18);
    u_xlatb1 = (float4(u_xlat18)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb29 = u_xlat18<5.0;
    u_xlat9.x = fma(u_xlat9.x, 6.0, (-u_xlat18));
    u_xlat18 = max(u_xlat27, 0.00100000005);
    u_xlat3.z = u_xlat27 + u_xlat27;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat18;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat18 = fma(u_xlat0.x, u_xlat9.x, (-u_xlat0.x));
    u_xlat9.x = fma((-u_xlat0.x), u_xlat9.x, 1.0);
    u_xlat3.y = u_xlat9.x * u_xlat3.z;
    u_xlat9.x = u_xlat18 + 1.0;
    u_xlat3.w = u_xlat9.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb29)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat9.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat9.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat9.xyz;
    u_xlat9.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat9.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat9.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb27 = 0.0>=FGlobals._DotParams.w;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat27 = input.TEXCOORD3.z;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    bool2 u_xlatb4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float2 u_xlat15;
    float u_xlat22;
    half u_xlat16_22;
    bool u_xlatb22;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_36;
    float u_xlat37;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_22 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + half(1.0);
    u_xlat16_1.x = u_xlat16_22 + (-FGlobals._Cutout);
    u_xlatb22 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_1.x = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_1.x = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat4.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat4.xyz = float3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_34 = dot((-u_xlat4.xyz), input.TEXCOORD1.xyz);
    u_xlat16_34 = u_xlat16_34 + u_xlat16_34;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_34)), (-u_xlat4.xyz)));
    u_xlat22 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat22 * float(u_xlat16_3.x);
    u_xlat6.x = u_xlat22 * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat6.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(FGlobals._NormalDiff);
    u_xlat22 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * FGlobals._NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(u_xlat22), float3(u_xlat16_3.xyz));
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat37 = u_xlat6.z * 8.29800034;
    u_xlat16_34 = (u_xlatb22) ? half(0.0) : half(u_xlat37);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat5.xyz, bias(float(u_xlat16_34)));
    u_xlat16_34 = u_xlat16_2.w + half(-1.0);
    u_xlat16_34 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_34, half(1.0));
    u_xlat16_34 = u_xlat16_34 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_34);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat37 = u_xlat22;
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat4.xyz = fma(u_xlat5.xyz, (-float3(u_xlat22)), u_xlat4.xyz);
    u_xlat16_34 = half((-u_xlat37) + 1.0);
    u_xlat16_22 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_34 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_36 = (-u_xlat16_34) + FGlobals._Smoothness;
    u_xlat16_36 = u_xlat16_36 + half(1.0);
    u_xlat16_36 = clamp(u_xlat16_36, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = fma(half3(FGlobals._Metallic), u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_10.xyz = half3(u_xlat16_36) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = fma(half3(u_xlat16_22), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_10.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_8.xyz, u_xlat16_3.xyz);
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat7.xyz = float3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat6.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat6.xz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_4.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_4.xyz = u_xlat16_4.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(float3(u_xlat22) * float3(u_xlat16_4.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_8.xyz, u_xlat16_1.xyz);
    u_xlat16_3.xyz = fma((-u_xlat16_1.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_11 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_11), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_3.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb4.xy = (float2(u_xlat33)==u_xlat0.zx);
    u_xlat2.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat2.zx;
    u_xlat2.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat15.xy = (u_xlatb4.y) ? u_xlat2.yw : u_xlat3.xy;
    u_xlat4.xy = (u_xlatb4.x) ? u_xlat3.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat4.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat4.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = fma(u_xlat11.x, 0.166666672, u_xlat22);
    u_xlat11.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat11.x);
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb2 = (float4(u_xlat22)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb4.x = u_xlat22<5.0;
    u_xlat11.x = fma(u_xlat11.x, 6.0, (-u_xlat22));
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat3.z = u_xlat33 + u_xlat33;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat22 = fma(u_xlat0.x, u_xlat11.x, (-u_xlat0.x));
    u_xlat11.x = fma((-u_xlat0.x), u_xlat11.x, 1.0);
    u_xlat3.y = u_xlat11.x * u_xlat3.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat3.w = u_xlat11.x * u_xlat3.z;
    u_xlat4.xz = (u_xlatb4.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat11.xyz = (u_xlatb2.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat11.xyz = (u_xlatb2.z) ? u_xlat3.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.y) ? u_xlat3.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.x) ? u_xlat3.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat11.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + float3(u_xlat16_1.xyz);
    u_xlatb33 = 0.0>=FGlobals._DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float2 u_xlat14;
    float u_xlat22;
    half u_xlat16_22;
    bool u_xlatb22;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat36;
    half u_xlat16_37;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_22 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + half(1.0);
    u_xlat16_1.x = u_xlat16_22 + (-FGlobals._Cutout);
    u_xlatb22 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + input.TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat3.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat3.xyz = float3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_35 = dot((-u_xlat3.xyz), input.TEXCOORD1.xyz);
    u_xlat16_35 = u_xlat16_35 + u_xlat16_35;
    u_xlat16_4.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_35)), (-u_xlat3.xyz)));
    u_xlat22 = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? float(u_xlat16_4.z) : (-float(u_xlat16_4.z));
    u_xlat5.z = u_xlat22 * float(u_xlat16_4.x);
    u_xlat6.x = u_xlat22 * float(u_xlat16_4.z);
    u_xlat5.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yz);
    u_xlat6.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(FGlobals._NormalDiff);
    u_xlat22 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * FGlobals._NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(u_xlat22), float3(u_xlat16_4.xyz));
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat36 = u_xlat6.z * 8.29800034;
    u_xlat16_35 = (u_xlatb22) ? half(0.0) : half(u_xlat36);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat5.xyz, bias(float(u_xlat16_35)));
    u_xlat16_35 = u_xlat16_1.w + half(-1.0);
    u_xlat16_35 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_35, half(1.0));
    u_xlat16_35 = u_xlat16_35 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat22;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = fma(u_xlat5.xyz, (-float3(u_xlat22)), u_xlat3.xyz);
    u_xlat16_35 = half((-u_xlat36) + 1.0);
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_37 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_37 = u_xlat16_37 + half(1.0);
    u_xlat16_37 = clamp(u_xlat16_37, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = fma(half3(FGlobals._Metallic), u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_10.xyz = half3(u_xlat16_37) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = fma(half3(u_xlat16_22), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, u_xlat16_8.xyz, u_xlat16_4.xyz);
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat7.xyz = float3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat6.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat6.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_4.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_3.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(float3(u_xlat22) * float3(u_xlat16_3.xyz));
    u_xlat16_2.xyz = fma(u_xlat16_4.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_4.xyz = fma((-u_xlat16_2.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_11 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_11), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_4.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat33)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat14.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat14.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat3.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat3.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = fma(u_xlat11.x, 0.166666672, u_xlat22);
    u_xlat11.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat11.x);
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb1 = (float4(u_xlat22)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb3.x = u_xlat22<5.0;
    u_xlat11.x = fma(u_xlat11.x, 6.0, (-u_xlat22));
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat4.z = u_xlat33 + u_xlat33;
    u_xlat4.z = clamp(u_xlat4.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat22 = fma(u_xlat0.x, u_xlat11.x, (-u_xlat0.x));
    u_xlat11.x = fma((-u_xlat0.x), u_xlat11.x, 1.0);
    u_xlat4.y = u_xlat11.x * u_xlat4.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat4.w = u_xlat11.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = fma((-u_xlat4.z), u_xlat0.x, u_xlat4.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat11.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat11.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat11.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + float3(u_xlat16_2.xyz);
    u_xlatb33 = 0.0>=FGlobals._DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_10.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + input.TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_10.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + input.TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    float2 u_xlat17;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat44;
    bool u_xlatb44;
    float u_xlat45;
    half u_xlat16_47;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_28 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + half(1.0);
    u_xlat16_1.x = u_xlat16_28 + (-FGlobals._Cutout);
    u_xlatb28 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat28 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat28), float3(u_xlat16_1.xyz));
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? half(0.0) : half(u_xlat45);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = half(u_xlat28 * u_xlat44);
    u_xlat28 = fma(u_xlat28, u_xlat28, 1.5);
    u_xlat16_47 = fma((-u_xlat16_47), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_47);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat45), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = float3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat6.xyz = float3(u_xlat45) * input.TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = fma(u_xlat44, u_xlat44, -1.0);
    u_xlat45 = fma(u_xlat45, u_xlat4.x, 1.00001001);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_47 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + FGlobals._Smoothness;
    u_xlat16_47 = u_xlat16_47 + half(1.0);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_47);
    u_xlat4.xyz = fma(float3(u_xlat28), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_10.xyz);
    u_xlat16_47 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_47 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_47))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_11.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_47), u_xlat16_11.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_12.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_12.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_13.xyz, u_xlat16_10.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_47 = half((-u_xlat2.x) + 1.0);
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = fma(half3(u_xlat16_47), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat28), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_14 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_14), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat42)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = fma(u_xlat14.x, 0.166666672, u_xlat28);
    u_xlat14.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat14.x);
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = (float4(u_xlat28)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = fma(u_xlat14.x, 6.0, (-u_xlat28));
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat28 = fma(u_xlat0.x, u_xlat14.x, (-u_xlat0.x));
    u_xlat14.x = fma((-u_xlat0.x), u_xlat14.x, 1.0);
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=FGlobals._DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    float2 u_xlat17;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat44;
    bool u_xlatb44;
    float u_xlat45;
    half u_xlat16_47;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_28 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + half(1.0);
    u_xlat16_1.x = u_xlat16_28 + (-FGlobals._Cutout);
    u_xlatb28 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat28 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat28), float3(u_xlat16_1.xyz));
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? half(0.0) : half(u_xlat45);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = half(u_xlat28 * u_xlat44);
    u_xlat28 = fma(u_xlat28, u_xlat28, 1.5);
    u_xlat16_47 = fma((-u_xlat16_47), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_47);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat45), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = float3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat6.xyz = float3(u_xlat45) * input.TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = fma(u_xlat44, u_xlat44, -1.0);
    u_xlat45 = fma(u_xlat45, u_xlat4.x, 1.00001001);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_47 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + FGlobals._Smoothness;
    u_xlat16_47 = u_xlat16_47 + half(1.0);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_47);
    u_xlat4.xyz = fma(float3(u_xlat28), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_10.xyz);
    u_xlat16_47 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_47 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_47))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_11.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_47), u_xlat16_11.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_12.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_12.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_13.xyz, u_xlat16_10.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_47 = half((-u_xlat2.x) + 1.0);
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = fma(half3(u_xlat16_47), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat28), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_14 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_14), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat42)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = fma(u_xlat14.x, 0.166666672, u_xlat28);
    u_xlat14.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat14.x);
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = (float4(u_xlat28)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = fma(u_xlat14.x, 6.0, (-u_xlat28));
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat28 = fma(u_xlat0.x, u_xlat14.x, (-u_xlat0.x));
    u_xlat14.x = fma((-u_xlat0.x), u_xlat14.x, 1.0);
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=FGlobals._DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float2 u_xlat14;
    float u_xlat22;
    half u_xlat16_22;
    bool u_xlatb22;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat36;
    half u_xlat16_37;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_22 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + half(1.0);
    u_xlat16_1.x = u_xlat16_22 + (-FGlobals._Cutout);
    u_xlatb22 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + input.TEXCOORD4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat3.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat3.xyz = float3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_35 = dot((-u_xlat3.xyz), input.TEXCOORD1.xyz);
    u_xlat16_35 = u_xlat16_35 + u_xlat16_35;
    u_xlat16_4.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_35)), (-u_xlat3.xyz)));
    u_xlat22 = dot(u_xlat16_4.zxy, (-u_xlat16_4.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? float(u_xlat16_4.z) : (-float(u_xlat16_4.z));
    u_xlat5.z = u_xlat22 * float(u_xlat16_4.x);
    u_xlat6.x = u_xlat22 * float(u_xlat16_4.z);
    u_xlat5.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yz);
    u_xlat6.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(FGlobals._NormalDiff);
    u_xlat22 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * FGlobals._NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(u_xlat22), float3(u_xlat16_4.xyz));
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat36 = u_xlat6.z * 8.29800034;
    u_xlat16_35 = (u_xlatb22) ? half(0.0) : half(u_xlat36);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat5.xyz, bias(float(u_xlat16_35)));
    u_xlat16_35 = u_xlat16_1.w + half(-1.0);
    u_xlat16_35 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_35, half(1.0));
    u_xlat16_35 = u_xlat16_35 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat22;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat3.xyz = fma(u_xlat5.xyz, (-float3(u_xlat22)), u_xlat3.xyz);
    u_xlat16_35 = half((-u_xlat36) + 1.0);
    u_xlat16_22 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_35 * u_xlat16_22;
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_37 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_37 = u_xlat16_37 + half(1.0);
    u_xlat16_37 = clamp(u_xlat16_37, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = fma(half3(FGlobals._Metallic), u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_10.xyz = half3(u_xlat16_37) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = fma(half3(u_xlat16_22), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, u_xlat16_8.xyz, u_xlat16_4.xyz);
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat7.xyz = float3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat6.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat6.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_4.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_3.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_3.xyz;
    u_xlat16_8.xyz = half3(float3(u_xlat22) * float3(u_xlat16_8.xyz));
    u_xlat16_2.xyz = fma(u_xlat16_4.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_4.xyz = fma((-u_xlat16_2.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_11 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_11), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_4.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat33)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat14.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat14.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat3.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat3.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = fma(u_xlat11.x, 0.166666672, u_xlat22);
    u_xlat11.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat11.x);
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb1 = (float4(u_xlat22)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb3.x = u_xlat22<5.0;
    u_xlat11.x = fma(u_xlat11.x, 6.0, (-u_xlat22));
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat4.z = u_xlat33 + u_xlat33;
    u_xlat4.z = clamp(u_xlat4.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat22 = fma(u_xlat0.x, u_xlat11.x, (-u_xlat0.x));
    u_xlat11.x = fma((-u_xlat0.x), u_xlat11.x, 1.0);
    u_xlat4.y = u_xlat11.x * u_xlat4.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat4.w = u_xlat11.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = fma((-u_xlat4.z), u_xlat0.x, u_xlat4.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat11.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat11.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat11.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + float3(u_xlat16_2.xyz);
    u_xlatb33 = 0.0>=FGlobals._DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = half3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_11.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + input.TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = half3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_11.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + input.TEXCOORD4.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler samplerunity_NHxRoughness [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    sampler sampler_TransparencyLM [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    bool2 u_xlatb2;
    float4 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_10;
    float2 u_xlat12;
    half3 u_xlat16_16;
    float u_xlat20;
    half u_xlat16_20;
    bool u_xlatb20;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat32;
    half u_xlat16_35;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_20 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat16_20) + half(1.0);
    u_xlat16_1.x = u_xlat16_20 + (-FGlobals._Cutout);
    u_xlatb20 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat2.xyz = float3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb20 = u_xlat20<9.99999975e-06;
    u_xlat20 = (u_xlatb20) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat20 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat20 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat20 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * FGlobals._NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat20), float3(u_xlat16_1.xyz));
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb20 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat20 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * input.TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = fma(u_xlat3.xyz, (-float3(u_xlat20)), u_xlat2.xyz);
    u_xlat16_35 = half((-u_xlat32) + 1.0);
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.x = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + half(1.0);
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_16.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_16.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_16.xyz = half3(u_xlat16_35) * u_xlat16_16.xyz;
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_20), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_7.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_7.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = fma(u_xlat16_9.xyz, u_xlat16_16.xyz, u_xlat16_5.xyz);
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat7.xyz = float3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_6.xyz = half3(fma(u_xlat2.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_16.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_2.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_8.xyz = half3(float3(u_xlat20) * float3(u_xlat16_8.xyz));
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    u_xlat16_6.xyz = fma((-u_xlat16_5.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_10 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_6.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = (float2(u_xlat30)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
    u_xlatb20 = u_xlat10.x<0.0;
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = fma(u_xlat10.x, 0.166666672, u_xlat20);
    u_xlat10.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat10.x);
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = (float4(u_xlat20)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb2.x = u_xlat20<5.0;
    u_xlat10.x = fma(u_xlat10.x, 6.0, (-u_xlat20));
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat20 = fma(u_xlat0.x, u_xlat10.x, (-u_xlat0.x));
    u_xlat10.x = fma((-u_xlat0.x), u_xlat10.x, 1.0);
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + float3(u_xlat16_5.xyz);
    u_xlatb30 = 0.0>=FGlobals._DotParams.w;
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD3.z;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    bool2 u_xlatb2;
    float4 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_10;
    float2 u_xlat12;
    half3 u_xlat16_16;
    float u_xlat20;
    half u_xlat16_20;
    bool u_xlatb20;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat32;
    half u_xlat16_35;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_20 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_20 = (-u_xlat16_20) + half(1.0);
    u_xlat16_1.x = u_xlat16_20 + (-FGlobals._Cutout);
    u_xlatb20 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat2.xyz = float3(u_xlat20) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat20 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb20 = u_xlat20<9.99999975e-06;
    u_xlat20 = (u_xlatb20) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat20 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat20 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat20 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat20 = sin(u_xlat20);
    u_xlat20 = u_xlat20 * FGlobals._NormalRand.w;
    u_xlat20 = fract(u_xlat20);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat20), float3(u_xlat16_1.xyz));
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb20 = u_xlat4.z<0.00499999989;
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb20) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat20 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat3.xyz = float3(u_xlat20) * input.TEXCOORD1.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat32 = u_xlat20;
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat2.xyz = fma(u_xlat3.xyz, (-float3(u_xlat20)), u_xlat2.xyz);
    u_xlat16_35 = half((-u_xlat32) + 1.0);
    u_xlat16_20 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_20 = u_xlat16_35 * u_xlat16_20;
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.x = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_6.x = u_xlat16_6.x + half(1.0);
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_16.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_16.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_16.xyz = half3(u_xlat16_35) * u_xlat16_16.xyz;
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = u_xlat16_6.xxx + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_20), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_7.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_7.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = fma(u_xlat16_9.xyz, u_xlat16_16.xyz, u_xlat16_5.xyz);
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat20 = rsqrt(u_xlat20);
    u_xlat7.xyz = float3(u_xlat20) * u_xlat7.xyz;
    u_xlat20 = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_6.xyz = half3(fma(u_xlat2.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_16.xyz)));
    u_xlat16_2.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_2.xyz = u_xlat16_2.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(float3(u_xlat20) * float3(u_xlat16_2.xyz));
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    u_xlat16_6.xyz = fma((-u_xlat16_5.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_10 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_6.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat30 = max(u_xlat0.y, u_xlat0.x);
    u_xlat30 = max(u_xlat30, u_xlat0.z);
    u_xlatb2.xy = (float2(u_xlat30)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat12.xy = (u_xlatb2.y) ? u_xlat1.yw : u_xlat3.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat12.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat30;
    u_xlat10.x = u_xlat2.x / u_xlat0.x;
    u_xlat10.x = u_xlat10.x + u_xlat2.y;
    u_xlatb20 = u_xlat10.x<0.0;
    u_xlat20 = u_xlatb20 ? 1.0 : float(0.0);
    u_xlat10.x = fma(u_xlat10.x, 0.166666672, u_xlat20);
    u_xlat10.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat10.x);
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat20 = u_xlat10.x * 6.0;
    u_xlat20 = floor(u_xlat20);
    u_xlatb1 = (float4(u_xlat20)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb2.x = u_xlat20<5.0;
    u_xlat10.x = fma(u_xlat10.x, 6.0, (-u_xlat20));
    u_xlat20 = max(u_xlat30, 0.00100000005);
    u_xlat3.z = u_xlat30 + u_xlat30;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat20;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat20 = fma(u_xlat0.x, u_xlat10.x, (-u_xlat0.x));
    u_xlat10.x = fma((-u_xlat0.x), u_xlat10.x, 1.0);
    u_xlat3.y = u_xlat10.x * u_xlat3.z;
    u_xlat10.x = u_xlat20 + 1.0;
    u_xlat3.w = u_xlat10.x * u_xlat3.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat3.x;
    u_xlat10.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat2.xyz;
    u_xlat10.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat10.xyz;
    u_xlat10.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat10.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat10.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + float3(u_xlat16_5.xyz);
    u_xlatb30 = 0.0>=FGlobals._DotParams.w;
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD3.z;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = half3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_11.xyz);
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half u_xlat16_12;
    float2 u_xlat15;
    float u_xlat24;
    half u_xlat16_24;
    bool u_xlatb24;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_24 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_24 = (-u_xlat16_24) + half(1.0);
    u_xlat16_1.x = u_xlat16_24 + (-FGlobals._Cutout);
    u_xlatb24 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb24) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb38 = u_xlat24<0.00499999989;
    u_xlat39 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb38) ? half(0.0) : half(u_xlat39);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat38 = u_xlat24 * u_xlat24;
    u_xlat16_41 = half(u_xlat24 * u_xlat38);
    u_xlat24 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat39 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat39), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat39 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = max(u_xlat39, 0.319999993);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat39 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat6.xyz = float3(u_xlat39) * input.TEXCOORD1.xyz;
    u_xlat39 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat4.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat39 = fma(u_xlat39, u_xlat4.x, 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat39;
    u_xlat24 = u_xlat38 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_41) * u_xlat16_7.xyz;
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_41);
    u_xlat4.xyz = fma(float3(u_xlat24), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = half3(u_xlat16_41) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_11.xyz);
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat2.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_8.xyz = fma(half3(u_xlat16_41), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat24), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_12 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat36 = max(u_xlat0.y, u_xlat0.x);
    u_xlat36 = max(u_xlat36, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat36)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat15.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat36;
    u_xlat12.x = u_xlat3.x / u_xlat0.x;
    u_xlat12.x = u_xlat12.x + u_xlat3.y;
    u_xlatb24 = u_xlat12.x<0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat12.x = fma(u_xlat12.x, 0.166666672, u_xlat24);
    u_xlat12.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat12.x);
    u_xlat12.x = fract(u_xlat12.x);
    u_xlat24 = u_xlat12.x * 6.0;
    u_xlat24 = floor(u_xlat24);
    u_xlatb1 = (float4(u_xlat24)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb38 = u_xlat24<5.0;
    u_xlat12.x = fma(u_xlat12.x, 6.0, (-u_xlat24));
    u_xlat24 = max(u_xlat36, 0.00100000005);
    u_xlat3.z = u_xlat36 + u_xlat36;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat24;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat24 = fma(u_xlat0.x, u_xlat12.x, (-u_xlat0.x));
    u_xlat12.x = fma((-u_xlat0.x), u_xlat12.x, 1.0);
    u_xlat3.y = u_xlat12.x * u_xlat3.z;
    u_xlat12.x = u_xlat24 + 1.0;
    u_xlat3.w = u_xlat12.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb38)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat12.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat12.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat12.xyz;
    u_xlat12.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat12.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat12.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb36 = 0.0>=FGlobals._DotParams.w;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD3.z;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler samplerunity_NHxRoughness [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    sampler sampler_TransparencyLM [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    bool2 u_xlatb4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float2 u_xlat15;
    float u_xlat22;
    half u_xlat16_22;
    bool u_xlatb22;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_36;
    float u_xlat37;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_22 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_22 = (-u_xlat16_22) + half(1.0);
    u_xlat16_1.x = u_xlat16_22 + (-FGlobals._Cutout);
    u_xlatb22 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb22) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_1.x = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_1.x = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat4.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat4.xyz = float3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_34 = dot((-u_xlat4.xyz), input.TEXCOORD1.xyz);
    u_xlat16_34 = u_xlat16_34 + u_xlat16_34;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_34)), (-u_xlat4.xyz)));
    u_xlat22 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb22 = u_xlat22<9.99999975e-06;
    u_xlat22 = (u_xlatb22) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat22 * float(u_xlat16_3.x);
    u_xlat6.x = u_xlat22 * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat6.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat5.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(FGlobals._NormalDiff);
    u_xlat22 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat22 = sin(u_xlat22);
    u_xlat22 = u_xlat22 * FGlobals._NormalRand.w;
    u_xlat22 = fract(u_xlat22);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(u_xlat22), float3(u_xlat16_3.xyz));
    u_xlat22 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * u_xlat5.xyz;
    u_xlat6.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb22 = u_xlat6.z<0.00499999989;
    u_xlat37 = u_xlat6.z * 8.29800034;
    u_xlat16_34 = (u_xlatb22) ? half(0.0) : half(u_xlat37);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat5.xyz, bias(float(u_xlat16_34)));
    u_xlat16_34 = u_xlat16_2.w + half(-1.0);
    u_xlat16_34 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_34, half(1.0));
    u_xlat16_34 = u_xlat16_34 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_34);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat5.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat37 = u_xlat22;
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat4.xyz = fma(u_xlat5.xyz, (-float3(u_xlat22)), u_xlat4.xyz);
    u_xlat16_34 = half((-u_xlat37) + 1.0);
    u_xlat16_22 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_34 * u_xlat16_22;
    u_xlat16_34 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_36 = (-u_xlat16_34) + FGlobals._Smoothness;
    u_xlat16_36 = u_xlat16_36 + half(1.0);
    u_xlat16_36 = clamp(u_xlat16_36, 0.0h, 1.0h);
    u_xlat16_7.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = fma(u_xlat16_7.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_34) * u_xlat16_8.xyz;
    u_xlat16_9.xyz = fma(half3(FGlobals._Metallic), u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_10.xyz = half3(u_xlat16_36) + (-u_xlat16_9.xyz);
    u_xlat16_10.xyz = fma(half3(u_xlat16_22), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_10.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_8.xyz, u_xlat16_3.xyz);
    u_xlat7.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat22 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat7.xyz = float3(u_xlat22) * u_xlat7.xyz;
    u_xlat22 = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat6.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat6.xz).x;
    u_xlat4.x = u_xlat4.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_34 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0h, 1.0h);
    u_xlat16_4.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_4.xyz = u_xlat16_4.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_8.xyz = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = half3(float3(u_xlat22) * float3(u_xlat16_8.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_8.xyz, u_xlat16_1.xyz);
    u_xlat16_3.xyz = fma((-u_xlat16_1.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_11 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_11), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_3.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat33 = max(u_xlat0.y, u_xlat0.x);
    u_xlat33 = max(u_xlat33, u_xlat0.z);
    u_xlatb4.xy = (float2(u_xlat33)==u_xlat0.zx);
    u_xlat2.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat3.xz = u_xlat2.zx;
    u_xlat2.w = 2.0;
    u_xlat3.y = float(4.0);
    u_xlat3.w = float(0.0);
    u_xlat15.xy = (u_xlatb4.y) ? u_xlat2.yw : u_xlat3.xy;
    u_xlat4.xy = (u_xlatb4.x) ? u_xlat3.zw : u_xlat15.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat11.x = u_xlat4.x / u_xlat0.x;
    u_xlat11.x = u_xlat11.x + u_xlat4.y;
    u_xlatb22 = u_xlat11.x<0.0;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat11.x = fma(u_xlat11.x, 0.166666672, u_xlat22);
    u_xlat11.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat11.x);
    u_xlat11.x = fract(u_xlat11.x);
    u_xlat22 = u_xlat11.x * 6.0;
    u_xlat22 = floor(u_xlat22);
    u_xlatb2 = (float4(u_xlat22)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb4.x = u_xlat22<5.0;
    u_xlat11.x = fma(u_xlat11.x, 6.0, (-u_xlat22));
    u_xlat22 = max(u_xlat33, 0.00100000005);
    u_xlat3.z = u_xlat33 + u_xlat33;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat22;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat22 = fma(u_xlat0.x, u_xlat11.x, (-u_xlat0.x));
    u_xlat11.x = fma((-u_xlat0.x), u_xlat11.x, 1.0);
    u_xlat3.y = u_xlat11.x * u_xlat3.z;
    u_xlat11.x = u_xlat22 + 1.0;
    u_xlat3.w = u_xlat11.x * u_xlat3.z;
    u_xlat4.xz = (u_xlatb4.x) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat11.xyz = (u_xlatb2.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat11.xyz = (u_xlatb2.z) ? u_xlat3.xzw : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.y) ? u_xlat3.yzx : u_xlat11.xyz;
    u_xlat11.xyz = (u_xlatb2.x) ? u_xlat3.zwx : u_xlat11.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat11.xyz;
    u_xlat4.xyz = (-u_xlat0.xyz) + float3(u_xlat16_1.xyz);
    u_xlatb33 = 0.0>=FGlobals._DotParams.w;
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD3.z;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    float2 u_xlat17;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat44;
    bool u_xlatb44;
    float u_xlat45;
    half u_xlat16_47;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_28 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + half(1.0);
    u_xlat16_1.x = u_xlat16_28 + (-FGlobals._Cutout);
    u_xlatb28 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat28 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat28), float3(u_xlat16_1.xyz));
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? half(0.0) : half(u_xlat45);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = half(u_xlat28 * u_xlat44);
    u_xlat28 = fma(u_xlat28, u_xlat28, 1.5);
    u_xlat16_47 = fma((-u_xlat16_47), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_47);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat45), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = float3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat6.xyz = float3(u_xlat45) * input.TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = fma(u_xlat44, u_xlat44, -1.0);
    u_xlat45 = fma(u_xlat45, u_xlat4.x, 1.00001001);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_47 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + FGlobals._Smoothness;
    u_xlat16_47 = u_xlat16_47 + half(1.0);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_47);
    u_xlat4.xyz = fma(float3(u_xlat28), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_47 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0h, 1.0h);
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = half3(u_xlat16_47) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_11.xyz);
    u_xlat16_47 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_47 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_47))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_11.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_47), u_xlat16_11.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_12.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_12.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_13.xyz, u_xlat16_10.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_47 = half((-u_xlat2.x) + 1.0);
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = fma(half3(u_xlat16_47), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat28), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_14 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_14), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat42)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = fma(u_xlat14.x, 0.166666672, u_xlat28);
    u_xlat14.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat14.x);
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = (float4(u_xlat28)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = fma(u_xlat14.x, 6.0, (-u_xlat28));
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat28 = fma(u_xlat0.x, u_xlat14.x, (-u_xlat0.x));
    u_xlat14.x = fma((-u_xlat0.x), u_xlat14.x, 1.0);
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=FGlobals._DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _NormalRand;
    half _NormalDiff;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool4 u_xlatb1;
    float3 u_xlat2;
    float4 u_xlat3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    float2 u_xlat17;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat44;
    bool u_xlatb44;
    float u_xlat45;
    half u_xlat16_47;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_28 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_28 = (-u_xlat16_28) + half(1.0);
    u_xlat16_1.x = u_xlat16_28 + (-FGlobals._Cutout);
    u_xlatb28 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb28) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat28 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = u_xlat28 * float(u_xlat16_1.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_1.z);
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat28), float3(u_xlat16_1.xyz));
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb44 = u_xlat28<0.00499999989;
    u_xlat45 = u_xlat28 * 8.29800034;
    u_xlat16_1.x = (u_xlatb44) ? half(0.0) : half(u_xlat45);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_5.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat44 = u_xlat28 * u_xlat28;
    u_xlat16_47 = half(u_xlat28 * u_xlat44);
    u_xlat28 = fma(u_xlat28, u_xlat28, 1.5);
    u_xlat16_47 = fma((-u_xlat16_47), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_47);
    u_xlat3.xyz = FGlobals._WorldSpaceCameraPos.xyzx.xyz + (-FGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat45 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat45), u_xlat2.xyz);
    u_xlat3.xyz = float3(u_xlat45) * u_xlat3.xyz;
    u_xlat45 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat45 = max(u_xlat45, 0.00100000005);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat4.xyz = float3(u_xlat45) * u_xlat4.xyz;
    u_xlat45 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = max(u_xlat45, 0.319999993);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat45 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat45 = rsqrt(u_xlat45);
    u_xlat6.xyz = float3(u_xlat45) * input.TEXCOORD1.xyz;
    u_xlat45 = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat45 = clamp(u_xlat45, 0.0f, 1.0f);
    u_xlat45 = u_xlat45 * u_xlat45;
    u_xlat4.x = fma(u_xlat44, u_xlat44, -1.0);
    u_xlat45 = fma(u_xlat45, u_xlat4.x, 1.00001001);
    u_xlat28 = u_xlat28 * u_xlat45;
    u_xlat28 = u_xlat44 / u_xlat28;
    u_xlat28 = u_xlat28 + -9.99999975e-05;
    u_xlat28 = max(u_xlat28, 0.0);
    u_xlat28 = min(u_xlat28, 100.0);
    u_xlat16_4.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_47 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_47) * u_xlat16_7.xyz;
    u_xlat16_47 = (-u_xlat16_47) + FGlobals._Smoothness;
    u_xlat16_47 = u_xlat16_47 + half(1.0);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_47);
    u_xlat4.xyz = fma(float3(u_xlat28), float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_47 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_47 = clamp(u_xlat16_47, 0.0h, 1.0h);
    u_xlat16_10.xyz = min(FGlobals._LightColor0.xyz, half3(0.349999994, 0.349999994, 0.349999994));
    u_xlat16_10.xyz = u_xlat16_10.xyz + half3(0.150000006, 0.150000006, 0.150000006);
    u_xlat16_11.xyz = half3(u_xlat16_47) * u_xlat16_10.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat16_11.xyz);
    u_xlat16_47 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_47 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_47))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_11.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_11.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_11.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_11.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_47), u_xlat16_11.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_12.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_12.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_12.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_11.xyz = u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_11.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_13.xyz, u_xlat16_10.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_47 = half((-u_xlat2.x) + 1.0);
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_47 = u_xlat16_47 * u_xlat16_47;
    u_xlat16_8.xyz = fma(half3(u_xlat16_47), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat2.xyz = fma(u_xlat4.xyz, float3(u_xlat28), float3(u_xlat16_7.xyz));
    u_xlat2.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat2.xyz);
    u_xlat16_5.xyz = half3(fma((-u_xlat2.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_14 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_14), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat42 = max(u_xlat0.y, u_xlat0.x);
    u_xlat42 = max(u_xlat42, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat42)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat17.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat17.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat42;
    u_xlat14.x = u_xlat3.x / u_xlat0.x;
    u_xlat14.x = u_xlat14.x + u_xlat3.y;
    u_xlatb28 = u_xlat14.x<0.0;
    u_xlat28 = u_xlatb28 ? 1.0 : float(0.0);
    u_xlat14.x = fma(u_xlat14.x, 0.166666672, u_xlat28);
    u_xlat14.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat14.x);
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat28 = u_xlat14.x * 6.0;
    u_xlat28 = floor(u_xlat28);
    u_xlatb1 = (float4(u_xlat28)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlatb44 = u_xlat28<5.0;
    u_xlat14.x = fma(u_xlat14.x, 6.0, (-u_xlat28));
    u_xlat28 = max(u_xlat42, 0.00100000005);
    u_xlat3.z = u_xlat42 + u_xlat42;
    u_xlat3.z = clamp(u_xlat3.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat28;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat28 = fma(u_xlat0.x, u_xlat14.x, (-u_xlat0.x));
    u_xlat14.x = fma((-u_xlat0.x), u_xlat14.x, 1.0);
    u_xlat3.y = u_xlat14.x * u_xlat3.z;
    u_xlat14.x = u_xlat28 + 1.0;
    u_xlat3.w = u_xlat14.x * u_xlat3.z;
    u_xlat4.xz = (bool(u_xlatb44)) ? u_xlat3.wz : u_xlat3.zy;
    u_xlat3.x = fma((-u_xlat3.z), u_xlat0.x, u_xlat3.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat4.y = u_xlat3.x;
    u_xlat14.xyz = (u_xlatb1.w) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat14.xyz = (u_xlatb1.z) ? u_xlat3.xzw : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.y) ? u_xlat3.yzx : u_xlat14.xyz;
    u_xlat14.xyz = (u_xlatb1.x) ? u_xlat3.zwx : u_xlat14.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.zzz : u_xlat14.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlatb42 = 0.0>=FGlobals._DotParams.w;
    u_xlat42 = u_xlatb42 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD3.z;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest" "RenderType" = "DotDriver" }
  ZWrite Off
  Cull Off
  GpuProgramID 74704
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half _DotSplitU;
    half _DotSplitV;
    float4 _DotParams;
    float4 _MainTex_ST;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb2;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat0.x = u_xlat0.x / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlatb2 = VGlobals.unity_FogParams.z!=0.0;
    output.TEXCOORD3.z = (u_xlatb2) ? u_xlat0.x : 1.0;
    u_xlat0.x = VGlobals._DotParams.x / float(VGlobals._DotSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.y = (-u_xlat0.x);
    u_xlat0.x = VGlobals._DotParams.x;
    output.TEXCOORD3.xy = u_xlat0.xy / float2(half2(VGlobals._DotSplitU, VGlobals._DotSplitV));
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    bool2 u_xlatb2;
    float4 u_xlat3;
    bool4 u_xlatb3;
    half3 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    float2 u_xlat8;
    float u_xlat12;
    half u_xlat16_12;
    bool u_xlatb12;
    float u_xlat18;
    bool u_xlatb18;
    half u_xlat16_19;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_12 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_12 = (-u_xlat16_12) + half(1.0);
    u_xlat16_1.x = u_xlat16_12 + (-FGlobals._Cutout);
    u_xlatb12 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb12) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat3.xyz = float3(u_xlat12) * input.TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = fma(u_xlat3.xyz, (-float3(u_xlat12)), u_xlat2.xyz);
    u_xlat12 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_1.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat12 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = u_xlat12 * u_xlat12;
    u_xlat2.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat12 = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat2.xy).x;
    u_xlat12 = u_xlat12 * 16.0;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.xyz = half3(float3(u_xlat12) * float3(u_xlat16_5.xyz));
    u_xlat16_19 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_19), u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_5.xyz = fma((-u_xlat16_5.yzx), u_xlat16_0.ywx, half3(1.0, 1.0, 1.0));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_6 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_5.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat18 = max(u_xlat0.y, u_xlat0.x);
    u_xlat18 = max(u_xlat18, u_xlat0.z);
    u_xlatb2.xy = (float2(u_xlat18)==u_xlat0.zx);
    u_xlat3.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat5.xz = u_xlat3.zx;
    u_xlat3.w = 2.0;
    u_xlat5.y = float(4.0);
    u_xlat5.w = float(0.0);
    u_xlat8.xy = (u_xlatb2.y) ? u_xlat3.yw : u_xlat5.xy;
    u_xlat2.xy = (u_xlatb2.x) ? u_xlat5.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat18;
    u_xlat6.x = u_xlat2.x / u_xlat0.x;
    u_xlat6.x = u_xlat6.x + u_xlat2.y;
    u_xlatb12 = u_xlat6.x<0.0;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat6.x = fma(u_xlat6.x, 0.166666672, u_xlat12);
    u_xlat6.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat6.x);
    u_xlat6.x = fract(u_xlat6.x);
    u_xlat12 = u_xlat6.x * 6.0;
    u_xlat12 = floor(u_xlat12);
    u_xlatb2.x = u_xlat12<5.0;
    u_xlat6.x = fma(u_xlat6.x, 6.0, (-u_xlat12));
    u_xlatb3 = (float4(u_xlat12)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlat12 = max(u_xlat18, 0.00100000005);
    u_xlat5.z = u_xlat18 + u_xlat18;
    u_xlat5.z = clamp(u_xlat5.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat0.x, u_xlat6.x, (-u_xlat0.x));
    u_xlat6.x = fma((-u_xlat0.x), u_xlat6.x, 1.0);
    u_xlat5.y = u_xlat6.x * u_xlat5.z;
    u_xlat6.x = u_xlat12 + 1.0;
    u_xlat5.w = u_xlat6.x * u_xlat5.z;
    u_xlat2.xz = (u_xlatb2.x) ? u_xlat5.wz : u_xlat5.zy;
    u_xlat5.x = fma((-u_xlat5.z), u_xlat0.x, u_xlat5.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat2.y = u_xlat5.x;
    u_xlat6.xyz = (u_xlatb3.w) ? u_xlat5.xyz : u_xlat2.xyz;
    u_xlat6.xyz = (u_xlatb3.z) ? u_xlat5.xzw : u_xlat6.xyz;
    u_xlat6.xyz = (u_xlatb3.y) ? u_xlat5.yzx : u_xlat6.xyz;
    u_xlat6.xyz = (u_xlatb3.x) ? u_xlat5.zwx : u_xlat6.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.zzz : u_xlat6.xyz;
    u_xlat2.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_1.xyz), (-u_xlat0.xyz));
    u_xlatb18 = 0.0>=FGlobals._DotParams.w;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat18), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat18 = input.TEXCOORD3.z;
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat18);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half u_xlat16_5;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat10;
    half u_xlat16_10;
    bool u_xlatb10;
    half u_xlat16_12;
    float u_xlat15;
    bool u_xlatb15;
    half u_xlat16_16;
    half u_xlat16_17;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_10 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = (-u_xlat16_10) + half(1.0);
    u_xlat16_1.x = u_xlat16_10 + (-FGlobals._Cutout);
    u_xlatb10 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb10) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat10), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = max(u_xlat10, 0.00100000005);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat10 = max(u_xlat10, 0.319999993);
    u_xlat16_17 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_17, u_xlat16_17, half(1.5));
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat10 = u_xlat10 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = fma(u_xlat16_17, u_xlat16_17, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_12), 1.00001001);
    u_xlat10 = u_xlat10 * u_xlat2.x;
    u_xlat10 = float(u_xlat16_17) / u_xlat10;
    u_xlat10 = u_xlat10 + -9.99999975e-05;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 100.0);
    u_xlat16_2.xzw = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_2.xzw, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(half3(FGlobals._Metallic), u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat2.xzw = float3(u_xlat10) * float3(u_xlat16_4.xyz);
    u_xlat16_16 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat2.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_16), u_xlat2.xzw);
    u_xlat2.xzw = u_xlat2.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat3.xyz = float3(u_xlat7) * u_xlat2.xzw;
    u_xlat16_1.xyz = half3(fma((-u_xlat3.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_5 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_5), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_1.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat15 = max(u_xlat0.y, u_xlat0.x);
    u_xlat15 = max(u_xlat15, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat15)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat8.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat15;
    u_xlat5.x = u_xlat3.x / u_xlat0.x;
    u_xlat5.x = u_xlat5.x + u_xlat3.y;
    u_xlatb10 = u_xlat5.x<0.0;
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat5.x = fma(u_xlat5.x, 0.166666672, u_xlat10);
    u_xlat5.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat5.x);
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat10 = u_xlat5.x * 6.0;
    u_xlat10 = floor(u_xlat10);
    u_xlatb3.x = u_xlat10<5.0;
    u_xlat5.x = fma(u_xlat5.x, 6.0, (-u_xlat10));
    u_xlatb1 = (float4(u_xlat10)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlat10 = max(u_xlat15, 0.00100000005);
    u_xlat4.z = u_xlat15 + u_xlat15;
    u_xlat4.z = clamp(u_xlat4.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat10;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = fma(u_xlat0.x, u_xlat5.x, (-u_xlat0.x));
    u_xlat5.x = fma((-u_xlat0.x), u_xlat5.x, 1.0);
    u_xlat4.y = u_xlat5.x * u_xlat4.z;
    u_xlat5.x = u_xlat10 + 1.0;
    u_xlat4.w = u_xlat5.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = fma((-u_xlat4.z), u_xlat0.x, u_xlat4.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat5.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat5.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat5.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat5.xyz;
    u_xlat2.xyz = fma(u_xlat2.xzw, float3(u_xlat7), (-u_xlat0.xyz));
    u_xlatb15 = 0.0>=FGlobals._DotParams.w;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat15), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = input.TEXCOORD3.z;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat15);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half _Cutout;
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half4 _AddColor;
    float4 _DotParams;
    half _DotStarHueSpeed;
    half _DotStarLightnessSpeed;
    half _DotStarMinLightness;
    half _DotStarMaxLightness;
    half _DotStarAddedSaturation;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _TransparencyLM [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    bool2 u_xlatb3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half u_xlat16_5;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat10;
    half u_xlat16_10;
    bool u_xlatb10;
    half u_xlat16_12;
    float u_xlat15;
    bool u_xlatb15;
    half u_xlat16_16;
    half u_xlat16_17;
    u_xlat0 = input.TEXCOORD0 + input.TEXCOORD3.xyxy;
    u_xlat16_10 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.zw).x;
    u_xlat16_0.xyw = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = (-u_xlat16_10) + half(1.0);
    u_xlat16_1.x = u_xlat16_10 + (-FGlobals._Cutout);
    u_xlatb10 = u_xlat16_1.x<half(0.0);
    if(((int(u_xlatb10) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat10), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = max(u_xlat10, 0.00100000005);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat10 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat10 = max(u_xlat10, 0.319999993);
    u_xlat16_17 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_17, u_xlat16_17, half(1.5));
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat10 = u_xlat10 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = fma(u_xlat16_17, u_xlat16_17, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_12), 1.00001001);
    u_xlat10 = u_xlat10 * u_xlat2.x;
    u_xlat10 = float(u_xlat16_17) / u_xlat10;
    u_xlat10 = u_xlat10 + -9.99999975e-05;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 100.0);
    u_xlat16_2.xzw = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_2.xzw, u_xlat16_0.xyw, FGlobals._AddColor.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(half3(FGlobals._Metallic), u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat2.xzw = float3(u_xlat10) * float3(u_xlat16_4.xyz);
    u_xlat16_16 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat2.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_16), u_xlat2.xzw);
    u_xlat2.xzw = u_xlat2.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat3.xyz = float3(u_xlat7) * u_xlat2.xzw;
    u_xlat16_1.xyz = half3(fma((-u_xlat3.yzx), float3(u_xlat16_0.ywx), float3(1.0, 1.0, 1.0)));
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._DotStarLightnessSpeed);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, 0.5, 0.5);
    u_xlat16_5 = (-FGlobals._DotStarMinLightness) + FGlobals._DotStarMaxLightness;
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_5), float(FGlobals._DotStarMinLightness));
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = fma((-float3(u_xlat16_1.xyz)), u_xlat0.xxx, float3(1.0, 1.0, 1.0));
    u_xlat15 = max(u_xlat0.y, u_xlat0.x);
    u_xlat15 = max(u_xlat15, u_xlat0.z);
    u_xlatb3.xy = (float2(u_xlat15)==u_xlat0.zx);
    u_xlat1.xyz = (-u_xlat0.yzx) + u_xlat0.xyz;
    u_xlat4.xz = u_xlat1.zx;
    u_xlat1.w = 2.0;
    u_xlat4.y = float(4.0);
    u_xlat4.w = float(0.0);
    u_xlat8.xy = (u_xlatb3.y) ? u_xlat1.yw : u_xlat4.xy;
    u_xlat3.xy = (u_xlatb3.x) ? u_xlat4.zw : u_xlat8.xy;
    u_xlat0.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, u_xlat0.z);
    u_xlat0.x = (-u_xlat0.x) + u_xlat15;
    u_xlat5.x = u_xlat3.x / u_xlat0.x;
    u_xlat5.x = u_xlat5.x + u_xlat3.y;
    u_xlatb10 = u_xlat5.x<0.0;
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat5.x = fma(u_xlat5.x, 0.166666672, u_xlat10);
    u_xlat5.x = fma(FGlobals.booster_Env.x, float(FGlobals._DotStarHueSpeed), u_xlat5.x);
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat10 = u_xlat5.x * 6.0;
    u_xlat10 = floor(u_xlat10);
    u_xlatb3.x = u_xlat10<5.0;
    u_xlat5.x = fma(u_xlat5.x, 6.0, (-u_xlat10));
    u_xlatb1 = (float4(u_xlat10)<float4(1.0, 2.0, 3.0, 4.0));
    u_xlat10 = max(u_xlat15, 0.00100000005);
    u_xlat4.z = u_xlat15 + u_xlat15;
    u_xlat4.z = clamp(u_xlat4.z, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x / u_xlat10;
    u_xlat0.x = u_xlat0.x + float(FGlobals._DotStarAddedSaturation);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = fma(u_xlat0.x, u_xlat5.x, (-u_xlat0.x));
    u_xlat5.x = fma((-u_xlat0.x), u_xlat5.x, 1.0);
    u_xlat4.y = u_xlat5.x * u_xlat4.z;
    u_xlat5.x = u_xlat10 + 1.0;
    u_xlat4.w = u_xlat5.x * u_xlat4.z;
    u_xlat3.xz = (u_xlatb3.x) ? u_xlat4.wz : u_xlat4.zy;
    u_xlat4.x = fma((-u_xlat4.z), u_xlat0.x, u_xlat4.z);
    u_xlatb0 = u_xlat0.x==0.0;
    u_xlat3.y = u_xlat4.x;
    u_xlat5.xyz = (u_xlatb1.w) ? u_xlat4.xyz : u_xlat3.xyz;
    u_xlat5.xyz = (u_xlatb1.z) ? u_xlat4.xzw : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat4.yzx : u_xlat5.xyz;
    u_xlat5.xyz = (u_xlatb1.x) ? u_xlat4.zwx : u_xlat5.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat4.zzz : u_xlat5.xyz;
    u_xlat2.xyz = fma(u_xlat2.xzw, float3(u_xlat7), (-u_xlat0.xyz));
    u_xlatb15 = 0.0>=FGlobals._DotParams.w;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat0.xyz = fma(float3(u_xlat15), u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = input.TEXCOORD3.z;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat15);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
}
}
}
Fallback "Booster/Black"
}
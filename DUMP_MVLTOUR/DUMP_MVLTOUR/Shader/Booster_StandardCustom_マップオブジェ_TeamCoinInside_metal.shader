//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/マップオブジェ/TeamCoinInside" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_FixedAmbientColor ("固定環境光色", Color) = (1,1,1,1)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 17853
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
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
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
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
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
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
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
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
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
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
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat24) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_28), u_xlat16_6.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat24) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_28), u_xlat16_6.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * float3(u_xlat1);
    u_xlat8.xyz = fma(u_xlat8.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_9.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_9.xyz = u_xlat16_9.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * float3(u_xlat1);
    u_xlat8.xyz = fma(u_xlat8.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_9.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_9.xyz = u_xlat16_9.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * float3(u_xlat1);
    u_xlat8.xyz = fma(u_xlat8.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_9.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_9.xyz = u_xlat16_9.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * float3(u_xlat1);
    u_xlat8.xyz = fma(u_xlat8.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_9.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_9.xyz = u_xlat16_9.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    half u_xlat16_27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat31;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_27 = u_xlat16_2.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_27);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat4.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat28;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = fma(u_xlat4.xyz, (-float3(u_xlat28)), u_xlat1.xyz);
    u_xlat28 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat28) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_27 = half((-u_xlat31) + 1.0);
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_30 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_30) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_10), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    output.SV_Target0.xyz = fma(u_xlat16_3.xyz, u_xlat16_5.xyz, u_xlat16_0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    half u_xlat16_27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat31;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_27 = u_xlat16_2.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_27);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat4.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat28;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = fma(u_xlat4.xyz, (-float3(u_xlat28)), u_xlat1.xyz);
    u_xlat28 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat28) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_27 = half((-u_xlat31) + 1.0);
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_30 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_30) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_10), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_0.xyz = fma(u_xlat16_3.xyz, u_xlat16_5.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat28 = input.TEXCOORD4;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat28), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    half u_xlat16_30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_30 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_30)), (-u_xlat1.xyz)));
    u_xlat31 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat31 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat31 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat31 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat31 = sin(u_xlat31);
    u_xlat31 = u_xlat31 * FGlobals._NormalRand.w;
    u_xlat31 = fract(u_xlat31);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat31), float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb31 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_30 = (u_xlatb31) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_30)));
    u_xlat16_30 = u_xlat16_2.w + half(-1.0);
    u_xlat16_30 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_30, half(1.0));
    u_xlat16_30 = u_xlat16_30 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_30);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat31 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * input.TEXCOORD1.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat31;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = fma(u_xlat3.xyz, (-float3(u_xlat31)), u_xlat1.xyz);
    u_xlat31 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(float3(u_xlat31) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_30 = half((-u_xlat33) + 1.0);
    u_xlat16_11 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_30 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_35 = (-u_xlat16_30) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = u_xlat16_3.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = half3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_11), u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat22 = input.TEXCOORD4;
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat22), u_xlat1.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat22 = input.TEXCOORD4;
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat22), u_xlat1.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half u_xlat16_24;
    float u_xlat25;
    half u_xlat16_27;
    float u_xlat28;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_24 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_24)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_24 = u_xlat16_2.w + half(-1.0);
    u_xlat16_24 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_24, half(1.0));
    u_xlat16_24 = u_xlat16_24 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_24);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat4.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat25;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = fma(u_xlat4.xyz, (-float3(u_xlat25)), u_xlat1.xyz);
    u_xlat25 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_24 = half((-u_xlat28) + 1.0);
    u_xlat16_9 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_24) * u_xlat16_4.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_9), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_24 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_24) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat25) * float3(u_xlat16_3.xyz));
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_5.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    output.SV_Target0.xyz = fma(u_xlat16_5.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    half u_xlat16_30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_30 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_30)), (-u_xlat1.xyz)));
    u_xlat31 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat31 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat31 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat31 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat31 = sin(u_xlat31);
    u_xlat31 = u_xlat31 * FGlobals._NormalRand.w;
    u_xlat31 = fract(u_xlat31);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat31), float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb31 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_30 = (u_xlatb31) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_30)));
    u_xlat16_30 = u_xlat16_2.w + half(-1.0);
    u_xlat16_30 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_30, half(1.0));
    u_xlat16_30 = u_xlat16_30 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_30);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat31 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * input.TEXCOORD1.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat31;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = fma(u_xlat3.xyz, (-float3(u_xlat31)), u_xlat1.xyz);
    u_xlat31 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(float3(u_xlat31) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_30 = half((-u_xlat33) + 1.0);
    u_xlat16_11 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_30 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_35 = (-u_xlat16_30) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = u_xlat16_3.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = half3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_11), u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat31 = input.TEXCOORD4;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat31), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    half u_xlat16_27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat1.xyz)));
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat28 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat28), float3(u_xlat16_2.xyz));
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb28 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_27)));
    u_xlat16_27 = u_xlat16_2.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_27);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat28;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = fma(u_xlat3.xyz, (-float3(u_xlat28)), u_xlat1.xyz);
    u_xlat28 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = half((-u_xlat30) + 1.0);
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = u_xlat16_3.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_10), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat28) * float3(u_xlat16_5.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    half u_xlat16_28;
    half u_xlat16_30;
    float u_xlat31;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_28)), (-u_xlat0.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_28 = u_xlat16_2.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_28);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat4.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat27;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat4.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_28 = half((-u_xlat31) + 1.0);
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_30 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_28) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_30) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    output.SV_Target0.xyz = fma(u_xlat16_3.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_2;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    half u_xlat16_17;
    float u_xlat24;
    float u_xlat25;
    half u_xlat16_25;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2 = fma(u_xlat16_25, u_xlat16_25, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_2);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = fma((-u_xlat16_3), half(0.280000001), half(1.0));
    u_xlat16_17 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_17), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = float(u_xlat16_9) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_11.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_11.xyz = fma(half3(FGlobals._Metallic), u_xlat16_11.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_13.xyz = u_xlat16_4.xyz * u_xlat16_5.xxx;
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_11.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = fma(float3(u_xlat24), float3(u_xlat16_11.xyz), float3(u_xlat16_13.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_13.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat25) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_11.xyz = fma(half3(u_xlat16_29), u_xlat16_6.xyz, u_xlat16_11.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat24), float3(u_xlat16_5.xyz));
    u_xlat16_5.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_5.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_5.xyz));
    u_xlat16_5.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = half3(u_xlat16_3) * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_11.xyz), u_xlat1.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_2;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    half u_xlat16_17;
    float u_xlat24;
    float u_xlat25;
    half u_xlat16_25;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2 = fma(u_xlat16_25, u_xlat16_25, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_2);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = fma((-u_xlat16_3), half(0.280000001), half(1.0));
    u_xlat16_17 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_17), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = float(u_xlat16_9) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_11.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_11.xyz = fma(half3(FGlobals._Metallic), u_xlat16_11.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_13.xyz = u_xlat16_4.xyz * u_xlat16_5.xxx;
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_11.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = fma(float3(u_xlat24), float3(u_xlat16_11.xyz), float3(u_xlat16_13.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_13.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat25) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_11.xyz = fma(half3(u_xlat16_29), u_xlat16_6.xyz, u_xlat16_11.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat24), float3(u_xlat16_5.xyz));
    u_xlat16_5.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_5.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_5.xyz));
    u_xlat16_5.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = half3(u_xlat16_3) * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_11.xyz), u_xlat1.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half u_xlat16_24;
    float u_xlat25;
    half u_xlat16_27;
    float u_xlat28;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_24 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_24)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_24 = u_xlat16_2.w + half(-1.0);
    u_xlat16_24 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_24, half(1.0));
    u_xlat16_24 = u_xlat16_24 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_24);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat4.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat25;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = fma(u_xlat4.xyz, (-float3(u_xlat25)), u_xlat1.xyz);
    u_xlat25 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_24 = half((-u_xlat28) + 1.0);
    u_xlat16_9 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_24) * u_xlat16_4.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_9), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_24 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_24) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat25) * float3(u_xlat16_3.xyz));
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_5.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_0.xyz = fma(u_xlat16_5.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat25 = input.TEXCOORD4;
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat25), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    half u_xlat16_31;
    half u_xlat16_32;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat27 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat27 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat27 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb27 = u_xlat3.z<0.00499999989;
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_4.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = half(1.0);
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

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half u_xlat16_24;
    float u_xlat25;
    float u_xlat26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_24 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_24)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_3.xyz));
    u_xlat16_24 = u_xlat16_2.w + half(-1.0);
    u_xlat16_24 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_24, half(1.0));
    u_xlat16_24 = u_xlat16_24 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_24);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat25)), u_xlat1.xyz);
    u_xlat25 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat16_4.xyz = half3(float3(u_xlat25) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_24 = half((-u_xlat26) + 1.0);
    u_xlat16_9 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_9), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    output.SV_Target0.xyz = fma(u_xlat16_3.xyz, u_xlat16_4.xyz, u_xlat16_0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    half u_xlat16_27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat1.xyz)));
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat28 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat28), float3(u_xlat16_2.xyz));
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb28 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_27)));
    u_xlat16_27 = u_xlat16_2.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_27);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat28;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = fma(u_xlat3.xyz, (-float3(u_xlat28)), u_xlat1.xyz);
    u_xlat28 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = half((-u_xlat30) + 1.0);
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = u_xlat16_3.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_10), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat28) * float3(u_xlat16_5.xyz));
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat28 = input.TEXCOORD4;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat28), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    half u_xlat16_27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_30;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat1.xyz)));
    u_xlat28 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat2.z = u_xlat28 * float(u_xlat16_3.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_3.z);
    u_xlat2.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat4.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat28), float3(u_xlat16_3.xyz));
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb28 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? half(0.0) : half(u_xlat29);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_27)));
    u_xlat16_27 = u_xlat16_2.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_27);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat28;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat28)), u_xlat1.xyz);
    u_xlat28 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat28) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = half((-u_xlat29) + 1.0);
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_30 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_30) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_10), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_3.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_HeuristicReflection [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    float u_xlat24;
    half u_xlat16_25;
    half u_xlat16_27;
    float u_xlat28;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_25 = u_xlat16_25 + u_xlat16_25;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_25)), (-u_xlat0.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_25 = u_xlat16_2.w + half(-1.0);
    u_xlat16_25 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_25, half(1.0));
    u_xlat16_25 = u_xlat16_25 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_25);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat4.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat24;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat4.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_25 = half((-u_xlat28) + 1.0);
    u_xlat16_8 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_25 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_25) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_25 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_25) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat24) * float3(u_xlat16_3.xyz));
    u_xlat0.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    output.SV_Target0.xyz = fma(u_xlat16_5.xyz, u_xlat16_3.xyz, u_xlat16_1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    half u_xlat16_28;
    half u_xlat16_30;
    float u_xlat31;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_28)), (-u_xlat0.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_28 = u_xlat16_2.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_28);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat4.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat27;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat4.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_28 = half((-u_xlat31) + 1.0);
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_30 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_28) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_30) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD4;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half3 u_xlat16_13;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_5.x = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_13.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_2.xyz;
    u_xlat16_13.xyz = fma(half3(FGlobals._Metallic), u_xlat16_13.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = (-u_xlat16_13.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_13.xyz);
    u_xlat16_5.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_13.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat24) * float3(u_xlat16_6.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_2;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    half u_xlat16_17;
    float u_xlat24;
    float u_xlat25;
    half u_xlat16_25;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2 = fma(u_xlat16_25, u_xlat16_25, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_2);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = fma((-u_xlat16_3), half(0.280000001), half(1.0));
    u_xlat16_17 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_17), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = float(u_xlat16_9) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_11.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_11.xyz = fma(half3(FGlobals._Metallic), u_xlat16_11.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_13.xyz = u_xlat16_4.xyz * u_xlat16_5.xxx;
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_11.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = fma(float3(u_xlat24), float3(u_xlat16_11.xyz), float3(u_xlat16_13.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_13.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat25) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_11.xyz = fma(half3(u_xlat16_29), u_xlat16_6.xyz, u_xlat16_11.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat24), float3(u_xlat16_5.xyz));
    u_xlat16_5.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_5.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_5.xyz));
    u_xlat16_5.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = half3(u_xlat16_3) * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_11.xyz), u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_2;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    half u_xlat16_17;
    float u_xlat24;
    float u_xlat25;
    half u_xlat16_25;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2 = fma(u_xlat16_25, u_xlat16_25, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_2);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = fma((-u_xlat16_3), half(0.280000001), half(1.0));
    u_xlat16_17 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_17), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = float(u_xlat16_9) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_11.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_11.xyz = fma(half3(FGlobals._Metallic), u_xlat16_11.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_13.xyz = u_xlat16_4.xyz * u_xlat16_5.xxx;
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_11.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = fma(float3(u_xlat24), float3(u_xlat16_11.xyz), float3(u_xlat16_13.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_13.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat25) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_11.xyz = fma(half3(u_xlat16_29), u_xlat16_6.xyz, u_xlat16_11.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat24), float3(u_xlat16_5.xyz));
    u_xlat16_5.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_5.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_5.xyz));
    u_xlat16_5.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = half3(u_xlat16_3) * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_11.xyz), u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_HeuristicReflection [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half u_xlat16_8;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_21 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_21;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_21)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_3.xyz));
    u_xlat16_21 = u_xlat16_2.w + half(-1.0);
    u_xlat16_21 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_21, half(1.0));
    u_xlat16_21 = u_xlat16_21 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_21);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat23 = u_xlat22;
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat22)), u_xlat1.xyz);
    u_xlat22 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_21 = half((-u_xlat23) + 1.0);
    u_xlat16_8 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_8 = u_xlat16_21 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_21 * u_xlat16_8;
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_24 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_24 = u_xlat16_24 + half(1.0);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_4.xyz = fma(half3(FGlobals._Metallic), u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_6.xyz = half3(u_xlat16_24) + (-u_xlat16_4.xyz);
    u_xlat16_6.xyz = fma(half3(u_xlat16_8), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_21 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_21) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat22) * float3(u_xlat16_3.xyz));
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_4.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xyz)));
    output.SV_Target0.xyz = fma(u_xlat16_4.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    half u_xlat16_24;
    float u_xlat25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_24 = u_xlat16_24 + half(1.0);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat25), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = max(u_xlat25, 0.00100000005);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat25 = max(u_xlat25, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat25 = u_xlat25 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_24 = fma((-u_xlat16_24), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat25 = float(u_xlat16_10) / u_xlat25;
    u_xlat25 = u_xlat25 + -9.99999975e-05;
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlat25 = min(u_xlat25, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat25), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat25 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_27 = half((-u_xlat26) + 1.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_3.xyz = fma(half3(u_xlat16_27), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat25), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_24);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    half u_xlat16_24;
    float u_xlat25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_24 = u_xlat16_24 + half(1.0);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat25), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = max(u_xlat25, 0.00100000005);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat25 = max(u_xlat25, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat25 = u_xlat25 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_24 = fma((-u_xlat16_24), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat25 = float(u_xlat16_10) / u_xlat25;
    u_xlat25 = u_xlat25 + -9.99999975e-05;
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlat25 = min(u_xlat25, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat25), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat25 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_27 = half((-u_xlat26) + 1.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_3.xyz = fma(half3(u_xlat16_27), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat25), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_24);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    half u_xlat16_31;
    half u_xlat16_32;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat27 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat27 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat27 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb27 = u_xlat3.z<0.00499999989;
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD4;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half u_xlat16_24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_24 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_24)), (-u_xlat1.xyz)));
    u_xlat25 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb25 = u_xlat25<9.99999975e-06;
    u_xlat25 = (u_xlatb25) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat2.z = u_xlat25 * float(u_xlat16_3.x);
    u_xlat4.x = u_xlat25 * float(u_xlat16_3.z);
    u_xlat2.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat4.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat25 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * FGlobals._NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat25), float3(u_xlat16_3.xyz));
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb25 = u_xlat4.z<0.00499999989;
    u_xlat26 = u_xlat4.z * 8.29800034;
    u_xlat16_24 = (u_xlatb25) ? half(0.0) : half(u_xlat26);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_24)));
    u_xlat16_24 = u_xlat16_2.w + half(-1.0);
    u_xlat16_24 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_24, half(1.0));
    u_xlat16_24 = u_xlat16_24 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_24);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat25)), u_xlat1.xyz);
    u_xlat25 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_24 = half((-u_xlat26) + 1.0);
    u_xlat16_9 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_9), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_24 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_24) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat25) * float3(u_xlat16_3.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_5.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half u_xlat16_7;
    float u_xlat21;
    half u_xlat16_23;
    float u_xlat24;
    half u_xlat16_25;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_2.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(FGlobals._Occlusion);
    u_xlat21 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat3.xyz = float3(u_xlat21) * input.TEXCOORD1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat21;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat21)), u_xlat0.xyz);
    u_xlat21 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat16_4.xyz = half3(float3(u_xlat21) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_23 = half((-u_xlat24) + 1.0);
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_23 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_25 = (-u_xlat16_23) + FGlobals._Smoothness;
    u_xlat16_25 = u_xlat16_25 + half(1.0);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = u_xlat16_3.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_6.xyz = half3(u_xlat16_25) + (-u_xlat16_5.xyz);
    u_xlat16_6.xyz = fma(half3(u_xlat16_7), u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat0.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = half3(float3(u_xlat16_5.xyz) * u_xlat0.xxx);
    u_xlat16_5.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_23), u_xlat16_5.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_5.xyz, u_xlat16_4.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    half u_xlat16_8;
    half3 u_xlat16_10;
    half u_xlat16_15;
    float u_xlat21;
    half u_xlat16_22;
    half u_xlat16_26;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat21), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_22 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2.x = fma(u_xlat16_22, u_xlat16_22, half(1.5));
    u_xlat21 = u_xlat21 * float(u_xlat16_2.x);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_8 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_3.x = u_xlat16_22 * u_xlat16_8;
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.280000001), half(1.0));
    u_xlat16_15 = fma(u_xlat16_8, u_xlat16_8, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_15), 1.00001001);
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = float(u_xlat16_8) / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_10.xyz = fma(half3(FGlobals._Metallic), u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat4.xyz = float3(u_xlat21) * float3(u_xlat16_10.xyz);
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xxx), u_xlat4.xyz);
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_10.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_26 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_26 = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_26)), (-u_xlat0.xyz)));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat16_26 = half((-u_xlat0.x) + 1.0);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_10.xyz = fma(half3(u_xlat16_26), u_xlat16_5.xyz, u_xlat16_10.xyz);
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_6.xyz));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_10.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(u_xlat1.xyz, float3(u_xlat7), float3(u_xlat16_3.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    half u_xlat16_8;
    half3 u_xlat16_10;
    half u_xlat16_15;
    float u_xlat21;
    half u_xlat16_22;
    half u_xlat16_26;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat21), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_22 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2.x = fma(u_xlat16_22, u_xlat16_22, half(1.5));
    u_xlat21 = u_xlat21 * float(u_xlat16_2.x);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_8 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_3.x = u_xlat16_22 * u_xlat16_8;
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.280000001), half(1.0));
    u_xlat16_15 = fma(u_xlat16_8, u_xlat16_8, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_15), 1.00001001);
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = float(u_xlat16_8) / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_10.xyz = fma(half3(FGlobals._Metallic), u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat4.xyz = float3(u_xlat21) * float3(u_xlat16_10.xyz);
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xxx), u_xlat4.xyz);
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_10.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_26 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_26 = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_26)), (-u_xlat0.xyz)));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat16_26 = half((-u_xlat0.x) + 1.0);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_10.xyz = fma(half3(u_xlat16_26), u_xlat16_5.xyz, u_xlat16_10.xyz);
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_6.xyz));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_10.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(u_xlat1.xyz, float3(u_xlat7), float3(u_xlat16_3.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half u_xlat16_24;
    float u_xlat25;
    float u_xlat26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_24 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_24)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_3.xyz));
    u_xlat16_24 = u_xlat16_2.w + half(-1.0);
    u_xlat16_24 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_24, half(1.0));
    u_xlat16_24 = u_xlat16_24 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_24);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat25)), u_xlat1.xyz);
    u_xlat25 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat16_4.xyz = half3(float3(u_xlat25) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_24 = half((-u_xlat26) + 1.0);
    u_xlat16_9 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_9), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_3.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_0.xyz = fma(u_xlat16_3.xyz, u_xlat16_4.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat25 = input.TEXCOORD4;
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat25), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat22 = input.TEXCOORD4;
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat22), u_xlat1.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half u_xlat16_9;
    half u_xlat16_16;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_21 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_21 = u_xlat16_21 + half(1.0);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_21);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat22), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = max(u_xlat22, 0.00100000005);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat22 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat22 = max(u_xlat22, 0.319999993);
    u_xlat16_23 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_23, u_xlat16_23, half(1.5));
    u_xlat22 = u_xlat22 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_21 = u_xlat16_23 * u_xlat16_9;
    u_xlat16_21 = fma((-u_xlat16_21), half(0.280000001), half(1.0));
    u_xlat16_16 = fma(u_xlat16_9, u_xlat16_9, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_16), 1.00001001);
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat22 = float(u_xlat16_9) / u_xlat22;
    u_xlat22 = u_xlat22 + -9.99999975e-05;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat22 = min(u_xlat22, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat22), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat22 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat16_24 = half((-u_xlat23) + 1.0);
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.xyz = fma(half3(u_xlat16_24), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat22), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_21);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat22 = input.TEXCOORD4;
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat22), u_xlat1.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    half u_xlat16_27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_30;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat1.xyz)));
    u_xlat28 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb28 = u_xlat28<9.99999975e-06;
    u_xlat28 = (u_xlatb28) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat2.z = u_xlat28 * float(u_xlat16_3.x);
    u_xlat4.x = u_xlat28 * float(u_xlat16_3.z);
    u_xlat2.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat4.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat28 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * FGlobals._NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat28), float3(u_xlat16_3.xyz));
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb28 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? half(0.0) : half(u_xlat29);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_27)));
    u_xlat16_27 = u_xlat16_2.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_27);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat2.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat28;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat28)), u_xlat1.xyz);
    u_xlat28 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat28) * float3(FGlobals._LightColor0.xyz));
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = half((-u_xlat29) + 1.0);
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_30 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_30) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_10), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat28 = input.TEXCOORD4;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat28), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD4;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD4;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_HeuristicReflection [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    float u_xlat24;
    half u_xlat16_25;
    half u_xlat16_27;
    float u_xlat28;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_25 = u_xlat16_25 + u_xlat16_25;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_25)), (-u_xlat0.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_2.xyz));
    u_xlat16_25 = u_xlat16_2.w + half(-1.0);
    u_xlat16_25 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_25, half(1.0));
    u_xlat16_25 = u_xlat16_25 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_25);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat4.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat24;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat4.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_25 = half((-u_xlat28) + 1.0);
    u_xlat16_8 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_25 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_25) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_25 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_25) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat24) * float3(u_xlat16_3.xyz));
    u_xlat0.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_29;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_3 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat24 = u_xlat24 * float(u_xlat16_3);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = float(u_xlat16_10) / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_29 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_29);
    u_xlat2.xyz = fma(float3(u_xlat24), float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat26) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_5.xyz = fma(half3(u_xlat16_29), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_0 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half3 u_xlat16_13;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_5.x = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_13.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_2.xyz;
    u_xlat16_13.xyz = fma(half3(FGlobals._Metallic), u_xlat16_13.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = (-u_xlat16_13.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_13.xyz);
    u_xlat16_5.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_13.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat24) * float3(u_xlat16_6.xyz));
    u_xlat16_4.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_10.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_10.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_HeuristicReflection [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half u_xlat16_8;
    half u_xlat16_21;
    float u_xlat22;
    float u_xlat23;
    half u_xlat16_24;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat1.xyz = float3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_21 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_21;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_21)), (-u_xlat1.xyz)));
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_3.xyz));
    u_xlat16_21 = u_xlat16_2.w + half(-1.0);
    u_xlat16_21 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_21, half(1.0));
    u_xlat16_21 = u_xlat16_21 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_21);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat23 = u_xlat22;
    u_xlat23 = clamp(u_xlat23, 0.0f, 1.0f);
    u_xlat22 = u_xlat22 + u_xlat22;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat22)), u_xlat1.xyz);
    u_xlat22 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_21 = half((-u_xlat23) + 1.0);
    u_xlat16_8 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_8 = u_xlat16_21 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_21 * u_xlat16_8;
    u_xlat16_21 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_24 = (-u_xlat16_21) + FGlobals._Smoothness;
    u_xlat16_24 = u_xlat16_24 + half(1.0);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = half3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_4.xyz = fma(half3(FGlobals._Metallic), u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_6.xyz = half3(u_xlat16_24) + (-u_xlat16_4.xyz);
    u_xlat16_6.xyz = fma(half3(u_xlat16_8), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_21 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_21) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat22) * float3(u_xlat16_3.xyz));
    u_xlat1.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat1.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_4.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xyz)));
    u_xlat16_0.xyz = fma(u_xlat16_4.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat22 = input.TEXCOORD4;
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat22), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    half u_xlat16_24;
    float u_xlat25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_24 = u_xlat16_24 + half(1.0);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat25), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = max(u_xlat25, 0.00100000005);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat25 = max(u_xlat25, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat25 = u_xlat25 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_24 = fma((-u_xlat16_24), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat25 = float(u_xlat16_10) / u_xlat25;
    u_xlat25 = u_xlat25 + -9.99999975e-05;
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlat25 = min(u_xlat25, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat25), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat25 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_27 = half((-u_xlat26) + 1.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_3.xyz = fma(half3(u_xlat16_27), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat25), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_24);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat25 = input.TEXCOORD4;
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat25), u_xlat1.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_HeuristicReflection [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_18;
    half u_xlat16_24;
    float u_xlat25;
    float u_xlat26;
    half u_xlat16_26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_24 = u_xlat16_24 + half(1.0);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = fma(u_xlat1.xyz, float3(u_xlat25), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = max(u_xlat25, 0.00100000005);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat25 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat25 = max(u_xlat25, 0.319999993);
    u_xlat16_26 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_6 = fma(u_xlat16_26, u_xlat16_26, half(1.5));
    u_xlat25 = u_xlat25 * float(u_xlat16_6);
    u_xlat6.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * input.TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_24 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_24 = fma((-u_xlat16_24), half(0.280000001), half(1.0));
    u_xlat16_18 = fma(u_xlat16_10, u_xlat16_10, half(-1.0));
    u_xlat2.x = fma(u_xlat2.x, float(u_xlat16_18), 1.00001001);
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat25 = float(u_xlat16_10) / u_xlat25;
    u_xlat25 = u_xlat25 + -9.99999975e-05;
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlat25 = min(u_xlat25, 100.0);
    u_xlat2.xyz = fma(float3(u_xlat25), float3(u_xlat16_3.xyz), float3(u_xlat16_4.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat25 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat16_27 = half((-u_xlat26) + 1.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_3.xyz = fma(half3(u_xlat16_27), u_xlat16_5.xyz, u_xlat16_3.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat25), float3(u_xlat16_0.xyz));
    u_xlat16_0.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_0.xxx)), (-u_xlat1.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_0.xyz));
    u_xlat16_0.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_0.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_0.x, half(1.0));
    u_xlat16_0.x = u_xlat16_0.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(u_xlat16_24);
    u_xlat1.xyz = fma(float3(u_xlat16_0.xyz), float3(u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat25 = input.TEXCOORD4;
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat25), u_xlat1.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    half u_xlat16_24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_27;
    u_xlat16_0.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat1.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat1.xyz = float3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_24 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_3.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_24)), (-u_xlat1.xyz)));
    u_xlat25 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb25 = u_xlat25<9.99999975e-06;
    u_xlat25 = (u_xlatb25) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat2.z = u_xlat25 * float(u_xlat16_3.x);
    u_xlat4.x = u_xlat25 * float(u_xlat16_3.z);
    u_xlat2.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat4.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat25 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * FGlobals._NormalRand.w;
    u_xlat25 = fract(u_xlat25);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat25), float3(u_xlat16_3.xyz));
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb25 = u_xlat4.z<0.00499999989;
    u_xlat26 = u_xlat4.z * 8.29800034;
    u_xlat16_24 = (u_xlatb25) ? half(0.0) : half(u_xlat26);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_24)));
    u_xlat16_24 = u_xlat16_2.w + half(-1.0);
    u_xlat16_24 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_24, half(1.0));
    u_xlat16_24 = u_xlat16_24 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * half3(u_xlat16_24);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(FGlobals._Occlusion);
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat2.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat25;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = fma(u_xlat2.xyz, (-float3(u_xlat25)), u_xlat1.xyz);
    u_xlat25 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_24 = half((-u_xlat26) + 1.0);
    u_xlat16_9 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_24 * u_xlat16_9;
    u_xlat16_24 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_27 = (-u_xlat16_24) + FGlobals._Smoothness;
    u_xlat16_27 = u_xlat16_27 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_27) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_9), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = half3(fma(u_xlat1.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_24 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3(u_xlat16_24) * FGlobals._LightColor0.xyz;
    u_xlat16_3.xyz = half3(float3(u_xlat25) * float3(u_xlat16_3.xyz));
    u_xlat16_0.xyz = fma(u_xlat16_5.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat25 = input.TEXCOORD4;
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat25), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD4;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    half4 _FixedAmbientColor;
    float4 _NormalRand;
    half _NormalDiff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat33;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * float3(u_xlat1);
    u_xlat11.xyz = fma(u_xlat11.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_11.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_4.xyz * half3(u_xlat16_38);
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_38);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_9.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat1) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_6.xyz = fma(half3(u_xlat16_38), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat33 = input.TEXCOORD4;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_HeuristicReflection [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half u_xlat16_7;
    float u_xlat21;
    half u_xlat16_23;
    float u_xlat24;
    half u_xlat16_25;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat16_1 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_1.xyz));
    u_xlat16_2.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(FGlobals._Occlusion);
    u_xlat21 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat3.xyz = float3(u_xlat21) * input.TEXCOORD1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat21;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat21)), u_xlat0.xyz);
    u_xlat21 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat16_4.xyz = half3(float3(u_xlat21) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_23 = half((-u_xlat24) + 1.0);
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_23 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_25 = (-u_xlat16_23) + FGlobals._Smoothness;
    u_xlat16_25 = u_xlat16_25 + half(1.0);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_3.xyz = u_xlat16_3.xyz * FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_6.xyz = half3(u_xlat16_25) + (-u_xlat16_5.xyz);
    u_xlat16_6.xyz = fma(half3(u_xlat16_7), u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat0.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = half3(float3(u_xlat16_5.xyz) * u_xlat0.xxx);
    u_xlat16_5.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_23), u_xlat16_5.xyz);
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_4.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat21 = input.TEXCOORD4;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat21), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    half u_xlat16_8;
    half3 u_xlat16_10;
    half u_xlat16_15;
    float u_xlat21;
    half u_xlat16_22;
    half u_xlat16_26;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat21), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_22 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2.x = fma(u_xlat16_22, u_xlat16_22, half(1.5));
    u_xlat21 = u_xlat21 * float(u_xlat16_2.x);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_8 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_3.x = u_xlat16_22 * u_xlat16_8;
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.280000001), half(1.0));
    u_xlat16_15 = fma(u_xlat16_8, u_xlat16_8, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_15), 1.00001001);
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = float(u_xlat16_8) / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_10.xyz = fma(half3(FGlobals._Metallic), u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat4.xyz = float3(u_xlat21) * float3(u_xlat16_10.xyz);
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xxx), u_xlat4.xyz);
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_10.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_26 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_26 = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_26)), (-u_xlat0.xyz)));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat16_26 = half((-u_xlat0.x) + 1.0);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_10.xyz = fma(half3(u_xlat16_26), u_xlat16_5.xyz, u_xlat16_10.xyz);
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_6.xyz));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_10.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(u_xlat1.xyz, float3(u_xlat7), float3(u_xlat16_3.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat21 = input.TEXCOORD4;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_HeuristicReflection [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<half, access::sample > _HeuristicReflection [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    half u_xlat16_8;
    half3 u_xlat16_10;
    half u_xlat16_15;
    float u_xlat21;
    half u_xlat16_22;
    half u_xlat16_26;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(u_xlat21), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_22 = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_2.x = fma(u_xlat16_22, u_xlat16_22, half(1.5));
    u_xlat21 = u_xlat21 * float(u_xlat16_2.x);
    u_xlat2.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * input.TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_8 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_3.x = u_xlat16_22 * u_xlat16_8;
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.280000001), half(1.0));
    u_xlat16_15 = fma(u_xlat16_8, u_xlat16_8, half(-1.0));
    u_xlat1.x = fma(u_xlat1.x, float(u_xlat16_15), 1.00001001);
    u_xlat21 = u_xlat21 * u_xlat1.x;
    u_xlat21 = float(u_xlat16_8) / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_10.xyz = fma(half3(FGlobals._Metallic), u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat4.xyz = float3(u_xlat21) * float3(u_xlat16_10.xyz);
    u_xlat16_5.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xxx), u_xlat4.xyz);
    u_xlat16_5.x = (-u_xlat16_5.x) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_5.xyz = (-u_xlat16_10.xyz) + u_xlat16_5.xxx;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_26 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_26 = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_26)), (-u_xlat0.xyz)));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat16_26 = half((-u_xlat0.x) + 1.0);
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_10.xyz = fma(half3(u_xlat16_26), u_xlat16_5.xyz, u_xlat16_10.xyz);
    u_xlat16_2 = _HeuristicReflection.sample(sampler_HeuristicReflection, float3(u_xlat16_6.xyz));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_10.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = fma(u_xlat1.xyz, float3(u_xlat7), float3(u_xlat16_3.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat21 = input.TEXCOORD4;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
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
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 80299
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
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
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat12;
    half u_xlat16_14;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * input.TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat12)), u_xlat0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.xyz = half3(u_xlat0.xxx * float3(u_xlat16_3.xyz));
    u_xlat16_14 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_3.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_14), u_xlat16_3.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat12;
    half u_xlat16_14;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * input.TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat12)), u_xlat0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.xyz = half3(u_xlat0.xxx * float3(u_xlat16_3.xyz));
    u_xlat16_14 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_3.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_14), u_xlat16_3.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat12;
    half u_xlat16_14;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * input.TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat12)), u_xlat0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.xyz = half3(u_xlat0.xxx * float3(u_xlat16_3.xyz));
    u_xlat16_14 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_3.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_14), u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_2.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = input.TEXCOORD5;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat9);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = input.TEXCOORD5;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat9);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat12;
    half u_xlat16_14;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * input.TEXCOORD1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat12)), u_xlat0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.xyz = half3(u_xlat0.xxx * float3(u_xlat16_3.xyz));
    u_xlat16_14 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_3.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_14), u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_2.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = input.TEXCOORD5;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat9);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, half3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = input.TEXCOORD5;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat9);
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
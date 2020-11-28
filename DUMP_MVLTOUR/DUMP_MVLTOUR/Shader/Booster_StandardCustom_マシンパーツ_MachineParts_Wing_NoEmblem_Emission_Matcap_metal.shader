//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/マシンパーツ/MachineParts_Wing_NoEmblem_Emission_Matcap" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MinMSA ("Min MSA", Vector) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map(UV0)", 2D) = "black" { }
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_Emission ("Emission", Color) = (0,0,0,0)
_EmissionIntensity ("Emission Intensity", Range(0, 50)) = 1
_EmissionMap ("Emission map(UV0)", 2D) = "white" { }
_SphereMap ("SphereMap", 2D) = "black" { }
_SphereMapScale ("SphereMap Scale", Vector) = (1,1,1,1)
_AlphaFactor ("アルファ強度", Range(0, 1)) = 1
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 2
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 208447
Program "vp" {
SubProgram "metal hw_tier00 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.COLOR0 = input.COLOR0;
    output.COLOR0 = clamp(output.COLOR0, 0.0h, 1.0h);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.COLOR0 = input.COLOR0;
    output.COLOR0 = clamp(output.COLOR0, 0.0h, 1.0h);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.COLOR0 = input.COLOR0;
    output.COLOR0 = clamp(output.COLOR0, 0.0h, 1.0h);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    half TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.COLOR0 = input.COLOR0;
    output.COLOR0 = clamp(output.COLOR0, 0.0h, 1.0h);
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * input.POSITION0.yyy;
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    output.TEXCOORD0 = half(u_xlat0.x);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    half TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.COLOR0 = input.COLOR0;
    output.COLOR0 = clamp(output.COLOR0, 0.0h, 1.0h);
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * input.POSITION0.yyy;
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    output.TEXCOORD0 = half(u_xlat0.x);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    half TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.COLOR0 = input.COLOR0;
    output.COLOR0 = clamp(output.COLOR0, 0.0h, 1.0h);
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * input.POSITION0.yyy;
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    output.TEXCOORD0 = half(u_xlat0.x);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal hw_tier00 " {
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
struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
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
struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
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
struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" }
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
    half4 unity_FogColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    u_xlat16_0.xyz = input.COLOR0.xyz + (-FGlobals.unity_FogColor.xyz);
    output.SV_Target0.xyz = fma(input.TEXCOORD0, u_xlat16_0.xyz, FGlobals.unity_FogColor.xyz);
    output.SV_Target0.w = input.COLOR0.w;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" }
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
    half4 unity_FogColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    u_xlat16_0.xyz = input.COLOR0.xyz + (-FGlobals.unity_FogColor.xyz);
    output.SV_Target0.xyz = fma(input.TEXCOORD0, u_xlat16_0.xyz, FGlobals.unity_FogColor.xyz);
    output.SV_Target0.w = input.COLOR0.w;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" }
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
    half4 unity_FogColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    u_xlat16_0.xyz = input.COLOR0.xyz + (-FGlobals.unity_FogColor.xyz);
    output.SV_Target0.xyz = fma(input.TEXCOORD0, u_xlat16_0.xyz, FGlobals.unity_FogColor.xyz);
    output.SV_Target0.w = input.COLOR0.w;
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 15658
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _EmissionMap_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_13;
    half2 u_xlat16_24;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    bool u_xlatb34;
    half u_xlat16_35;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat3.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat34 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat34 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat4.xyz = float3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_35)));
    u_xlat16_35 = u_xlat16_4.w + half(-1.0);
    u_xlat16_35 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_35, half(1.0));
    u_xlat16_35 = u_xlat16_35 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_24.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_24.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_13.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_13.x = u_xlat16_13.x + half(1.0);
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0h, 1.0h);
    u_xlat16_13.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat33)), u_xlat0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat16_9.xyz = half3(float3(u_xlat33) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = half3(float3(u_xlat16_8.xyz) * u_xlat0.xxx);
    u_xlat16_7.xyz = fma(u_xlat16_7.xyz, u_xlat16_2.xxx, u_xlat16_10.xyz);
    u_xlat16_2.x = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_0.x;
    u_xlat16_2.xyz = fma(u_xlat16_0.xxx, u_xlat16_13.xyz, u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_7.xyz, u_xlat16_9.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_13;
    half2 u_xlat16_24;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    bool u_xlatb34;
    half u_xlat16_35;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat3.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat34 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat34 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat4.xyz = float3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_35)));
    u_xlat16_35 = u_xlat16_4.w + half(-1.0);
    u_xlat16_35 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_35, half(1.0));
    u_xlat16_35 = u_xlat16_35 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_24.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_24.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_13.x = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_13.x = u_xlat16_13.x + half(1.0);
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0h, 1.0h);
    u_xlat16_13.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat33)), u_xlat0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat16_9.xyz = half3(float3(u_xlat33) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = half3(float3(u_xlat16_8.xyz) * u_xlat0.xxx);
    u_xlat16_7.xyz = fma(u_xlat16_7.xyz, u_xlat16_2.xxx, u_xlat16_10.xyz);
    u_xlat16_2.x = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_0.x;
    u_xlat16_2.xyz = fma(u_xlat16_0.xxx, u_xlat16_13.xyz, u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_7.xyz, u_xlat16_9.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    float u_xlat20;
    half u_xlat16_23;
    float u_xlat30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_33;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_33 = half((-u_xlat1.x) + 1.0);
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat30 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb31 = u_xlat30<0.00499999989;
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_23 = half(u_xlat30 * u_xlat1.x);
    u_xlat30 = fma(u_xlat30, u_xlat30, 1.5);
    u_xlat16_23 = fma((-u_xlat16_23), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_23);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_11.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_11.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13.x = u_xlat16_13.x + half(1.0);
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat16_13.xyz = fma(half3(u_xlat16_33), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_13.xyz = u_xlat16_13.xyz * u_xlat16_6.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_3.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat10), float3(u_xlat16_13.xyz));
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    float u_xlat20;
    half u_xlat16_23;
    float u_xlat30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_33;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_33 = half((-u_xlat1.x) + 1.0);
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat30 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb31 = u_xlat30<0.00499999989;
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_23 = half(u_xlat30 * u_xlat1.x);
    u_xlat30 = fma(u_xlat30, u_xlat30, 1.5);
    u_xlat16_23 = fma((-u_xlat16_23), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_23);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_11.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_11.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13.x = u_xlat16_13.x + half(1.0);
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat16_13.xyz = fma(half3(u_xlat16_33), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_13.xyz = u_xlat16_13.xyz * u_xlat16_6.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_3.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat10), float3(u_xlat16_13.xyz));
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    float u_xlat20;
    half u_xlat16_23;
    float u_xlat30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_33;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_33 = half((-u_xlat1.x) + 1.0);
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat30 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb31 = u_xlat30<0.00499999989;
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_23 = half(u_xlat30 * u_xlat1.x);
    u_xlat30 = fma(u_xlat30, u_xlat30, 1.5);
    u_xlat16_23 = fma((-u_xlat16_23), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_23);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_11.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_11.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13.x = u_xlat16_13.x + half(1.0);
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat16_13.xyz = fma(half3(u_xlat16_33), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_13.xyz = u_xlat16_13.xyz * u_xlat16_6.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_3.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat10), float3(u_xlat16_13.xyz));
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_13;
    float u_xlat20;
    half u_xlat16_23;
    float u_xlat30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_33;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_33 = half((-u_xlat1.x) + 1.0);
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat30 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb31 = u_xlat30<0.00499999989;
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? half(0.0) : half(u_xlat32);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_23 = half(u_xlat30 * u_xlat1.x);
    u_xlat30 = fma(u_xlat30, u_xlat30, 1.5);
    u_xlat16_23 = fma((-u_xlat16_23), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_23);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_11.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_11.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13.x = u_xlat16_13.x + half(1.0);
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat16_13.xyz = fma(half3(u_xlat16_33), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_13.xyz = u_xlat16_13.xyz * u_xlat16_6.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_3.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat10), float3(u_xlat16_13.xyz));
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_13;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_33;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat2.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_33 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_33)));
    u_xlat16_33 = u_xlat16_4.w + half(-1.0);
    u_xlat16_33 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_33, half(1.0));
    u_xlat16_33 = u_xlat16_33 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_33);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_13 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat2.w = 1.0;
    u_xlat16_8.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_8.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_8.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_8.xyz = u_xlat16_8.xyz + input.TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.zzz * u_xlat16_0.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_13;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_33;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat2.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_33 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_33)));
    u_xlat16_33 = u_xlat16_4.w + half(-1.0);
    u_xlat16_33 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_33, half(1.0));
    u_xlat16_33 = u_xlat16_33 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_33);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_13 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat2.w = 1.0;
    u_xlat16_8.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_8.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_8.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_8.xyz = u_xlat16_8.xyz + input.TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.zzz * u_xlat16_0.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_13;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_33;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat2.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_33 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_33)));
    u_xlat16_33 = u_xlat16_4.w + half(-1.0);
    u_xlat16_33 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_33, half(1.0));
    u_xlat16_33 = u_xlat16_33 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_33);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_13 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat2.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD5.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_10.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_33 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_33 = clamp(u_xlat16_33, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_33) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_4.x = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = u_xlat16_4.xxx * FGlobals._LightColor0.xyz;
    u_xlat1.xyw = u_xlat1.xyw * float3(u_xlat16_4.xyw);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_4.x = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = u_xlat16_4.xxx * FGlobals._LightColor0.xyz;
    u_xlat1.xyw = u_xlat1.xyw * float3(u_xlat16_4.xyw);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_EmissionMap [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_13;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    bool u_xlatb34;
    half u_xlat16_35;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat3.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat34 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat34 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat4.xyz = float3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_35)));
    u_xlat16_35 = u_xlat16_4.w + half(-1.0);
    u_xlat16_35 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_35, half(1.0));
    u_xlat16_35 = u_xlat16_35 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_2.x = u_xlat16_13 + half(1.0);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_2.xyw = (-u_xlat16_8.xyz) + u_xlat16_2.xxx;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat33)), u_xlat0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat16_9.xyz = half3(float3(u_xlat33) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_39 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_8.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_2.xyw);
    u_xlat16_2.xyz = fma(u_xlat16_10.xyz, u_xlat16_9.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat23;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat2.xyz = fma(u_xlat1.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat34 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat34 = max(u_xlat34, 0.319999993);
    u_xlat16_2.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_2.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat13.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat34 = u_xlat34 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat2.x * u_xlat2.x;
    u_xlat23 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat23, 1.00001001);
    u_xlat1.x = u_xlat1.x * u_xlat34;
    u_xlat1.x = u_xlat12 / u_xlat1.x;
    u_xlat16_36 = half(u_xlat2.x * u_xlat12);
    u_xlat16_36 = fma((-u_xlat16_36), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_5.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_3.zzz * u_xlat16_10.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat34 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat34), float3(u_xlat16_7.xyz));
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat13.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_7.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat13.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat11.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat5.z = u_xlat11.x * float(u_xlat16_7.x);
    u_xlat6.x = u_xlat11.x * float(u_xlat16_7.z);
    u_xlat5.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat6.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat11.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat34 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_7.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat2.x<0.00499999989;
    u_xlat34 = u_xlat2.x * 8.29800034;
    u_xlat16_3.x = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_3.x)));
    u_xlat16_3.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_3.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_3.x, half(1.0));
    u_xlat16_3.x = u_xlat16_3.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.zzz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(u_xlat16_36);
    u_xlat0.xyz = fma(float3(u_xlat16_3.xyz), float3(u_xlat16_8.xyz), u_xlat1.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat23;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat2.xyz = fma(u_xlat1.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat34 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat34 = max(u_xlat34, 0.319999993);
    u_xlat16_2.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_2.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat13.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat34 = u_xlat34 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat2.x * u_xlat2.x;
    u_xlat23 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat23, 1.00001001);
    u_xlat1.x = u_xlat1.x * u_xlat34;
    u_xlat1.x = u_xlat12 / u_xlat1.x;
    u_xlat16_36 = half(u_xlat2.x * u_xlat12);
    u_xlat16_36 = fma((-u_xlat16_36), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_5.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_3.zzz * u_xlat16_10.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat34 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat34), float3(u_xlat16_7.xyz));
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat13.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_7.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat13.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat11.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat5.z = u_xlat11.x * float(u_xlat16_7.x);
    u_xlat6.x = u_xlat11.x * float(u_xlat16_7.z);
    u_xlat5.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat6.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat11.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat34 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_7.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat2.x<0.00499999989;
    u_xlat34 = u_xlat2.x * 8.29800034;
    u_xlat16_3.x = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_3.x)));
    u_xlat16_3.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_3.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_3.x, half(1.0));
    u_xlat16_3.x = u_xlat16_3.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.zzz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(u_xlat16_36);
    u_xlat0.xyz = fma(float3(u_xlat16_3.xyz), float3(u_xlat16_8.xyz), u_xlat1.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_13;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_33;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat2.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_33 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_33)));
    u_xlat16_33 = u_xlat16_4.w + half(-1.0);
    u_xlat16_33 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_33, half(1.0));
    u_xlat16_33 = u_xlat16_33 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_33);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_13 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat2.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD5.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_10.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_10.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_33 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_33 = clamp(u_xlat16_33, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_33) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_14;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    bool u_xlatb34;
    half u_xlat16_36;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat2.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat34 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat34 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat34 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat4.xyz = float3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_3.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_36 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_36)));
    u_xlat16_36 = u_xlat16_4.w + half(-1.0);
    u_xlat16_36 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_36, half(1.0));
    u_xlat16_36 = u_xlat16_36 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_36);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_14 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat33)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_39 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat16_6.x = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_6.x = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_6.x))));
    u_xlat16_0 = half4(u_xlat2.yzzx * u_xlat2.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_6.xxx, u_xlat16_8.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = half3(u_xlat1.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_10.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_8.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat5.xyw = u_xlat5.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat5.xyw = u_xlat5.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_4.x = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = u_xlat16_4.xxx * FGlobals._LightColor0.xyz;
    u_xlat1.xyw = u_xlat1.xyw * float3(u_xlat16_4.xyw);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat10;
    float u_xlat19;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    half u_xlat16_30;
    float u_xlat35;
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_2.xy)).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = fma(FGlobals._Color, u_xlat16_2, FGlobals._AddColor);
    u_xlat16_3.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    output.SV_Target0.w = u_xlat16_2.w * FGlobals._AlphaFactor;
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_0.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_30 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_4.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = (-u_xlat16_30) + u_xlat16_4.y;
    u_xlat16_30 = u_xlat16_30 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_30);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat8.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat35 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat35, 1.00001001);
    u_xlat35 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat35;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = half(u_xlat19 * u_xlat28);
    u_xlat16_30 = fma((-u_xlat16_30), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_5.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_4.x = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = u_xlat16_4.xxx * FGlobals._LightColor0.xyz;
    u_xlat1.xyw = u_xlat1.xyw * float3(u_xlat16_4.xyw);
    u_xlat35 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat35), float3(u_xlat16_7.xyz));
    u_xlat16_4.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyw = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_4.xxx)), (-u_xlat8.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_5.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_3.xyz = fma(u_xlat16_5.xxx, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_4.wxy, (-u_xlat16_4.xyw));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_4.w) : (-float(u_xlat16_4.w));
    u_xlat8.z = u_xlat0.x * float(u_xlat16_4.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_4.w);
    u_xlat8.xy = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.yw);
    u_xlat0.yz = (-float2(u_xlat16_4.xy)) * float2(u_xlat16_4.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat8.xyz;
    u_xlat8.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8.x = rsqrt(u_xlat8.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat8.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_4.xyw));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_4.x = (u_xlatb27) ? half(0.0) : half(u_xlat19);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_4.x)));
    u_xlat16_4.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyw = u_xlat16_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.zzz * u_xlat16_4.xyw;
    u_xlat16_4.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz), u_xlat1.xyw);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_EmissionMap [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_12;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_32;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_2.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_32 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_32)));
    u_xlat16_32 = u_xlat16_4.w + half(-1.0);
    u_xlat16_32 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_32, half(1.0));
    u_xlat16_32 = u_xlat16_32 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_32);
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_12 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_2.x = u_xlat16_12 + half(1.0);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_2.xyw = (-u_xlat16_8.xyz) + u_xlat16_2.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_8.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_2.xyw);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat30) * float3(u_xlat16_6.xyz));
    u_xlat16_2.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    bool u_xlatb10;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat22;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_31;
    float u_xlat32;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat3.xyz = fma(u_xlat2.xyz, u_xlat10.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat32 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat32 = max(u_xlat32, 0.319999993);
    u_xlat16_3.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_3.xyz, FGlobals._MinMSA.xyz);
    u_xlat3.x = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat13.x = fma(u_xlat3.x, u_xlat3.x, 1.5);
    u_xlat32 = u_xlat32 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_5.xyz));
    u_xlat13.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat3.x * u_xlat3.x;
    u_xlat22 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat2.x = fma(u_xlat2.x, u_xlat22, 1.00001001);
    u_xlat2.x = u_xlat2.x * u_xlat32;
    u_xlat2.x = u_xlat12 / u_xlat2.x;
    u_xlat16_31 = half(u_xlat3.x * u_xlat12);
    u_xlat16_31 = fma((-u_xlat16_31), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_5.xy = fma(u_xlat16_5.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_5.xy)).xyz;
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_5 = fma(FGlobals._Color, u_xlat16_5, FGlobals._AddColor);
    u_xlat16_8.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_5.xyz);
    output.SV_Target0.w = u_xlat16_5.w * FGlobals._AlphaFactor;
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_4.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_4.x = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = u_xlat16_4.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_4.x = u_xlat16_4.x + half(1.0);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = (-u_xlat16_9.xyz) + u_xlat16_4.xxx;
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat32 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat13.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat10.xyz)));
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat16_8.x = half((-u_xlat10.x) + 1.0);
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_4.xyw = fma(u_xlat16_8.xxx, u_xlat16_4.xyw, u_xlat16_9.xyz);
    u_xlat10.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb10 = u_xlat10.x<9.99999975e-06;
    u_xlat10.x = (u_xlatb10) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat6.z = u_xlat10.x * float(u_xlat16_1.x);
    u_xlat7.x = u_xlat10.x * float(u_xlat16_1.z);
    u_xlat6.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat7.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat10.xyz = u_xlat6.xyz + (-u_xlat7.xyz);
    u_xlat32 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat32 = rsqrt(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat10.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat3.x<0.00499999989;
    u_xlat32 = u_xlat3.x * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? half(0.0) : half(u_xlat32);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_31);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_4.xyw), u_xlat2.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    bool u_xlatb10;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat22;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_31;
    float u_xlat32;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat3.xyz = fma(u_xlat2.xyz, u_xlat10.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat32 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat32 = max(u_xlat32, 0.319999993);
    u_xlat16_3.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_3.xyz, FGlobals._MinMSA.xyz);
    u_xlat3.x = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat13.x = fma(u_xlat3.x, u_xlat3.x, 1.5);
    u_xlat32 = u_xlat32 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_5.xyz));
    u_xlat13.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat3.x * u_xlat3.x;
    u_xlat22 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat2.x = fma(u_xlat2.x, u_xlat22, 1.00001001);
    u_xlat2.x = u_xlat2.x * u_xlat32;
    u_xlat2.x = u_xlat12 / u_xlat2.x;
    u_xlat16_31 = half(u_xlat3.x * u_xlat12);
    u_xlat16_31 = fma((-u_xlat16_31), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_5.xy = fma(u_xlat16_5.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_5.xy)).xyz;
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_5 = fma(FGlobals._Color, u_xlat16_5, FGlobals._AddColor);
    u_xlat16_8.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_5.xyz);
    output.SV_Target0.w = u_xlat16_5.w * FGlobals._AlphaFactor;
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_4.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_4.x = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = u_xlat16_4.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_4.x = u_xlat16_4.x + half(1.0);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = (-u_xlat16_9.xyz) + u_xlat16_4.xxx;
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat32 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat13.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat10.xyz)));
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat16_8.x = half((-u_xlat10.x) + 1.0);
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_4.xyw = fma(u_xlat16_8.xxx, u_xlat16_4.xyw, u_xlat16_9.xyz);
    u_xlat10.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb10 = u_xlat10.x<9.99999975e-06;
    u_xlat10.x = (u_xlatb10) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat6.z = u_xlat10.x * float(u_xlat16_1.x);
    u_xlat7.x = u_xlat10.x * float(u_xlat16_1.z);
    u_xlat6.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat7.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat10.xyz = u_xlat6.xyz + (-u_xlat7.xyz);
    u_xlat32 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat32 = rsqrt(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat10.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat3.x<0.00499999989;
    u_xlat32 = u_xlat3.x * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? half(0.0) : half(u_xlat32);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_31);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_4.xyw), u_xlat2.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_13;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    bool u_xlatb34;
    half u_xlat16_35;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat3.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat34 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat34 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat4.xyz = float3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_35)));
    u_xlat16_35 = u_xlat16_4.w + half(-1.0);
    u_xlat16_35 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_35, half(1.0));
    u_xlat16_35 = u_xlat16_35 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_35);
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_2.x = u_xlat16_13 + half(1.0);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_2.xyw = (-u_xlat16_8.xyz) + u_xlat16_2.xxx;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat33)), u_xlat0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat16_9.xyz = half3(float3(u_xlat33) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_39 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_8.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_2.xyw);
    u_xlat16_2.xyz = fma(u_xlat16_10.xyz, u_xlat16_9.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_EmissionMap [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_11;
    half u_xlat16_13;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_33;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat2.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_33 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_33)));
    u_xlat16_33 = u_xlat16_4.w + half(-1.0);
    u_xlat16_33 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_33, half(1.0));
    u_xlat16_33 = u_xlat16_33 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_33);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_13 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat16_6.x = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_6.x = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_6.x))));
    u_xlat16_0 = half4(u_xlat2.yzzx * u_xlat2.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_6.xxx, u_xlat16_8.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat2.w = 1.0;
    u_xlat16_8.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_8.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_8.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat16_11.xyz = fma(u_xlat16_11.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_11.xyz);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_33 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_33 = clamp(u_xlat16_33, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_33) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(u_xlat1.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_3.x = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = u_xlat16_3.xxx * FGlobals._LightColor0.xyz;
    u_xlat5.xyw = float3(u_xlat16_3.xyw) * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_3.x = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = u_xlat16_3.xxx * FGlobals._LightColor0.xyz;
    u_xlat5.xyw = float3(u_xlat16_3.xyw) * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat23;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat2.xyz = fma(u_xlat1.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat34 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat34 = max(u_xlat34, 0.319999993);
    u_xlat16_2.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_2.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat13.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat34 = u_xlat34 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat2.x * u_xlat2.x;
    u_xlat23 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat23, 1.00001001);
    u_xlat1.x = u_xlat1.x * u_xlat34;
    u_xlat1.x = u_xlat12 / u_xlat1.x;
    u_xlat16_36 = half(u_xlat2.x * u_xlat12);
    u_xlat16_36 = fma((-u_xlat16_36), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_5.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_3.zzz * u_xlat16_10.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat34 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat34), float3(u_xlat16_7.xyz));
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat13.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_7.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat13.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat11.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat5.z = u_xlat11.x * float(u_xlat16_7.x);
    u_xlat6.x = u_xlat11.x * float(u_xlat16_7.z);
    u_xlat5.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat6.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat11.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat34 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_7.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat2.x<0.00499999989;
    u_xlat34 = u_xlat2.x * 8.29800034;
    u_xlat16_3.x = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_3.x)));
    u_xlat16_3.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_3.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_3.x, half(1.0));
    u_xlat16_3.x = u_xlat16_3.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.zzz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(u_xlat16_36);
    u_xlat0.xyz = fma(float3(u_xlat16_3.xyz), float3(u_xlat16_8.xyz), u_xlat1.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat23;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat2.xyz = fma(u_xlat1.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat34 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat34 = max(u_xlat34, 0.319999993);
    u_xlat16_2.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_2.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat13.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat34 = u_xlat34 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat5.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat13.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat2.x * u_xlat2.x;
    u_xlat23 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat23, 1.00001001);
    u_xlat1.x = u_xlat1.x * u_xlat34;
    u_xlat1.x = u_xlat12 / u_xlat1.x;
    u_xlat16_36 = half(u_xlat2.x * u_xlat12);
    u_xlat16_36 = fma((-u_xlat16_36), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat6.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat6.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat6.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_5.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_3.zzz * u_xlat16_10.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat34 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat34), float3(u_xlat16_7.xyz));
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat13.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_7.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat13.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat11.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat5.z = u_xlat11.x * float(u_xlat16_7.x);
    u_xlat6.x = u_xlat11.x * float(u_xlat16_7.z);
    u_xlat5.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat6.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat11.xyz = u_xlat5.xyz + (-u_xlat6.xyz);
    u_xlat34 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_7.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat2.x<0.00499999989;
    u_xlat34 = u_xlat2.x * 8.29800034;
    u_xlat16_3.x = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_3.x)));
    u_xlat16_3.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_3.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_3.x, half(1.0));
    u_xlat16_3.x = u_xlat16_3.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.zzz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(u_xlat16_36);
    u_xlat0.xyz = fma(float3(u_xlat16_3.xyz), float3(u_xlat16_8.xyz), u_xlat1.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_1.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_14;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    bool u_xlatb34;
    half u_xlat16_36;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat2.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat34 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb34 = u_xlat34<9.99999975e-06;
    u_xlat34 = (u_xlatb34) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat34 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat34 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat4.xyz = float3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_3.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_36 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_36)));
    u_xlat16_36 = u_xlat16_4.w + half(-1.0);
    u_xlat16_36 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_36, half(1.0));
    u_xlat16_36 = u_xlat16_36 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_36);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_14 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat33;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat33)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_39 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_39;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat16_6.x = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_6.x = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_6.x))));
    u_xlat16_0 = half4(u_xlat2.yzzx * u_xlat2.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_6.xxx, u_xlat16_8.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = half3(u_xlat1.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_10.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_8.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
    u_xlat16_1.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat34 = input.TEXCOORD6;
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat34), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat5.xyw = u_xlat5.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_EmissionMap [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat5.xyw = u_xlat5.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_EmissionMap [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_12;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_32;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat3.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_2.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_32 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_32)));
    u_xlat16_32 = u_xlat16_4.w + half(-1.0);
    u_xlat16_32 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_32, half(1.0));
    u_xlat16_32 = u_xlat16_32 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_32);
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_12 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_7.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_2.x = u_xlat16_12 + half(1.0);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_2.xyw = (-u_xlat16_8.xyz) + u_xlat16_2.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_8.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_2.xyw);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat30) * float3(u_xlat16_6.xyz));
    u_xlat16_2.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    bool u_xlatb10;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat22;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_31;
    float u_xlat32;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat3.xyz = fma(u_xlat2.xyz, u_xlat10.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat32 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat32 = max(u_xlat32, 0.319999993);
    u_xlat16_3.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_3.xyz, FGlobals._MinMSA.xyz);
    u_xlat3.x = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat13.x = fma(u_xlat3.x, u_xlat3.x, 1.5);
    u_xlat32 = u_xlat32 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_5.xyz));
    u_xlat13.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat3.x * u_xlat3.x;
    u_xlat22 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat2.x = fma(u_xlat2.x, u_xlat22, 1.00001001);
    u_xlat2.x = u_xlat2.x * u_xlat32;
    u_xlat2.x = u_xlat12 / u_xlat2.x;
    u_xlat16_31 = half(u_xlat3.x * u_xlat12);
    u_xlat16_31 = fma((-u_xlat16_31), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_5.xy = fma(u_xlat16_5.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_5.xy)).xyz;
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_5 = fma(FGlobals._Color, u_xlat16_5, FGlobals._AddColor);
    u_xlat16_8.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_5.xyz);
    output.SV_Target0.w = u_xlat16_5.w * FGlobals._AlphaFactor;
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_4.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_4.x = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = u_xlat16_4.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_4.x = u_xlat16_4.x + half(1.0);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = (-u_xlat16_9.xyz) + u_xlat16_4.xxx;
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat32 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat13.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat10.xyz)));
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat16_8.x = half((-u_xlat10.x) + 1.0);
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_4.xyw = fma(u_xlat16_8.xxx, u_xlat16_4.xyw, u_xlat16_9.xyz);
    u_xlat10.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb10 = u_xlat10.x<9.99999975e-06;
    u_xlat10.x = (u_xlatb10) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat6.z = u_xlat10.x * float(u_xlat16_1.x);
    u_xlat7.x = u_xlat10.x * float(u_xlat16_1.z);
    u_xlat6.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat7.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat10.xyz = u_xlat6.xyz + (-u_xlat7.xyz);
    u_xlat32 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat32 = rsqrt(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat10.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat3.x<0.00499999989;
    u_xlat32 = u_xlat3.x * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? half(0.0) : half(u_xlat32);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_31);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_4.xyw), u_xlat2.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    bool u_xlatb10;
    float u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half3 u_xlat16_13;
    float u_xlat22;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_31;
    float u_xlat32;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat3.xyz = fma(u_xlat2.xyz, u_xlat10.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat32 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat32 = max(u_xlat32, 0.319999993);
    u_xlat16_3.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_4.xyz = max(u_xlat16_3.xyz, FGlobals._MinMSA.xyz);
    u_xlat3.x = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat13.x = fma(u_xlat3.x, u_xlat3.x, 1.5);
    u_xlat32 = u_xlat32 * u_xlat13.x;
    u_xlat16_13.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = fma(u_xlat16_13.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_5.xyz));
    u_xlat6.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_5.xyz));
    u_xlat13.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13.x = rsqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat3.x * u_xlat3.x;
    u_xlat22 = fma(u_xlat12, u_xlat12, -1.0);
    u_xlat2.x = fma(u_xlat2.x, u_xlat22, 1.00001001);
    u_xlat2.x = u_xlat2.x * u_xlat32;
    u_xlat2.x = u_xlat12 / u_xlat2.x;
    u_xlat16_31 = half(u_xlat3.x * u_xlat12);
    u_xlat16_31 = fma((-u_xlat16_31), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_5.xy = fma(u_xlat16_5.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_5.xy)).xyz;
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_5 = fma(FGlobals._Color, u_xlat16_5, FGlobals._AddColor);
    u_xlat16_8.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_5.xyz);
    output.SV_Target0.w = u_xlat16_5.w * FGlobals._AlphaFactor;
    u_xlat16_9.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_4.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_4.x = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = u_xlat16_4.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_4.x = u_xlat16_4.x + half(1.0);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0h, 1.0h);
    u_xlat16_4.xyw = (-u_xlat16_9.xyz) + u_xlat16_4.xxx;
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_8.xyz));
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat32 = dot(u_xlat13.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat13.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat13.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat10.xyz)));
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat16_8.x = half((-u_xlat10.x) + 1.0);
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_4.xyw = fma(u_xlat16_8.xxx, u_xlat16_4.xyw, u_xlat16_9.xyz);
    u_xlat10.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb10 = u_xlat10.x<9.99999975e-06;
    u_xlat10.x = (u_xlatb10) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat6.z = u_xlat10.x * float(u_xlat16_1.x);
    u_xlat7.x = u_xlat10.x * float(u_xlat16_1.z);
    u_xlat6.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat7.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat10.xyz = u_xlat6.xyz + (-u_xlat7.xyz);
    u_xlat32 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat32 = rsqrt(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(u_xlat32);
    u_xlat10.xyz = u_xlat10.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat10.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlatb30 = u_xlat3.x<0.00499999989;
    u_xlat32 = u_xlat3.x * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? half(0.0) : half(u_xlat32);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_4.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_31);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_4.xyw), u_xlat2.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_EmissionMap [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_11;
    half u_xlat16_13;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    bool u_xlatb31;
    half u_xlat16_33;
    half u_xlat16_36;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat2.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat2.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat0.xyz)));
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb31 = u_xlat31<9.99999975e-06;
    u_xlat31 = (u_xlatb31) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat4.z = u_xlat31 * float(u_xlat16_3.x);
    u_xlat5.x = u_xlat31 * float(u_xlat16_3.z);
    u_xlat4.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat5.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat4.xyz = float3(u_xlat31) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_3.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat5.z = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_33 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_33)));
    u_xlat16_33 = u_xlat16_4.w + half(-1.0);
    u_xlat16_33 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_33, half(1.0));
    u_xlat16_33 = u_xlat16_33 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_33);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_3.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_3.x = u_xlat16_13 + half(1.0);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat30;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_36 * u_xlat16_0.x;
    u_xlat16_3.xyw = fma(u_xlat16_0.xxx, u_xlat16_3.xyw, u_xlat16_8.xyz);
    u_xlat16_3.xyw = u_xlat16_3.xyw * u_xlat16_6.xyz;
    u_xlat16_6.x = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_6.x = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_6.x))));
    u_xlat16_0 = half4(u_xlat2.yzzx * u_xlat2.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_6.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_6.xxx, u_xlat16_8.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat2.w = 1.0;
    u_xlat16_8.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_8.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_8.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_11.xyz = u_xlat16_11.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_11.xyz = exp2(u_xlat16_11.xyz);
    u_xlat16_11.xyz = fma(u_xlat16_11.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_11.xyz = max(u_xlat16_11.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_11.xyz);
    u_xlat16_6.xyz = u_xlat16_3.zzz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = fma(u_xlat16_6.xyz, u_xlat16_7.xyz, u_xlat16_3.xyw);
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_33 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_33 = clamp(u_xlat16_33, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_33) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(u_xlat1.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_3.xyz = fma(u_xlat16_9.xyz, u_xlat16_6.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_3.xyz);
    u_xlat16_1.xyz = u_xlat16_3.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat31 = input.TEXCOORD6;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat31), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_3.x = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = u_xlat16_3.xxx * FGlobals._LightColor0.xyz;
    u_xlat5.xyw = float3(u_xlat16_3.xyw) * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
    half4 _SphereMapScale;
    half _AlphaFactor;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
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
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_EmissionMap [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat16;
    float u_xlat27;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_35;
    float u_xlat38;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_2.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_2.x))));
    u_xlat16_3 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_4.x = dot(FGlobals.unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(FGlobals.unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(FGlobals.unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_4.xyz);
    u_xlat1.w = 1.0;
    u_xlat16_3.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_3.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_3.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = fma(u_xlat16_5.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = max(u_xlat16_5.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.zzz;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_0.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = fma(FGlobals._Color, u_xlat16_4, FGlobals._AddColor);
    u_xlat16_7.xyz = fma(u_xlat16_0.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    output.SV_Target0.w = u_xlat16_4.w * FGlobals._AlphaFactor;
    u_xlat16_35 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_8.xyz = half3(u_xlat16_35) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_3.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = (-u_xlat16_35) + u_xlat16_3.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_35);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat6.xyz = fma(u_xlat5.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat5.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat5.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0f, 1.0f);
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = fma(u_xlat38, u_xlat38, -1.0);
    u_xlat16 = fma(u_xlat16, u_xlat6.x, 1.00001001);
    u_xlat6.x = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_35 = half(u_xlat27 * u_xlat38);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = fma(u_xlat5.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_3.x = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyw = u_xlat16_3.xxx * FGlobals._LightColor0.xyz;
    u_xlat5.xyw = float3(u_xlat16_3.xyw) * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat5.xyw = fma(u_xlat5.xyw, u_xlat6.xxx, float3(u_xlat16_2.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_3.x = half((-u_xlat11.x) + 1.0);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.xyw = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat11.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
    u_xlat11.x = (u_xlatb11) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat6.z = u_xlat11.x * float(u_xlat16_2.x);
    u_xlat10.x = u_xlat11.x * float(u_xlat16_2.z);
    u_xlat6.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat10.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat6.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat6.xxx;
    u_xlat11.xyz = u_xlat11.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat11.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlatb33 = u_xlat27<0.00499999989;
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb33) ? half(0.0) : half(u_xlat27);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_2.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_2.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_2.x, half(1.0));
    u_xlat16_2.x = u_xlat16_2.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_3.zzz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_2.xyz), float3(u_xlat16_3.xyw), u_xlat5.xyw);
    u_xlat16_5.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = half3(fma(float3(u_xlat16_5.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 115386
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat2.xyz));
    u_xlat9 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.y = u_xlat2.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat2.y;
    output.TEXCOORD4.y = u_xlat2.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat2.xyz));
    u_xlat9 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.y = u_xlat2.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat2.y;
    output.TEXCOORD4.y = u_xlat2.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat2.xyz));
    u_xlat9 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.y = u_xlat2.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat2.y;
    output.TEXCOORD4.y = u_xlat2.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD8 [[ user(TEXCOORD8) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat12 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat12) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD8 [[ user(TEXCOORD8) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat12 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat12) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD8 [[ user(TEXCOORD8) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat0.x, float(u_xlat16_2));
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat12 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat12) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_SphereMap [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_10;
    half2 u_xlat16_12;
    float u_xlat18;
    half u_xlat16_20;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat3.xyz = float3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat18)), u_xlat0.xyz);
    u_xlat18 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat18) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_4.xy = max(u_xlat16_12.xy, FGlobals._MinMSA.xy);
    u_xlat0.y = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_10.xy = fma(u_xlat16_5.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_6.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_10.xy)).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, FGlobals._AddColor.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_6.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_10.xyz);
    u_xlat16_5.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(u_xlat16_4.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_20 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat0.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_4.xyz = fma(u_xlat16_10.xyz, half3(u_xlat16_20), u_xlat16_5.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    output.SV_Target0.w = half(0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_MSA [[ sampler (2) ]],
    sampler sampler_SphereMap [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half2 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    float u_xlat15;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat15), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat16_1.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_6.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat15 = u_xlat15 * float(u_xlat16_6.x);
    u_xlat16_6.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_7.xyz));
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_7.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_7.xyz);
    u_xlat16_4.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(u_xlat16_2.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_4.xyz);
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat5) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_MSA [[ sampler (2) ]],
    sampler sampler_SphereMap [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half2 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    float u_xlat15;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat15), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat16_1.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_6.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat15 = u_xlat15 * float(u_xlat16_6.x);
    u_xlat16_6.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_7.xyz));
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_7.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_7.xyz);
    u_xlat16_4.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(u_xlat16_2.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_4.xyz);
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat5) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD8 [[ user(TEXCOORD8) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_SphereMap [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_10;
    half2 u_xlat16_12;
    float u_xlat18;
    half u_xlat16_20;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat3.xyz = float3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat18)), u_xlat0.xyz);
    u_xlat18 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat18) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_4.xy = max(u_xlat16_12.xy, FGlobals._MinMSA.xy);
    u_xlat0.y = (-float(u_xlat16_4.y)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_10.xy = fma(u_xlat16_5.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_6.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_10.xy)).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals._Color.xyz, u_xlat16_1.xyz, FGlobals._AddColor.xyz);
    u_xlat16_10.xyz = fma(u_xlat16_6.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_10.xyz);
    u_xlat16_5.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(u_xlat16_4.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_20 = fma((-u_xlat16_4.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xyz = half3(u_xlat0.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_4.xyz = fma(u_xlat16_10.xyz, half3(u_xlat16_20), u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat0.x = input.TEXCOORD8;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_2.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD8 [[ user(TEXCOORD8) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_MSA [[ sampler (2) ]],
    sampler sampler_SphereMap [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half2 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    float u_xlat15;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat15), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat16_1.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_6.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat15 = u_xlat15 * float(u_xlat16_6.x);
    u_xlat16_6.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_7.xyz));
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_7.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_7.xyz);
    u_xlat16_4.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(u_xlat16_2.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_4.xyz);
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat5) * u_xlat0.xzw;
    u_xlat15 = input.TEXCOORD8;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat15);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD8 [[ user(TEXCOORD8) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_MSA [[ sampler (2) ]],
    sampler sampler_SphereMap [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half2 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    float u_xlat15;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat15), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat16_1.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_6.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat15 = u_xlat15 * float(u_xlat16_6.x);
    u_xlat16_6.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_7.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_7.xyz));
    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = dot(u_xlat6.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_10), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_7.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_7.xyz);
    u_xlat16_4.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(u_xlat16_2.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_4.xyz);
    u_xlat0.xzw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat5) * u_xlat0.xzw;
    u_xlat15 = input.TEXCOORD8;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat15);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
}
}
}
Fallback "Booster/Black"
}
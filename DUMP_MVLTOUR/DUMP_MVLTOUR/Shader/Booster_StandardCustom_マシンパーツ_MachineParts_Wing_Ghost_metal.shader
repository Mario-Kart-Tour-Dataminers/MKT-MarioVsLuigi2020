//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/マシンパーツ/MachineParts_Wing_Ghost" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MinMSA ("Min MSA", Vector) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map", 2D) = "black" { }
_NumberTex ("Number Map", 2D) = "black" { }
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_Decal ("Decal(UV1)", 2D) = "black" { }
_AlphaFactor ("アルファ強度", Range(0, 1)) = 1
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 2
}
SubShader {
 LOD 2500
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 2500
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 405055
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
  LOD 2500
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 874
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat0.x, float(u_xlat16_2));
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
}
Program "fp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    output.SV_Target0.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    output.SV_Target0.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    output.SV_Target0.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_26), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_26), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_26), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb9;
    int u_xlati19;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_32;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat27, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati19 = 0x1;
    while(true){
        u_xlatb28 = u_xlati19>=u_xlati27;
        if(u_xlatb28){break;}
        u_xlat28 = float(u_xlati19);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = FGlobals._WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = fma(u_xlat29, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat28, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat27), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_32 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_32 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_32))));
    u_xlat16_8.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_32), u_xlat16_8.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_32 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_32 = max(u_xlat16_32, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_32), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb9;
    int u_xlati19;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_32;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat27, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati19 = 0x1;
    while(true){
        u_xlatb28 = u_xlati19>=u_xlati27;
        if(u_xlatb28){break;}
        u_xlat28 = float(u_xlati19);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = FGlobals._WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = fma(u_xlat29, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat28, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat27), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_32 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_32 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_32))));
    u_xlat16_8.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_32), u_xlat16_8.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_32 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_32 = max(u_xlat16_32, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_32), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb9;
    int u_xlati19;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_32;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat27, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati19 = 0x1;
    while(true){
        u_xlatb28 = u_xlati19>=u_xlati27;
        if(u_xlatb28){break;}
        u_xlat28 = float(u_xlati19);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = FGlobals._WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = fma(u_xlat29, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat28, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat27), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_32 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_32 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_32))));
    u_xlat16_8.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_32), u_xlat16_8.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_32 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_32 = max(u_xlat16_32, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_32), u_xlat16_5.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(u_xlat16_26), (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(u_xlat16_26), (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(u_xlat16_26), (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_26), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_26), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_26), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    half3 u_xlat16_9;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat1.x = input.TEXCOORD4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_9.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    half3 u_xlat16_9;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat1.x = input.TEXCOORD4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_9.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    half3 u_xlat16_9;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_7.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat1.x = input.TEXCOORD4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_9.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_29 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_29 = max(u_xlat16_29, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_29), u_xlat16_5.xyz);
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_8.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb9;
    half3 u_xlat16_10;
    int u_xlati19;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_32;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat27, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati19 = 0x1;
    while(true){
        u_xlatb28 = u_xlati19>=u_xlati27;
        if(u_xlatb28){break;}
        u_xlat28 = float(u_xlati19);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = FGlobals._WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = fma(u_xlat29, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat28, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat27), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_32 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_32 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_32))));
    u_xlat16_8.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_32), u_xlat16_8.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_32 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_32 = max(u_xlat16_32, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_32), u_xlat16_5.xyz);
    u_xlat1.x = input.TEXCOORD4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_10.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_10.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb9;
    half3 u_xlat16_10;
    int u_xlati19;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_32;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat27, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati19 = 0x1;
    while(true){
        u_xlatb28 = u_xlati19>=u_xlati27;
        if(u_xlatb28){break;}
        u_xlat28 = float(u_xlati19);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = FGlobals._WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = fma(u_xlat29, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat28, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat27), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_32 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_32 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_32))));
    u_xlat16_8.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_32), u_xlat16_8.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_32 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_32 = max(u_xlat16_32, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_32), u_xlat16_5.xyz);
    u_xlat1.x = input.TEXCOORD4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_10.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_10.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    bool u_xlatb9;
    half3 u_xlat16_10;
    int u_xlati19;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    bool u_xlatb28;
    float u_xlat29;
    half u_xlat16_32;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb9 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb9) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat27 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat27 = fract(u_xlat27);
    u_xlat27 = u_xlat27 * 10.0;
    u_xlat27 = floor(u_xlat27);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat27, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb27 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati27 = (u_xlatb27) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati19 = 0x1;
    while(true){
        u_xlatb28 = u_xlati19>=u_xlati27;
        if(u_xlatb28){break;}
        u_xlat28 = float(u_xlati19);
        u_xlat29 = u_xlat28 * 3.32192802;
        u_xlat29 = exp2(u_xlat29);
        u_xlat29 = FGlobals._WingExtraParam.x / u_xlat29;
        u_xlat29 = fract(u_xlat29);
        u_xlat29 = u_xlat29 * 10.0;
        u_xlat29 = floor(u_xlat29);
        u_xlat4.y = fma(u_xlat29, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat28, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat27 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat27 = (u_xlatb1.x) ? 0.0 : u_xlat27;
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat27), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_8.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_8.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_8.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_32 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_32 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_32))));
    u_xlat16_8.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_32), u_xlat16_8.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_32 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_32 = max(u_xlat16_32, half(0.0));
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_32), u_xlat16_5.xyz);
    u_xlat1.x = input.TEXCOORD4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_10.xyz = u_xlat16_5.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat1.xyz = fma(u_xlat1.xxx, float3(u_xlat16_10.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat1.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  LOD 2500
  Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 120550
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_2));
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
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    output.SV_Target0.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    output.SV_Target0.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    output.SV_Target0.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_5.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_5.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
    half4 _WorldSpaceLightPos0;
    half4 _LightColor0;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    half u_xlat16_26;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_26 = dot(input.TEXCOORD1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_26 = max(u_xlat16_26, half(0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_5.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
}
}
 Pass {
  Name "PREPASS"
  LOD 2500
  Tags { "LIGHTMODE" = "PREPASSBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 168861
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
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
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
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
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
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
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
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
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0.xyz = half3(fma(input.TEXCOORD0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5)));
    output.SV_Target0.w = half(0.0);
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
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0.xyz = half3(fma(input.TEXCOORD0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5)));
    output.SV_Target0.w = half(0.0);
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
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0.xyz = half3(fma(input.TEXCOORD0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5)));
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
}
}
 Pass {
  Name "PREPASS"
  LOD 2500
  Tags { "LIGHTMODE" = "PREPASSFINAL" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 223676
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
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
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
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
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
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
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
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
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
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat1.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat1.x * VGlobals._ProjectionParams.z;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma(u_xlat1.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_2.x = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat1.x, float(u_xlat16_2.x));
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat0.zw;
    output.TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2.x))));
    u_xlat16_1 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = fma(VGlobals.unity_SHC.xyz, u_xlat16_2.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_3.x = half(dot(float4(VGlobals.unity_SHAr), u_xlat0));
    u_xlat16_3.y = half(dot(float4(VGlobals.unity_SHAg), u_xlat0));
    u_xlat16_3.z = half(dot(float4(VGlobals.unity_SHAb), u_xlat0));
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(float3(u_xlat16_2.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
    float4 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    u_xlat0.x = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_3));
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD2.zw = u_xlat2.zw;
    output.TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat4 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat4 * (-u_xlat0.x);
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
struct FGlobals_Type
{
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
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
struct FGlobals_Type
{
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
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
struct FGlobals_Type
{
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_5.xyz));
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(0.699999988);
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    sampler sampler_LightBuffer [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat0.xyz = (-float3(u_xlat16_6.xyz)) + input.TEXCOORD4.xyz;
    u_xlat21 = input.TEXCOORD5;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), u_xlat0.xyz, (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    sampler sampler_LightBuffer [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > _LightBuffer [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xy = input.TEXCOORD2.xy / input.TEXCOORD2.ww;
    u_xlat16_0.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = max(u_xlat16_0.xyz, half3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_0.xyz, (-u_xlat16_6.xyz));
    u_xlat0.x = input.TEXCOORD5;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.699999988);
    return output;
}
"
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 2500
  Tags { "LIGHTMODE" = "DEFERRED" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 305365
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_2 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_2))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_2), u_xlat16_3.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _Decal_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat9;
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
    output.TEXCOORD0.zw = fma(input.TEXCOORD1.xy, VGlobals._Decal_ST.xy, VGlobals._Decal_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-VGlobals.unity_ShadowFadeCenterAndType.xyz);
    output.TEXCOORD4.xyz = u_xlat0.xyz * VGlobals.unity_ShadowFadeCenterAndType.www;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat1.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat1.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat1.w, u_xlat0.x);
    u_xlat3 = (-VGlobals.unity_ShadowFadeCenterAndType.w) + 1.0;
    output.TEXCOORD4.w = u_xlat3 * (-u_xlat0.x);
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
struct FGlobals_Type
{
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3 = half4(1.0, 1.0, 1.0, 1.0);
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
struct FGlobals_Type
{
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3 = half4(1.0, 1.0, 1.0, 1.0);
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
struct FGlobals_Type
{
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    output.SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3 = half4(1.0, 1.0, 1.0, 1.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_ProbesOcclusion;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = FGlobals.unity_ProbesOcclusion;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_ProbesOcclusion;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = FGlobals.unity_ProbesOcclusion;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_ProbesOcclusion;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_NumberTex [[ sampler (0) ]],
    sampler sampler_Decal [[ sampler (1) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_6.xyz = u_xlat16_6.xyz + input.TEXCOORD4.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = FGlobals.unity_ProbesOcclusion;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler sampler_NumberTex [[ sampler (1) ]],
    sampler sampler_Decal [[ sampler (2) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.w = 1.0;
    output.SV_Target2 = half4(u_xlat0);
    output.SV_Target3.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD3.xy);
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat1.w = 1.0;
    output.SV_Target2 = half4(u_xlat1);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD3.xy);
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat1.w = 1.0;
    output.SV_Target2 = half4(u_xlat1);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
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
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    bool u_xlatb7;
    int u_xlati15;
    float u_xlat21;
    int u_xlati21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb7 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb7) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat21 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 10.0;
    u_xlat21 = floor(u_xlat21);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat21, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb21 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati21 = (u_xlatb21) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati15 = 0x1;
    while(true){
        u_xlatb22 = u_xlati15>=u_xlati21;
        if(u_xlatb22){break;}
        u_xlat22 = float(u_xlati15);
        u_xlat23 = u_xlat22 * 3.32192802;
        u_xlat23 = exp2(u_xlat23);
        u_xlat23 = FGlobals._WingExtraParam.x / u_xlat23;
        u_xlat23 = fract(u_xlat23);
        u_xlat23 = u_xlat23 * 10.0;
        u_xlat23 = floor(u_xlat23);
        u_xlat4.y = fma(u_xlat23, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat22, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati15 = u_xlati15 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat21 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat21 = (u_xlatb1.x) ? 0.0 : u_xlat21;
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat21), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD3.xy);
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat1.w = 1.0;
    output.SV_Target2 = half4(u_xlat1);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD3.xy);
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat1.w = 1.0;
    output.SV_Target2 = half4(u_xlat1);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD3.xy);
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat1.w = 1.0;
    output.SV_Target2 = half4(u_xlat1);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_Lightmap_HDR;
    half4 _Color;
    half4 booster_PowerSavingAdjustColor;
    half4 _AddColor;
    float4 _WingExtraParam;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    half4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    half4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    half4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
    half4 SV_Target4 [[ color(xlt_remap_o[4]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler sampler_NumberTex [[ sampler (2) ]],
    sampler sampler_Decal [[ sampler (3) ]],
    texture2d<half, access::sample > _NumberTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Decal [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    bool2 u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    bool u_xlatb8;
    int u_xlati17;
    float u_xlat24;
    int u_xlati24;
    bool u_xlatb24;
    float u_xlat25;
    bool u_xlatb25;
    float u_xlat26;
    half u_xlat16_29;
    u_xlatb0 = (input.TEXCOORD0.xxyy>=float4(0.629999995, 0.649999976, 0.629999995, 0.649999976));
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.zx));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlatb8 = u_xlatb0.y || u_xlatb0.w;
    u_xlat0.y = (u_xlatb8) ? 0.0 : u_xlat0.x;
    u_xlat0.x = float(1.5);
    u_xlat0.z = float(1.5);
    u_xlat24 = FGlobals._WingExtraParam.x + 9.99999975e-06;
    u_xlat24 = fract(u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
    u_xlat24 = floor(u_xlat24);
    u_xlat1.xyz = fma(input.TEXCOORD0.yxx, float3(0.300000012, 0.300000012, 0.300000012), float3(-0.170000002, -0.159999996, -0.165000007));
    u_xlat1.w = fma(u_xlat24, 0.100000001, u_xlat1.x);
    u_xlat16_2.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat1.zw).xyz;
    u_xlatb24 = 100.0<FGlobals._WingExtraParam.x;
    u_xlati24 = (u_xlatb24) ? 0x4 : 0x3;
    u_xlat3.xyz = float3(u_xlat16_2.xyz);
    u_xlati17 = 0x1;
    while(true){
        u_xlatb25 = u_xlati17>=u_xlati24;
        if(u_xlatb25){break;}
        u_xlat25 = float(u_xlati17);
        u_xlat26 = u_xlat25 * 3.32192802;
        u_xlat26 = exp2(u_xlat26);
        u_xlat26 = FGlobals._WingExtraParam.x / u_xlat26;
        u_xlat26 = fract(u_xlat26);
        u_xlat26 = u_xlat26 * 10.0;
        u_xlat26 = floor(u_xlat26);
        u_xlat4.y = fma(u_xlat26, 0.100000001, u_xlat1.x);
        u_xlat4.x = fma(u_xlat25, 0.0450000018, u_xlat1.y);
        u_xlat16_4.xyz = _NumberTex.sample(sampler_NumberTex, u_xlat4.xy).xyz;
        u_xlat3.xyz = u_xlat3.xyz + float3(u_xlat16_4.xyz);
        u_xlati17 = u_xlati17 + 0x1;
    }
    u_xlat0.xyz = fma(float3(0.0, 1.5, 0.0), u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xyz = fma(u_xlat3.xyz, float3(0.5, 0.5, 0.5), u_xlat0.xyz);
    u_xlatb1.xy = (input.TEXCOORD0.yy>=float2(0.879999995, 0.600000024));
    u_xlat24 = u_xlatb1.y ? 1.0 : float(0.0);
    u_xlat24 = (u_xlatb1.x) ? 0.0 : u_xlat24;
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_2 = _Decal.sample(sampler_Decal, input.TEXCOORD0.zw);
    u_xlat16_2 = fma(u_xlat16_2, FGlobals._Color, FGlobals._AddColor);
    u_xlat16_5.xyz = half3(fma((-u_xlat0.xyz), float3(u_xlat24), float3(u_xlat16_2.xyz)));
    u_xlat16_5.xyz = half3(fma(float3(u_xlat16_2.www), float3(u_xlat16_5.xyz), u_xlat1.xyz));
    u_xlat16_6.xyz = (-FGlobals.booster_PowerSavingAdjustColor.xyz) + half3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_6.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_6.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_0 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_29 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_29 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_29))));
    u_xlat16_7.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_29), u_xlat16_7.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD3.xy);
    output.SV_Target3.xyz = exp2((-u_xlat16_6.xyz));
    output.SV_Target0.xyz = u_xlat16_5.xyz;
    output.SV_Target0.w = half(1.0);
    output.SV_Target1 = half4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat1.w = 1.0;
    output.SV_Target2 = half4(u_xlat1);
    output.SV_Target3.w = half(1.0);
    output.SV_Target4 = u_xlat16_0;
    return output;
}
"
}
}
}
}
Fallback "Booster/Black"
}
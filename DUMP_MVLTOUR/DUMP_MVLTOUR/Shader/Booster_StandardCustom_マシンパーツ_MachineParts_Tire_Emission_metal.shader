//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/マシンパーツ/MachineParts_Tire_Emission" {
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
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 128
}
SubShader {
 Tags { "DisableBatching" = "true" "RenderType" = "MachineParts_Tire" }
 Pass {
  Name "ShadowCaster"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "SHADOWSUPPORT" = "true" }
  GpuProgramID 63849
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD1 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    u_xlat0.xy = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yx;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xy;
    u_xlat3.y = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat2.y = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xy;
    u_xlat3.z = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat2.z = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xy;
    u_xlat3.w = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat2.w = fma(u_xlat0.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yx;
    u_xlat4.x = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat5.x = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xy;
    u_xlat4.y = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat5.y = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xy;
    u_xlat4.z = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat5.z = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xy;
    u_xlat4.w = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat5.w = fma(u_xlat1.x, u_xlat0.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat5);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat5);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].z;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].z;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].z;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].z;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].z;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].z;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].z;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].z;
    u_xlat2 = fma(u_xlat3, u_xlat1.zzzz, u_xlat2);
    u_xlat3.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].z;
    u_xlat4.x = (-u_xlat3.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].z;
    u_xlat3.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].z;
    u_xlat4.y = (-u_xlat3.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].z;
    u_xlat3.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].z;
    u_xlat4.z = (-u_xlat3.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].z;
    u_xlat3.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].z;
    u_xlat4.w = (-u_xlat3.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].z;
    u_xlat3 = fma(u_xlat1.xxxx, u_xlat4, u_xlat3);
    u_xlat2 = u_xlat2 + (-u_xlat3);
    u_xlat1 = fma(u_xlat2, u_xlat1.yyyy, u_xlat3);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.xxxx, u_xlat0);
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
Keywords { "SHADOWS_DEPTH" }
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD1 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    u_xlat0.xy = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yx;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xy;
    u_xlat3.y = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat2.y = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xy;
    u_xlat3.z = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat2.z = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xy;
    u_xlat3.w = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat2.w = fma(u_xlat0.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yx;
    u_xlat4.x = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat5.x = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xy;
    u_xlat4.y = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat5.y = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xy;
    u_xlat4.z = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat5.z = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xy;
    u_xlat4.w = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat5.w = fma(u_xlat1.x, u_xlat0.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat5);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat5);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].z;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].z;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].z;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].z;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].z;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].z;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].z;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].z;
    u_xlat2 = fma(u_xlat3, u_xlat1.zzzz, u_xlat2);
    u_xlat3.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].z;
    u_xlat4.x = (-u_xlat3.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].z;
    u_xlat3.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].z;
    u_xlat4.y = (-u_xlat3.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].z;
    u_xlat3.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].z;
    u_xlat4.z = (-u_xlat3.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].z;
    u_xlat3.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].z;
    u_xlat4.w = (-u_xlat3.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].z;
    u_xlat3 = fma(u_xlat1.xxxx, u_xlat4, u_xlat3);
    u_xlat2 = u_xlat2 + (-u_xlat3);
    u_xlat1 = fma(u_xlat2, u_xlat1.yyyy, u_xlat3);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.xxxx, u_xlat0);
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
Keywords { "SHADOWS_DEPTH" }
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD1 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    u_xlat0.xy = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yx;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xy;
    u_xlat3.y = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat2.y = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xy;
    u_xlat3.z = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat2.z = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xy;
    u_xlat3.w = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat2.w = fma(u_xlat0.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yx;
    u_xlat4.x = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat5.x = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xy;
    u_xlat4.y = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat5.y = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xy;
    u_xlat4.z = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat5.z = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xy;
    u_xlat4.w = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat5.w = fma(u_xlat1.x, u_xlat0.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat5);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat5);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].z;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].z;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].z;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].z;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].z;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].z;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].z;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].z;
    u_xlat2 = fma(u_xlat3, u_xlat1.zzzz, u_xlat2);
    u_xlat3.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].z;
    u_xlat4.x = (-u_xlat3.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].z;
    u_xlat3.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].z;
    u_xlat4.y = (-u_xlat3.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].z;
    u_xlat3.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].z;
    u_xlat4.z = (-u_xlat3.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].z;
    u_xlat3.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].z;
    u_xlat4.w = (-u_xlat3.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].z;
    u_xlat3 = fma(u_xlat1.xxxx, u_xlat4, u_xlat3);
    u_xlat2 = u_xlat2 + (-u_xlat3);
    u_xlat1 = fma(u_xlat2, u_xlat1.yyyy, u_xlat3);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.xxxx, u_xlat0);
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
Keywords { "SHADOWS_CUBE" }
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD1 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    u_xlat0.xy = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yx;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xy;
    u_xlat3.y = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat2.y = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xy;
    u_xlat3.z = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat2.z = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xy;
    u_xlat3.w = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat2.w = fma(u_xlat0.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yx;
    u_xlat4.x = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat5.x = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xy;
    u_xlat4.y = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat5.y = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xy;
    u_xlat4.z = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat5.z = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xy;
    u_xlat4.w = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat5.w = fma(u_xlat1.x, u_xlat0.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat5);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat5);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].z;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].z;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].z;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].z;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].z;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].z;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].z;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].z;
    u_xlat2 = fma(u_xlat3, u_xlat1.zzzz, u_xlat2);
    u_xlat3.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].z;
    u_xlat4.x = (-u_xlat3.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].z;
    u_xlat3.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].z;
    u_xlat4.y = (-u_xlat3.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].z;
    u_xlat3.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].z;
    u_xlat4.z = (-u_xlat3.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].z;
    u_xlat3.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].z;
    u_xlat4.w = (-u_xlat3.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].z;
    u_xlat3 = fma(u_xlat1.xxxx, u_xlat4, u_xlat3);
    u_xlat2 = u_xlat2 + (-u_xlat3);
    u_xlat1 = fma(u_xlat2, u_xlat1.yyyy, u_xlat3);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.xxxx, u_xlat0);
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
Keywords { "SHADOWS_CUBE" }
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD1 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    u_xlat0.xy = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yx;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xy;
    u_xlat3.y = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat2.y = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xy;
    u_xlat3.z = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat2.z = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xy;
    u_xlat3.w = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat2.w = fma(u_xlat0.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yx;
    u_xlat4.x = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat5.x = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xy;
    u_xlat4.y = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat5.y = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xy;
    u_xlat4.z = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat5.z = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xy;
    u_xlat4.w = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat5.w = fma(u_xlat1.x, u_xlat0.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat5);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat5);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].z;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].z;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].z;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].z;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].z;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].z;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].z;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].z;
    u_xlat2 = fma(u_xlat3, u_xlat1.zzzz, u_xlat2);
    u_xlat3.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].z;
    u_xlat4.x = (-u_xlat3.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].z;
    u_xlat3.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].z;
    u_xlat4.y = (-u_xlat3.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].z;
    u_xlat3.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].z;
    u_xlat4.z = (-u_xlat3.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].z;
    u_xlat3.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].z;
    u_xlat4.w = (-u_xlat3.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].z;
    u_xlat3 = fma(u_xlat1.xxxx, u_xlat4, u_xlat3);
    u_xlat2 = u_xlat2 + (-u_xlat3);
    u_xlat1 = fma(u_xlat2, u_xlat1.yyyy, u_xlat3);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.xxxx, u_xlat0);
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
Keywords { "SHADOWS_CUBE" }
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD1 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    u_xlat0.xy = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yx;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xy;
    u_xlat3.y = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat2.y = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xy;
    u_xlat3.z = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat2.z = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xy;
    u_xlat3.w = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat2.w = fma(u_xlat0.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yx) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yx;
    u_xlat4.x = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat5.x = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xy;
    u_xlat4.y = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat5.y = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat0.xz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xy;
    u_xlat4.z = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat5.z = fma(u_xlat1.x, u_xlat0.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat0.xw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xy;
    u_xlat4.w = fma(u_xlat1.x, u_xlat0.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat5.w = fma(u_xlat1.x, u_xlat0.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat5);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat5);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat0 = u_xlat3 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].z;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].z;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].z;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].z;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].z;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].z;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].z;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].z;
    u_xlat2 = fma(u_xlat3, u_xlat1.zzzz, u_xlat2);
    u_xlat3.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].z;
    u_xlat4.x = (-u_xlat3.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].z;
    u_xlat3.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].z;
    u_xlat4.y = (-u_xlat3.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].z;
    u_xlat3.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].z;
    u_xlat4.z = (-u_xlat3.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].z;
    u_xlat3.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].z;
    u_xlat4.w = (-u_xlat3.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].z;
    u_xlat3 = fma(u_xlat1.xxxx, u_xlat4, u_xlat3);
    u_xlat2 = u_xlat2 + (-u_xlat3);
    u_xlat1 = fma(u_xlat2, u_xlat1.yyyy, u_xlat3);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.xxxx, u_xlat0);
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
Keywords { "SHADOWS_DEPTH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
)
{
    Mtl_FragmentOut output;
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
)
{
    Mtl_FragmentOut output;
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
)
{
    Mtl_FragmentOut output;
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
)
{
    Mtl_FragmentOut output;
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
)
{
    Mtl_FragmentOut output;
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
)
{
    Mtl_FragmentOut output;
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "RenderType" = "MachineParts_Tire" }
  GpuProgramID 65821
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat42 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat42), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat42 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = float3(u_xlat42) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat42 = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, float3(u_xlat42), u_xlat4.xyz);
    u_xlat42 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat42), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat0.xyz = float3(u_xlat42) * u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat2 = float4(u_xlat42) * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat42 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat42) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat42 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat42), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat42 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = float3(u_xlat42) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat42 = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, float3(u_xlat42), u_xlat4.xyz);
    u_xlat42 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat42), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat0.xyz = float3(u_xlat42) * u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat2 = float4(u_xlat42) * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat42 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat42) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat42 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat42), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat42 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = float3(u_xlat42) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat42 = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, float3(u_xlat42), u_xlat4.xyz);
    u_xlat42 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat42), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat0.xyz = float3(u_xlat42) * u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat2 = float4(u_xlat42) * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat42 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat42) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat42 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat42), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat42 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = float3(u_xlat42) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat42 = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, float3(u_xlat42), u_xlat4.xyz);
    u_xlat42 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat42), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat0.xyz = float3(u_xlat42) * u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat2 = float4(u_xlat42) * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat42 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat42) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat42 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat42), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat42 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = float3(u_xlat42) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat42 = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, float3(u_xlat42), u_xlat4.xyz);
    u_xlat42 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat42), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat0.xyz = float3(u_xlat42) * u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat2 = float4(u_xlat42) * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat42 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat42) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat42 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat42), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat42 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = float3(u_xlat42) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat42 = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, float3(u_xlat42), u_xlat4.xyz);
    u_xlat42 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat42), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat0.xyz = float3(u_xlat42) * u_xlat0.xyz;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat42 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat2 = float4(u_xlat42) * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat42 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat42) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat36 = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, float3(u_xlat36), u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat42 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat42 = (-u_xlat42) + 1.0;
    u_xlat42 = u_xlat42 * VGlobals._ProjectionParams.z;
    u_xlat42 = max(u_xlat42, 0.0);
    u_xlat42 = fma(u_xlat42, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat1.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = u_xlat1.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat1.xxx, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2 = u_xlat1.xxxx * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat42, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat42 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat42 = (-u_xlat42) + 1.0;
    u_xlat42 = u_xlat42 * VGlobals._ProjectionParams.z;
    u_xlat42 = max(u_xlat42, 0.0);
    u_xlat42 = fma(u_xlat42, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat1.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = u_xlat1.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat1.xxx, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2 = u_xlat1.xxxx * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat42, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat42 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat42 = (-u_xlat42) + 1.0;
    u_xlat42 = u_xlat42 * VGlobals._ProjectionParams.z;
    u_xlat42 = max(u_xlat42, 0.0);
    u_xlat42 = fma(u_xlat42, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat1.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = u_xlat1.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat1.xxx, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2 = u_xlat1.xxxx * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat42, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat42 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat42 = (-u_xlat42) + 1.0;
    u_xlat42 = u_xlat42 * VGlobals._ProjectionParams.z;
    u_xlat42 = max(u_xlat42, 0.0);
    u_xlat42 = fma(u_xlat42, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat1.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = u_xlat1.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat1.xxx, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2 = u_xlat1.xxxx * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat42, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat42 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat42 = (-u_xlat42) + 1.0;
    u_xlat42 = u_xlat42 * VGlobals._ProjectionParams.z;
    u_xlat42 = max(u_xlat42, 0.0);
    u_xlat42 = fma(u_xlat42, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat1.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = u_xlat1.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat1.xxx, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2 = u_xlat1.xxxx * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat42, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    half3 u_xlat16_13;
    float u_xlat42;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat42 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat42), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat42 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat42), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat42 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat42 = (-u_xlat42) + 1.0;
    u_xlat42 = u_xlat42 * VGlobals._ProjectionParams.z;
    u_xlat42 = max(u_xlat42, 0.0);
    u_xlat42 = fma(u_xlat42, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat1.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat4.xyz = u_xlat1.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat2.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat1.xxx, u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat2.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.x = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(u_xlat2.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2 = u_xlat1.xxxx * u_xlat3.xyzz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD4.z = u_xlat2.w;
    u_xlat16_12 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_12 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_12))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_13.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_13.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_13.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_12), u_xlat16_13.xyz);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat42, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, VGlobals._EmissionMap_ST.xy, VGlobals._EmissionMap_ST.zw);
    u_xlat5.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat6.x = (-u_xlat5.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat5.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat6.y = (-u_xlat5.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat5.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat6.z = (-u_xlat5.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat5.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat6.w = (-u_xlat5.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat5 = fma(u_xlat6, u_xlat1.zzzz, u_xlat5);
    u_xlat6.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat7.x = (-u_xlat6.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat6.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat7.y = (-u_xlat6.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat6.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat7.z = (-u_xlat6.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat6.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat7.w = (-u_xlat6.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat6 = fma(u_xlat1.xxxx, u_xlat7, u_xlat6);
    u_xlat5 = u_xlat5 + (-u_xlat6);
    u_xlat1 = fma(u_xlat5, u_xlat1.yyyy, u_xlat6);
    u_xlat1.x = dot(u_xlat1, input.POSITION0);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat1.xxx, u_xlat4.xyz);
    output.TEXCOORD2.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat4.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13 = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat2.xyz = float3(u_xlat13) * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat4.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, u_xlat1.xxx, u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat1.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.w = u_xlat1.y;
    output.TEXCOORD4.w = u_xlat1.z;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat39, float(u_xlat16_12));
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_10;
    half u_xlat16_19;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat29 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb29 = u_xlat29<9.99999975e-06;
    u_xlat29 = (u_xlatb29) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = float(u_xlat16_1.x) * u_xlat29;
    u_xlat4.x = float(u_xlat16_1.z) * u_xlat29;
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat29 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat3.xyz = float3(u_xlat29) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_3.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_19 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_9 = u_xlat16_19 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_19 * u_xlat16_9;
    u_xlat16_19 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_1.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_10) + (-u_xlat16_8.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_9), u_xlat16_1.xyw, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(u_xlat0.xxx * float3(u_xlat16_8.xyz));
    u_xlat16_7.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_19), u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_10;
    half u_xlat16_19;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat29 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb29 = u_xlat29<9.99999975e-06;
    u_xlat29 = (u_xlatb29) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = float(u_xlat16_1.x) * u_xlat29;
    u_xlat4.x = float(u_xlat16_1.z) * u_xlat29;
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat29 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat3.xyz = float3(u_xlat29) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_3.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_19 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_9 = u_xlat16_19 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_19 * u_xlat16_9;
    u_xlat16_19 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_1.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_10) + (-u_xlat16_8.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_9), u_xlat16_1.xyw, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(u_xlat0.xxx * float3(u_xlat16_8.xyz));
    u_xlat16_7.xyz = fma(u_xlat16_7.xyz, half3(u_xlat16_19), u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat18;
    half u_xlat16_19;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_19 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_19 = fma((-u_xlat16_19), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_19);
    u_xlat16_19 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat11.x * u_xlat11.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat27, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = float3(u_xlat16_7.xyz) * u_xlat9.xxx;
    u_xlat9.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_19), u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyw));
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat18;
    half u_xlat16_19;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_19 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_19 = fma((-u_xlat16_19), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_19);
    u_xlat16_19 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat11.x * u_xlat11.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat27, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = float3(u_xlat16_7.xyz) * u_xlat9.xxx;
    u_xlat9.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_19), u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyw));
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat18;
    half u_xlat16_19;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_19 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_19 = fma((-u_xlat16_19), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_19);
    u_xlat16_19 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat11.x * u_xlat11.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat27, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = float3(u_xlat16_7.xyz) * u_xlat9.xxx;
    u_xlat9.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_19), u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyw));
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat18;
    half u_xlat16_19;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_19 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_19 = fma((-u_xlat16_19), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_19);
    u_xlat16_19 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_19) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat11.x * u_xlat11.x;
    u_xlat18 = max(u_xlat3.x, 0.319999993);
    u_xlat18 = u_xlat27 * u_xlat18;
    u_xlat27 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat27, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat9.xyz = float3(u_xlat16_7.xyz) * u_xlat9.xxx;
    u_xlat9.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_19), u_xlat9.xyz);
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_1.xyw));
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat30;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb2 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb2) ? half(0.0) : half(u_xlat30);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_3.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat2.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x + u_xlat2.x;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-u_xlat2.xxx), u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_11 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_11;
    u_xlat16_28 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_28) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_11), u_xlat16_1.xyw, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(u_xlat2.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.w = 1.0;
    u_xlat16_8.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_8.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_8.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + input.TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_1.xyw);
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat30;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb2 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb2) ? half(0.0) : half(u_xlat30);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_3.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat2.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x + u_xlat2.x;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-u_xlat2.xxx), u_xlat11.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_11 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_28 * u_xlat16_11;
    u_xlat16_28 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_28) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_10) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_11), u_xlat16_1.xyw, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(u_xlat2.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.w = 1.0;
    u_xlat16_8.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_8.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_8.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + input.TEXCOORD5.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_1.xyw);
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_10;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat27;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat10.xyz)));
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb2 = u_xlat4.z<0.00499999989;
    u_xlat27 = u_xlat4.z * 8.29800034;
    u_xlat16_25 = (u_xlatb2) ? half(0.0) : half(u_xlat27);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_25)));
    u_xlat16_25 = u_xlat16_3.w + half(-1.0);
    u_xlat16_25 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_25, half(1.0));
    u_xlat16_25 = u_xlat16_25 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat2.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x + u_xlat2.x;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-u_xlat2.xxx), u_xlat10.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_25 = half((-u_xlat3.x) + 1.0);
    u_xlat16_10 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_9 = (-u_xlat16_25) + u_xlat16_1.y;
    u_xlat16_9 = u_xlat16_9 + half(1.0);
    u_xlat16_9 = clamp(u_xlat16_9, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_9) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_10), u_xlat16_1.xyw, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_5.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_5.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_5.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_5.xyz = u_xlat16_5.xyz + input.TEXCOORD5.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_1.xyw);
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_25 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_25) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat2.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_3 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_3, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_3 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_3, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_10;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat29 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb29 = u_xlat29<9.99999975e-06;
    u_xlat29 = (u_xlatb29) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = float(u_xlat16_1.x) * u_xlat29;
    u_xlat4.x = float(u_xlat16_1.z) * u_xlat29;
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat29 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat3.xyz = float3(u_xlat29) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_3.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_28) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = fma(u_xlat16_1.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_10) + (-u_xlat16_8.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_9), u_xlat16_1.xyw, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_7.xyz, u_xlat16_1.xyw);
    u_xlat16_1.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_10;
    float u_xlat24;
    half u_xlat16_25;
    float u_xlat27;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat10.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat10.xyz)));
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb2 = u_xlat4.z<0.00499999989;
    u_xlat27 = u_xlat4.z * 8.29800034;
    u_xlat16_25 = (u_xlatb2) ? half(0.0) : half(u_xlat27);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_25)));
    u_xlat16_25 = u_xlat16_3.w + half(-1.0);
    u_xlat16_25 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_25, half(1.0));
    u_xlat16_25 = u_xlat16_25 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat3.x = u_xlat2.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat2.x = u_xlat2.x + u_xlat2.x;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-u_xlat2.xxx), u_xlat10.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat4.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat2.x = u_xlat2.x * 16.0;
    u_xlat16_25 = half((-u_xlat3.x) + 1.0);
    u_xlat16_10 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_25 * u_xlat16_10;
    u_xlat16_25 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_9 = (-u_xlat16_25) + u_xlat16_1.y;
    u_xlat16_9 = u_xlat16_9 + half(1.0);
    u_xlat16_9 = clamp(u_xlat16_9, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_9) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_10), u_xlat16_1.xyw, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_5.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_5.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_5.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_5.xyz = u_xlat16_5.xyz + input.TEXCOORD5.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_1.xyw);
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_25 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_25) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat2.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD6;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _WorldSpaceLightPos0;
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_12;
    float u_xlat31;
    half u_xlat16_32;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat10.xyz)));
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_2.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat3.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat3.xyz = float3(u_xlat33) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb0 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_32 = (u_xlatb0) ? half(0.0) : half(u_xlat33);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_32)));
    u_xlat16_32 = u_xlat16_3.w + half(-1.0);
    u_xlat16_32 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_32, half(1.0));
    u_xlat16_32 = u_xlat16_32 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_32);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_32 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_12 = (-u_xlat16_32) + u_xlat16_2.y;
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_12 = clamp(u_xlat16_12, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.xyw = half3(u_xlat16_12) + (-u_xlat16_7.xyz);
    u_xlat0.x = dot(u_xlat10.xyz, u_xlat1.xyz);
    u_xlat3.x = u_xlat0.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-u_xlat0.xxx), u_xlat10.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_35 = half((-u_xlat3.x) + 1.0);
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_35;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_7.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_5.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_5.x))));
    u_xlat16_0 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_5.xxx, u_xlat16_7.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = half3(u_xlat3.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat1.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_9.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_2.xyw);
    u_xlat16_2.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_2.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat12;
    float u_xlat20;
    float u_xlat24;
    bool u_xlatb24;
    half u_xlat16_25;
    float u_xlat28;
    float u_xlat29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_25 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_25 = (-u_xlat16_25) + u_xlat16_2.y;
    u_xlat16_25 = u_xlat16_25 + half(1.0);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat12.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat12.x = u_xlat28 * u_xlat28;
    u_xlat20 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat28 = u_xlat20 * u_xlat20;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat20, u_xlat20, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat29;
    u_xlat4.x = u_xlat12.x * u_xlat4.x;
    u_xlat4.x = u_xlat28 / u_xlat4.x;
    u_xlat16_25 = half(u_xlat20 * u_xlat28);
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = u_xlat4.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat29), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlatb24 = u_xlat20<0.00499999989;
    u_xlat20 = u_xlat20 * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat20);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat12;
    float u_xlat20;
    float u_xlat24;
    bool u_xlatb24;
    half u_xlat16_25;
    float u_xlat28;
    float u_xlat29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_25 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_25 = (-u_xlat16_25) + u_xlat16_2.y;
    u_xlat16_25 = u_xlat16_25 + half(1.0);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat12.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat12.x = u_xlat28 * u_xlat28;
    u_xlat20 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat28 = u_xlat20 * u_xlat20;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat20, u_xlat20, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat29;
    u_xlat4.x = u_xlat12.x * u_xlat4.x;
    u_xlat4.x = u_xlat28 / u_xlat4.x;
    u_xlat16_25 = half(u_xlat20 * u_xlat28);
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = u_xlat4.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat29), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlatb24 = u_xlat20<0.00499999989;
    u_xlat20 = u_xlat20 * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat20);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_3 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_3, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat11;
    half3 u_xlat16_11;
    float u_xlat12;
    float u_xlat20;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat11.xyz = fma(u_xlat3.xyz, u_xlat11.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat4.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat4.xyz)));
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat3.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat3.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_1.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(u_xlat16_1.xyz));
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat2.x = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb30 = u_xlat2.x<0.00499999989;
    u_xlat4.x = u_xlat2.x * 8.29800034;
    u_xlat16_5.x = (u_xlatb30) ? half(0.0) : half(u_xlat4.x);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_3.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat3.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_32 = half(u_xlat2.x * u_xlat3.x);
    u_xlat2.x = fma(u_xlat2.x, u_xlat2.x, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat12 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat12);
    u_xlat12 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat20 = max(u_xlat12, 0.319999993);
    u_xlat2.x = u_xlat2.x * u_xlat20;
    u_xlat20 = fma(u_xlat3.x, u_xlat3.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat20, 1.00001001);
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat2.x = u_xlat3.x / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_11.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_11.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_3 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_3, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(u_xlat16_7.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat0.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + input.TEXCOORD5.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_0.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, float3(u_xlat29), float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float u_xlat8;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_16;
    float u_xlat24;
    bool u_xlatb24;
    half u_xlat16_25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat26 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb26 = u_xlat26<9.99999975e-06;
    u_xlat26 = (u_xlatb26) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = float(u_xlat16_1.x) * u_xlat26;
    u_xlat4.x = float(u_xlat16_1.z) * u_xlat26;
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = rsqrt(u_xlat26);
    u_xlat3.xyz = float3(u_xlat26) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb24 = u_xlat4.z<0.00499999989;
    u_xlat26 = u_xlat4.z * 8.29800034;
    u_xlat16_25 = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_25)));
    u_xlat16_25 = u_xlat16_3.w + half(-1.0);
    u_xlat16_25 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_25, half(1.0));
    u_xlat16_25 = u_xlat16_25 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat24)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat8 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat4.x = u_xlat8 * u_xlat8;
    u_xlat8 = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat8 = u_xlat8 * 16.0;
    u_xlat16_25 = half((-u_xlat26) + 1.0);
    u_xlat16_16 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_16;
    u_xlat16_25 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_9 = (-u_xlat16_25) + u_xlat16_1.y;
    u_xlat16_9 = u_xlat16_9 + half(1.0);
    u_xlat16_9 = clamp(u_xlat16_9, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_9) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_16), u_xlat16_1.xyw, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(float3(u_xlat8), float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_8.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_1.xyw);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_25 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_25) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat0.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * float3(u_xlat16_7.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * float3(u_xlat16_7.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_10;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat29 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb29 = u_xlat29<9.99999975e-06;
    u_xlat29 = (u_xlatb29) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = float(u_xlat16_1.x) * u_xlat29;
    u_xlat4.x = float(u_xlat16_1.z) * u_xlat29;
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat29 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat3.xyz = float3(u_xlat29) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_3.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_10 = (-u_xlat16_28) + u_xlat16_1.y;
    u_xlat16_10 = u_xlat16_10 + half(1.0);
    u_xlat16_10 = clamp(u_xlat16_10, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = fma(u_xlat16_1.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_10) + (-u_xlat16_8.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_9), u_xlat16_1.xyw, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_7.xyz, u_xlat16_1.xyw);
    u_xlat16_1.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_11;
    half3 u_xlat16_12;
    float u_xlat28;
    half u_xlat16_29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = rsqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat1.xyz;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_2.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat3.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb0 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb0) ? half(0.0) : half(u_xlat30);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_29)));
    u_xlat16_29 = u_xlat16_3.w + half(-1.0);
    u_xlat16_29 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_29, half(1.0));
    u_xlat16_29 = u_xlat16_29 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_29 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_11 = (-u_xlat16_29) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + half(1.0);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.xyw = half3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat0.x = dot(u_xlat9.xyz, u_xlat1.xyz);
    u_xlat3.x = u_xlat0.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-u_xlat0.xxx), u_xlat9.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_32 = half((-u_xlat3.x) + 1.0);
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_32;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_7.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_5.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_5.x))));
    u_xlat16_0 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_5.xxx, u_xlat16_7.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat1.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_2.xyw);
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat3.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_2.xyz = fma(u_xlat16_8.xyz, u_xlat16_5.xyz, u_xlat16_2.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat13;
    float u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat31;
    float u_xlat32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_28 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_2.y;
    u_xlat16_28 = u_xlat16_28 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_28 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_8.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat13.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat13.x = u_xlat31 * u_xlat31;
    u_xlat22 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat31 = u_xlat22 * u_xlat22;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat32;
    u_xlat4.x = u_xlat13.x * u_xlat4.x;
    u_xlat4.x = u_xlat31 / u_xlat4.x;
    u_xlat16_28 = half(u_xlat22 * u_xlat31);
    u_xlat16_28 = fma((-u_xlat16_28), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = float3(u_xlat16_8.xyz) * u_xlat4.xyw;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat22);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_28);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat13;
    float u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat31;
    float u_xlat32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_28 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_2.y;
    u_xlat16_28 = u_xlat16_28 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_28 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_8.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat13.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat13.x = u_xlat31 * u_xlat31;
    u_xlat22 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat31 = u_xlat22 * u_xlat22;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat32;
    u_xlat4.x = u_xlat13.x * u_xlat4.x;
    u_xlat4.x = u_xlat31 / u_xlat4.x;
    u_xlat16_28 = half(u_xlat22 * u_xlat31);
    u_xlat16_28 = fma((-u_xlat16_28), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = float3(u_xlat16_8.xyz) * u_xlat4.xyw;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat22);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_28);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    output.SV_Target0.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat9.xyz = u_xlat9.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half u_xlat16_12;
    float u_xlat31;
    half u_xlat16_32;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10.x = rsqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = rsqrt(u_xlat31);
    u_xlat1.xyz = float3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat10.xyz)));
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_2.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat3.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat3.xyz = float3(u_xlat33) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb0 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_32 = (u_xlatb0) ? half(0.0) : half(u_xlat33);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_32)));
    u_xlat16_32 = u_xlat16_3.w + half(-1.0);
    u_xlat16_32 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_32, half(1.0));
    u_xlat16_32 = u_xlat16_32 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_32);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_32 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_12 = (-u_xlat16_32) + u_xlat16_2.y;
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_12 = clamp(u_xlat16_12, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_32) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.xyw = half3(u_xlat16_12) + (-u_xlat16_7.xyz);
    u_xlat0.x = dot(u_xlat10.xyz, u_xlat1.xyz);
    u_xlat3.x = u_xlat0.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-u_xlat0.xxx), u_xlat10.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_35 = half((-u_xlat3.x) + 1.0);
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_35;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_35 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_7.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_5.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_5.x))));
    u_xlat16_0 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_5.xxx, u_xlat16_7.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat16_7.xyz = half3(u_xlat3.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat1.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_9.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_2.xyw);
    u_xlat16_2.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_2.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat31 = input.TEXCOORD6;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat31), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat12;
    float u_xlat20;
    float u_xlat24;
    bool u_xlatb24;
    half u_xlat16_25;
    float u_xlat28;
    float u_xlat29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_25 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_25 = (-u_xlat16_25) + u_xlat16_2.y;
    u_xlat16_25 = u_xlat16_25 + half(1.0);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat12.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat12.x = u_xlat28 * u_xlat28;
    u_xlat20 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat28 = u_xlat20 * u_xlat20;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat20, u_xlat20, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat29;
    u_xlat4.x = u_xlat12.x * u_xlat4.x;
    u_xlat4.x = u_xlat28 / u_xlat4.x;
    u_xlat16_25 = half(u_xlat20 * u_xlat28);
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = u_xlat4.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat29), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlatb24 = u_xlat20<0.00499999989;
    u_xlat20 = u_xlat20 * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat20);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD6;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat12;
    float u_xlat20;
    float u_xlat24;
    bool u_xlatb24;
    half u_xlat16_25;
    float u_xlat28;
    float u_xlat29;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_25 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_25 = (-u_xlat16_25) + u_xlat16_2.y;
    u_xlat16_25 = u_xlat16_25 + half(1.0);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_25);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat12.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat12.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat12.x = u_xlat28 * u_xlat28;
    u_xlat20 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat28 = u_xlat20 * u_xlat20;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat20, u_xlat20, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat29;
    u_xlat4.x = u_xlat12.x * u_xlat4.x;
    u_xlat4.x = u_xlat28 / u_xlat4.x;
    u_xlat16_25 = half(u_xlat20 * u_xlat28);
    u_xlat16_25 = fma((-u_xlat16_25), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = u_xlat4.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat29), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlatb24 = u_xlat20<0.00499999989;
    u_xlat20 = u_xlat20 * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat20);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_25);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD6;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    float u_xlat8;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_16;
    float u_xlat24;
    bool u_xlatb24;
    half u_xlat16_25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat2.xyz)));
    u_xlat26 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb26 = u_xlat26<9.99999975e-06;
    u_xlat26 = (u_xlatb26) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat3.z = float(u_xlat16_1.x) * u_xlat26;
    u_xlat4.x = float(u_xlat16_1.z) * u_xlat26;
    u_xlat3.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat4.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = rsqrt(u_xlat26);
    u_xlat3.xyz = float3(u_xlat26) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat3.xyz = float3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb24 = u_xlat4.z<0.00499999989;
    u_xlat26 = u_xlat4.z * 8.29800034;
    u_xlat16_25 = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_25)));
    u_xlat16_25 = u_xlat16_3.w + half(-1.0);
    u_xlat16_25 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_25, half(1.0));
    u_xlat16_25 = u_xlat16_25 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat24)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat8 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat4.x = u_xlat8 * u_xlat8;
    u_xlat8 = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat8 = u_xlat8 * 16.0;
    u_xlat16_25 = half((-u_xlat26) + 1.0);
    u_xlat16_16 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_25 * u_xlat16_16;
    u_xlat16_25 = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_9 = (-u_xlat16_25) + u_xlat16_1.y;
    u_xlat16_9 = u_xlat16_9 + half(1.0);
    u_xlat16_9 = clamp(u_xlat16_9, 0.0h, 1.0h);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.xyw = half3(u_xlat16_9) + (-u_xlat16_7.xyz);
    u_xlat16_1.xyw = fma(half3(u_xlat16_16), u_xlat16_1.xyw, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(float3(u_xlat8), float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_1.xyw = u_xlat16_1.xyw * u_xlat16_5.xyz;
    u_xlat16_8.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_1.xyw);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_25 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_25) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat0.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD6;
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * float3(u_xlat16_7.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 _AddColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half3 _Emission;
    half _EmissionIntensity;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    float3 u_xlat11;
    float u_xlat18;
    float u_xlat27;
    half u_xlat16_28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat11.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_1.x = dot((-u_xlat11.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat11.xyz)));
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_28 = half((-u_xlat2.x) + 1.0);
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat2.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb2 = u_xlat2.x<9.99999975e-06;
    u_xlat2.x = (u_xlatb2) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat4.z = float(u_xlat16_1.x) * u_xlat2.x;
    u_xlat2.x = float(u_xlat16_1.z) * u_xlat2.x;
    u_xlat4.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat2.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat29 = rsqrt(u_xlat29);
    u_xlat2.xyz = float3(u_xlat29) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat27 = (-float(u_xlat16_1.y)) + 1.0;
    u_xlatb29 = u_xlat27<0.00499999989;
    u_xlat30 = u_xlat27 * 8.29800034;
    u_xlat16_5.x = (u_xlatb29) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_5.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_1.zzz * u_xlat16_5.xyz;
    u_xlat2.x = u_xlat27 * u_xlat27;
    u_xlat16_32 = half(u_xlat27 * u_xlat2.x);
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.5);
    u_xlat16_32 = fma((-u_xlat16_32), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_32);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat11.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = max(u_xlat11.x, 0.319999993);
    u_xlat27 = u_xlat27 * u_xlat11.x;
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat3.x * u_xlat3.x;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, -1.0);
    u_xlat9.x = fma(u_xlat9.x, u_xlat18, 1.00001001);
    u_xlat9.x = u_xlat9.x * u_xlat27;
    u_xlat9.x = u_xlat2.x / u_xlat9.x;
    u_xlat9.x = u_xlat9.x + -9.99999975e-05;
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlat9.x = min(u_xlat9.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(u_xlat16_1.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x + half(1.0);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyw = fma(half3(u_xlat16_28), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat9.xyz = fma(u_xlat9.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_32 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_7.xyz = half3(u_xlat16_32) * FGlobals._LightColor0.xyz;
    u_xlat9.xyz = u_xlat9.xyz * float3(u_xlat16_7.xyz);
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz;
    u_xlat0.xyz = fma(u_xlat9.xyz, u_xlat0.xxx, float3(u_xlat16_6.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xyw), u_xlat0.xyz);
    u_xlat16_2.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_2.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    bool u_xlatb3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat9;
    half u_xlat16_11;
    half3 u_xlat16_12;
    float u_xlat28;
    half u_xlat16_29;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat1.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = rsqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * u_xlat1.xyz;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat1.xyz = float3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), u_xlat1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat3.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
    u_xlat3.x = (u_xlatb3) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat3.x;
    u_xlat3.x = float(u_xlat16_2.z) * u_xlat3.x;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat3.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat4.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat4.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb0 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_29 = (u_xlatb0) ? half(0.0) : half(u_xlat30);
    u_xlat16_3 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_29)));
    u_xlat16_29 = u_xlat16_3.w + half(-1.0);
    u_xlat16_29 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_29, half(1.0));
    u_xlat16_29 = u_xlat16_29 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_29);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_29 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_11 = (-u_xlat16_29) + u_xlat16_2.y;
    u_xlat16_11 = u_xlat16_11 + half(1.0);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0h, 1.0h);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = fma(FGlobals._Color.xyz, u_xlat16_3.xyz, FGlobals._AddColor.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.xyw = half3(u_xlat16_11) + (-u_xlat16_7.xyz);
    u_xlat0.x = dot(u_xlat9.xyz, u_xlat1.xyz);
    u_xlat3.x = u_xlat0.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-u_xlat0.xxx), u_xlat9.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_32 = half((-u_xlat3.x) + 1.0);
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_32;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_32 * u_xlat16_0.x;
    u_xlat16_2.xyw = fma(u_xlat16_0.xxx, u_xlat16_2.xyw, u_xlat16_7.xyz);
    u_xlat16_2.xyw = u_xlat16_2.xyw * u_xlat16_5.xyz;
    u_xlat16_5.x = half(u_xlat1.y * u_xlat1.y);
    u_xlat16_5.x = half(fma(u_xlat1.x, u_xlat1.x, (-float(u_xlat16_5.x))));
    u_xlat16_0 = half4(u_xlat1.yzzx * u_xlat1.xyzz);
    u_xlat16_7.x = dot(FGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_7.y = dot(FGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_7.z = dot(FGlobals.unity_SHBb, u_xlat16_0);
    u_xlat16_5.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_5.xxx, u_xlat16_7.xyz);
    u_xlat3.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat1.w = 1.0;
    u_xlat16_7.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_7.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_7.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_2.zzz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_2.xyw);
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_29 = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_29) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(u_xlat3.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_2.xyz = fma(u_xlat16_8.xyz, u_xlat16_5.xyz, u_xlat16_2.xyz);
    u_xlat16_1.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(FGlobals._EmissionIntensity), u_xlat16_2.xyz);
    u_xlat16_1.xyz = u_xlat16_2.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat28 = input.TEXCOORD6;
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.xyz = fma(float3(u_xlat28), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat13;
    float u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat31;
    float u_xlat32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_28 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_2.y;
    u_xlat16_28 = u_xlat16_28 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_28 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_8.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat13.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat13.x = u_xlat31 * u_xlat31;
    u_xlat22 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat31 = u_xlat22 * u_xlat22;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat32;
    u_xlat4.x = u_xlat13.x * u_xlat4.x;
    u_xlat4.x = u_xlat31 / u_xlat4.x;
    u_xlat16_28 = half(u_xlat22 * u_xlat31);
    u_xlat16_28 = fma((-u_xlat16_28), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = float3(u_xlat16_8.xyz) * u_xlat4.xyw;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat22);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_28);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<half, access::sample > _EmissionMap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat13;
    float u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat31;
    float u_xlat32;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_1.x = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_1.x))));
    u_xlat16_2 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_3.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_3.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_3.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_1.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_1.xxx, u_xlat16_3.xyz);
    u_xlat0.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = max(u_xlat16_4.xyz, FGlobals._MinMSA.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.zzz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = fma(FGlobals._Color.xyz, u_xlat16_4.xyz, FGlobals._AddColor.xyz);
    u_xlat16_28 = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_2.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_2.y;
    u_xlat16_28 = u_xlat16_28 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) + half3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_28 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_8.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat4.x = input.TEXCOORD2.w;
    u_xlat4.y = input.TEXCOORD3.w;
    u_xlat4.z = input.TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat4.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat4.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat13.xyz = fma(u_xlat5.xyz, u_xlat4.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat5.xyz = u_xlat4.xxx * u_xlat5.xyz;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat13.x = u_xlat31 * u_xlat31;
    u_xlat22 = (-float(u_xlat16_2.y)) + 1.0;
    u_xlat31 = u_xlat22 * u_xlat22;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat4.x = u_xlat4.x * u_xlat32;
    u_xlat4.x = u_xlat13.x * u_xlat4.x;
    u_xlat4.x = u_xlat31 / u_xlat4.x;
    u_xlat16_28 = half(u_xlat22 * u_xlat31);
    u_xlat16_28 = fma((-u_xlat16_28), half(0.280000001), half(1.0));
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyw = fma(u_xlat4.xxx, float3(u_xlat16_3.xyz), float3(u_xlat16_6.xyz));
    u_xlat4.xyw = float3(u_xlat16_8.xyz) * u_xlat4.xyw;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat4.xyw = fma(u_xlat4.xyw, float3(u_xlat32), float3(u_xlat16_1.xyz));
    u_xlat16_1.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat5.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_2.x = half((-u_xlat0.x) + 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyw = fma(u_xlat16_2.xxx, u_xlat16_7.xyz, u_xlat16_3.xyz);
    u_xlat0.x = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat5.z = u_xlat0.x * float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    u_xlat5.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat0.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat5.xxx;
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat22);
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_2.zzz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_28);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xyw), u_xlat4.xyw);
    u_xlat16_4.xyz = _EmissionMap.sample(sampler_EmissionMap, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * FGlobals._Emission.xxyz.yzw;
    u_xlat16_1.xyz = half3(fma(float3(u_xlat16_4.xyz), float3(FGlobals._EmissionIntensity), u_xlat0.xyz));
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
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
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDADD" "RenderType" = "MachineParts_Tire" }
  ZWrite Off
  GpuProgramID 190243
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD1 [[ attribute(4) ]] ;
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
    float3 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat5.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat5.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat5.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat0.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat2.x = (-u_xlat0.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat0.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat2.y = (-u_xlat0.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat0.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat2.z = (-u_xlat0.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat0.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat2.w = (-u_xlat0.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat0 = fma(u_xlat2, u_xlat1.zzzz, u_xlat0);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat2 = fma(u_xlat1.xxxx, u_xlat3, u_xlat2);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat2);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat0.xxx, u_xlat4.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD1 [[ attribute(4) ]] ;
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
    float3 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat5.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat5.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat5.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat0.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat2.x = (-u_xlat0.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat0.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat2.y = (-u_xlat0.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat0.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat2.z = (-u_xlat0.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat0.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat2.w = (-u_xlat0.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat0 = fma(u_xlat2, u_xlat1.zzzz, u_xlat0);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat2 = fma(u_xlat1.xxxx, u_xlat3, u_xlat2);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat2);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat0.xxx, u_xlat4.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD1 [[ attribute(4) ]] ;
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
    float3 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat36;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat36 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat36), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat36 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat36), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat5.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat5.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat12.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat12.xyz = u_xlat12.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat12.xyz);
    u_xlat5.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat36 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat36), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat2.xyz = float3(u_xlat36) * u_xlat2.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat36 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat36) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat0.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat2.x = (-u_xlat0.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat0.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat2.y = (-u_xlat0.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat0.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat2.z = (-u_xlat0.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat0.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat2.w = (-u_xlat0.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat0 = fma(u_xlat2, u_xlat1.zzzz, u_xlat0);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat2 = fma(u_xlat1.xxxx, u_xlat3, u_xlat2);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat2);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat0.xxx, u_xlat4.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD1 [[ attribute(4) ]] ;
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
    float3 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat39, float(u_xlat16_12));
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat5.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat5.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat13.xyz = u_xlat13.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat13.xyz);
    u_xlat5.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat39), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat2.xyz = float3(u_xlat39) * u_xlat2.xyz;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat0.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat39 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat0.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat2.x = (-u_xlat0.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat0.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat2.y = (-u_xlat0.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat0.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat2.z = (-u_xlat0.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat0.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat2.w = (-u_xlat0.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat0 = fma(u_xlat2, u_xlat1.zzzz, u_xlat0);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat2 = fma(u_xlat1.xxxx, u_xlat3, u_xlat2);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat2);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat0.xxx, u_xlat4.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD1 [[ attribute(4) ]] ;
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
    float3 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat39, float(u_xlat16_12));
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat5.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat5.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat13.xyz = u_xlat13.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat13.xyz);
    u_xlat5.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat39), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat2.xyz = float3(u_xlat39) * u_xlat2.xyz;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat0.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat39 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat0.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat2.x = (-u_xlat0.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat0.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat2.y = (-u_xlat0.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat0.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat2.z = (-u_xlat0.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat0.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat2.w = (-u_xlat0.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat0 = fma(u_xlat2, u_xlat1.zzzz, u_xlat0);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat2 = fma(u_xlat1.xxxx, u_xlat3, u_xlat2);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat2);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat0.xxx, u_xlat4.xyz);
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
    float4 hlslcc_mtx4x4_flMatrix[4];
    float4 hlslcc_mtx4x4_frMatrix[4];
    float4 hlslcc_mtx4x4_rlMatrix[4];
    float4 hlslcc_mtx4x4_rrMatrix[4];
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
    float4 TEXCOORD1 [[ attribute(4) ]] ;
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
    float3 u_xlat1;
    bool3 u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat39;
    u_xlat0.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].yxz;
    u_xlatb1.xyz = (input.TEXCOORD1.xxx>=float3(1.0, 2.0, 3.0));
    u_xlat1.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(u_xlatb1.xyz));
    u_xlat2.x = fma(u_xlat0.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].y);
    u_xlat3.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].xyz;
    u_xlat2.y = fma(u_xlat3.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].y);
    u_xlat4.xyz = (-VGlobals.hlslcc_mtx4x4_rlMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].xzy;
    u_xlat2.z = fma(u_xlat4.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].y);
    u_xlat5.xyw = (-VGlobals.hlslcc_mtx4x4_rlMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].xzy;
    u_xlat2.w = fma(u_xlat5.w, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].y);
    u_xlat6.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[0].yxz) + VGlobals.hlslcc_mtx4x4_frMatrix[0].yxz;
    u_xlat7.x = fma(u_xlat1.x, u_xlat6.x, VGlobals.hlslcc_mtx4x4_flMatrix[0].y);
    u_xlat8.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[1].xyz) + VGlobals.hlslcc_mtx4x4_frMatrix[1].xyz;
    u_xlat7.y = fma(u_xlat1.x, u_xlat8.y, VGlobals.hlslcc_mtx4x4_flMatrix[1].y);
    u_xlat9.xyz = (-VGlobals.hlslcc_mtx4x4_flMatrix[2].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[2].xzy;
    u_xlat7.z = fma(u_xlat1.x, u_xlat9.z, VGlobals.hlslcc_mtx4x4_flMatrix[2].y);
    u_xlat10.xyw = (-VGlobals.hlslcc_mtx4x4_flMatrix[3].xzy) + VGlobals.hlslcc_mtx4x4_frMatrix[3].xzy;
    u_xlat7.w = fma(u_xlat1.x, u_xlat10.w, VGlobals.hlslcc_mtx4x4_flMatrix[3].y);
    u_xlat2 = u_xlat2 + (-u_xlat7);
    u_xlat2 = fma(u_xlat2, u_xlat1.yyyy, u_xlat7);
    u_xlat0.x = dot(u_xlat2, input.POSITION0);
    u_xlat7 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat11.x = fma(u_xlat0.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].z);
    u_xlat0.x = fma(u_xlat0.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[0].x);
    u_xlat11.y = fma(u_xlat3.z, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].z);
    u_xlat0.y = fma(u_xlat3.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[1].x);
    u_xlat11.z = fma(u_xlat4.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].z);
    u_xlat0.z = fma(u_xlat4.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[2].x);
    u_xlat11.w = fma(u_xlat5.y, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].z);
    u_xlat0.w = fma(u_xlat5.x, u_xlat1.z, VGlobals.hlslcc_mtx4x4_rlMatrix[3].x);
    u_xlat3.x = fma(u_xlat1.x, u_xlat6.z, VGlobals.hlslcc_mtx4x4_flMatrix[0].z);
    u_xlat4.x = fma(u_xlat1.x, u_xlat6.y, VGlobals.hlslcc_mtx4x4_flMatrix[0].x);
    u_xlat3.y = fma(u_xlat1.x, u_xlat8.z, VGlobals.hlslcc_mtx4x4_flMatrix[1].z);
    u_xlat4.y = fma(u_xlat1.x, u_xlat8.x, VGlobals.hlslcc_mtx4x4_flMatrix[1].x);
    u_xlat3.z = fma(u_xlat1.x, u_xlat9.y, VGlobals.hlslcc_mtx4x4_flMatrix[2].z);
    u_xlat4.z = fma(u_xlat1.x, u_xlat9.x, VGlobals.hlslcc_mtx4x4_flMatrix[2].x);
    u_xlat3.w = fma(u_xlat1.x, u_xlat10.y, VGlobals.hlslcc_mtx4x4_flMatrix[3].z);
    u_xlat4.w = fma(u_xlat1.x, u_xlat10.x, VGlobals.hlslcc_mtx4x4_flMatrix[3].x);
    u_xlat0 = u_xlat0 + (-u_xlat4);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat4);
    u_xlat39 = dot(u_xlat0, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], float4(u_xlat39), u_xlat7);
    u_xlat5 = (-u_xlat3) + u_xlat11;
    u_xlat3 = fma(u_xlat5, u_xlat1.yyyy, u_xlat3);
    u_xlat39 = dot(u_xlat3, input.POSITION0);
    u_xlat4 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], float4(u_xlat39), u_xlat4);
    u_xlat5 = u_xlat4 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat6 = u_xlat5.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat5.xxxx, u_xlat6);
    u_xlat6 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat5.zzzz, u_xlat6);
    u_xlat5 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat5.wwww, u_xlat6);
    output.mtl_Position = u_xlat5;
    u_xlat39 = u_xlat5.z / VGlobals._ProjectionParams.y;
    u_xlat39 = (-u_xlat39) + 1.0;
    u_xlat39 = u_xlat39 * VGlobals._ProjectionParams.z;
    u_xlat39 = max(u_xlat39, 0.0);
    u_xlat39 = fma(u_xlat39, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    u_xlat16_12 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat39, float(u_xlat16_12));
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    u_xlat5.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.TANGENT0.xyz);
    u_xlat5.y = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat13.x = dot(u_xlat2.xyz, input.TANGENT0.xyz);
    u_xlat13.xyz = u_xlat13.xxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, u_xlat0.xxx, u_xlat13.xyz);
    u_xlat5.z = dot(u_xlat3.xyz, input.NORMAL0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, input.TANGENT0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, float3(u_xlat39), u_xlat0.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat2.xyz = float3(u_xlat39) * u_xlat2.xyz;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat0.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat2.zxy, u_xlat0.yzx, (-u_xlat3.xyz));
    u_xlat39 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat39) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat0.z;
    output.TEXCOORD2.z = u_xlat2.y;
    output.TEXCOORD3.x = u_xlat0.x;
    output.TEXCOORD4.x = u_xlat0.y;
    output.TEXCOORD3.z = u_xlat2.z;
    output.TEXCOORD4.z = u_xlat2.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    u_xlat0.x = VGlobals.hlslcc_mtx4x4_rlMatrix[0].w;
    u_xlat2.x = (-u_xlat0.x) + VGlobals.hlslcc_mtx4x4_rrMatrix[0].w;
    u_xlat0.y = VGlobals.hlslcc_mtx4x4_rlMatrix[1].w;
    u_xlat2.y = (-u_xlat0.y) + VGlobals.hlslcc_mtx4x4_rrMatrix[1].w;
    u_xlat0.z = VGlobals.hlslcc_mtx4x4_rlMatrix[2].w;
    u_xlat2.z = (-u_xlat0.z) + VGlobals.hlslcc_mtx4x4_rrMatrix[2].w;
    u_xlat0.w = VGlobals.hlslcc_mtx4x4_rlMatrix[3].w;
    u_xlat2.w = (-u_xlat0.w) + VGlobals.hlslcc_mtx4x4_rrMatrix[3].w;
    u_xlat0 = fma(u_xlat2, u_xlat1.zzzz, u_xlat0);
    u_xlat2.x = VGlobals.hlslcc_mtx4x4_flMatrix[0].w;
    u_xlat3.x = (-u_xlat2.x) + VGlobals.hlslcc_mtx4x4_frMatrix[0].w;
    u_xlat2.y = VGlobals.hlslcc_mtx4x4_flMatrix[1].w;
    u_xlat3.y = (-u_xlat2.y) + VGlobals.hlslcc_mtx4x4_frMatrix[1].w;
    u_xlat2.z = VGlobals.hlslcc_mtx4x4_flMatrix[2].w;
    u_xlat3.z = (-u_xlat2.z) + VGlobals.hlslcc_mtx4x4_frMatrix[2].w;
    u_xlat2.w = VGlobals.hlslcc_mtx4x4_flMatrix[3].w;
    u_xlat3.w = (-u_xlat2.w) + VGlobals.hlslcc_mtx4x4_frMatrix[3].w;
    u_xlat2 = fma(u_xlat1.xxxx, u_xlat3, u_xlat2);
    u_xlat0 = u_xlat0 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat1.yyyy, u_xlat2);
    u_xlat0.x = dot(u_xlat0, input.POSITION0);
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, u_xlat0.xxx, u_xlat4.xyz);
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
    half4 _LightColor0;
    half4 _Color;
    half4 _AddColor;
    half4 _MinMSA;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_8;
    half2 u_xlat16_10;
    float u_xlat15;
    half u_xlat16_16;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xyz = float3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat15)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_1.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_3.xy = max(u_xlat16_10.xy, FGlobals._MinMSA.xy);
    u_xlat0.y = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = fma(FGlobals._Color.xyz, u_xlat16_5.xyz, FGlobals._AddColor.xyz);
    u_xlat16_4.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(u_xlat16_3.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_16 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat0.xxx * float3(u_xlat16_4.xyz));
    u_xlat16_3.xyz = fma(u_xlat16_8.xyz, half3(u_xlat16_16), u_xlat16_4.xyz);
    output.SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
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
    half4 _AddColor;
    half4 _MinMSA;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    float u_xlat8;
    float u_xlat12;
    half u_xlat16_12;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat12), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat16_2.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat16_2.xy, FGlobals._MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + half(1.0);
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = fma(u_xlat16_12, u_xlat16_12, half(1.5));
    u_xlat4.x = float(u_xlat16_12) * u_xlat4.x;
    u_xlat16_12 = fma(u_xlat16_2.x, u_xlat16_2.x, half(-1.0));
    u_xlat8 = fma(u_xlat8, float(u_xlat16_12), 1.00001001);
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = float(u_xlat16_2.x) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_3.xyz = u_xlat16_5.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_1.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat4.xyz = u_xlat4.xxx * float3(u_xlat16_3.xyz);
    u_xlat4.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xxx), u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
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
    half4 _AddColor;
    half4 _MinMSA;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    float u_xlat8;
    float u_xlat12;
    half u_xlat16_12;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat12), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat16_2.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat16_2.xy, FGlobals._MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + half(1.0);
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = fma(u_xlat16_12, u_xlat16_12, half(1.5));
    u_xlat4.x = float(u_xlat16_12) * u_xlat4.x;
    u_xlat16_12 = fma(u_xlat16_2.x, u_xlat16_2.x, half(-1.0));
    u_xlat8 = fma(u_xlat8, float(u_xlat16_12), 1.00001001);
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = float(u_xlat16_2.x) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_3.xyz = u_xlat16_5.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_1.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat4.xyz = u_xlat4.xxx * float3(u_xlat16_3.xyz);
    u_xlat4.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xxx), u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
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
    half4 _AddColor;
    half4 _MinMSA;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_8;
    half2 u_xlat16_10;
    float u_xlat15;
    half u_xlat16_16;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xyz = float3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat2.xyz = fma(u_xlat0.xyz, (-float3(u_xlat15)), u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_1.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_3.xy = max(u_xlat16_10.xy, FGlobals._MinMSA.xy);
    u_xlat0.y = (-float(u_xlat16_3.y)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = fma(FGlobals._Color.xyz, u_xlat16_5.xyz, FGlobals._AddColor.xyz);
    u_xlat16_4.xyz = u_xlat16_8.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = fma(u_xlat16_3.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_16 = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = half3(u_xlat0.xxx * float3(u_xlat16_4.xyz));
    u_xlat16_3.xyz = fma(u_xlat16_8.xyz, half3(u_xlat16_16), u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = input.TEXCOORD8;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_1.xyz) * u_xlat0.xxx;
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
    half4 _AddColor;
    half4 _MinMSA;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    float u_xlat8;
    float u_xlat12;
    half u_xlat16_12;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat12), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat16_2.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat16_2.xy, FGlobals._MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + half(1.0);
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = fma(u_xlat16_12, u_xlat16_12, half(1.5));
    u_xlat4.x = float(u_xlat16_12) * u_xlat4.x;
    u_xlat16_12 = fma(u_xlat16_2.x, u_xlat16_2.x, half(-1.0));
    u_xlat8 = fma(u_xlat8, float(u_xlat16_12), 1.00001001);
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = float(u_xlat16_2.x) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_3.xyz = u_xlat16_5.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_1.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat4.xyz = u_xlat4.xxx * float3(u_xlat16_3.xyz);
    u_xlat4.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xxx), u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat12 = input.TEXCOORD8;
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat12);
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
    half4 _AddColor;
    half4 _MinMSA;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(1) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    float u_xlat8;
    float u_xlat12;
    half u_xlat16_12;
    u_xlat16_0.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat0.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_1.xyz));
    u_xlat0.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_1.xyz));
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat12), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat4.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat4.x = max(u_xlat4.x, 0.319999993);
    u_xlat8 = u_xlat12 * u_xlat12;
    u_xlat16_2.xy = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xy;
    u_xlat16_1.xy = max(u_xlat16_2.xy, FGlobals._MinMSA.xy);
    u_xlat16_12 = (-u_xlat16_1.y) + half(1.0);
    u_xlat16_2.x = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = fma(u_xlat16_12, u_xlat16_12, half(1.5));
    u_xlat4.x = float(u_xlat16_12) * u_xlat4.x;
    u_xlat16_12 = fma(u_xlat16_2.x, u_xlat16_2.x, half(-1.0));
    u_xlat8 = fma(u_xlat8, float(u_xlat16_12), 1.00001001);
    u_xlat4.x = u_xlat8 * u_xlat4.x;
    u_xlat4.x = float(u_xlat16_2.x) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = fma(FGlobals._Color.xyz, u_xlat16_2.xyz, FGlobals._AddColor.xyz);
    u_xlat16_3.xyz = u_xlat16_5.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(u_xlat16_1.xxx, u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_1.x = fma((-u_xlat16_1.x), half(0.779083729), half(0.779083729));
    u_xlat4.xyz = u_xlat4.xxx * float3(u_xlat16_3.xyz);
    u_xlat4.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_1.xxx), u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat12 = input.TEXCOORD8;
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat12);
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
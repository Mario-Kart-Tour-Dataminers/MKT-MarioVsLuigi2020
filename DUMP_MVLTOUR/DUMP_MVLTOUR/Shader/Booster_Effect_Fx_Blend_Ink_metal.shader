//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_Ink" {
Properties {
_MainTex ("Texture", 2D) = "black" { }
_Color ("Color", Color) = (0,0,0,1)
_FinalTex ("Final Texture", 2D) = "black" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
 Pass {
  Name "SimpleCopy"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 11256
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_TARGET0 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)));
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
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_TARGET0 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)));
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
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_TARGET0 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)));
    return output;
}
"
}
}
}
 Pass {
  Name "InkPaint"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 88646
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
    float4 hlslcc_mtx4x4_affineTrans[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.xyz = input.POSITION0.yyy * VGlobals.hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[0].xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[2].xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = half2(input.TEXCOORD0.xy);
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
    float4 hlslcc_mtx4x4_affineTrans[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.xyz = input.POSITION0.yyy * VGlobals.hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[0].xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[2].xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = half2(input.TEXCOORD0.xy);
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
    float4 hlslcc_mtx4x4_affineTrans[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.xyz = input.POSITION0.yyy * VGlobals.hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[0].xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[2].xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = half2(input.TEXCOORD0.xy);
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
    float4 _fadingConsts;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float u_xlat1;
    bool u_xlatb1;
    float u_xlat3;
    float u_xlat5;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).x;
    u_xlat0.z = (-float(u_xlat16_0)) + 1.0;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(FGlobals._fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    output.SV_TARGET0 = u_xlat0 * float4(u_xlat1);
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
    float4 _fadingConsts;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float u_xlat1;
    bool u_xlatb1;
    float u_xlat3;
    float u_xlat5;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).x;
    u_xlat0.z = (-float(u_xlat16_0)) + 1.0;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(FGlobals._fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    output.SV_TARGET0 = u_xlat0 * float4(u_xlat1);
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
    float4 _fadingConsts;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float u_xlat1;
    bool u_xlatb1;
    float u_xlat3;
    float u_xlat5;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).x;
    u_xlat0.z = (-float(u_xlat16_0)) + 1.0;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat3 = max(FGlobals._fadingConsts.x, 0.0);
    u_xlat5 = trunc(u_xlat3);
    u_xlat0.y = (-u_xlat5) + u_xlat3;
    u_xlat0.x = u_xlat5 * 0.015625;
    u_xlat0.w = 0.0;
    output.SV_TARGET0 = u_xlat0 * float4(u_xlat1);
    return output;
}
"
}
}
}
 Pass {
  Name "InkAging"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 154450
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 _requiredSize;
    float4 _fadingConsts;
    float4 _touchPoints;
    float4 _agingValues;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    float u_xlat2;
    float u_xlat3;
    float u_xlat6;
    float u_xlat9;
    bool u_xlatb9;
    u_xlat0.xy = (-FGlobals._touchPoints.yx) + FGlobals._touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb9 = 0.0>=u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = float4(input.TEXCOORD0.xyxy) + (-FGlobals._inkOffset.xyxy);
    u_xlat1 = fma(FGlobals._requiredSize.xyxy, u_xlat1, (-FGlobals._touchPoints));
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = fma(u_xlat0.x, u_xlat1.x, (-u_xlat2));
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
    u_xlatb0.z = u_xlat6<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xz));
    u_xlat3 = fma(u_xlat0.z, u_xlat9, u_xlat3);
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat6, u_xlat3);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-FGlobals._fadingConsts.z);
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).xzwy);
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, FGlobals._fadingConsts.x);
    u_xlat3 = u_xlat3 + (-FGlobals._agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    output.SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    output.SV_TARGET0.x = u_xlat3 * 0.015625;
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
    float4 _requiredSize;
    float4 _fadingConsts;
    float4 _touchPoints;
    float4 _agingValues;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    float u_xlat2;
    float u_xlat3;
    float u_xlat6;
    float u_xlat9;
    bool u_xlatb9;
    u_xlat0.xy = (-FGlobals._touchPoints.yx) + FGlobals._touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb9 = 0.0>=u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = float4(input.TEXCOORD0.xyxy) + (-FGlobals._inkOffset.xyxy);
    u_xlat1 = fma(FGlobals._requiredSize.xyxy, u_xlat1, (-FGlobals._touchPoints));
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = fma(u_xlat0.x, u_xlat1.x, (-u_xlat2));
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
    u_xlatb0.z = u_xlat6<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xz));
    u_xlat3 = fma(u_xlat0.z, u_xlat9, u_xlat3);
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat6, u_xlat3);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-FGlobals._fadingConsts.z);
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).xzwy);
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, FGlobals._fadingConsts.x);
    u_xlat3 = u_xlat3 + (-FGlobals._agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    output.SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    output.SV_TARGET0.x = u_xlat3 * 0.015625;
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
    float4 _requiredSize;
    float4 _fadingConsts;
    float4 _touchPoints;
    float4 _agingValues;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    float u_xlat2;
    float u_xlat3;
    float u_xlat6;
    float u_xlat9;
    bool u_xlatb9;
    u_xlat0.xy = (-FGlobals._touchPoints.yx) + FGlobals._touchPoints.wz;
    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb9 = 0.0>=u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat9 = max(u_xlat9, u_xlat6);
    u_xlat1 = float4(input.TEXCOORD0.xyxy) + (-FGlobals._inkOffset.xyxy);
    u_xlat1 = fma(FGlobals._requiredSize.xyxy, u_xlat1, (-FGlobals._touchPoints));
    u_xlat2 = u_xlat0.y * u_xlat1.y;
    u_xlat2 = fma(u_xlat0.x, u_xlat1.x, (-u_xlat2));
    u_xlat0.x = dot(u_xlat1.yx, u_xlat0.xy);
    u_xlat3 = u_xlat2 * u_xlat2;
    u_xlat3 = u_xlat3 / u_xlat9;
    u_xlat9 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = (-u_xlat3) + u_xlat9;
    u_xlatb0.z = u_xlat6<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xz));
    u_xlat3 = fma(u_xlat0.z, u_xlat9, u_xlat3);
    u_xlat6 = (-u_xlat3) + u_xlat1.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat6, u_xlat3);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-FGlobals._fadingConsts.z);
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).xzwy);
    u_xlat3 = u_xlat1.x * 64.0;
    u_xlat3 = floor(u_xlat3);
    u_xlat3 = u_xlat1.w + u_xlat3;
    u_xlat3 = min(u_xlat3, FGlobals._fadingConsts.x);
    u_xlat3 = u_xlat3 + (-FGlobals._agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat3;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = trunc(u_xlat0.x);
    output.SV_TARGET0.y = (-u_xlat3) + u_xlat0.x;
    output.SV_TARGET0.x = u_xlat3 * 0.015625;
    return output;
}
"
}
}
}
 Pass {
  Name "InkDraw"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 235358
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 _Color;
    float4 _fadingConsts;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_FinalTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _FinalTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    u_xlat0.xy = float2(input.TEXCOORD0.xy) + FGlobals._inkOffset.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _FinalTex.sample(sampler_FinalTex, u_xlat0.xy).xyz;
    output.SV_TARGET0.xyz = float3(u_xlat16_0.xyz) * FGlobals._Color.xyz;
    u_xlat0.x = float(u_xlat16_1.x) * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = float(u_xlat16_1.y) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    output.SV_TARGET0.w = u_xlat0.x * FGlobals._Color.w;
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
    float4 _Color;
    float4 _fadingConsts;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_FinalTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _FinalTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    u_xlat0.xy = float2(input.TEXCOORD0.xy) + FGlobals._inkOffset.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _FinalTex.sample(sampler_FinalTex, u_xlat0.xy).xyz;
    output.SV_TARGET0.xyz = float3(u_xlat16_0.xyz) * FGlobals._Color.xyz;
    u_xlat0.x = float(u_xlat16_1.x) * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = float(u_xlat16_1.y) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    output.SV_TARGET0.w = u_xlat0.x * FGlobals._Color.w;
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
    float4 _Color;
    float4 _fadingConsts;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_FinalTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _FinalTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    u_xlat0.xy = float2(input.TEXCOORD0.xy) + FGlobals._inkOffset.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _FinalTex.sample(sampler_FinalTex, u_xlat0.xy).xyz;
    output.SV_TARGET0.xyz = float3(u_xlat16_0.xyz) * FGlobals._Color.xyz;
    u_xlat0.x = float(u_xlat16_1.x) * 64.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = float(u_xlat16_1.y) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.y;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * 1.57079637;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_1.z);
    output.SV_TARGET0.w = u_xlat0.x * FGlobals._Color.w;
    return output;
}
"
}
}
}
 Pass {
  Name "InkCopy"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 281734
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
    float4 hlslcc_mtx4x4_affineTrans[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.xyz = input.POSITION0.yyy * VGlobals.hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[0].xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[2].xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = half2(input.TEXCOORD0.xy);
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
    float4 hlslcc_mtx4x4_affineTrans[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.xyz = input.POSITION0.yyy * VGlobals.hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[0].xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[2].xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = half2(input.TEXCOORD0.xy);
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
    float4 hlslcc_mtx4x4_affineTrans[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.xyz = input.POSITION0.yyy * VGlobals.hlslcc_mtx4x4_affineTrans[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[0].xyz, input.POSITION0.xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[2].xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4_affineTrans[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = half2(input.TEXCOORD0.xy);
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
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_TARGET0 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)));
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
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_TARGET0 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)));
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
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_TARGET0 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)));
    return output;
}
"
}
}
}
 Pass {
  Name "InkAging2"
  Tags { "IGNOREPROJECTOR" = "true" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 328269
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
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
    float4 _requiredSize;
    float4 _fadingConsts;
    float4 _touchPoints;
    float4 _touchPointsSecond;
    float4 _agingValues;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float u_xlat8;
    bool u_xlatb8;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.xy = (-FGlobals._touchPoints.yx) + FGlobals._touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb12 = 0.0>=u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = float4(input.TEXCOORD0.xyxy) + (-FGlobals._inkOffset.xyxy);
    u_xlat2 = fma(FGlobals._requiredSize.xyxy, u_xlat1.zwzw, (-FGlobals._touchPoints));
    u_xlat1 = fma(FGlobals._requiredSize.xyxy, u_xlat1, (-FGlobals._touchPointsSecond));
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = fma(u_xlat0.x, u_xlat2.x, (-u_xlat3));
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
    u_xlatb0.z = u_xlat8<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xz));
    u_xlat4.x = fma(u_xlat0.z, u_xlat12, u_xlat4.x);
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat8, u_xlat4.x);
    u_xlat4.xy = (-FGlobals._touchPointsSecond.yx) + FGlobals._touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = fma(u_xlat4.x, u_xlat1.x, (-u_xlat12));
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
    u_xlatb8 = 0.0>=u_xlat2.x;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
    u_xlatb4 = 0.0>=u_xlat4.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = fma(u_xlat2.x, u_xlat12, u_xlat8);
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = fma(u_xlat4.x, u_xlat12, u_xlat8);
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-FGlobals._fadingConsts.z);
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).xzwy);
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, FGlobals._fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-FGlobals._agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    output.SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    output.SV_TARGET0.x = u_xlat4.x * 0.015625;
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
    float4 _requiredSize;
    float4 _fadingConsts;
    float4 _touchPoints;
    float4 _touchPointsSecond;
    float4 _agingValues;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float u_xlat8;
    bool u_xlatb8;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.xy = (-FGlobals._touchPoints.yx) + FGlobals._touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb12 = 0.0>=u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = float4(input.TEXCOORD0.xyxy) + (-FGlobals._inkOffset.xyxy);
    u_xlat2 = fma(FGlobals._requiredSize.xyxy, u_xlat1.zwzw, (-FGlobals._touchPoints));
    u_xlat1 = fma(FGlobals._requiredSize.xyxy, u_xlat1, (-FGlobals._touchPointsSecond));
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = fma(u_xlat0.x, u_xlat2.x, (-u_xlat3));
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
    u_xlatb0.z = u_xlat8<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xz));
    u_xlat4.x = fma(u_xlat0.z, u_xlat12, u_xlat4.x);
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat8, u_xlat4.x);
    u_xlat4.xy = (-FGlobals._touchPointsSecond.yx) + FGlobals._touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = fma(u_xlat4.x, u_xlat1.x, (-u_xlat12));
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
    u_xlatb8 = 0.0>=u_xlat2.x;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
    u_xlatb4 = 0.0>=u_xlat4.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = fma(u_xlat2.x, u_xlat12, u_xlat8);
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = fma(u_xlat4.x, u_xlat12, u_xlat8);
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-FGlobals._fadingConsts.z);
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).xzwy);
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, FGlobals._fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-FGlobals._agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    output.SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    output.SV_TARGET0.x = u_xlat4.x * 0.015625;
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
    float4 _requiredSize;
    float4 _fadingConsts;
    float4 _touchPoints;
    float4 _touchPointsSecond;
    float4 _agingValues;
    float4 _inkOffset;
};

struct Mtl_FragmentIn
{
    half2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float u_xlat8;
    bool u_xlatb8;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.xy = (-FGlobals._touchPoints.yx) + FGlobals._touchPoints.wz;
    u_xlat8 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb12 = 0.0>=u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat12 = max(u_xlat12, u_xlat8);
    u_xlat1 = float4(input.TEXCOORD0.xyxy) + (-FGlobals._inkOffset.xyxy);
    u_xlat2 = fma(FGlobals._requiredSize.xyxy, u_xlat1.zwzw, (-FGlobals._touchPoints));
    u_xlat1 = fma(FGlobals._requiredSize.xyxy, u_xlat1, (-FGlobals._touchPointsSecond));
    u_xlat3 = u_xlat0.y * u_xlat2.y;
    u_xlat3 = fma(u_xlat0.x, u_xlat2.x, (-u_xlat3));
    u_xlat0.x = dot(u_xlat2.yx, u_xlat0.xy);
    u_xlat4.x = u_xlat3 * u_xlat3;
    u_xlat4.x = u_xlat4.x / u_xlat12;
    u_xlat12 = dot(u_xlat2.zw, u_xlat2.zw);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat12 = (-u_xlat4.x) + u_xlat12;
    u_xlatb0.z = u_xlat8<u_xlat0.x;
    u_xlatb0.x = 0.0>=u_xlat0.x;
    u_xlat0.xz = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xz));
    u_xlat4.x = fma(u_xlat0.z, u_xlat12, u_xlat4.x);
    u_xlat8 = (-u_xlat4.x) + u_xlat2.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat8, u_xlat4.x);
    u_xlat4.xy = (-FGlobals._touchPointsSecond.yx) + FGlobals._touchPointsSecond.wz;
    u_xlat12 = u_xlat1.y * u_xlat4.y;
    u_xlat12 = fma(u_xlat4.x, u_xlat1.x, (-u_xlat12));
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat2.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = dot(u_xlat1.yx, u_xlat4.xy);
    u_xlatb8 = 0.0>=u_xlat2.x;
    u_xlat8 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = max(u_xlat8, u_xlat2.x);
    u_xlatb2 = u_xlat2.x<u_xlat4.x;
    u_xlatb4 = 0.0>=u_xlat4.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat8 = u_xlat12 / u_xlat8;
    u_xlat12 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat12 = (-u_xlat8) + u_xlat12;
    u_xlat8 = fma(u_xlat2.x, u_xlat12, u_xlat8);
    u_xlat12 = (-u_xlat8) + u_xlat1.x;
    u_xlat4.x = fma(u_xlat4.x, u_xlat12, u_xlat8);
    u_xlat0.x = min(u_xlat4.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-FGlobals._fadingConsts.z);
    u_xlat0.x = u_xlat0.x * FGlobals._fadingConsts.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = float4(_MainTex.sample(sampler_MainTex, float2(input.TEXCOORD0.xy)).xzwy);
    u_xlat4.x = u_xlat1.x * 64.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = u_xlat1.w + u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, FGlobals._fadingConsts.x);
    u_xlat4.x = u_xlat4.x + (-FGlobals._agingValues.w);
    u_xlat1.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0.x = 0.0<u_xlat1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_TARGET0.zw = u_xlat0.yz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.x = trunc(u_xlat0.x);
    output.SV_TARGET0.y = (-u_xlat4.x) + u_xlat0.x;
    output.SV_TARGET0.x = u_xlat4.x * 0.015625;
    return output;
}
"
}
}
}
}
}
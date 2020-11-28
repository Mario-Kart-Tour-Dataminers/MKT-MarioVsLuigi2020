//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI(Booster)/UIImageBlur" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 3742
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
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
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
    float _scale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD0.xy + float2(FGlobals._scale);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(float4(FGlobals._scale), float4(-1.0, 1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(-1.0, -1.0, -2.0, 2.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat2.xy = fma(float2(FGlobals._scale), float2(2.0, 2.0), input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(2.0, -2.0, -2.0, -2.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(3.0, 3.0, -3.0, 3.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(3.0, -3.0, -3.0, -3.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * half4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
    output.SV_Target0 = u_xlat16_0;
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
    float _scale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD0.xy + float2(FGlobals._scale);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(float4(FGlobals._scale), float4(-1.0, 1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(-1.0, -1.0, -2.0, 2.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat2.xy = fma(float2(FGlobals._scale), float2(2.0, 2.0), input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(2.0, -2.0, -2.0, -2.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(3.0, 3.0, -3.0, 3.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(3.0, -3.0, -3.0, -3.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * half4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
    output.SV_Target0 = u_xlat16_0;
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
    float _scale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD0.xy + float2(FGlobals._scale);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(float4(FGlobals._scale), float4(-1.0, 1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(-1.0, -1.0, -2.0, 2.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat2.xy = fma(float2(FGlobals._scale), float2(2.0, 2.0), input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(2.0, -2.0, -2.0, -2.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(3.0, 3.0, -3.0, 3.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1 = fma(float4(FGlobals._scale), float4(3.0, -3.0, -3.0, -3.0), input.TEXCOORD0.xyxy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * half4(0.0769230798, 0.0769230798, 0.0769230798, 0.0769230798);
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
}
}
}
}
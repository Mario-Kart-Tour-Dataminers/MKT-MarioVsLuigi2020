//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Shadow/SeparableBlur" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 50780
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
    float4 offsets;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = float2(input.TEXCOORD0.xy);
    output.TEXCOORD1 = fma(VGlobals.offsets.xyxy, float4(1.0, 1.0, -1.0, -1.0), float4(input.TEXCOORD0.xyxy));
    output.TEXCOORD2 = fma(VGlobals.offsets.xyxy, float4(2.0, 2.0, -2.0, -2.0), float4(input.TEXCOORD0.xyxy));
    output.TEXCOORD3 = fma(VGlobals.offsets.xyxy, float4(3.0, 3.0, -3.0, -3.0), float4(input.TEXCOORD0.xyxy));
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
    float4 offsets;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = float2(input.TEXCOORD0.xy);
    output.TEXCOORD1 = fma(VGlobals.offsets.xyxy, float4(1.0, 1.0, -1.0, -1.0), float4(input.TEXCOORD0.xyxy));
    output.TEXCOORD2 = fma(VGlobals.offsets.xyxy, float4(2.0, 2.0, -2.0, -2.0), float4(input.TEXCOORD0.xyxy));
    output.TEXCOORD3 = fma(VGlobals.offsets.xyxy, float4(3.0, 3.0, -3.0, -3.0), float4(input.TEXCOORD0.xyxy));
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
    float4 offsets;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = float2(input.TEXCOORD0.xy);
    output.TEXCOORD1 = fma(VGlobals.offsets.xyxy, float4(1.0, 1.0, -1.0, -1.0), float4(input.TEXCOORD0.xyxy));
    output.TEXCOORD2 = fma(VGlobals.offsets.xyxy, float4(2.0, 2.0, -2.0, -2.0), float4(input.TEXCOORD0.xyxy));
    output.TEXCOORD3 = fma(VGlobals.offsets.xyxy, float4(3.0, 3.0, -3.0, -3.0), float4(input.TEXCOORD0.xyxy));
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * half4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.400000006, 0.400000006, 0.400000006, 0.400000006), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.150000006, 0.150000006, 0.150000006, 0.150000006), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * half4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.400000006, 0.400000006, 0.400000006, 0.400000006), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.150000006, 0.150000006, 0.150000006, 0.150000006), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * half4(0.150000006, 0.150000006, 0.150000006, 0.150000006);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.400000006, 0.400000006, 0.400000006, 0.400000006), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.150000006, 0.150000006, 0.150000006, 0.150000006), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.100000001, 0.100000001, 0.100000001, 0.100000001), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_0);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw);
    u_xlat16_0 = fma(u_xlat16_1, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_0);
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
}
}
}
}
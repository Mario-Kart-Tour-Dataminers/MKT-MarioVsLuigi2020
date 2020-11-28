//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Bloom" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 63068
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float u_xlat7;
    float u_xlat19;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._MainTex_TexelSize.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(0.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat3.xy = input.TEXCOORD0.xy;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0f, 1.0f);
    u_xlat3.xy = u_xlat3.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat4 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 * half4(0.03125, 0.03125, 0.03125, 0.03125);
    u_xlat16_0 = fma(u_xlat16_0, half4(0.125, 0.125, 0.125, 0.125), u_xlat16_1);
    u_xlat16_1 = u_xlat16_2 + u_xlat16_4;
    u_xlat16_2 = u_xlat16_3 + u_xlat16_4;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_4 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_4;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat16_0 = min(u_xlat16_0, half4(65504.0, 65504.0, 65504.0, 65504.0));
    u_xlat16_1.x = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.xxxx;
    u_xlat0 = min(float4(u_xlat16_0), FGlobals._Params.xxxx);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
    u_xlat1.yz = u_xlat1.xx + (-FGlobals._Threshold.yx);
    u_xlat1.xy = max(u_xlat1.xy, float2(9.99999975e-05, 0.0));
    u_xlat7 = min(u_xlat1.y, FGlobals._Threshold.z);
    u_xlat19 = u_xlat7 * FGlobals._Threshold.w;
    u_xlat7 = u_xlat7 * u_xlat19;
    u_xlat7 = max(u_xlat1.z, u_xlat7);
    u_xlat1.x = u_xlat7 / u_xlat1.x;
    output.SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float u_xlat7;
    float u_xlat19;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._MainTex_TexelSize.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(0.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat3.xy = input.TEXCOORD0.xy;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0f, 1.0f);
    u_xlat3.xy = u_xlat3.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat4 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 * half4(0.03125, 0.03125, 0.03125, 0.03125);
    u_xlat16_0 = fma(u_xlat16_0, half4(0.125, 0.125, 0.125, 0.125), u_xlat16_1);
    u_xlat16_1 = u_xlat16_2 + u_xlat16_4;
    u_xlat16_2 = u_xlat16_3 + u_xlat16_4;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_4 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_4;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat16_0 = min(u_xlat16_0, half4(65504.0, 65504.0, 65504.0, 65504.0));
    u_xlat16_1.x = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.xxxx;
    u_xlat0 = min(float4(u_xlat16_0), FGlobals._Params.xxxx);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
    u_xlat1.yz = u_xlat1.xx + (-FGlobals._Threshold.yx);
    u_xlat1.xy = max(u_xlat1.xy, float2(9.99999975e-05, 0.0));
    u_xlat7 = min(u_xlat1.y, FGlobals._Threshold.z);
    u_xlat19 = u_xlat7 * FGlobals._Threshold.w;
    u_xlat7 = u_xlat7 * u_xlat19;
    u_xlat7 = max(u_xlat1.z, u_xlat7);
    u_xlat1.x = u_xlat7 / u_xlat1.x;
    output.SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    float u_xlat7;
    float u_xlat19;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._MainTex_TexelSize.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(0.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat3.xy = input.TEXCOORD0.xy;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0f, 1.0f);
    u_xlat3.xy = u_xlat3.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat4 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 * half4(0.03125, 0.03125, 0.03125, 0.03125);
    u_xlat16_0 = fma(u_xlat16_0, half4(0.125, 0.125, 0.125, 0.125), u_xlat16_1);
    u_xlat16_1 = u_xlat16_2 + u_xlat16_4;
    u_xlat16_2 = u_xlat16_3 + u_xlat16_4;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_4 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_4;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat16_0 = min(u_xlat16_0, half4(65504.0, 65504.0, 65504.0, 65504.0));
    u_xlat16_1.x = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.xxxx;
    u_xlat0 = min(float4(u_xlat16_0), FGlobals._Params.xxxx);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
    u_xlat1.yz = u_xlat1.xx + (-FGlobals._Threshold.yx);
    u_xlat1.xy = max(u_xlat1.xy, float2(9.99999975e-05, 0.0));
    u_xlat7 = min(u_xlat1.y, FGlobals._Threshold.z);
    u_xlat19 = u_xlat7 * FGlobals._Threshold.w;
    u_xlat7 = u_xlat7 * u_xlat19;
    u_xlat7 = max(u_xlat1.z, u_xlat7);
    u_xlat1.x = u_xlat7 / u_xlat1.x;
    output.SV_Target0 = u_xlat0 * u_xlat1.xxxx;
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 123788
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float u_xlat4;
    float u_xlat10;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * half4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = min(u_xlat16_0, half4(65504.0, 65504.0, 65504.0, 65504.0));
    u_xlat16_1.x = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.xxxx;
    u_xlat0 = min(float4(u_xlat16_0), FGlobals._Params.xxxx);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
    u_xlat1.yz = u_xlat1.xx + (-FGlobals._Threshold.yx);
    u_xlat1.xy = max(u_xlat1.xy, float2(9.99999975e-05, 0.0));
    u_xlat4 = min(u_xlat1.y, FGlobals._Threshold.z);
    u_xlat10 = u_xlat4 * FGlobals._Threshold.w;
    u_xlat4 = u_xlat4 * u_xlat10;
    u_xlat4 = max(u_xlat1.z, u_xlat4);
    u_xlat1.x = u_xlat4 / u_xlat1.x;
    output.SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float u_xlat4;
    float u_xlat10;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * half4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = min(u_xlat16_0, half4(65504.0, 65504.0, 65504.0, 65504.0));
    u_xlat16_1.x = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.xxxx;
    u_xlat0 = min(float4(u_xlat16_0), FGlobals._Params.xxxx);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
    u_xlat1.yz = u_xlat1.xx + (-FGlobals._Threshold.yx);
    u_xlat1.xy = max(u_xlat1.xy, float2(9.99999975e-05, 0.0));
    u_xlat4 = min(u_xlat1.y, FGlobals._Threshold.z);
    u_xlat10 = u_xlat4 * FGlobals._Threshold.w;
    u_xlat4 = u_xlat4 * u_xlat10;
    u_xlat4 = max(u_xlat1.z, u_xlat4);
    u_xlat1.x = u_xlat4 / u_xlat1.x;
    output.SV_Target0 = u_xlat0 * u_xlat1.xxxx;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float u_xlat4;
    float u_xlat10;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * half4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = min(u_xlat16_0, half4(65504.0, 65504.0, 65504.0, 65504.0));
    u_xlat16_1.x = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1.xxxx;
    u_xlat0 = min(float4(u_xlat16_0), FGlobals._Params.xxxx);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.z, u_xlat1.x);
    u_xlat1.yz = u_xlat1.xx + (-FGlobals._Threshold.yx);
    u_xlat1.xy = max(u_xlat1.xy, float2(9.99999975e-05, 0.0));
    u_xlat4 = min(u_xlat1.y, FGlobals._Threshold.z);
    u_xlat10 = u_xlat4 * FGlobals._Threshold.w;
    u_xlat4 = u_xlat4 * u_xlat10;
    u_xlat4 = max(u_xlat1.z, u_xlat4);
    u_xlat1.x = u_xlat4 / u_xlat1.x;
    output.SV_Target0 = u_xlat0 * u_xlat1.xxxx;
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 174891
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._MainTex_TexelSize.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(0.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat3.xy = input.TEXCOORD0.xy;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0f, 1.0f);
    u_xlat3.xy = u_xlat3.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat4 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 * half4(0.03125, 0.03125, 0.03125, 0.03125);
    u_xlat16_0 = fma(u_xlat16_0, half4(0.125, 0.125, 0.125, 0.125), u_xlat16_1);
    u_xlat16_1 = u_xlat16_2 + u_xlat16_4;
    u_xlat16_2 = u_xlat16_3 + u_xlat16_4;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_4 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_4;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    output.SV_Target0 = fma(float4(u_xlat16_1), float4(0.03125, 0.03125, 0.03125, 0.03125), float4(u_xlat16_0));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._MainTex_TexelSize.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(0.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat3.xy = input.TEXCOORD0.xy;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0f, 1.0f);
    u_xlat3.xy = u_xlat3.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat4 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 * half4(0.03125, 0.03125, 0.03125, 0.03125);
    u_xlat16_0 = fma(u_xlat16_0, half4(0.125, 0.125, 0.125, 0.125), u_xlat16_1);
    u_xlat16_1 = u_xlat16_2 + u_xlat16_4;
    u_xlat16_2 = u_xlat16_3 + u_xlat16_4;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_4 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_4;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    output.SV_Target0 = fma(float4(u_xlat16_1), float4(0.03125, 0.03125, 0.03125, 0.03125), float4(u_xlat16_0));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half4 u_xlat16_5;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._MainTex_TexelSize.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(0.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat3.xy = input.TEXCOORD0.xy;
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0f, 1.0f);
    u_xlat3.xy = u_xlat3.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
    u_xlat4 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_5;
    u_xlat16_5 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 * half4(0.03125, 0.03125, 0.03125, 0.03125);
    u_xlat16_0 = fma(u_xlat16_0, half4(0.125, 0.125, 0.125, 0.125), u_xlat16_1);
    u_xlat16_1 = u_xlat16_2 + u_xlat16_4;
    u_xlat16_2 = u_xlat16_3 + u_xlat16_4;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_4 = u_xlat16_3 + u_xlat16_5;
    u_xlat16_1 = u_xlat16_1 + u_xlat16_4;
    u_xlat16_0 = fma(u_xlat16_1, half4(0.03125, 0.03125, 0.03125, 0.03125), u_xlat16_0);
    u_xlat1.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_1 = u_xlat16_3 + u_xlat16_1;
    output.SV_Target0 = fma(float4(u_xlat16_1), float4(0.03125, 0.03125, 0.03125, 0.03125), float4(u_xlat16_0));
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 261858
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    output.SV_Target0 = float4(u_xlat16_0) * float4(0.25, 0.25, 0.25, 0.25);
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    output.SV_Target0 = float4(u_xlat16_0) * float4(0.25, 0.25, 0.25, 0.25);
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, -1.0, 1.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    output.SV_Target0 = float4(u_xlat16_0) * float4(0.25, 0.25, 0.25, 0.25);
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 278575
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BloomTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BloomTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half4 u_xlat16_5;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat1.x = 1.0;
    u_xlat1.z = FGlobals._SampleScale;
    u_xlat1 = u_xlat1.xxzz * FGlobals._MainTex_TexelSize.xyxy;
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.0);
    u_xlat2.x = FGlobals._SampleScale;
    u_xlat3 = fma((-u_xlat1.xywy), u_xlat2.xxwx, input.TEXCOORD0.xyxy);
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.zw);
    u_xlat16_3 = fma(u_xlat16_3, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_4);
    u_xlat4.xy = fma((-u_xlat1.zy), u_xlat2.zx, input.TEXCOORD0.xy);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
    u_xlat4 = fma(u_xlat1.zwxw, u_xlat2.zwxw, input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat1.zywy, u_xlat2.zxwx, input.TEXCOORD0.xyxy);
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat1.xy = fma(u_xlat1.xy, u_xlat2.xx, input.TEXCOORD0.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = u_xlat5 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_3 = fma(u_xlat16_5, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_3);
    u_xlat16_0 = fma(u_xlat16_0, half4(4.0, 4.0, 4.0, 4.0), u_xlat16_3);
    u_xlat16_0 = fma(u_xlat16_4, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_0);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = fma(u_xlat16_2, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_0);
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = _BloomTex.sample(sampler_BloomTex, input.TEXCOORD1.xy);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.0625, 0.0625, 0.0625, 0.0625), float4(u_xlat16_1));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BloomTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BloomTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half4 u_xlat16_5;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat1.x = 1.0;
    u_xlat1.z = FGlobals._SampleScale;
    u_xlat1 = u_xlat1.xxzz * FGlobals._MainTex_TexelSize.xyxy;
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.0);
    u_xlat2.x = FGlobals._SampleScale;
    u_xlat3 = fma((-u_xlat1.xywy), u_xlat2.xxwx, input.TEXCOORD0.xyxy);
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.zw);
    u_xlat16_3 = fma(u_xlat16_3, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_4);
    u_xlat4.xy = fma((-u_xlat1.zy), u_xlat2.zx, input.TEXCOORD0.xy);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
    u_xlat4 = fma(u_xlat1.zwxw, u_xlat2.zwxw, input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat1.zywy, u_xlat2.zxwx, input.TEXCOORD0.xyxy);
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat1.xy = fma(u_xlat1.xy, u_xlat2.xx, input.TEXCOORD0.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = u_xlat5 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_3 = fma(u_xlat16_5, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_3);
    u_xlat16_0 = fma(u_xlat16_0, half4(4.0, 4.0, 4.0, 4.0), u_xlat16_3);
    u_xlat16_0 = fma(u_xlat16_4, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_0);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = fma(u_xlat16_2, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_0);
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = _BloomTex.sample(sampler_BloomTex, input.TEXCOORD1.xy);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.0625, 0.0625, 0.0625, 0.0625), float4(u_xlat16_1));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BloomTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BloomTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float4 u_xlat5;
    half4 u_xlat16_5;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat1.x = 1.0;
    u_xlat1.z = FGlobals._SampleScale;
    u_xlat1 = u_xlat1.xxzz * FGlobals._MainTex_TexelSize.xyxy;
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.0);
    u_xlat2.x = FGlobals._SampleScale;
    u_xlat3 = fma((-u_xlat1.xywy), u_xlat2.xxwx, input.TEXCOORD0.xyxy);
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.zw);
    u_xlat16_3 = fma(u_xlat16_3, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_4);
    u_xlat4.xy = fma((-u_xlat1.zy), u_xlat2.zx, input.TEXCOORD0.xy);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
    u_xlat4 = fma(u_xlat1.zwxw, u_xlat2.zwxw, input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat1.zywy, u_xlat2.zxwx, input.TEXCOORD0.xyxy);
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat1.xy = fma(u_xlat1.xy, u_xlat2.xx, input.TEXCOORD0.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat2 = u_xlat5 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.zw);
    u_xlat16_3 = fma(u_xlat16_5, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_3);
    u_xlat16_0 = fma(u_xlat16_0, half4(4.0, 4.0, 4.0, 4.0), u_xlat16_3);
    u_xlat16_0 = fma(u_xlat16_4, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_0);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = fma(u_xlat16_2, half4(2.0, 2.0, 2.0, 2.0), u_xlat16_0);
    u_xlat16_0 = u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = _BloomTex.sample(sampler_BloomTex, input.TEXCOORD1.xy);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.0625, 0.0625, 0.0625, 0.0625), float4(u_xlat16_1));
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 332011
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BloomTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BloomTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    u_xlat0 = FGlobals._MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.x = FGlobals._SampleScale * 0.5;
    u_xlat2 = fma(u_xlat0.xyzy, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xwzw, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = _BloomTex.sample(sampler_BloomTex, input.TEXCOORD1.xy);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.25, 0.25, 0.25, 0.25), float4(u_xlat16_1));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BloomTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BloomTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    u_xlat0 = FGlobals._MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.x = FGlobals._SampleScale * 0.5;
    u_xlat2 = fma(u_xlat0.xyzy, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xwzw, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = _BloomTex.sample(sampler_BloomTex, input.TEXCOORD1.xy);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.25, 0.25, 0.25, 0.25), float4(u_xlat16_1));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BloomTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BloomTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    u_xlat0 = FGlobals._MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.x = FGlobals._SampleScale * 0.5;
    u_xlat2 = fma(u_xlat0.xyzy, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xwzw, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = _BloomTex.sample(sampler_BloomTex, input.TEXCOORD1.xy);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.25, 0.25, 0.25, 0.25), float4(u_xlat16_1));
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 431202
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float2 u_xlat1;
    float u_xlat5;
    float u_xlat6;
    half u_xlat16_6;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, half3(65504.0, 65504.0, 65504.0));
    u_xlat16_6 = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0.xyz = half3(u_xlat16_6) * u_xlat16_0.xyz;
    u_xlat0.xyz = min(float3(u_xlat16_0.xyz), FGlobals._Params.xxx);
    u_xlat6 = max(u_xlat0.y, u_xlat0.x);
    u_xlat6 = max(u_xlat0.z, u_xlat6);
    u_xlat1.xy = float2(u_xlat6) + (-FGlobals._Threshold.yx);
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, FGlobals._Threshold.z);
    u_xlat5 = u_xlat1.x * FGlobals._Threshold.w;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat1.x = max(u_xlat1.y, u_xlat1.x);
    u_xlat6 = u_xlat1.x / u_xlat6;
    output.SV_Target0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
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
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float2 u_xlat1;
    float u_xlat5;
    float u_xlat6;
    half u_xlat16_6;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, half3(65504.0, 65504.0, 65504.0));
    u_xlat16_6 = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0.xyz = half3(u_xlat16_6) * u_xlat16_0.xyz;
    u_xlat0.xyz = min(float3(u_xlat16_0.xyz), FGlobals._Params.xxx);
    u_xlat6 = max(u_xlat0.y, u_xlat0.x);
    u_xlat6 = max(u_xlat0.z, u_xlat6);
    u_xlat1.xy = float2(u_xlat6) + (-FGlobals._Threshold.yx);
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, FGlobals._Threshold.z);
    u_xlat5 = u_xlat1.x * FGlobals._Threshold.w;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat1.x = max(u_xlat1.y, u_xlat1.x);
    u_xlat6 = u_xlat1.x / u_xlat6;
    output.SV_Target0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
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
    float4 _Threshold;
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AutoExposureTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AutoExposureTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float2 u_xlat1;
    float u_xlat5;
    float u_xlat6;
    half u_xlat16_6;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, half3(65504.0, 65504.0, 65504.0));
    u_xlat16_6 = _AutoExposureTex.sample(sampler_AutoExposureTex, input.TEXCOORD0.xy).x;
    u_xlat16_0.xyz = half3(u_xlat16_6) * u_xlat16_0.xyz;
    u_xlat0.xyz = min(float3(u_xlat16_0.xyz), FGlobals._Params.xxx);
    u_xlat6 = max(u_xlat0.y, u_xlat0.x);
    u_xlat6 = max(u_xlat0.z, u_xlat6);
    u_xlat1.xy = float2(u_xlat6) + (-FGlobals._Threshold.yx);
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, FGlobals._Threshold.z);
    u_xlat5 = u_xlat1.x * FGlobals._Threshold.w;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat1.x = max(u_xlat1.y, u_xlat1.x);
    u_xlat6 = u_xlat1.x / u_xlat6;
    output.SV_Target0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 484084
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
    float4 _ColorIntensity;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat1.x = 1.0;
    u_xlat1.z = FGlobals._SampleScale;
    u_xlat1 = u_xlat1.xxzz * FGlobals._MainTex_TexelSize.xyxy;
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.0);
    u_xlat2.x = FGlobals._SampleScale;
    u_xlat3 = fma((-u_xlat1.xywy), u_xlat2.xxwx, input.TEXCOORD0.xyxy);
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), u_xlat16_4.xyz);
    u_xlat4.xy = fma((-u_xlat1.zy), u_xlat2.zx, input.TEXCOORD0.xy);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat4 = fma(u_xlat1.zwxw, u_xlat2.zwxw, input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat1.zywy, u_xlat2.zxwx, input.TEXCOORD0.xyxy);
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat1.xy = fma(u_xlat1.xy, u_xlat2.xx, input.TEXCOORD0.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat2 = u_xlat5 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_5.xyz, half3(2.0, 2.0, 2.0), u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(4.0, 4.0, 4.0), u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_4.xyz, half3(2.0, 2.0, 2.0), u_xlat16_0.xyz);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.0625, 0.0625, 0.0625);
    u_xlat0.xyz = float3(u_xlat16_0.xyz) * FGlobals._ColorIntensity.www;
    output.SV_Target0.xyz = u_xlat0.xyz * FGlobals._ColorIntensity.xyz;
    output.SV_Target0.w = 1.0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
    float4 _ColorIntensity;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat1.x = 1.0;
    u_xlat1.z = FGlobals._SampleScale;
    u_xlat1 = u_xlat1.xxzz * FGlobals._MainTex_TexelSize.xyxy;
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.0);
    u_xlat2.x = FGlobals._SampleScale;
    u_xlat3 = fma((-u_xlat1.xywy), u_xlat2.xxwx, input.TEXCOORD0.xyxy);
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), u_xlat16_4.xyz);
    u_xlat4.xy = fma((-u_xlat1.zy), u_xlat2.zx, input.TEXCOORD0.xy);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat4 = fma(u_xlat1.zwxw, u_xlat2.zwxw, input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat1.zywy, u_xlat2.zxwx, input.TEXCOORD0.xyxy);
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat1.xy = fma(u_xlat1.xy, u_xlat2.xx, input.TEXCOORD0.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat2 = u_xlat5 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_5.xyz, half3(2.0, 2.0, 2.0), u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(4.0, 4.0, 4.0), u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_4.xyz, half3(2.0, 2.0, 2.0), u_xlat16_0.xyz);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.0625, 0.0625, 0.0625);
    u_xlat0.xyz = float3(u_xlat16_0.xyz) * FGlobals._ColorIntensity.www;
    output.SV_Target0.xyz = u_xlat0.xyz * FGlobals._ColorIntensity.xyz;
    output.SV_Target0.w = 1.0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
    float4 _ColorIntensity;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    float4 u_xlat5;
    half3 u_xlat16_5;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat1.x = 1.0;
    u_xlat1.z = FGlobals._SampleScale;
    u_xlat1 = u_xlat1.xxzz * FGlobals._MainTex_TexelSize.xyxy;
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.0);
    u_xlat2.x = FGlobals._SampleScale;
    u_xlat3 = fma((-u_xlat1.xywy), u_xlat2.xxwx, input.TEXCOORD0.xyxy);
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), u_xlat16_4.xyz);
    u_xlat4.xy = fma((-u_xlat1.zy), u_xlat2.zx, input.TEXCOORD0.xy);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat4 = fma(u_xlat1.zwxw, u_xlat2.zwxw, input.TEXCOORD0.xyxy);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat1.zywy, u_xlat2.zxwx, input.TEXCOORD0.xyxy);
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat1.xy = fma(u_xlat1.xy, u_xlat2.xx, input.TEXCOORD0.xy);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat2 = u_xlat5 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat4 = u_xlat4 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat4.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_5.xyz, half3(2.0, 2.0, 2.0), u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(4.0, 4.0, 4.0), u_xlat16_3.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_4.xyz, half3(2.0, 2.0, 2.0), u_xlat16_0.xyz);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.0625, 0.0625, 0.0625);
    u_xlat0.xyz = float3(u_xlat16_0.xyz) * FGlobals._ColorIntensity.www;
    output.SV_Target0.xyz = u_xlat0.xyz * FGlobals._ColorIntensity.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 539531
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
    float4 _ColorIntensity;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    u_xlat0 = FGlobals._MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.x = FGlobals._SampleScale * 0.5;
    u_xlat2 = fma(u_xlat0.xyzy, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xwzw, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.25, 0.25, 0.25);
    u_xlat0.xyz = float3(u_xlat16_0.xyz) * FGlobals._ColorIntensity.www;
    output.SV_Target0.xyz = u_xlat0.xyz * FGlobals._ColorIntensity.xyz;
    output.SV_Target0.w = 1.0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
    float4 _ColorIntensity;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    u_xlat0 = FGlobals._MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.x = FGlobals._SampleScale * 0.5;
    u_xlat2 = fma(u_xlat0.xyzy, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xwzw, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.25, 0.25, 0.25);
    u_xlat0.xyz = float3(u_xlat16_0.xyz) * FGlobals._ColorIntensity.www;
    output.SV_Target0.xyz = u_xlat0.xyz * FGlobals._ColorIntensity.xyz;
    output.SV_Target0.w = 1.0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _SampleScale;
    float4 _ColorIntensity;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    u_xlat0 = FGlobals._MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.x = FGlobals._SampleScale * 0.5;
    u_xlat2 = fma(u_xlat0.xyzy, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xwzw, u_xlat1.xxxx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.25, 0.25, 0.25);
    u_xlat0.xyz = float3(u_xlat16_0.xyz) * FGlobals._ColorIntensity.www;
    output.SV_Target0.xyz = u_xlat0.xyz * FGlobals._ColorIntensity.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
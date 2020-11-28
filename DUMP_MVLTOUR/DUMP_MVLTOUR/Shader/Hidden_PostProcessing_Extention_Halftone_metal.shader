//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/Halftone" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 29009
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
    float _DotPatternRowColumnNumber;
    float _DarkeningFactor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    float u_xlat4;
    half u_xlat16_4;
    u_xlat0.x = dot(float2(0.707000017, -0.707000017), input.TEXCOORD0.xy);
    u_xlat0.y = dot(float2(0.707000017, 0.707000017), input.TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dfdx(u_xlat0.x);
    u_xlat4 = dfdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z + u_xlat16_4;
    u_xlat16_4 = fma((-u_xlat16_4), half(0.333333343), half(1.0));
    u_xlat0.w = fma(float(u_xlat16_4), float(u_xlat16_4), u_xlat2.x);
    u_xlat2.x = fma(float(u_xlat16_4), float(u_xlat16_4), (-u_xlat2.x));
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat2.x = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * float3(FGlobals._DarkeningFactor);
    u_xlat1.xyz = fma((-float3(u_xlat16_1.xyz)), float3(FGlobals._DarkeningFactor), float3(u_xlat16_1.xyz));
    output.SV_TARGET0.w = float(u_xlat16_1.w);
    output.SV_TARGET0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat2.xyz);
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
    float _DotPatternRowColumnNumber;
    float _DarkeningFactor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    float u_xlat4;
    half u_xlat16_4;
    u_xlat0.x = dot(float2(0.707000017, -0.707000017), input.TEXCOORD0.xy);
    u_xlat0.y = dot(float2(0.707000017, 0.707000017), input.TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dfdx(u_xlat0.x);
    u_xlat4 = dfdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z + u_xlat16_4;
    u_xlat16_4 = fma((-u_xlat16_4), half(0.333333343), half(1.0));
    u_xlat0.w = fma(float(u_xlat16_4), float(u_xlat16_4), u_xlat2.x);
    u_xlat2.x = fma(float(u_xlat16_4), float(u_xlat16_4), (-u_xlat2.x));
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat2.x = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * float3(FGlobals._DarkeningFactor);
    u_xlat1.xyz = fma((-float3(u_xlat16_1.xyz)), float3(FGlobals._DarkeningFactor), float3(u_xlat16_1.xyz));
    output.SV_TARGET0.w = float(u_xlat16_1.w);
    output.SV_TARGET0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat2.xyz);
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
    float _DotPatternRowColumnNumber;
    float _DarkeningFactor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    float3 u_xlat1;
    half4 u_xlat16_1;
    float3 u_xlat2;
    float u_xlat4;
    half u_xlat16_4;
    u_xlat0.x = dot(float2(0.707000017, -0.707000017), input.TEXCOORD0.xy);
    u_xlat0.y = dot(float2(0.707000017, 0.707000017), input.TEXCOORD0.xy);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._DotPatternRowColumnNumber);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat2.x = dfdx(u_xlat0.x);
    u_xlat4 = dfdy(u_xlat0.x);
    u_xlat2.x = abs(u_xlat4) + abs(u_xlat2.x);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_4 = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_4 = u_xlat16_1.z + u_xlat16_4;
    u_xlat16_4 = fma((-u_xlat16_4), half(0.333333343), half(1.0));
    u_xlat0.w = fma(float(u_xlat16_4), float(u_xlat16_4), u_xlat2.x);
    u_xlat2.x = fma(float(u_xlat16_4), float(u_xlat16_4), (-u_xlat2.x));
    u_xlat0.xz = (-u_xlat2.xx) + u_xlat0.xw;
    u_xlat2.x = float(1.0) / u_xlat0.z;
    u_xlat0.x = u_xlat2.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat2.x = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat16_1.xyz) * float3(FGlobals._DarkeningFactor);
    u_xlat1.xyz = fma((-float3(u_xlat16_1.xyz)), float3(FGlobals._DarkeningFactor), float3(u_xlat16_1.xyz));
    output.SV_TARGET0.w = float(u_xlat16_1.w);
    output.SV_TARGET0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat2.xyz);
    return output;
}
"
}
}
}
}
}
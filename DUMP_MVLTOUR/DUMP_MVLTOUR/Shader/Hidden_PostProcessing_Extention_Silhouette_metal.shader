//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/Silhouette" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 55107
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
    float _DepthFactor;
    float _BaseDepth;
    float _SecondaryColorThreshold;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    bool u_xlatb0;
    float u_xlat1;
    float u_xlat2;
    float u_xlat4;
    half2 u_xlat16_4;
    bool u_xlatb4;
    float u_xlat6;
    u_xlat0.xy = float2(0.200000003, 3.0) / float2(FGlobals._DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + float2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_4.xy = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat16_4.xy, half2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
    u_xlatb0 = u_xlat0.x<u_xlat4;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = fma((-u_xlat6), u_xlat6, 1.0);
    u_xlat6 = u_xlat6 * FGlobals._DepthFactor;
    u_xlat6 = fma(u_xlat6, 0.100000001, 0.200000003);
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = fma((-u_xlat1), u_xlat1, 1.0);
    u_xlat6 = fma((-FGlobals._DepthFactor), u_xlat1, u_xlat6);
    u_xlat1 = u_xlat1 * FGlobals._DepthFactor;
    u_xlat0.x = fma(u_xlat0.x, u_xlat6, u_xlat1);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = (-u_xlat2) + u_xlat4;
    u_xlatb4 = u_xlat2<u_xlat4;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = fma(u_xlat2, u_xlat6, 0.5);
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = fma(u_xlat4, u_xlat2, u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    output.SV_TARGET0.xz = u_xlat0.xx * float2(FGlobals._SecondaryColorThreshold);
    output.SV_TARGET0.y = u_xlat0.x + FGlobals._BaseDepth;
    output.SV_TARGET0.w = 1.0;
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
    float _DepthFactor;
    float _BaseDepth;
    float _SecondaryColorThreshold;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    bool u_xlatb0;
    float u_xlat1;
    float u_xlat2;
    float u_xlat4;
    half2 u_xlat16_4;
    bool u_xlatb4;
    float u_xlat6;
    u_xlat0.xy = float2(0.200000003, 3.0) / float2(FGlobals._DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + float2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_4.xy = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat16_4.xy, half2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
    u_xlatb0 = u_xlat0.x<u_xlat4;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = fma((-u_xlat6), u_xlat6, 1.0);
    u_xlat6 = u_xlat6 * FGlobals._DepthFactor;
    u_xlat6 = fma(u_xlat6, 0.100000001, 0.200000003);
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = fma((-u_xlat1), u_xlat1, 1.0);
    u_xlat6 = fma((-FGlobals._DepthFactor), u_xlat1, u_xlat6);
    u_xlat1 = u_xlat1 * FGlobals._DepthFactor;
    u_xlat0.x = fma(u_xlat0.x, u_xlat6, u_xlat1);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = (-u_xlat2) + u_xlat4;
    u_xlatb4 = u_xlat2<u_xlat4;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = fma(u_xlat2, u_xlat6, 0.5);
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = fma(u_xlat4, u_xlat2, u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    output.SV_TARGET0.xz = u_xlat0.xx * float2(FGlobals._SecondaryColorThreshold);
    output.SV_TARGET0.y = u_xlat0.x + FGlobals._BaseDepth;
    output.SV_TARGET0.w = 1.0;
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
    float _DepthFactor;
    float _BaseDepth;
    float _SecondaryColorThreshold;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    bool u_xlatb0;
    float u_xlat1;
    float u_xlat2;
    float u_xlat4;
    half2 u_xlat16_4;
    bool u_xlatb4;
    float u_xlat6;
    u_xlat0.xy = float2(0.200000003, 3.0) / float2(FGlobals._DepthFactor);
    u_xlat0.xy = (-u_xlat0.xy) + float2(1.0, 1.0);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat2 = u_xlat0.x + (-u_xlat0.y);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_4.xy = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).zw;
    u_xlat4 = dot(u_xlat16_4.xy, half2(1.0, 0.00392156886));
    u_xlat6 = (-u_xlat0.x) + u_xlat4;
    u_xlatb0 = u_xlat0.x<u_xlat4;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat6 + -1.0;
    u_xlat6 = fma((-u_xlat6), u_xlat6, 1.0);
    u_xlat6 = u_xlat6 * FGlobals._DepthFactor;
    u_xlat6 = fma(u_xlat6, 0.100000001, 0.200000003);
    u_xlat1 = u_xlat4 + -1.0;
    u_xlat1 = fma((-u_xlat1), u_xlat1, 1.0);
    u_xlat6 = fma((-FGlobals._DepthFactor), u_xlat1, u_xlat6);
    u_xlat1 = u_xlat1 * FGlobals._DepthFactor;
    u_xlat0.x = fma(u_xlat0.x, u_xlat6, u_xlat1);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = (-u_xlat2) + u_xlat4;
    u_xlatb4 = u_xlat2<u_xlat4;
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = 0.5 / u_xlat2;
    u_xlat2 = fma(u_xlat2, u_xlat6, 0.5);
    u_xlat2 = (-u_xlat0.x) + u_xlat2;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat0.x = fma(u_xlat4, u_xlat2, u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    output.SV_TARGET0.xz = u_xlat0.xx * float2(FGlobals._SecondaryColorThreshold);
    output.SV_TARGET0.y = u_xlat0.x + FGlobals._BaseDepth;
    output.SV_TARGET0.w = 1.0;
    return output;
}
"
}
}
}
}
}
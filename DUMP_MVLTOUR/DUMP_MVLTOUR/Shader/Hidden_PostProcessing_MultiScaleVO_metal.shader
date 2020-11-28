//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/MultiScaleVO" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 46854
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    output.SV_Target0 = float4(u_xlat0);
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    output.SV_Target0 = float4(u_xlat0);
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    output.SV_Target0 = float4(u_xlat0);
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
  GpuProgramID 112212
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    output.SV_Target0.xyz = float3(0.0, 0.0, 0.0);
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_0);
    output.SV_Target1.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target1.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    output.SV_Target0.xyz = float3(0.0, 0.0, 0.0);
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_0);
    output.SV_Target1.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target1.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    output.SV_Target0.xyz = float3(0.0, 0.0, 0.0);
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_0);
    output.SV_Target1.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target1.w = 0.0;
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
  GpuProgramID 147802
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
Keywords { "FOG_LINEAR" }
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
Keywords { "FOG_LINEAR" }
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
SubProgram "metal hw_tier00 " {
Keywords { "APPLY_FORWARD_FOG" }
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
Keywords { "APPLY_FORWARD_FOG" }
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
Keywords { "APPLY_FORWARD_FOG" }
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
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
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
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "APPLY_FORWARD_FOG" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float3 _FogParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    half u_xlat16_1;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = u_xlat0 * FGlobals._FogParams.xyzx.x;
    u_xlat0 = u_xlat0 * (-u_xlat0);
    u_xlat0 = exp2(u_xlat0);
    u_xlat16_1 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    u_xlat0 = u_xlat0 * float(u_xlat16_1);
    output.SV_Target0.xyz = float3(u_xlat0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "APPLY_FORWARD_FOG" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float3 _FogParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    half u_xlat16_1;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = u_xlat0 * FGlobals._FogParams.xyzx.x;
    u_xlat0 = u_xlat0 * (-u_xlat0);
    u_xlat0 = exp2(u_xlat0);
    u_xlat16_1 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    u_xlat0 = u_xlat0 * float(u_xlat16_1);
    output.SV_Target0.xyz = float3(u_xlat0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "APPLY_FORWARD_FOG" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float3 _FogParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    half u_xlat16_1;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = u_xlat0 * FGlobals._FogParams.xyzx.x;
    u_xlat0 = u_xlat0 * (-u_xlat0);
    u_xlat0 = exp2(u_xlat0);
    u_xlat16_1 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    u_xlat0 = u_xlat0 * float(u_xlat16_1);
    output.SV_Target0.xyz = float3(u_xlat0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float3 _FogParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    half u_xlat16_1;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = (-u_xlat0) + FGlobals._FogParams.xyzx.z;
    u_xlat1 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat0 = u_xlat0 / u_xlat1;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat16_1 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    u_xlat0 = u_xlat0 * float(u_xlat16_1);
    output.SV_Target0.xyz = float3(u_xlat0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float3 _FogParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    half u_xlat16_1;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = (-u_xlat0) + FGlobals._FogParams.xyzx.z;
    u_xlat1 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat0 = u_xlat0 / u_xlat1;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat16_1 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    u_xlat0 = u_xlat0 * float(u_xlat16_1);
    output.SV_Target0.xyz = float3(u_xlat0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "APPLY_FORWARD_FOG" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float3 _FogParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_MSVOcclusionTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    half u_xlat16_1;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = (-u_xlat0) + FGlobals._FogParams.xyzx.z;
    u_xlat1 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat0 = u_xlat0 / u_xlat1;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat16_1 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    u_xlat0 = u_xlat0 * float(u_xlat16_1);
    output.SV_Target0.xyz = float3(u_xlat0) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = 0.0;
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
  GpuProgramID 258340
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    output.SV_Target0.xyz = float3(half3(u_xlat16_0));
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    output.SV_Target0.xyz = float3(half3(u_xlat16_0));
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MSVOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _MSVOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half u_xlat16_0;
    u_xlat16_0 = _MSVOcclusionTexture.sample(sampler_MSVOcclusionTexture, input.TEXCOORD1.xy).x;
    output.SV_Target0.xyz = float3(half3(u_xlat16_0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Debug/Overlays" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 30676
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
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _Params;
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
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    float u_xlat2;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy, level(0.0)).x;
    u_xlat2 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat2, FGlobals._ZBufferParams.y);
    u_xlat2 = fma((-FGlobals.unity_OrthoParams.w), u_xlat2, 1.0);
    u_xlat0 = u_xlat2 / u_xlat0;
    u_xlat0 = (-u_xlat1) + u_xlat0;
    output.SV_Target0.xyz = fma(FGlobals._Params.xxx, float3(u_xlat0), float3(u_xlat1));
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
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _Params;
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
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    float u_xlat2;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy, level(0.0)).x;
    u_xlat2 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat2, FGlobals._ZBufferParams.y);
    u_xlat2 = fma((-FGlobals.unity_OrthoParams.w), u_xlat2, 1.0);
    u_xlat0 = u_xlat2 / u_xlat0;
    u_xlat0 = (-u_xlat1) + u_xlat0;
    output.SV_Target0.xyz = fma(FGlobals._Params.xxx, float3(u_xlat0), float3(u_xlat1));
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
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _Params;
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
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float u_xlat1;
    float u_xlat2;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy, level(0.0)).x;
    u_xlat2 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat2, FGlobals._ZBufferParams.y);
    u_xlat2 = fma((-FGlobals.unity_OrthoParams.w), u_xlat2, 1.0);
    u_xlat0 = u_xlat2 / u_xlat0;
    u_xlat0 = (-u_xlat1) + u_xlat0;
    output.SV_Target0.xyz = fma(FGlobals._Params.xxx, float3(u_xlat0), float3(u_xlat1));
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
  GpuProgramID 80912
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "SOURCE_GBUFFER" }
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
Keywords { "SOURCE_GBUFFER" }
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
Keywords { "SOURCE_GBUFFER" }
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half u_xlat16_4;
    u_xlat16_0.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_4 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_4 = half(2.0) / u_xlat16_4;
    u_xlat1.xy = float2(u_xlat16_0.xy) * float2(u_xlat16_4);
    u_xlat1.z = float(u_xlat16_4) + -1.0;
    u_xlat0.xyz = u_xlat1.xyz * float3(1.0, 1.0, -1.0);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half u_xlat16_4;
    u_xlat16_0.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_4 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_4 = half(2.0) / u_xlat16_4;
    u_xlat1.xy = float2(u_xlat16_0.xy) * float2(u_xlat16_4);
    u_xlat1.z = float(u_xlat16_4) + -1.0;
    u_xlat0.xyz = u_xlat1.xyz * float3(1.0, 1.0, -1.0);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half u_xlat16_4;
    u_xlat16_0.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_4 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_4 = half(2.0) / u_xlat16_4;
    u_xlat1.xy = float2(u_xlat16_0.xy) * float2(u_xlat16_4);
    u_xlat1.z = float(u_xlat16_4) + -1.0;
    u_xlat0.xyz = u_xlat1.xyz * float3(1.0, 1.0, -1.0);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOURCE_GBUFFER" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    u_xlat16_0.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = float3(u_xlat16_0.yyy) * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, float3(u_xlat16_0.xxx), u_xlat1.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, float3(u_xlat16_0.zzz), u_xlat0.xyw);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOURCE_GBUFFER" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    u_xlat16_0.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = float3(u_xlat16_0.yyy) * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, float3(u_xlat16_0.xxx), u_xlat1.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, float3(u_xlat16_0.zzz), u_xlat0.xyw);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOURCE_GBUFFER" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    u_xlat16_0.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = float3(u_xlat16_0.yyy) * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, float3(u_xlat16_0.xxx), u_xlat1.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, float3(u_xlat16_0.zzz), u_xlat0.xyw);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
  GpuProgramID 190968
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float3 u_xlat0;
    bool u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat11;
    bool u_xlatb11;
    float2 u_xlat12;
    float u_xlat15;
    bool u_xlatb15;
    float u_xlat16;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat0.xy = float2(_CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy);
    u_xlat10 = abs(u_xlat0.y);
    u_xlat15 = max(u_xlat10, abs(u_xlat0.x));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(u_xlat10, abs(u_xlat0.x));
    u_xlatb10 = u_xlat10<abs(u_xlat0.x);
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6 = fma(u_xlat1.x, 0.0208350997, -0.0851330012);
    u_xlat6 = fma(u_xlat1.x, u_xlat6, 0.180141002);
    u_xlat6 = fma(u_xlat1.x, u_xlat6, -0.330299497);
    u_xlat1.x = fma(u_xlat1.x, u_xlat6, 0.999866009);
    u_xlat6 = u_xlat15 * u_xlat1.x;
    u_xlat6 = fma(u_xlat6, -2.0, 1.57079637);
    u_xlat10 = u_xlatb10 ? u_xlat6 : float(0.0);
    u_xlat10 = fma(u_xlat15, u_xlat1.x, u_xlat10);
    u_xlatb15 = (-u_xlat0.y)<u_xlat0.y;
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10 = u_xlat15 + u_xlat10;
    u_xlat15 = min((-u_xlat0.y), u_xlat0.x);
    u_xlatb15 = u_xlat15<(-u_xlat15);
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * float2(1.0, -1.0);
    u_xlat2 = u_xlat0.xyxy * FGlobals._Params.xxyy;
    u_xlatb0 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb0 = u_xlatb0 && u_xlatb15;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10) : u_xlat10;
    u_xlat0.x = fma(u_xlat0.x, 0.318309873, 1.0);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(3.0, 3.0, 3.0), float3(-3.0, -2.0, -4.0));
    u_xlat0.xyz = fma(abs(u_xlat0.xyz), float3(1.0, -1.0, -1.0), float3(-1.0, 2.0, 2.0));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-float3(u_xlat16_1.xyz));
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = u_xlat2.zw * float2(0.25, 0.25);
    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = min(u_xlat16, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat15), u_xlat0.xyz, float3(u_xlat16_1.xyz));
    u_xlat15 = FGlobals._MainTex_TexelSize.w * FGlobals._Params.y;
    u_xlat15 = u_xlat15 / FGlobals._MainTex_TexelSize.z;
    u_xlat1.y = floor(u_xlat15);
    u_xlat1.x = FGlobals._Params.y;
    u_xlat1.xy = FGlobals._MainTex_TexelSize.zw / u_xlat1.xy;
    u_xlat2.xy = hlslcc_FragCoord.xy / u_xlat1.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + float2(0.5, 0.5);
    u_xlat12.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = fma((-u_xlat2.xy), u_xlat1.xy, hlslcc_FragCoord.xy);
    u_xlat15 = min(u_xlat1.y, u_xlat1.x);
    u_xlat15 = u_xlat15 * 0.707106769;
    u_xlat1.xy = u_xlat12.xy / FGlobals._MainTex_TexelSize.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat16_1.xy * half2(1.0, -1.0);
    u_xlat11 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat12.x = rsqrt(u_xlat11);
    u_xlatb11 = u_xlat11!=0.0;
    u_xlat3.xy = float2(u_xlat16_1.xy) * u_xlat12.xx;
    u_xlat3.z = (-u_xlat3.y);
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xy);
    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.xy);
    u_xlat2.x = u_xlat16 * u_xlat15;
    u_xlat15 = fma(u_xlat15, u_xlat16, -2.0);
    u_xlat7.xy = fma((-u_xlat2.xx), float2(0.375, -0.0625), u_xlat1.xy);
    u_xlat3.xyz = u_xlat2.xxx * float3(0.5, 0.25, -0.125);
    u_xlat4.x = u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat3.xw = fma((-u_xlat2.xx), float2(0.25, 0.125), u_xlat4.xy);
    u_xlat3.xw = (-u_xlat3.xw) + u_xlat4.xy;
    u_xlat16 = dot(u_xlat3.xw, u_xlat3.xw);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.xy = u_xlat3.xw / float2(u_xlat16);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat16 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat7.xy = fma((-u_xlat2.xx), float2(0.375, 0.0625), u_xlat1.xy);
    u_xlat3.xw = u_xlat1.xy + float2(1.0, -0.0);
    u_xlat1.x = fma(u_xlat2.x, -0.25, u_xlat1.x);
    u_xlat6 = dot((-u_xlat3.yz), (-u_xlat3.yz));
    u_xlat6 = sqrt(u_xlat6);
    u_xlat4.xy = (-u_xlat3.yz) / float2(u_xlat6);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat6 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat6 = max(u_xlat16, u_xlat6);
    u_xlat1.x = max((-u_xlat1.x), u_xlat6);
    u_xlat6 = u_xlat15 / abs(u_xlat15);
    u_xlat16 = u_xlat6 * u_xlat3.x;
    u_xlat6 = (-u_xlat6) * u_xlat3.w;
    u_xlat15 = fma(-abs(u_xlat15), 0.5, abs(u_xlat16));
    u_xlat15 = max(u_xlat15, abs(u_xlat6));
    u_xlat15 = min(u_xlat15, u_xlat1.x);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlatb11 ? u_xlat15 : float(0.0);
    output.SV_Target0.xyz = float3(u_xlat15) + u_xlat0.xyz;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float3 u_xlat0;
    bool u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat11;
    bool u_xlatb11;
    float2 u_xlat12;
    float u_xlat15;
    bool u_xlatb15;
    float u_xlat16;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat0.xy = float2(_CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy);
    u_xlat10 = abs(u_xlat0.y);
    u_xlat15 = max(u_xlat10, abs(u_xlat0.x));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(u_xlat10, abs(u_xlat0.x));
    u_xlatb10 = u_xlat10<abs(u_xlat0.x);
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6 = fma(u_xlat1.x, 0.0208350997, -0.0851330012);
    u_xlat6 = fma(u_xlat1.x, u_xlat6, 0.180141002);
    u_xlat6 = fma(u_xlat1.x, u_xlat6, -0.330299497);
    u_xlat1.x = fma(u_xlat1.x, u_xlat6, 0.999866009);
    u_xlat6 = u_xlat15 * u_xlat1.x;
    u_xlat6 = fma(u_xlat6, -2.0, 1.57079637);
    u_xlat10 = u_xlatb10 ? u_xlat6 : float(0.0);
    u_xlat10 = fma(u_xlat15, u_xlat1.x, u_xlat10);
    u_xlatb15 = (-u_xlat0.y)<u_xlat0.y;
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10 = u_xlat15 + u_xlat10;
    u_xlat15 = min((-u_xlat0.y), u_xlat0.x);
    u_xlatb15 = u_xlat15<(-u_xlat15);
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * float2(1.0, -1.0);
    u_xlat2 = u_xlat0.xyxy * FGlobals._Params.xxyy;
    u_xlatb0 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb0 = u_xlatb0 && u_xlatb15;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10) : u_xlat10;
    u_xlat0.x = fma(u_xlat0.x, 0.318309873, 1.0);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(3.0, 3.0, 3.0), float3(-3.0, -2.0, -4.0));
    u_xlat0.xyz = fma(abs(u_xlat0.xyz), float3(1.0, -1.0, -1.0), float3(-1.0, 2.0, 2.0));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-float3(u_xlat16_1.xyz));
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = u_xlat2.zw * float2(0.25, 0.25);
    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = min(u_xlat16, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat15), u_xlat0.xyz, float3(u_xlat16_1.xyz));
    u_xlat15 = FGlobals._MainTex_TexelSize.w * FGlobals._Params.y;
    u_xlat15 = u_xlat15 / FGlobals._MainTex_TexelSize.z;
    u_xlat1.y = floor(u_xlat15);
    u_xlat1.x = FGlobals._Params.y;
    u_xlat1.xy = FGlobals._MainTex_TexelSize.zw / u_xlat1.xy;
    u_xlat2.xy = hlslcc_FragCoord.xy / u_xlat1.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + float2(0.5, 0.5);
    u_xlat12.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = fma((-u_xlat2.xy), u_xlat1.xy, hlslcc_FragCoord.xy);
    u_xlat15 = min(u_xlat1.y, u_xlat1.x);
    u_xlat15 = u_xlat15 * 0.707106769;
    u_xlat1.xy = u_xlat12.xy / FGlobals._MainTex_TexelSize.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat16_1.xy * half2(1.0, -1.0);
    u_xlat11 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat12.x = rsqrt(u_xlat11);
    u_xlatb11 = u_xlat11!=0.0;
    u_xlat3.xy = float2(u_xlat16_1.xy) * u_xlat12.xx;
    u_xlat3.z = (-u_xlat3.y);
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xy);
    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.xy);
    u_xlat2.x = u_xlat16 * u_xlat15;
    u_xlat15 = fma(u_xlat15, u_xlat16, -2.0);
    u_xlat7.xy = fma((-u_xlat2.xx), float2(0.375, -0.0625), u_xlat1.xy);
    u_xlat3.xyz = u_xlat2.xxx * float3(0.5, 0.25, -0.125);
    u_xlat4.x = u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat3.xw = fma((-u_xlat2.xx), float2(0.25, 0.125), u_xlat4.xy);
    u_xlat3.xw = (-u_xlat3.xw) + u_xlat4.xy;
    u_xlat16 = dot(u_xlat3.xw, u_xlat3.xw);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.xy = u_xlat3.xw / float2(u_xlat16);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat16 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat7.xy = fma((-u_xlat2.xx), float2(0.375, 0.0625), u_xlat1.xy);
    u_xlat3.xw = u_xlat1.xy + float2(1.0, -0.0);
    u_xlat1.x = fma(u_xlat2.x, -0.25, u_xlat1.x);
    u_xlat6 = dot((-u_xlat3.yz), (-u_xlat3.yz));
    u_xlat6 = sqrt(u_xlat6);
    u_xlat4.xy = (-u_xlat3.yz) / float2(u_xlat6);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat6 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat6 = max(u_xlat16, u_xlat6);
    u_xlat1.x = max((-u_xlat1.x), u_xlat6);
    u_xlat6 = u_xlat15 / abs(u_xlat15);
    u_xlat16 = u_xlat6 * u_xlat3.x;
    u_xlat6 = (-u_xlat6) * u_xlat3.w;
    u_xlat15 = fma(-abs(u_xlat15), 0.5, abs(u_xlat16));
    u_xlat15 = max(u_xlat15, abs(u_xlat6));
    u_xlat15 = min(u_xlat15, u_xlat1.x);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlatb11 ? u_xlat15 : float(0.0);
    output.SV_Target0.xyz = float3(u_xlat15) + u_xlat0.xyz;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float3 u_xlat0;
    bool u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat11;
    bool u_xlatb11;
    float2 u_xlat12;
    float u_xlat15;
    bool u_xlatb15;
    float u_xlat16;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat0.xy = float2(_CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy);
    u_xlat10 = abs(u_xlat0.y);
    u_xlat15 = max(u_xlat10, abs(u_xlat0.x));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(u_xlat10, abs(u_xlat0.x));
    u_xlatb10 = u_xlat10<abs(u_xlat0.x);
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6 = fma(u_xlat1.x, 0.0208350997, -0.0851330012);
    u_xlat6 = fma(u_xlat1.x, u_xlat6, 0.180141002);
    u_xlat6 = fma(u_xlat1.x, u_xlat6, -0.330299497);
    u_xlat1.x = fma(u_xlat1.x, u_xlat6, 0.999866009);
    u_xlat6 = u_xlat15 * u_xlat1.x;
    u_xlat6 = fma(u_xlat6, -2.0, 1.57079637);
    u_xlat10 = u_xlatb10 ? u_xlat6 : float(0.0);
    u_xlat10 = fma(u_xlat15, u_xlat1.x, u_xlat10);
    u_xlatb15 = (-u_xlat0.y)<u_xlat0.y;
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10 = u_xlat15 + u_xlat10;
    u_xlat15 = min((-u_xlat0.y), u_xlat0.x);
    u_xlatb15 = u_xlat15<(-u_xlat15);
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * float2(1.0, -1.0);
    u_xlat2 = u_xlat0.xyxy * FGlobals._Params.xxyy;
    u_xlatb0 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb0 = u_xlatb0 && u_xlatb15;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10) : u_xlat10;
    u_xlat0.x = fma(u_xlat0.x, 0.318309873, 1.0);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(3.0, 3.0, 3.0), float3(-3.0, -2.0, -4.0));
    u_xlat0.xyz = fma(abs(u_xlat0.xyz), float3(1.0, -1.0, -1.0), float3(-1.0, 2.0, 2.0));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-float3(u_xlat16_1.xyz));
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = u_xlat2.zw * float2(0.25, 0.25);
    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = min(u_xlat16, 1.0);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat15), u_xlat0.xyz, float3(u_xlat16_1.xyz));
    u_xlat15 = FGlobals._MainTex_TexelSize.w * FGlobals._Params.y;
    u_xlat15 = u_xlat15 / FGlobals._MainTex_TexelSize.z;
    u_xlat1.y = floor(u_xlat15);
    u_xlat1.x = FGlobals._Params.y;
    u_xlat1.xy = FGlobals._MainTex_TexelSize.zw / u_xlat1.xy;
    u_xlat2.xy = hlslcc_FragCoord.xy / u_xlat1.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + float2(0.5, 0.5);
    u_xlat12.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = fma((-u_xlat2.xy), u_xlat1.xy, hlslcc_FragCoord.xy);
    u_xlat15 = min(u_xlat1.y, u_xlat1.x);
    u_xlat15 = u_xlat15 * 0.707106769;
    u_xlat1.xy = u_xlat12.xy / FGlobals._MainTex_TexelSize.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat16_1.xy * half2(1.0, -1.0);
    u_xlat11 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat12.x = rsqrt(u_xlat11);
    u_xlatb11 = u_xlat11!=0.0;
    u_xlat3.xy = float2(u_xlat16_1.xy) * u_xlat12.xx;
    u_xlat3.z = (-u_xlat3.y);
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xy);
    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.xy);
    u_xlat2.x = u_xlat16 * u_xlat15;
    u_xlat15 = fma(u_xlat15, u_xlat16, -2.0);
    u_xlat7.xy = fma((-u_xlat2.xx), float2(0.375, -0.0625), u_xlat1.xy);
    u_xlat3.xyz = u_xlat2.xxx * float3(0.5, 0.25, -0.125);
    u_xlat4.x = u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat3.xw = fma((-u_xlat2.xx), float2(0.25, 0.125), u_xlat4.xy);
    u_xlat3.xw = (-u_xlat3.xw) + u_xlat4.xy;
    u_xlat16 = dot(u_xlat3.xw, u_xlat3.xw);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.xy = u_xlat3.xw / float2(u_xlat16);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat16 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat7.xy = fma((-u_xlat2.xx), float2(0.375, 0.0625), u_xlat1.xy);
    u_xlat3.xw = u_xlat1.xy + float2(1.0, -0.0);
    u_xlat1.x = fma(u_xlat2.x, -0.25, u_xlat1.x);
    u_xlat6 = dot((-u_xlat3.yz), (-u_xlat3.yz));
    u_xlat6 = sqrt(u_xlat6);
    u_xlat4.xy = (-u_xlat3.yz) / float2(u_xlat6);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat6 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat6 = max(u_xlat16, u_xlat6);
    u_xlat1.x = max((-u_xlat1.x), u_xlat6);
    u_xlat6 = u_xlat15 / abs(u_xlat15);
    u_xlat16 = u_xlat6 * u_xlat3.x;
    u_xlat6 = (-u_xlat6) * u_xlat3.w;
    u_xlat15 = fma(-abs(u_xlat15), 0.5, abs(u_xlat16));
    u_xlat15 = max(u_xlat15, abs(u_xlat6));
    u_xlat15 = min(u_xlat15, u_xlat1.x);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlatb11 ? u_xlat15 : float(0.0);
    output.SV_Target0.xyz = float3(u_xlat15) + u_xlat0.xyz;
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
  GpuProgramID 217722
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    int4 u_xlati1;
    bool4 u_xlatb1;
    bool4 u_xlatb2;
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlatb1 = (u_xlat0<float4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = (float4(0.0, 0.0, 0.0, 0.0)<u_xlat0);
    u_xlati1 = int4((uint4(u_xlatb1) * 0xffffffffu) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb2 = (u_xlat0==float4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = int4(uint4(u_xlati1) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb1 = (u_xlati1==int4(0x0, 0x0, 0x0, 0x0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    u_xlat0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.25, 0.25, 0.25);
    output.SV_Target0 = (u_xlatb1.x) ? float4(1.0, 0.0, 1.0, 1.0) : u_xlat0;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    int4 u_xlati1;
    bool4 u_xlatb1;
    bool4 u_xlatb2;
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlatb1 = (u_xlat0<float4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = (float4(0.0, 0.0, 0.0, 0.0)<u_xlat0);
    u_xlati1 = int4((uint4(u_xlatb1) * 0xffffffffu) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb2 = (u_xlat0==float4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = int4(uint4(u_xlati1) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb1 = (u_xlati1==int4(0x0, 0x0, 0x0, 0x0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    u_xlat0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.25, 0.25, 0.25);
    output.SV_Target0 = (u_xlatb1.x) ? float4(1.0, 0.0, 1.0, 1.0) : u_xlat0;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    int4 u_xlati1;
    bool4 u_xlatb1;
    bool4 u_xlatb2;
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlatb1 = (u_xlat0<float4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = (float4(0.0, 0.0, 0.0, 0.0)<u_xlat0);
    u_xlati1 = int4((uint4(u_xlatb1) * 0xffffffffu) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb2 = (u_xlat0==float4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = int4(uint4(u_xlati1) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb1 = (u_xlati1==int4(0x0, 0x0, 0x0, 0x0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    u_xlat0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.25, 0.25, 0.25);
    output.SV_Target0 = (u_xlatb1.x) ? float4(1.0, 0.0, 1.0, 1.0) : u_xlat0;
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
  GpuProgramID 269731
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_9;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * half(-367.857117);
    u_xlat16_9 = fma(u_xlat16_1.x, half(-367.857117), (-u_xlat16_9));
    u_xlat16_9 = fma(u_xlat16_1.z, half(16511.7441), u_xlat16_9);
    u_xlat2.z = float(u_xlat16_9) * 6.0796734e-05;
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat16_9 = dot(u_xlat16_1.xy, half2(4833.03809, 11677.1963));
    u_xlat16_9 = half(float(u_xlat16_9) * 6.0796734e-05);
    u_xlat2.xy = min(float2(u_xlat16_9), float2(1.0, 1.0));
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_9;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * half(-367.857117);
    u_xlat16_9 = fma(u_xlat16_1.x, half(-367.857117), (-u_xlat16_9));
    u_xlat16_9 = fma(u_xlat16_1.z, half(16511.7441), u_xlat16_9);
    u_xlat2.z = float(u_xlat16_9) * 6.0796734e-05;
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat16_9 = dot(u_xlat16_1.xy, half2(4833.03809, 11677.1963));
    u_xlat16_9 = half(float(u_xlat16_9) * 6.0796734e-05);
    u_xlat2.xy = min(float2(u_xlat16_9), float2(1.0, 1.0));
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_9;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * half(-367.857117);
    u_xlat16_9 = fma(u_xlat16_1.x, half(-367.857117), (-u_xlat16_9));
    u_xlat16_9 = fma(u_xlat16_1.z, half(16511.7441), u_xlat16_9);
    u_xlat2.z = float(u_xlat16_9) * 6.0796734e-05;
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat16_9 = dot(u_xlat16_1.xy, half2(4833.03809, 11677.1963));
    u_xlat16_9 = half(float(u_xlat16_9) * 6.0796734e-05);
    u_xlat2.xy = min(float2(u_xlat16_9), float2(1.0, 1.0));
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
  GpuProgramID 340467
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_9;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * half(66.0126495);
    u_xlat16_9 = fma(u_xlat16_1.x, half(66.0126495), (-u_xlat16_9));
    u_xlat16_9 = fma(u_xlat16_1.z, half(16511.7441), u_xlat16_9);
    u_xlat2.z = float(u_xlat16_9) * 6.0796734e-05;
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat16_9 = dot(u_xlat16_1.xy, half2(1855.91467, 14655.8301));
    u_xlat16_9 = half(float(u_xlat16_9) * 6.0796734e-05);
    u_xlat2.xy = min(float2(u_xlat16_9), float2(1.0, 1.0));
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_9;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * half(66.0126495);
    u_xlat16_9 = fma(u_xlat16_1.x, half(66.0126495), (-u_xlat16_9));
    u_xlat16_9 = fma(u_xlat16_1.z, half(16511.7441), u_xlat16_9);
    u_xlat2.z = float(u_xlat16_9) * 6.0796734e-05;
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat16_9 = dot(u_xlat16_1.xy, half2(1855.91467, 14655.8301));
    u_xlat16_9 = half(float(u_xlat16_9) * 6.0796734e-05);
    u_xlat2.xy = min(float2(u_xlat16_9), float2(1.0, 1.0));
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half u_xlat16_9;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * half(66.0126495);
    u_xlat16_9 = fma(u_xlat16_1.x, half(66.0126495), (-u_xlat16_9));
    u_xlat16_9 = fma(u_xlat16_1.z, half(16511.7441), u_xlat16_9);
    u_xlat2.z = float(u_xlat16_9) * 6.0796734e-05;
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat16_9 = dot(u_xlat16_1.xy, half2(1855.91467, 14655.8301));
    u_xlat16_9 = half(float(u_xlat16_9) * 6.0796734e-05);
    u_xlat2.xy = min(float2(u_xlat16_9), float2(1.0, 1.0));
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
  GpuProgramID 400182
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half2 u_xlat16_3;
    half u_xlat16_10;
    half u_xlat16_12;
    float u_xlat13;
    half u_xlat16_13;
    bool u_xlatb13;
    half u_xlat16_14;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, half3(2.43251014, 11.4688454, 1.76049244));
    u_xlat16_2 = half4(float4(u_xlat16_12) * float4(0.00778222037, 5.98477382e-05, -0.000328985829, 0.232164323));
    u_xlat16_3.xy = half2(u_xlat16_12) * half2(0.137866527, 0.00933136418);
    u_xlat16_12 = dot(u_xlat16_1.xyz, half3(6.5019784, 11.0320301, 1.22384095));
    u_xlat16_13 = u_xlat16_12 * half(0.00778222037);
    u_xlat13 = float(u_xlat16_2.x) / float(u_xlat16_13);
    u_xlatb13 = u_xlat13<0.834949017;
    u_xlat16_2.xy = half2(fma(float2(u_xlat16_12), float2(-4.58941759e-06, 0.000198408336), float2(u_xlat16_2.yz)));
    u_xlat16_10 = fma(u_xlat16_12, half(0.239932507), (-u_xlat16_2.w));
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(98.8431854, -58.8051376);
    u_xlat13 = (u_xlatb13) ? u_xlat2.x : u_xlat2.y;
    u_xlat2.x = fma(u_xlat13, 1.61047399, float(u_xlat16_10));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_14 = fma(u_xlat16_12, half(-0.0504402146), u_xlat16_3.x);
    u_xlat16_12 = fma(u_xlat16_12, half(-0.00292370259), (-u_xlat16_3.y));
    u_xlat2.z = fma(u_xlat13, 14.2738457, float(u_xlat16_12));
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat2.y = fma((-u_xlat13), 2.53264189, float(u_xlat16_14));
    u_xlat2.y = clamp(u_xlat2.y, 0.0f, 1.0f);
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half2 u_xlat16_3;
    half u_xlat16_10;
    half u_xlat16_12;
    float u_xlat13;
    half u_xlat16_13;
    bool u_xlatb13;
    half u_xlat16_14;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, half3(2.43251014, 11.4688454, 1.76049244));
    u_xlat16_2 = half4(float4(u_xlat16_12) * float4(0.00778222037, 5.98477382e-05, -0.000328985829, 0.232164323));
    u_xlat16_3.xy = half2(u_xlat16_12) * half2(0.137866527, 0.00933136418);
    u_xlat16_12 = dot(u_xlat16_1.xyz, half3(6.5019784, 11.0320301, 1.22384095));
    u_xlat16_13 = u_xlat16_12 * half(0.00778222037);
    u_xlat13 = float(u_xlat16_2.x) / float(u_xlat16_13);
    u_xlatb13 = u_xlat13<0.834949017;
    u_xlat16_2.xy = half2(fma(float2(u_xlat16_12), float2(-4.58941759e-06, 0.000198408336), float2(u_xlat16_2.yz)));
    u_xlat16_10 = fma(u_xlat16_12, half(0.239932507), (-u_xlat16_2.w));
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(98.8431854, -58.8051376);
    u_xlat13 = (u_xlatb13) ? u_xlat2.x : u_xlat2.y;
    u_xlat2.x = fma(u_xlat13, 1.61047399, float(u_xlat16_10));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_14 = fma(u_xlat16_12, half(-0.0504402146), u_xlat16_3.x);
    u_xlat16_12 = fma(u_xlat16_12, half(-0.00292370259), (-u_xlat16_3.y));
    u_xlat2.z = fma(u_xlat13, 14.2738457, float(u_xlat16_12));
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat2.y = fma((-u_xlat13), 2.53264189, float(u_xlat16_14));
    u_xlat2.y = clamp(u_xlat2.y, 0.0f, 1.0f);
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
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
    float4 _Params;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half2 u_xlat16_3;
    half u_xlat16_10;
    half u_xlat16_12;
    float u_xlat13;
    half u_xlat16_13;
    bool u_xlatb13;
    half u_xlat16_14;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, half3(2.43251014, 11.4688454, 1.76049244));
    u_xlat16_2 = half4(float4(u_xlat16_12) * float4(0.00778222037, 5.98477382e-05, -0.000328985829, 0.232164323));
    u_xlat16_3.xy = half2(u_xlat16_12) * half2(0.137866527, 0.00933136418);
    u_xlat16_12 = dot(u_xlat16_1.xyz, half3(6.5019784, 11.0320301, 1.22384095));
    u_xlat16_13 = u_xlat16_12 * half(0.00778222037);
    u_xlat13 = float(u_xlat16_2.x) / float(u_xlat16_13);
    u_xlatb13 = u_xlat13<0.834949017;
    u_xlat16_2.xy = half2(fma(float2(u_xlat16_12), float2(-4.58941759e-06, 0.000198408336), float2(u_xlat16_2.yz)));
    u_xlat16_10 = fma(u_xlat16_12, half(0.239932507), (-u_xlat16_2.w));
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(98.8431854, -58.8051376);
    u_xlat13 = (u_xlatb13) ? u_xlat2.x : u_xlat2.y;
    u_xlat2.x = fma(u_xlat13, 1.61047399, float(u_xlat16_10));
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat16_14 = fma(u_xlat16_12, half(-0.0504402146), u_xlat16_3.x);
    u_xlat16_12 = fma(u_xlat16_12, half(-0.00292370259), (-u_xlat16_3.y));
    u_xlat2.z = fma(u_xlat13, 14.2738457, float(u_xlat16_12));
    u_xlat2.z = clamp(u_xlat2.z, 0.0f, 1.0f);
    u_xlat2.y = fma((-u_xlat13), 2.53264189, float(u_xlat16_14));
    u_xlat2.y = clamp(u_xlat2.y, 0.0f, 1.0f);
    u_xlat0.xyz = fma((-float3(u_xlat16_0.xyz)), float3(u_xlat16_0.xyz), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals._Params.xxx, u_xlat0.xyz, float3(u_xlat16_1.xyz));
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
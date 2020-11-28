//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/MotionBlur" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 2508
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
    float4 _CameraMotionVectorsTexture_TexelSize;
    float _VelocityScale;
    float _RcpMaxBlurRadius;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    float u_xlat1;
    float u_xlat2;
    half2 u_xlat16_2;
    u_xlat0.x = FGlobals._VelocityScale * 0.5;
    u_xlat0.xy = u_xlat0.xx * FGlobals._CameraMotionVectorsTexture_TexelSize.zw;
    u_xlat16_2.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * float2(u_xlat16_2.xy);
    u_xlat2 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat2 = u_xlat2 * FGlobals._RcpMaxBlurRadius;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.xy = u_xlat0.xy / float2(u_xlat2);
    u_xlat0.xy = fma(u_xlat0.xy, float2(FGlobals._RcpMaxBlurRadius), float2(1.0, 1.0));
    output.SV_Target0.xy = u_xlat0.xy * float2(0.5, 0.5);
    u_xlat0.x = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    output.SV_Target0.z = u_xlat1 / u_xlat0.x;
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
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _CameraMotionVectorsTexture_TexelSize;
    float _VelocityScale;
    float _RcpMaxBlurRadius;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    float u_xlat1;
    float u_xlat2;
    half2 u_xlat16_2;
    u_xlat0.x = FGlobals._VelocityScale * 0.5;
    u_xlat0.xy = u_xlat0.xx * FGlobals._CameraMotionVectorsTexture_TexelSize.zw;
    u_xlat16_2.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * float2(u_xlat16_2.xy);
    u_xlat2 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat2 = u_xlat2 * FGlobals._RcpMaxBlurRadius;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.xy = u_xlat0.xy / float2(u_xlat2);
    u_xlat0.xy = fma(u_xlat0.xy, float2(FGlobals._RcpMaxBlurRadius), float2(1.0, 1.0));
    output.SV_Target0.xy = u_xlat0.xy * float2(0.5, 0.5);
    u_xlat0.x = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    output.SV_Target0.z = u_xlat1 / u_xlat0.x;
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
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _CameraMotionVectorsTexture_TexelSize;
    float _VelocityScale;
    float _RcpMaxBlurRadius;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    float u_xlat1;
    float u_xlat2;
    half2 u_xlat16_2;
    u_xlat0.x = FGlobals._VelocityScale * 0.5;
    u_xlat0.xy = u_xlat0.xx * FGlobals._CameraMotionVectorsTexture_TexelSize.zw;
    u_xlat16_2.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * float2(u_xlat16_2.xy);
    u_xlat2 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat2 = u_xlat2 * FGlobals._RcpMaxBlurRadius;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.xy = u_xlat0.xy / float2(u_xlat2);
    u_xlat0.xy = fma(u_xlat0.xy, float2(FGlobals._RcpMaxBlurRadius), float2(1.0, 1.0));
    output.SV_Target0.xy = u_xlat0.xy * float2(0.5, 0.5);
    u_xlat0.x = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat1 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy).x;
    u_xlat1 = u_xlat1 * FGlobals._ZBufferParams.x;
    u_xlat0.x = fma(u_xlat0.x, u_xlat1, FGlobals._ZBufferParams.y);
    u_xlat1 = fma((-FGlobals.unity_OrthoParams.w), u_xlat1, 1.0);
    output.SV_Target0.z = u_xlat1 / u_xlat0.x;
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
  GpuProgramID 70181
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
    float4 _MainTex_TexelSize;
    float _MaxBlurRadius;
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
    half2 u_xlat16_0;
    float4 u_xlat1;
    half2 u_xlat16_1;
    bool u_xlatb1;
    float u_xlat3;
    float u_xlat4;
    half2 u_xlat16_4;
    bool u_xlatb4;
    half2 u_xlat16_5;
    float u_xlat6;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat16_0.xy = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xy;
    u_xlat16_4.xy = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xy;
    u_xlat0.zw = fma(float2(u_xlat16_4.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xy = fma(float2(u_xlat16_0.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0 = u_xlat0 * float4(FGlobals._MaxBlurRadius);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat3 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlatb1 = u_xlat1.x<u_xlat3;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat16_1.xy = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xy;
    u_xlat16_5.xy = _MainTex.sample(sampler_MainTex, u_xlat1.zw).xy;
    u_xlat1.zw = fma(float2(u_xlat16_5.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat1.xy = fma(float2(u_xlat16_1.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat1 = u_xlat1 * float4(FGlobals._MaxBlurRadius);
    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb4 = u_xlat4<u_xlat6;
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat6 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlatb4 = u_xlat4<u_xlat6;
    output.SV_Target0.xy = (bool(u_xlatb4)) ? u_xlat1.zw : u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 _MainTex_TexelSize;
    float _MaxBlurRadius;
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
    half2 u_xlat16_0;
    float4 u_xlat1;
    half2 u_xlat16_1;
    bool u_xlatb1;
    float u_xlat3;
    float u_xlat4;
    half2 u_xlat16_4;
    bool u_xlatb4;
    half2 u_xlat16_5;
    float u_xlat6;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat16_0.xy = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xy;
    u_xlat16_4.xy = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xy;
    u_xlat0.zw = fma(float2(u_xlat16_4.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xy = fma(float2(u_xlat16_0.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0 = u_xlat0 * float4(FGlobals._MaxBlurRadius);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat3 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlatb1 = u_xlat1.x<u_xlat3;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat16_1.xy = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xy;
    u_xlat16_5.xy = _MainTex.sample(sampler_MainTex, u_xlat1.zw).xy;
    u_xlat1.zw = fma(float2(u_xlat16_5.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat1.xy = fma(float2(u_xlat16_1.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat1 = u_xlat1 * float4(FGlobals._MaxBlurRadius);
    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb4 = u_xlat4<u_xlat6;
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat6 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlatb4 = u_xlat4<u_xlat6;
    output.SV_Target0.xy = (bool(u_xlatb4)) ? u_xlat1.zw : u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 _MainTex_TexelSize;
    float _MaxBlurRadius;
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
    half2 u_xlat16_0;
    float4 u_xlat1;
    half2 u_xlat16_1;
    bool u_xlatb1;
    float u_xlat3;
    float u_xlat4;
    half2 u_xlat16_4;
    bool u_xlatb4;
    half2 u_xlat16_5;
    float u_xlat6;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat16_0.xy = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xy;
    u_xlat16_4.xy = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xy;
    u_xlat0.zw = fma(float2(u_xlat16_4.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xy = fma(float2(u_xlat16_0.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0 = u_xlat0 * float4(FGlobals._MaxBlurRadius);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat3 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlatb1 = u_xlat1.x<u_xlat3;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat16_1.xy = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xy;
    u_xlat16_5.xy = _MainTex.sample(sampler_MainTex, u_xlat1.zw).xy;
    u_xlat1.zw = fma(float2(u_xlat16_5.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat1.xy = fma(float2(u_xlat16_1.xy), float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat1 = u_xlat1 * float4(FGlobals._MaxBlurRadius);
    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb4 = u_xlat4<u_xlat6;
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat4 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat6 = dot(u_xlat1.zw, u_xlat1.zw);
    u_xlatb4 = u_xlat4<u_xlat6;
    output.SV_Target0.xy = (bool(u_xlatb4)) ? u_xlat1.zw : u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 160524
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
    float4 u_xlat1;
    bool u_xlatb1;
    float u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float2 u_xlat5;
    float u_xlat6;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy).xy);
    u_xlat4.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.zw).xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat3 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlatb1 = u_xlat1.x<u_xlat3;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat4.xy : u_xlat0.xy;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat5.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb4 = u_xlat4.x<u_xlat6;
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat6 = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlatb4 = u_xlat4.x<u_xlat6;
    output.SV_Target0.xy = (bool(u_xlatb4)) ? u_xlat5.xy : u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 u_xlat1;
    bool u_xlatb1;
    float u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float2 u_xlat5;
    float u_xlat6;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy).xy);
    u_xlat4.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.zw).xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat3 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlatb1 = u_xlat1.x<u_xlat3;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat4.xy : u_xlat0.xy;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat5.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb4 = u_xlat4.x<u_xlat6;
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat6 = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlatb4 = u_xlat4.x<u_xlat6;
    output.SV_Target0.xy = (bool(u_xlatb4)) ? u_xlat5.xy : u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 u_xlat1;
    bool u_xlatb1;
    float u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float2 u_xlat5;
    float u_xlat6;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, -0.5, 0.5, -0.5), input.TEXCOORD0.xyxy);
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy).xy);
    u_xlat4.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.zw).xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat3 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlatb1 = u_xlat1.x<u_xlat3;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat4.xy : u_xlat0.xy;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat5.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat6 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb4 = u_xlat4.x<u_xlat6;
    u_xlat0.xy = (bool(u_xlatb4)) ? u_xlat1.xy : u_xlat0.xy;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat6 = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlatb4 = u_xlat4.x<u_xlat6;
    output.SV_Target0.xy = (bool(u_xlatb4)) ? u_xlat5.xy : u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 229487
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
    float4 _MainTex_TexelSize;
    int _TileMaxLoop;
    float2 _TileMaxOffs;
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
    float2 u_xlat0;
    float4 u_xlat1;
    int u_xlati2;
    float2 u_xlat3;
    float u_xlat4;
    bool u_xlatb4;
    float2 u_xlat7;
    bool u_xlatb7;
    float u_xlat9;
    float2 u_xlat10;
    float2 u_xlat13;
    bool u_xlatb13;
    int u_xlati17;
    u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, FGlobals._TileMaxOffs.xxxy.zw, input.TEXCOORD0.xy);
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.xw = FGlobals._MainTex_TexelSize.xy;
    u_xlat10.x = float(0.0);
    u_xlat10.y = float(0.0);
    u_xlati2 = 0x0;
    while(true){
        u_xlatb7 = u_xlati2>=FGlobals._TileMaxLoop;
        if(u_xlatb7){break;}
        u_xlat7.x = float(u_xlati2);
        u_xlat7.xy = fma(u_xlat1.xy, u_xlat7.xx, u_xlat0.xy);
        u_xlat3.xy = u_xlat10.xy;
        u_xlati17 = 0x0;
        while(true){
            u_xlatb13 = u_xlati17>=FGlobals._TileMaxLoop;
            if(u_xlatb13){break;}
            u_xlat13.x = float(u_xlati17);
            u_xlat13.xy = fma(u_xlat1.zw, u_xlat13.xx, u_xlat7.xy);
            u_xlat13.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat13.xy).xy);
            u_xlat4 = dot(u_xlat3.xy, u_xlat3.xy);
            u_xlat9 = dot(u_xlat13.xy, u_xlat13.xy);
            u_xlatb4 = u_xlat4<u_xlat9;
            u_xlat3.xy = (bool(u_xlatb4)) ? u_xlat13.xy : u_xlat3.xy;
            u_xlati17 = u_xlati17 + 0x1;
        }
        u_xlat10.xy = u_xlat3.xy;
        u_xlati2 = u_xlati2 + 0x1;
    }
    output.SV_Target0.xy = u_xlat10.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 _MainTex_TexelSize;
    int _TileMaxLoop;
    float2 _TileMaxOffs;
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
    float2 u_xlat0;
    float4 u_xlat1;
    int u_xlati2;
    float2 u_xlat3;
    float u_xlat4;
    bool u_xlatb4;
    float2 u_xlat7;
    bool u_xlatb7;
    float u_xlat9;
    float2 u_xlat10;
    float2 u_xlat13;
    bool u_xlatb13;
    int u_xlati17;
    u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, FGlobals._TileMaxOffs.xxxy.zw, input.TEXCOORD0.xy);
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.xw = FGlobals._MainTex_TexelSize.xy;
    u_xlat10.x = float(0.0);
    u_xlat10.y = float(0.0);
    u_xlati2 = 0x0;
    while(true){
        u_xlatb7 = u_xlati2>=FGlobals._TileMaxLoop;
        if(u_xlatb7){break;}
        u_xlat7.x = float(u_xlati2);
        u_xlat7.xy = fma(u_xlat1.xy, u_xlat7.xx, u_xlat0.xy);
        u_xlat3.xy = u_xlat10.xy;
        u_xlati17 = 0x0;
        while(true){
            u_xlatb13 = u_xlati17>=FGlobals._TileMaxLoop;
            if(u_xlatb13){break;}
            u_xlat13.x = float(u_xlati17);
            u_xlat13.xy = fma(u_xlat1.zw, u_xlat13.xx, u_xlat7.xy);
            u_xlat13.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat13.xy).xy);
            u_xlat4 = dot(u_xlat3.xy, u_xlat3.xy);
            u_xlat9 = dot(u_xlat13.xy, u_xlat13.xy);
            u_xlatb4 = u_xlat4<u_xlat9;
            u_xlat3.xy = (bool(u_xlatb4)) ? u_xlat13.xy : u_xlat3.xy;
            u_xlati17 = u_xlati17 + 0x1;
        }
        u_xlat10.xy = u_xlat3.xy;
        u_xlati2 = u_xlati2 + 0x1;
    }
    output.SV_Target0.xy = u_xlat10.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 _MainTex_TexelSize;
    int _TileMaxLoop;
    float2 _TileMaxOffs;
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
    float2 u_xlat0;
    float4 u_xlat1;
    int u_xlati2;
    float2 u_xlat3;
    float u_xlat4;
    bool u_xlatb4;
    float2 u_xlat7;
    bool u_xlatb7;
    float u_xlat9;
    float2 u_xlat10;
    float2 u_xlat13;
    bool u_xlatb13;
    int u_xlati17;
    u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, FGlobals._TileMaxOffs.xxxy.zw, input.TEXCOORD0.xy);
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.xw = FGlobals._MainTex_TexelSize.xy;
    u_xlat10.x = float(0.0);
    u_xlat10.y = float(0.0);
    u_xlati2 = 0x0;
    while(true){
        u_xlatb7 = u_xlati2>=FGlobals._TileMaxLoop;
        if(u_xlatb7){break;}
        u_xlat7.x = float(u_xlati2);
        u_xlat7.xy = fma(u_xlat1.xy, u_xlat7.xx, u_xlat0.xy);
        u_xlat3.xy = u_xlat10.xy;
        u_xlati17 = 0x0;
        while(true){
            u_xlatb13 = u_xlati17>=FGlobals._TileMaxLoop;
            if(u_xlatb13){break;}
            u_xlat13.x = float(u_xlati17);
            u_xlat13.xy = fma(u_xlat1.zw, u_xlat13.xx, u_xlat7.xy);
            u_xlat13.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat13.xy).xy);
            u_xlat4 = dot(u_xlat3.xy, u_xlat3.xy);
            u_xlat9 = dot(u_xlat13.xy, u_xlat13.xy);
            u_xlatb4 = u_xlat4<u_xlat9;
            u_xlat3.xy = (bool(u_xlatb4)) ? u_xlat13.xy : u_xlat3.xy;
            u_xlati17 = u_xlati17 + 0x1;
        }
        u_xlat10.xy = u_xlat3.xy;
        u_xlati2 = u_xlati2 + 0x1;
    }
    output.SV_Target0.xy = u_xlat10.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 276320
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
    float4 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float u_xlat4;
    float2 u_xlat6;
    bool u_xlatb6;
    float2 u_xlat7;
    half2 u_xlat16_7;
    float u_xlat8;
    float u_xlat9;
    bool u_xlatb9;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy).xy);
    u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.zw).xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat4 = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlatb1 = u_xlat1.x<u_xlat4;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat6.xy : u_xlat0.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat7.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat16_7.xy = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy;
    u_xlat7.xy = float2(u_xlat16_7.xy) * float2(1.00999999, 1.00999999);
    u_xlat2.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat2.x<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat2 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(-1.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.zw).xy);
    u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy).xy);
    u_xlat8 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat8<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat9 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat8 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat8<u_xlat9;
    u_xlat7.xy = (bool(u_xlatb9)) ? u_xlat2.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb9 = u_xlat2.x<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat7.xy : u_xlat1.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
    output.SV_Target0.xy = u_xlat0.xy * float2(0.990099013, 0.990099013);
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float u_xlat4;
    float2 u_xlat6;
    bool u_xlatb6;
    float2 u_xlat7;
    half2 u_xlat16_7;
    float u_xlat8;
    float u_xlat9;
    bool u_xlatb9;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy).xy);
    u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.zw).xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat4 = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlatb1 = u_xlat1.x<u_xlat4;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat6.xy : u_xlat0.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat7.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat16_7.xy = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy;
    u_xlat7.xy = float2(u_xlat16_7.xy) * float2(1.00999999, 1.00999999);
    u_xlat2.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat2.x<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat2 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(-1.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.zw).xy);
    u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy).xy);
    u_xlat8 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat8<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat9 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat8 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat8<u_xlat9;
    u_xlat7.xy = (bool(u_xlatb9)) ? u_xlat2.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb9 = u_xlat2.x<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat7.xy : u_xlat1.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
    output.SV_Target0.xy = u_xlat0.xy * float2(0.990099013, 0.990099013);
    output.SV_Target0.zw = float2(0.0, 0.0);
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
    float4 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float u_xlat4;
    float2 u_xlat6;
    bool u_xlatb6;
    float2 u_xlat7;
    half2 u_xlat16_7;
    float u_xlat8;
    float u_xlat9;
    bool u_xlatb9;
    u_xlat0 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy).xy);
    u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.zw).xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat4 = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlatb1 = u_xlat1.x<u_xlat4;
    u_xlat0.xy = (bool(u_xlatb1)) ? u_xlat6.xy : u_xlat0.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat7.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat16_7.xy = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy;
    u_xlat7.xy = float2(u_xlat16_7.xy) * float2(1.00999999, 1.00999999);
    u_xlat2.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat2.x<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat2 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(-1.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.zw).xy);
    u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy).xy);
    u_xlat8 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat8<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat9 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 1.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat7.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.zw).xy);
    u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy).xy);
    u_xlat8 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlatb9 = u_xlat8<u_xlat9;
    u_xlat7.xy = (bool(u_xlatb9)) ? u_xlat2.xy : u_xlat7.xy;
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb9 = u_xlat2.x<u_xlat9;
    u_xlat1.xy = (bool(u_xlatb9)) ? u_xlat7.xy : u_xlat1.xy;
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlatb6 = u_xlat9<u_xlat6.x;
    u_xlat0.xy = (bool(u_xlatb6)) ? u_xlat0.xy : u_xlat1.xy;
    output.SV_Target0.xy = u_xlat0.xy * float2(0.990099013, 0.990099013);
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 334382
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
    float4 _ScreenParams;
    float4 _MainTex_TexelSize;
    float2 _VelocityTex_TexelSize;
    float2 _NeighborMaxTex_TexelSize;
    float _MaxBlurRadius;
    float _LoopCount;
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
    sampler sampler_VelocityTex [[ sampler (1) ]],
    sampler sampler_NeighborMaxTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _VelocityTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _NeighborMaxTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    float u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    bool2 u_xlatb7;
    float2 u_xlat8;
    half3 u_xlat16_8;
    float u_xlat13;
    float u_xlat19;
    float2 u_xlat21;
    float u_xlat22;
    float u_xlat25;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat31;
    float u_xlat34;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat1.xy = input.TEXCOORD0.xy + float2(2.0, 0.0);
    u_xlat1.xy = u_xlat1.xy * FGlobals._ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.x = dot(float2(0.0671105608, 0.00583714992), u_xlat1.xy);
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * 52.9829178;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat2.x = cos(u_xlat1.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat1.xy = u_xlat2.xy * FGlobals._NeighborMaxTex_TexelSize.xxxy.zw;
    u_xlat1.xy = fma(u_xlat1.xy, float2(0.25, 0.25), input.TEXCOORD0.xy);
    u_xlat1.xy = float2(_NeighborMaxTex.sample(sampler_NeighborMaxTex, u_xlat1.xy).xy);
    u_xlat19 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlatb28 = u_xlat19<2.0;
    if(u_xlatb28){
        output.SV_Target0 = float4(u_xlat16_0);
        return output;
    }
    u_xlat16_2.xyz = _VelocityTex.sample(sampler_VelocityTex, input.TEXCOORD0.xy, level(0.0)).xyz;
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(2.0, 2.0), half2(-1.0, -1.0));
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(FGlobals._MaxBlurRadius);
    u_xlat28 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat3.xy = max(float2(u_xlat28), float2(0.5, 1.0));
    u_xlat16_28 = half(1.0) / u_xlat16_2.z;
    u_xlat29 = u_xlat3.x + u_xlat3.x;
    u_xlatb29 = u_xlat19<u_xlat29;
    u_xlat3.x = u_xlat19 / u_xlat3.x;
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xx;
    u_xlat2.xy = (bool(u_xlatb29)) ? u_xlat2.xy : u_xlat1.xy;
    u_xlat29 = u_xlat19 * 0.5;
    u_xlat29 = min(u_xlat29, FGlobals._LoopCount);
    u_xlat29 = floor(u_xlat29);
    u_xlat3.x = float(1.0) / u_xlat29;
    u_xlat21.xy = input.TEXCOORD0.xy * FGlobals._ScreenParams.xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.x = dot(float2(0.0671105608, 0.00583714992), u_xlat21.xy);
    u_xlat3.z = fract(u_xlat21.x);
    u_xlat21.xy = u_xlat3.zx * float2(52.9829178, 0.25);
    u_xlat21.x = fract(u_xlat21.x);
    u_xlat21.x = u_xlat21.x + -0.5;
    u_xlat4 = fma((-u_xlat3.x), 0.5, 1.0);
    u_xlat5.w = 1.0;
    u_xlat6.x = float(0.0);
    u_xlat6.y = float(0.0);
    u_xlat6.z = float(0.0);
    u_xlat6.w = float(0.0);
    u_xlat13 = u_xlat4;
    u_xlat22 = 0.0;
    u_xlat31 = u_xlat3.y;
    while(true){
        u_xlatb7.x = u_xlat21.y>=u_xlat13;
        if(u_xlatb7.x){break;}
        u_xlat7.xy = float2(u_xlat22) * float2(0.25, 0.5);
        u_xlat7.xy = fract(u_xlat7.xy);
        u_xlatb7.xy = (float2(0.499000013, 0.499000013)<u_xlat7.xy);
        u_xlat7.xz = (u_xlatb7.x) ? u_xlat2.xy : u_xlat1.xy;
        u_xlat34 = (u_xlatb7.y) ? (-u_xlat13) : u_xlat13;
        u_xlat34 = fma(u_xlat21.x, u_xlat3.x, u_xlat34);
        u_xlat7.xz = float2(u_xlat34) * u_xlat7.xz;
        u_xlat8.xy = fma(u_xlat7.xz, FGlobals._MainTex_TexelSize.xy, input.TEXCOORD0.xy);
        u_xlat7.xz = fma(u_xlat7.xz, FGlobals._VelocityTex_TexelSize.xyxx.xy, input.TEXCOORD0.xy);
        u_xlat5.xyz = float3(_MainTex.sample(sampler_MainTex, u_xlat8.xy, level(0.0)).xyz);
        u_xlat16_8.xyz = _VelocityTex.sample(sampler_VelocityTex, u_xlat7.xz, level(0.0)).xyz;
        u_xlat16_7.xz = fma(u_xlat16_8.xy, half2(2.0, 2.0), half2(-1.0, -1.0));
        u_xlat7.xz = float2(u_xlat16_7.xz) * float2(FGlobals._MaxBlurRadius);
        u_xlat16_8.x = u_xlat16_2.z + (-u_xlat16_8.z);
        u_xlat16_8.x = u_xlat16_28 * u_xlat16_8.x;
        u_xlat16_8.x = u_xlat16_8.x * half(20.0);
        u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0h, 1.0h);
        u_xlat7.x = dot(u_xlat7.xz, u_xlat7.xz);
        u_xlat7.x = sqrt(u_xlat7.x);
        u_xlat7.x = (-u_xlat31) + u_xlat7.x;
        u_xlat7.x = fma(float(u_xlat16_8.x), u_xlat7.x, u_xlat31);
        u_xlat25 = fma((-u_xlat19), abs(u_xlat34), u_xlat7.x);
        u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
        u_xlat25 = u_xlat25 / u_xlat7.x;
        u_xlat34 = (-u_xlat13) + 1.20000005;
        u_xlat25 = u_xlat34 * u_xlat25;
        u_xlat6 = fma(u_xlat5, float4(u_xlat25), u_xlat6);
        u_xlat31 = max(u_xlat31, u_xlat7.x);
        u_xlat5.x = (-u_xlat3.x) + u_xlat13;
        u_xlat13 = (u_xlatb7.y) ? u_xlat5.x : u_xlat13;
        u_xlat22 = u_xlat22 + 1.0;
    }
    u_xlat1.x = dot(float2(u_xlat31), float2(u_xlat29));
    u_xlat1.x = 1.20000005 / u_xlat1.x;
    u_xlat2.xyz = float3(u_xlat16_0.xyz);
    u_xlat2.w = 1.0;
    u_xlat1 = fma(u_xlat2, u_xlat1.xxxx, u_xlat6);
    output.SV_Target0.xyz = u_xlat1.xyz / u_xlat1.www;
    output.SV_Target0.w = float(u_xlat16_0.w);
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
    float4 _ScreenParams;
    float4 _MainTex_TexelSize;
    float2 _VelocityTex_TexelSize;
    float2 _NeighborMaxTex_TexelSize;
    float _MaxBlurRadius;
    float _LoopCount;
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
    sampler sampler_VelocityTex [[ sampler (1) ]],
    sampler sampler_NeighborMaxTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _VelocityTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _NeighborMaxTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    float u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    bool2 u_xlatb7;
    float2 u_xlat8;
    half3 u_xlat16_8;
    float u_xlat13;
    float u_xlat19;
    float2 u_xlat21;
    float u_xlat22;
    float u_xlat25;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat31;
    float u_xlat34;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat1.xy = input.TEXCOORD0.xy + float2(2.0, 0.0);
    u_xlat1.xy = u_xlat1.xy * FGlobals._ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.x = dot(float2(0.0671105608, 0.00583714992), u_xlat1.xy);
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * 52.9829178;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat2.x = cos(u_xlat1.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat1.xy = u_xlat2.xy * FGlobals._NeighborMaxTex_TexelSize.xxxy.zw;
    u_xlat1.xy = fma(u_xlat1.xy, float2(0.25, 0.25), input.TEXCOORD0.xy);
    u_xlat1.xy = float2(_NeighborMaxTex.sample(sampler_NeighborMaxTex, u_xlat1.xy).xy);
    u_xlat19 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlatb28 = u_xlat19<2.0;
    if(u_xlatb28){
        output.SV_Target0 = float4(u_xlat16_0);
        return output;
    }
    u_xlat16_2.xyz = _VelocityTex.sample(sampler_VelocityTex, input.TEXCOORD0.xy, level(0.0)).xyz;
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(2.0, 2.0), half2(-1.0, -1.0));
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(FGlobals._MaxBlurRadius);
    u_xlat28 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat3.xy = max(float2(u_xlat28), float2(0.5, 1.0));
    u_xlat16_28 = half(1.0) / u_xlat16_2.z;
    u_xlat29 = u_xlat3.x + u_xlat3.x;
    u_xlatb29 = u_xlat19<u_xlat29;
    u_xlat3.x = u_xlat19 / u_xlat3.x;
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xx;
    u_xlat2.xy = (bool(u_xlatb29)) ? u_xlat2.xy : u_xlat1.xy;
    u_xlat29 = u_xlat19 * 0.5;
    u_xlat29 = min(u_xlat29, FGlobals._LoopCount);
    u_xlat29 = floor(u_xlat29);
    u_xlat3.x = float(1.0) / u_xlat29;
    u_xlat21.xy = input.TEXCOORD0.xy * FGlobals._ScreenParams.xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.x = dot(float2(0.0671105608, 0.00583714992), u_xlat21.xy);
    u_xlat3.z = fract(u_xlat21.x);
    u_xlat21.xy = u_xlat3.zx * float2(52.9829178, 0.25);
    u_xlat21.x = fract(u_xlat21.x);
    u_xlat21.x = u_xlat21.x + -0.5;
    u_xlat4 = fma((-u_xlat3.x), 0.5, 1.0);
    u_xlat5.w = 1.0;
    u_xlat6.x = float(0.0);
    u_xlat6.y = float(0.0);
    u_xlat6.z = float(0.0);
    u_xlat6.w = float(0.0);
    u_xlat13 = u_xlat4;
    u_xlat22 = 0.0;
    u_xlat31 = u_xlat3.y;
    while(true){
        u_xlatb7.x = u_xlat21.y>=u_xlat13;
        if(u_xlatb7.x){break;}
        u_xlat7.xy = float2(u_xlat22) * float2(0.25, 0.5);
        u_xlat7.xy = fract(u_xlat7.xy);
        u_xlatb7.xy = (float2(0.499000013, 0.499000013)<u_xlat7.xy);
        u_xlat7.xz = (u_xlatb7.x) ? u_xlat2.xy : u_xlat1.xy;
        u_xlat34 = (u_xlatb7.y) ? (-u_xlat13) : u_xlat13;
        u_xlat34 = fma(u_xlat21.x, u_xlat3.x, u_xlat34);
        u_xlat7.xz = float2(u_xlat34) * u_xlat7.xz;
        u_xlat8.xy = fma(u_xlat7.xz, FGlobals._MainTex_TexelSize.xy, input.TEXCOORD0.xy);
        u_xlat7.xz = fma(u_xlat7.xz, FGlobals._VelocityTex_TexelSize.xyxx.xy, input.TEXCOORD0.xy);
        u_xlat5.xyz = float3(_MainTex.sample(sampler_MainTex, u_xlat8.xy, level(0.0)).xyz);
        u_xlat16_8.xyz = _VelocityTex.sample(sampler_VelocityTex, u_xlat7.xz, level(0.0)).xyz;
        u_xlat16_7.xz = fma(u_xlat16_8.xy, half2(2.0, 2.0), half2(-1.0, -1.0));
        u_xlat7.xz = float2(u_xlat16_7.xz) * float2(FGlobals._MaxBlurRadius);
        u_xlat16_8.x = u_xlat16_2.z + (-u_xlat16_8.z);
        u_xlat16_8.x = u_xlat16_28 * u_xlat16_8.x;
        u_xlat16_8.x = u_xlat16_8.x * half(20.0);
        u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0h, 1.0h);
        u_xlat7.x = dot(u_xlat7.xz, u_xlat7.xz);
        u_xlat7.x = sqrt(u_xlat7.x);
        u_xlat7.x = (-u_xlat31) + u_xlat7.x;
        u_xlat7.x = fma(float(u_xlat16_8.x), u_xlat7.x, u_xlat31);
        u_xlat25 = fma((-u_xlat19), abs(u_xlat34), u_xlat7.x);
        u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
        u_xlat25 = u_xlat25 / u_xlat7.x;
        u_xlat34 = (-u_xlat13) + 1.20000005;
        u_xlat25 = u_xlat34 * u_xlat25;
        u_xlat6 = fma(u_xlat5, float4(u_xlat25), u_xlat6);
        u_xlat31 = max(u_xlat31, u_xlat7.x);
        u_xlat5.x = (-u_xlat3.x) + u_xlat13;
        u_xlat13 = (u_xlatb7.y) ? u_xlat5.x : u_xlat13;
        u_xlat22 = u_xlat22 + 1.0;
    }
    u_xlat1.x = dot(float2(u_xlat31), float2(u_xlat29));
    u_xlat1.x = 1.20000005 / u_xlat1.x;
    u_xlat2.xyz = float3(u_xlat16_0.xyz);
    u_xlat2.w = 1.0;
    u_xlat1 = fma(u_xlat2, u_xlat1.xxxx, u_xlat6);
    output.SV_Target0.xyz = u_xlat1.xyz / u_xlat1.www;
    output.SV_Target0.w = float(u_xlat16_0.w);
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
    float4 _ScreenParams;
    float4 _MainTex_TexelSize;
    float2 _VelocityTex_TexelSize;
    float2 _NeighborMaxTex_TexelSize;
    float _MaxBlurRadius;
    float _LoopCount;
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
    sampler sampler_VelocityTex [[ sampler (1) ]],
    sampler sampler_NeighborMaxTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _VelocityTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _NeighborMaxTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    float u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    bool2 u_xlatb7;
    float2 u_xlat8;
    half3 u_xlat16_8;
    float u_xlat13;
    float u_xlat19;
    float2 u_xlat21;
    float u_xlat22;
    float u_xlat25;
    float u_xlat28;
    half u_xlat16_28;
    bool u_xlatb28;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat31;
    float u_xlat34;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat1.xy = input.TEXCOORD0.xy + float2(2.0, 0.0);
    u_xlat1.xy = u_xlat1.xy * FGlobals._ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.x = dot(float2(0.0671105608, 0.00583714992), u_xlat1.xy);
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * 52.9829178;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat2.x = cos(u_xlat1.x);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat1.xy = u_xlat2.xy * FGlobals._NeighborMaxTex_TexelSize.xxxy.zw;
    u_xlat1.xy = fma(u_xlat1.xy, float2(0.25, 0.25), input.TEXCOORD0.xy);
    u_xlat1.xy = float2(_NeighborMaxTex.sample(sampler_NeighborMaxTex, u_xlat1.xy).xy);
    u_xlat19 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat19 = sqrt(u_xlat19);
    u_xlatb28 = u_xlat19<2.0;
    if(u_xlatb28){
        output.SV_Target0 = float4(u_xlat16_0);
        return output;
    }
    u_xlat16_2.xyz = _VelocityTex.sample(sampler_VelocityTex, input.TEXCOORD0.xy, level(0.0)).xyz;
    u_xlat16_2.xy = fma(u_xlat16_2.xy, half2(2.0, 2.0), half2(-1.0, -1.0));
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(FGlobals._MaxBlurRadius);
    u_xlat28 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat28 = sqrt(u_xlat28);
    u_xlat3.xy = max(float2(u_xlat28), float2(0.5, 1.0));
    u_xlat16_28 = half(1.0) / u_xlat16_2.z;
    u_xlat29 = u_xlat3.x + u_xlat3.x;
    u_xlatb29 = u_xlat19<u_xlat29;
    u_xlat3.x = u_xlat19 / u_xlat3.x;
    u_xlat2.xy = u_xlat2.xy * u_xlat3.xx;
    u_xlat2.xy = (bool(u_xlatb29)) ? u_xlat2.xy : u_xlat1.xy;
    u_xlat29 = u_xlat19 * 0.5;
    u_xlat29 = min(u_xlat29, FGlobals._LoopCount);
    u_xlat29 = floor(u_xlat29);
    u_xlat3.x = float(1.0) / u_xlat29;
    u_xlat21.xy = input.TEXCOORD0.xy * FGlobals._ScreenParams.xy;
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.x = dot(float2(0.0671105608, 0.00583714992), u_xlat21.xy);
    u_xlat3.z = fract(u_xlat21.x);
    u_xlat21.xy = u_xlat3.zx * float2(52.9829178, 0.25);
    u_xlat21.x = fract(u_xlat21.x);
    u_xlat21.x = u_xlat21.x + -0.5;
    u_xlat4 = fma((-u_xlat3.x), 0.5, 1.0);
    u_xlat5.w = 1.0;
    u_xlat6.x = float(0.0);
    u_xlat6.y = float(0.0);
    u_xlat6.z = float(0.0);
    u_xlat6.w = float(0.0);
    u_xlat13 = u_xlat4;
    u_xlat22 = 0.0;
    u_xlat31 = u_xlat3.y;
    while(true){
        u_xlatb7.x = u_xlat21.y>=u_xlat13;
        if(u_xlatb7.x){break;}
        u_xlat7.xy = float2(u_xlat22) * float2(0.25, 0.5);
        u_xlat7.xy = fract(u_xlat7.xy);
        u_xlatb7.xy = (float2(0.499000013, 0.499000013)<u_xlat7.xy);
        u_xlat7.xz = (u_xlatb7.x) ? u_xlat2.xy : u_xlat1.xy;
        u_xlat34 = (u_xlatb7.y) ? (-u_xlat13) : u_xlat13;
        u_xlat34 = fma(u_xlat21.x, u_xlat3.x, u_xlat34);
        u_xlat7.xz = float2(u_xlat34) * u_xlat7.xz;
        u_xlat8.xy = fma(u_xlat7.xz, FGlobals._MainTex_TexelSize.xy, input.TEXCOORD0.xy);
        u_xlat7.xz = fma(u_xlat7.xz, FGlobals._VelocityTex_TexelSize.xyxx.xy, input.TEXCOORD0.xy);
        u_xlat5.xyz = float3(_MainTex.sample(sampler_MainTex, u_xlat8.xy, level(0.0)).xyz);
        u_xlat16_8.xyz = _VelocityTex.sample(sampler_VelocityTex, u_xlat7.xz, level(0.0)).xyz;
        u_xlat16_7.xz = fma(u_xlat16_8.xy, half2(2.0, 2.0), half2(-1.0, -1.0));
        u_xlat7.xz = float2(u_xlat16_7.xz) * float2(FGlobals._MaxBlurRadius);
        u_xlat16_8.x = u_xlat16_2.z + (-u_xlat16_8.z);
        u_xlat16_8.x = u_xlat16_28 * u_xlat16_8.x;
        u_xlat16_8.x = u_xlat16_8.x * half(20.0);
        u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0h, 1.0h);
        u_xlat7.x = dot(u_xlat7.xz, u_xlat7.xz);
        u_xlat7.x = sqrt(u_xlat7.x);
        u_xlat7.x = (-u_xlat31) + u_xlat7.x;
        u_xlat7.x = fma(float(u_xlat16_8.x), u_xlat7.x, u_xlat31);
        u_xlat25 = fma((-u_xlat19), abs(u_xlat34), u_xlat7.x);
        u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
        u_xlat25 = u_xlat25 / u_xlat7.x;
        u_xlat34 = (-u_xlat13) + 1.20000005;
        u_xlat25 = u_xlat34 * u_xlat25;
        u_xlat6 = fma(u_xlat5, float4(u_xlat25), u_xlat6);
        u_xlat31 = max(u_xlat31, u_xlat7.x);
        u_xlat5.x = (-u_xlat3.x) + u_xlat13;
        u_xlat13 = (u_xlatb7.y) ? u_xlat5.x : u_xlat13;
        u_xlat22 = u_xlat22 + 1.0;
    }
    u_xlat1.x = dot(float2(u_xlat31), float2(u_xlat29));
    u_xlat1.x = 1.20000005 / u_xlat1.x;
    u_xlat2.xyz = float3(u_xlat16_0.xyz);
    u_xlat2.w = 1.0;
    u_xlat1 = fma(u_xlat2, u_xlat1.xxxx, u_xlat6);
    output.SV_Target0.xyz = u_xlat1.xyz / u_xlat1.www;
    output.SV_Target0.w = float(u_xlat16_0.w);
    return output;
}
"
}
}
}
}
}
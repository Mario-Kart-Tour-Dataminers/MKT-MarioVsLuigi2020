//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/DepthOfField" {
Properties {
}
SubShader {
 Pass {
  Name "CoC Calculation"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 44132
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
    float _RcpMaxCoC;
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
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0 = fma(FGlobals._ZBufferParams.z, u_xlat0, FGlobals._ZBufferParams.w);
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-FGlobals._Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * FGlobals._LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = fma(u_xlat0, FGlobals._RcpMaxCoC, 0.5);
    output.SV_Target0 = float4(u_xlat0);
    output.SV_Target0 = clamp(output.SV_Target0, 0.0f, 1.0f);
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
    float _RcpMaxCoC;
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
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0 = fma(FGlobals._ZBufferParams.z, u_xlat0, FGlobals._ZBufferParams.w);
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-FGlobals._Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * FGlobals._LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = fma(u_xlat0, FGlobals._RcpMaxCoC, 0.5);
    output.SV_Target0 = float4(u_xlat0);
    output.SV_Target0 = clamp(output.SV_Target0, 0.0f, 1.0f);
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
    float _RcpMaxCoC;
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
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0 = fma(FGlobals._ZBufferParams.z, u_xlat0, FGlobals._ZBufferParams.w);
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-FGlobals._Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * FGlobals._LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = fma(u_xlat0, FGlobals._RcpMaxCoC, 0.5);
    output.SV_Target0 = float4(u_xlat0);
    output.SV_Target0 = clamp(output.SV_Target0, 0.0f, 1.0f);
    return output;
}
"
}
}
}
 Pass {
  Name "CoC Temporal Filter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 93513
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
    float3 _TaaParams;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    sampler sampler_CoCTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float2 u_xlat3;
    float3 u_xlat5;
    bool u_xlatb5;
    bool u_xlatb6;
    float u_xlat8;
    bool u_xlatb9;
    float2 u_xlat11;
    float u_xlat12;
    u_xlat0.xy = FGlobals._MainTex_TexelSize.yy * float2(-0.0, -1.0);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 0.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat12 = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlat0.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.zw).x);
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat1.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = select(float2(0.0, 0.0), u_xlat11.xy, bool2(bool2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat5.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x);
    u_xlat2.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x);
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = FGlobals._MainTex_TexelSize.yy * float2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.x = _MainTex.sample(sampler_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, float(u_xlat16_0.x));
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    output.SV_Target0 = fma(FGlobals._TaaParams.xxyz.wwww, u_xlat0.xxxx, u_xlat1.xxxx);
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
    float3 _TaaParams;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    sampler sampler_CoCTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float2 u_xlat3;
    float3 u_xlat5;
    bool u_xlatb5;
    bool u_xlatb6;
    float u_xlat8;
    bool u_xlatb9;
    float2 u_xlat11;
    float u_xlat12;
    u_xlat0.xy = FGlobals._MainTex_TexelSize.yy * float2(-0.0, -1.0);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 0.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat12 = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlat0.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.zw).x);
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat1.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = select(float2(0.0, 0.0), u_xlat11.xy, bool2(bool2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat5.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x);
    u_xlat2.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x);
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = FGlobals._MainTex_TexelSize.yy * float2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.x = _MainTex.sample(sampler_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, float(u_xlat16_0.x));
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    output.SV_Target0 = fma(FGlobals._TaaParams.xxyz.wwww, u_xlat0.xxxx, u_xlat1.xxxx);
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
    float3 _TaaParams;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    sampler sampler_CoCTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float2 u_xlat3;
    float3 u_xlat5;
    bool u_xlatb5;
    bool u_xlatb6;
    float u_xlat8;
    bool u_xlatb9;
    float2 u_xlat11;
    float u_xlat12;
    u_xlat0.xy = FGlobals._MainTex_TexelSize.yy * float2(-0.0, -1.0);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 0.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat12 = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlat0.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.zw).x);
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat1.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = select(float2(0.0, 0.0), u_xlat11.xy, bool2(bool2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat5.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x);
    u_xlat2.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x);
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = FGlobals._MainTex_TexelSize.yy * float2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.x = _MainTex.sample(sampler_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, float(u_xlat16_0.x));
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    output.SV_Target0 = fma(FGlobals._TaaParams.xxyz.wwww, u_xlat0.xxxx, u_xlat1.xxxx);
    return output;
}
"
}
}
}
 Pass {
  Name "Downsample and Prefilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 164481
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat4;
    half u_xlat16_4;
    half u_xlat16_8;
    bool u_xlatb8;
    half u_xlat16_12;
    half u_xlat16_13;
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + half(1.0);
    u_xlat16_8 = _CoCTex.sample(sampler_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = fma(u_xlat16_8, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = half3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = fma(u_xlat16_0, half(2.0), half(-1.0));
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + half(1.0);
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_4), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_13 = _CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = fma(u_xlat16_13, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_12), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = _CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = fma(u_xlat16_12, half(2.0), half(-1.0));
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + half(1.0);
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xxx, u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = half(max(float(u_xlat16_4), 9.99999975e-06));
    u_xlat16_1.xyz = u_xlat16_1.xyz / half3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(float(u_xlat16_4), float(u_xlat16_0));
    u_xlat0.x = max(float(u_xlat16_8), float(u_xlat16_0));
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._MaxCoC;
    u_xlat4 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    output.SV_Target0.w = u_xlat0.x;
    u_xlat0.x = fma(u_xlat4, -2.0, 3.0);
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat4;
    half u_xlat16_4;
    half u_xlat16_8;
    bool u_xlatb8;
    half u_xlat16_12;
    half u_xlat16_13;
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + half(1.0);
    u_xlat16_8 = _CoCTex.sample(sampler_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = fma(u_xlat16_8, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = half3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = fma(u_xlat16_0, half(2.0), half(-1.0));
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + half(1.0);
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_4), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_13 = _CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = fma(u_xlat16_13, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_12), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = _CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = fma(u_xlat16_12, half(2.0), half(-1.0));
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + half(1.0);
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xxx, u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = half(max(float(u_xlat16_4), 9.99999975e-06));
    u_xlat16_1.xyz = u_xlat16_1.xyz / half3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(float(u_xlat16_4), float(u_xlat16_0));
    u_xlat0.x = max(float(u_xlat16_8), float(u_xlat16_0));
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._MaxCoC;
    u_xlat4 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    output.SV_Target0.w = u_xlat0.x;
    u_xlat0.x = fma(u_xlat4, -2.0, 3.0);
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat4;
    half u_xlat16_4;
    half u_xlat16_8;
    bool u_xlatb8;
    half u_xlat16_12;
    half u_xlat16_13;
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + half(1.0);
    u_xlat16_8 = _CoCTex.sample(sampler_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = fma(u_xlat16_8, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = half3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = fma(u_xlat16_0, half(2.0), half(-1.0));
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + half(1.0);
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_4), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_13 = _CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = fma(u_xlat16_13, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_12), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = _CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = fma(u_xlat16_12, half(2.0), half(-1.0));
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + half(1.0);
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xxx, u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = half(max(float(u_xlat16_4), 9.99999975e-06));
    u_xlat16_1.xyz = u_xlat16_1.xyz / half3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(float(u_xlat16_4), float(u_xlat16_0));
    u_xlat0.x = max(float(u_xlat16_8), float(u_xlat16_0));
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._MaxCoC;
    u_xlat4 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    output.SV_Target0.w = u_xlat0.x;
    u_xlat0.x = fma(u_xlat4, -2.0, 3.0);
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (small)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 249983
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

constant float4 ImmCB_0[16] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.545454562, 0.0, 0.0, 0.0),
	float4(0.168554723, 0.518758118, 0.0, 0.0),
	float4(-0.441282034, 0.320610106, 0.0, 0.0),
	float4(-0.441281974, -0.320610195, 0.0, 0.0),
	float4(0.168554798, -0.518758118, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.809017003, 0.587785244, 0.0, 0.0),
	float4(0.309016973, 0.95105654, 0.0, 0.0),
	float4(-0.309017032, 0.95105648, 0.0, 0.0),
	float4(-0.809017062, 0.587785184, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.809016943, -0.587785363, 0.0, 0.0),
	float4(-0.309016645, -0.9510566, 0.0, 0.0),
	float4(0.309017122, -0.95105648, 0.0, 0.0),
	float4(0.809016943, -0.587785304, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x10;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[16] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.545454562, 0.0, 0.0, 0.0),
	float4(0.168554723, 0.518758118, 0.0, 0.0),
	float4(-0.441282034, 0.320610106, 0.0, 0.0),
	float4(-0.441281974, -0.320610195, 0.0, 0.0),
	float4(0.168554798, -0.518758118, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.809017003, 0.587785244, 0.0, 0.0),
	float4(0.309016973, 0.95105654, 0.0, 0.0),
	float4(-0.309017032, 0.95105648, 0.0, 0.0),
	float4(-0.809017062, 0.587785184, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.809016943, -0.587785363, 0.0, 0.0),
	float4(-0.309016645, -0.9510566, 0.0, 0.0),
	float4(0.309017122, -0.95105648, 0.0, 0.0),
	float4(0.809016943, -0.587785304, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x10;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[16] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.545454562, 0.0, 0.0, 0.0),
	float4(0.168554723, 0.518758118, 0.0, 0.0),
	float4(-0.441282034, 0.320610106, 0.0, 0.0),
	float4(-0.441281974, -0.320610195, 0.0, 0.0),
	float4(0.168554798, -0.518758118, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.809017003, 0.587785244, 0.0, 0.0),
	float4(0.309016973, 0.95105654, 0.0, 0.0),
	float4(-0.309017032, 0.95105648, 0.0, 0.0),
	float4(-0.809017062, 0.587785184, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.809016943, -0.587785363, 0.0, 0.0),
	float4(-0.309016645, -0.9510566, 0.0, 0.0),
	float4(0.309017122, -0.95105648, 0.0, 0.0),
	float4(0.809016943, -0.587785304, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x10;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (medium)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 304599
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

constant float4 ImmCB_0[22] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.533333361, 0.0, 0.0, 0.0),
	float4(0.332527906, 0.41697681, 0.0, 0.0),
	float4(-0.118677847, 0.519961596, 0.0, 0.0),
	float4(-0.480516732, 0.231404707, 0.0, 0.0),
	float4(-0.480516732, -0.231404677, 0.0, 0.0),
	float4(-0.118677631, -0.519961655, 0.0, 0.0),
	float4(0.332527846, -0.416976899, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x16;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[22] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.533333361, 0.0, 0.0, 0.0),
	float4(0.332527906, 0.41697681, 0.0, 0.0),
	float4(-0.118677847, 0.519961596, 0.0, 0.0),
	float4(-0.480516732, 0.231404707, 0.0, 0.0),
	float4(-0.480516732, -0.231404677, 0.0, 0.0),
	float4(-0.118677631, -0.519961655, 0.0, 0.0),
	float4(0.332527846, -0.416976899, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x16;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[22] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.533333361, 0.0, 0.0, 0.0),
	float4(0.332527906, 0.41697681, 0.0, 0.0),
	float4(-0.118677847, 0.519961596, 0.0, 0.0),
	float4(-0.480516732, 0.231404707, 0.0, 0.0),
	float4(-0.480516732, -0.231404677, 0.0, 0.0),
	float4(-0.118677631, -0.519961655, 0.0, 0.0),
	float4(0.332527846, -0.416976899, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x16;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 387360
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

constant float4 ImmCB_0[43] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.363636374, 0.0, 0.0, 0.0),
	float4(0.226723567, 0.284302384, 0.0, 0.0),
	float4(-0.0809167102, 0.354519248, 0.0, 0.0),
	float4(-0.327625036, 0.157775939, 0.0, 0.0),
	float4(-0.327625036, -0.157775909, 0.0, 0.0),
	float4(-0.0809165612, -0.354519278, 0.0, 0.0),
	float4(0.226723522, -0.284302413, 0.0, 0.0),
	float4(0.681818187, 0.0, 0.0, 0.0),
	float4(0.614296973, 0.295829833, 0.0, 0.0),
	float4(0.425106674, 0.533066928, 0.0, 0.0),
	float4(0.151718855, 0.664723575, 0.0, 0.0),
	float4(-0.151718825, 0.664723575, 0.0, 0.0),
	float4(-0.425106794, 0.533066869, 0.0, 0.0),
	float4(-0.614296973, 0.295829862, 0.0, 0.0),
	float4(-0.681818187, 0.0, 0.0, 0.0),
	float4(-0.614296973, -0.295829833, 0.0, 0.0),
	float4(-0.425106555, -0.533067048, 0.0, 0.0),
	float4(-0.151718557, -0.664723635, 0.0, 0.0),
	float4(0.151719198, -0.664723516, 0.0, 0.0),
	float4(0.425106615, -0.533067048, 0.0, 0.0),
	float4(0.614296973, -0.295829833, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.955572784, 0.294755191, 0.0, 0.0),
	float4(0.826238751, 0.5633201, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.365340978, 0.930873752, 0.0, 0.0),
	float4(0.0747300014, 0.997203827, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.50000006, 0.866025388, 0.0, 0.0),
	float4(-0.733051956, 0.680172682, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.988830864, 0.149042085, 0.0, 0.0),
	float4(-0.988830805, -0.149042487, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.733051836, -0.680172801, 0.0, 0.0),
	float4(-0.499999911, -0.866025448, 0.0, 0.0),
	float4(-0.222521007, -0.974927902, 0.0, 0.0),
	float4(0.074730292, -0.997203767, 0.0, 0.0),
	float4(0.365341485, -0.930873573, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.826238811, -0.563319981, 0.0, 0.0),
	float4(0.955572903, -0.294754833, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x2b;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[43] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.363636374, 0.0, 0.0, 0.0),
	float4(0.226723567, 0.284302384, 0.0, 0.0),
	float4(-0.0809167102, 0.354519248, 0.0, 0.0),
	float4(-0.327625036, 0.157775939, 0.0, 0.0),
	float4(-0.327625036, -0.157775909, 0.0, 0.0),
	float4(-0.0809165612, -0.354519278, 0.0, 0.0),
	float4(0.226723522, -0.284302413, 0.0, 0.0),
	float4(0.681818187, 0.0, 0.0, 0.0),
	float4(0.614296973, 0.295829833, 0.0, 0.0),
	float4(0.425106674, 0.533066928, 0.0, 0.0),
	float4(0.151718855, 0.664723575, 0.0, 0.0),
	float4(-0.151718825, 0.664723575, 0.0, 0.0),
	float4(-0.425106794, 0.533066869, 0.0, 0.0),
	float4(-0.614296973, 0.295829862, 0.0, 0.0),
	float4(-0.681818187, 0.0, 0.0, 0.0),
	float4(-0.614296973, -0.295829833, 0.0, 0.0),
	float4(-0.425106555, -0.533067048, 0.0, 0.0),
	float4(-0.151718557, -0.664723635, 0.0, 0.0),
	float4(0.151719198, -0.664723516, 0.0, 0.0),
	float4(0.425106615, -0.533067048, 0.0, 0.0),
	float4(0.614296973, -0.295829833, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.955572784, 0.294755191, 0.0, 0.0),
	float4(0.826238751, 0.5633201, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.365340978, 0.930873752, 0.0, 0.0),
	float4(0.0747300014, 0.997203827, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.50000006, 0.866025388, 0.0, 0.0),
	float4(-0.733051956, 0.680172682, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.988830864, 0.149042085, 0.0, 0.0),
	float4(-0.988830805, -0.149042487, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.733051836, -0.680172801, 0.0, 0.0),
	float4(-0.499999911, -0.866025448, 0.0, 0.0),
	float4(-0.222521007, -0.974927902, 0.0, 0.0),
	float4(0.074730292, -0.997203767, 0.0, 0.0),
	float4(0.365341485, -0.930873573, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.826238811, -0.563319981, 0.0, 0.0),
	float4(0.955572903, -0.294754833, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x2b;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[43] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.363636374, 0.0, 0.0, 0.0),
	float4(0.226723567, 0.284302384, 0.0, 0.0),
	float4(-0.0809167102, 0.354519248, 0.0, 0.0),
	float4(-0.327625036, 0.157775939, 0.0, 0.0),
	float4(-0.327625036, -0.157775909, 0.0, 0.0),
	float4(-0.0809165612, -0.354519278, 0.0, 0.0),
	float4(0.226723522, -0.284302413, 0.0, 0.0),
	float4(0.681818187, 0.0, 0.0, 0.0),
	float4(0.614296973, 0.295829833, 0.0, 0.0),
	float4(0.425106674, 0.533066928, 0.0, 0.0),
	float4(0.151718855, 0.664723575, 0.0, 0.0),
	float4(-0.151718825, 0.664723575, 0.0, 0.0),
	float4(-0.425106794, 0.533066869, 0.0, 0.0),
	float4(-0.614296973, 0.295829862, 0.0, 0.0),
	float4(-0.681818187, 0.0, 0.0, 0.0),
	float4(-0.614296973, -0.295829833, 0.0, 0.0),
	float4(-0.425106555, -0.533067048, 0.0, 0.0),
	float4(-0.151718557, -0.664723635, 0.0, 0.0),
	float4(0.151719198, -0.664723516, 0.0, 0.0),
	float4(0.425106615, -0.533067048, 0.0, 0.0),
	float4(0.614296973, -0.295829833, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.955572784, 0.294755191, 0.0, 0.0),
	float4(0.826238751, 0.5633201, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.365340978, 0.930873752, 0.0, 0.0),
	float4(0.0747300014, 0.997203827, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.50000006, 0.866025388, 0.0, 0.0),
	float4(-0.733051956, 0.680172682, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.988830864, 0.149042085, 0.0, 0.0),
	float4(-0.988830805, -0.149042487, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.733051836, -0.680172801, 0.0, 0.0),
	float4(-0.499999911, -0.866025448, 0.0, 0.0),
	float4(-0.222521007, -0.974927902, 0.0, 0.0),
	float4(0.074730292, -0.997203767, 0.0, 0.0),
	float4(0.365341485, -0.930873573, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.826238811, -0.563319981, 0.0, 0.0),
	float4(0.955572903, -0.294754833, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x2b;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (very large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 398012
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

constant float4 ImmCB_0[71] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.275862098, 0.0, 0.0, 0.0),
	float4(0.171997204, 0.215677679, 0.0, 0.0),
	float4(-0.0613850951, 0.268945664, 0.0, 0.0),
	float4(-0.248543158, 0.119692102, 0.0, 0.0),
	float4(-0.248543158, -0.11969208, 0.0, 0.0),
	float4(-0.0613849834, -0.268945694, 0.0, 0.0),
	float4(0.171997175, -0.215677708, 0.0, 0.0),
	float4(0.517241359, 0.0, 0.0, 0.0),
	float4(0.466018349, 0.224422619, 0.0, 0.0),
	float4(0.322494715, 0.40439558, 0.0, 0.0),
	float4(0.115097053, 0.504273057, 0.0, 0.0),
	float4(-0.115097038, 0.504273057, 0.0, 0.0),
	float4(-0.322494805, 0.404395521, 0.0, 0.0),
	float4(-0.466018349, 0.224422649, 0.0, 0.0),
	float4(-0.517241359, 0.0, 0.0, 0.0),
	float4(-0.466018349, -0.224422619, 0.0, 0.0),
	float4(-0.322494626, -0.40439564, 0.0, 0.0),
	float4(-0.11509683, -0.504273117, 0.0, 0.0),
	float4(0.115097322, -0.504272997, 0.0, 0.0),
	float4(0.322494656, -0.40439564, 0.0, 0.0),
	float4(0.466018349, -0.224422619, 0.0, 0.0),
	float4(0.758620679, 0.0, 0.0, 0.0),
	float4(0.724917293, 0.223607376, 0.0, 0.0),
	float4(0.626801789, 0.427346289, 0.0, 0.0),
	float4(0.472992241, 0.593113542, 0.0, 0.0),
	float4(0.277155221, 0.706180096, 0.0, 0.0),
	float4(0.0566917248, 0.756499469, 0.0, 0.0),
	float4(-0.168808997, 0.73960048, 0.0, 0.0),
	float4(-0.379310399, 0.656984746, 0.0, 0.0),
	float4(-0.556108356, 0.515993059, 0.0, 0.0),
	float4(-0.683493614, 0.32915324, 0.0, 0.0),
	float4(-0.750147521, 0.113066405, 0.0, 0.0),
	float4(-0.750147521, -0.113066711, 0.0, 0.0),
	float4(-0.683493614, -0.32915318, 0.0, 0.0),
	float4(-0.556108296, -0.515993178, 0.0, 0.0),
	float4(-0.37931028, -0.656984806, 0.0, 0.0),
	float4(-0.168809041, -0.73960048, 0.0, 0.0),
	float4(0.0566919446, -0.75649941, 0.0, 0.0),
	float4(0.277155608, -0.706179917, 0.0, 0.0),
	float4(0.472992152, -0.593113661, 0.0, 0.0),
	float4(0.626801848, -0.4273462, 0.0, 0.0),
	float4(0.724917352, -0.223607108, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.974927902, 0.222520933, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.781831503, 0.623489797, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.433883637, 0.900968909, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(0.0, 1.0, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.433883846, 0.90096885, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.781831682, 0.623489559, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.974927902, 0.222520933, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.974927902, -0.222520873, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.781831384, -0.623489916, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.433883458, -0.900969028, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.0, -1.0, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.433883488, -0.900968969, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.781831443, -0.623489857, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0),
	float4(0.974927902, -0.222520858, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x47;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[71] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.275862098, 0.0, 0.0, 0.0),
	float4(0.171997204, 0.215677679, 0.0, 0.0),
	float4(-0.0613850951, 0.268945664, 0.0, 0.0),
	float4(-0.248543158, 0.119692102, 0.0, 0.0),
	float4(-0.248543158, -0.11969208, 0.0, 0.0),
	float4(-0.0613849834, -0.268945694, 0.0, 0.0),
	float4(0.171997175, -0.215677708, 0.0, 0.0),
	float4(0.517241359, 0.0, 0.0, 0.0),
	float4(0.466018349, 0.224422619, 0.0, 0.0),
	float4(0.322494715, 0.40439558, 0.0, 0.0),
	float4(0.115097053, 0.504273057, 0.0, 0.0),
	float4(-0.115097038, 0.504273057, 0.0, 0.0),
	float4(-0.322494805, 0.404395521, 0.0, 0.0),
	float4(-0.466018349, 0.224422649, 0.0, 0.0),
	float4(-0.517241359, 0.0, 0.0, 0.0),
	float4(-0.466018349, -0.224422619, 0.0, 0.0),
	float4(-0.322494626, -0.40439564, 0.0, 0.0),
	float4(-0.11509683, -0.504273117, 0.0, 0.0),
	float4(0.115097322, -0.504272997, 0.0, 0.0),
	float4(0.322494656, -0.40439564, 0.0, 0.0),
	float4(0.466018349, -0.224422619, 0.0, 0.0),
	float4(0.758620679, 0.0, 0.0, 0.0),
	float4(0.724917293, 0.223607376, 0.0, 0.0),
	float4(0.626801789, 0.427346289, 0.0, 0.0),
	float4(0.472992241, 0.593113542, 0.0, 0.0),
	float4(0.277155221, 0.706180096, 0.0, 0.0),
	float4(0.0566917248, 0.756499469, 0.0, 0.0),
	float4(-0.168808997, 0.73960048, 0.0, 0.0),
	float4(-0.379310399, 0.656984746, 0.0, 0.0),
	float4(-0.556108356, 0.515993059, 0.0, 0.0),
	float4(-0.683493614, 0.32915324, 0.0, 0.0),
	float4(-0.750147521, 0.113066405, 0.0, 0.0),
	float4(-0.750147521, -0.113066711, 0.0, 0.0),
	float4(-0.683493614, -0.32915318, 0.0, 0.0),
	float4(-0.556108296, -0.515993178, 0.0, 0.0),
	float4(-0.37931028, -0.656984806, 0.0, 0.0),
	float4(-0.168809041, -0.73960048, 0.0, 0.0),
	float4(0.0566919446, -0.75649941, 0.0, 0.0),
	float4(0.277155608, -0.706179917, 0.0, 0.0),
	float4(0.472992152, -0.593113661, 0.0, 0.0),
	float4(0.626801848, -0.4273462, 0.0, 0.0),
	float4(0.724917352, -0.223607108, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.974927902, 0.222520933, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.781831503, 0.623489797, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.433883637, 0.900968909, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(0.0, 1.0, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.433883846, 0.90096885, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.781831682, 0.623489559, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.974927902, 0.222520933, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.974927902, -0.222520873, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.781831384, -0.623489916, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.433883458, -0.900969028, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.0, -1.0, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.433883488, -0.900968969, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.781831443, -0.623489857, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0),
	float4(0.974927902, -0.222520858, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x47;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[71] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.275862098, 0.0, 0.0, 0.0),
	float4(0.171997204, 0.215677679, 0.0, 0.0),
	float4(-0.0613850951, 0.268945664, 0.0, 0.0),
	float4(-0.248543158, 0.119692102, 0.0, 0.0),
	float4(-0.248543158, -0.11969208, 0.0, 0.0),
	float4(-0.0613849834, -0.268945694, 0.0, 0.0),
	float4(0.171997175, -0.215677708, 0.0, 0.0),
	float4(0.517241359, 0.0, 0.0, 0.0),
	float4(0.466018349, 0.224422619, 0.0, 0.0),
	float4(0.322494715, 0.40439558, 0.0, 0.0),
	float4(0.115097053, 0.504273057, 0.0, 0.0),
	float4(-0.115097038, 0.504273057, 0.0, 0.0),
	float4(-0.322494805, 0.404395521, 0.0, 0.0),
	float4(-0.466018349, 0.224422649, 0.0, 0.0),
	float4(-0.517241359, 0.0, 0.0, 0.0),
	float4(-0.466018349, -0.224422619, 0.0, 0.0),
	float4(-0.322494626, -0.40439564, 0.0, 0.0),
	float4(-0.11509683, -0.504273117, 0.0, 0.0),
	float4(0.115097322, -0.504272997, 0.0, 0.0),
	float4(0.322494656, -0.40439564, 0.0, 0.0),
	float4(0.466018349, -0.224422619, 0.0, 0.0),
	float4(0.758620679, 0.0, 0.0, 0.0),
	float4(0.724917293, 0.223607376, 0.0, 0.0),
	float4(0.626801789, 0.427346289, 0.0, 0.0),
	float4(0.472992241, 0.593113542, 0.0, 0.0),
	float4(0.277155221, 0.706180096, 0.0, 0.0),
	float4(0.0566917248, 0.756499469, 0.0, 0.0),
	float4(-0.168808997, 0.73960048, 0.0, 0.0),
	float4(-0.379310399, 0.656984746, 0.0, 0.0),
	float4(-0.556108356, 0.515993059, 0.0, 0.0),
	float4(-0.683493614, 0.32915324, 0.0, 0.0),
	float4(-0.750147521, 0.113066405, 0.0, 0.0),
	float4(-0.750147521, -0.113066711, 0.0, 0.0),
	float4(-0.683493614, -0.32915318, 0.0, 0.0),
	float4(-0.556108296, -0.515993178, 0.0, 0.0),
	float4(-0.37931028, -0.656984806, 0.0, 0.0),
	float4(-0.168809041, -0.73960048, 0.0, 0.0),
	float4(0.0566919446, -0.75649941, 0.0, 0.0),
	float4(0.277155608, -0.706179917, 0.0, 0.0),
	float4(0.472992152, -0.593113661, 0.0, 0.0),
	float4(0.626801848, -0.4273462, 0.0, 0.0),
	float4(0.724917352, -0.223607108, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.974927902, 0.222520933, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.781831503, 0.623489797, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.433883637, 0.900968909, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(0.0, 1.0, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.433883846, 0.90096885, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.781831682, 0.623489559, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.974927902, 0.222520933, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.974927902, -0.222520873, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.781831384, -0.623489916, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.433883458, -0.900969028, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.0, -1.0, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.433883488, -0.900968969, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.781831443, -0.623489857, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0),
	float4(0.974927902, -0.222520858, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x47;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Postfilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 460563
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
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
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
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
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
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
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
    output.SV_Target0 = float4(u_xlat16_0) * float4(0.25, 0.25, 0.25, 0.25);
    return output;
}
"
}
}
}
 Pass {
  Name "Combine"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 538506
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    sampler sampler_DepthOfFieldTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _DepthOfFieldTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, input.TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + half(-0.5);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = fma(float(u_xlat16_0), FGlobals._MaxCoC, (-u_xlat3));
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = float4(_DepthOfFieldTex.sample(sampler_DepthOfFieldTex, input.TEXCOORD1.xy));
    u_xlat0.x = fma(u_xlat3, u_xlat0.x, u_xlat1.w);
    u_xlat0.x = fma((-u_xlat6), u_xlat1.w, u_xlat0.x);
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = u_xlat0.w;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    sampler sampler_DepthOfFieldTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _DepthOfFieldTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, input.TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + half(-0.5);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = fma(float(u_xlat16_0), FGlobals._MaxCoC, (-u_xlat3));
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = float4(_DepthOfFieldTex.sample(sampler_DepthOfFieldTex, input.TEXCOORD1.xy));
    u_xlat0.x = fma(u_xlat3, u_xlat0.x, u_xlat1.w);
    u_xlat0.x = fma((-u_xlat6), u_xlat1.w, u_xlat0.x);
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = u_xlat0.w;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    sampler sampler_DepthOfFieldTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _DepthOfFieldTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, input.TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + half(-0.5);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = fma(float(u_xlat16_0), FGlobals._MaxCoC, (-u_xlat3));
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = float4(_DepthOfFieldTex.sample(sampler_DepthOfFieldTex, input.TEXCOORD1.xy));
    u_xlat0.x = fma(u_xlat3, u_xlat0.x, u_xlat1.w);
    u_xlat0.x = fma((-u_xlat6), u_xlat1.w, u_xlat0.x);
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = u_xlat0.w;
    return output;
}
"
}
}
}
 Pass {
  Name "Debug Overlay"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 651689
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
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
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float u_xlat2;
    half u_xlat16_6;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-FGlobals._Distance);
    u_xlat2 = u_xlat2 * FGlobals._LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(0.0, 1.0, 1.0), float3(1.0, 0.0, 0.0));
    u_xlat1.xyz = (-u_xlat0.xww) + float3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = fma(float3(u_xlat2), u_xlat1.xyz, u_xlat0.xzw);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, half3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + half(0.5);
    output.SV_Target0.xyz = float3(u_xlat16_6) * u_xlat0.xyz;
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
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
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float u_xlat2;
    half u_xlat16_6;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-FGlobals._Distance);
    u_xlat2 = u_xlat2 * FGlobals._LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(0.0, 1.0, 1.0), float3(1.0, 0.0, 0.0));
    u_xlat1.xyz = (-u_xlat0.xww) + float3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = fma(float3(u_xlat2), u_xlat1.xyz, u_xlat0.xzw);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, half3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + half(0.5);
    output.SV_Target0.xyz = float3(u_xlat16_6) * u_xlat0.xyz;
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
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
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float u_xlat2;
    half u_xlat16_6;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-FGlobals._Distance);
    u_xlat2 = u_xlat2 * FGlobals._LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(0.0, 1.0, 1.0), float3(1.0, 0.0, 0.0));
    u_xlat1.xyz = (-u_xlat0.xww) + float3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = fma(float3(u_xlat2), u_xlat1.xyz, u_xlat0.xzw);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, half3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + half(0.5);
    output.SV_Target0.xyz = float3(u_xlat16_6) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
SubShader {
 Pass {
  Name "CoC Calculation"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 700650
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
    float _RcpMaxCoC;
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
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0 = fma(FGlobals._ZBufferParams.z, u_xlat0, FGlobals._ZBufferParams.w);
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-FGlobals._Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * FGlobals._LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = fma(u_xlat0, FGlobals._RcpMaxCoC, 0.5);
    output.SV_Target0 = float4(u_xlat0);
    output.SV_Target0 = clamp(output.SV_Target0, 0.0f, 1.0f);
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
    float _RcpMaxCoC;
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
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0 = fma(FGlobals._ZBufferParams.z, u_xlat0, FGlobals._ZBufferParams.w);
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-FGlobals._Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * FGlobals._LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = fma(u_xlat0, FGlobals._RcpMaxCoC, 0.5);
    output.SV_Target0 = float4(u_xlat0);
    output.SV_Target0 = clamp(output.SV_Target0, 0.0f, 1.0f);
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
    float _RcpMaxCoC;
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
    u_xlat0 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0 = fma(FGlobals._ZBufferParams.z, u_xlat0, FGlobals._ZBufferParams.w);
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat1 = u_xlat0 + (-FGlobals._Distance);
    u_xlat0 = max(u_xlat0, 9.99999975e-06);
    u_xlat1 = u_xlat1 * FGlobals._LensCoeff;
    u_xlat0 = u_xlat1 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.5;
    u_xlat0 = fma(u_xlat0, FGlobals._RcpMaxCoC, 0.5);
    output.SV_Target0 = float4(u_xlat0);
    output.SV_Target0 = clamp(output.SV_Target0, 0.0f, 1.0f);
    return output;
}
"
}
}
}
 Pass {
  Name "CoC Temporal Filter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 778674
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
    float3 _TaaParams;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    sampler sampler_CoCTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float2 u_xlat3;
    float3 u_xlat5;
    bool u_xlatb5;
    bool u_xlatb6;
    float u_xlat8;
    bool u_xlatb9;
    float2 u_xlat11;
    float u_xlat12;
    u_xlat0.xy = FGlobals._MainTex_TexelSize.yy * float2(-0.0, -1.0);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 0.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat12 = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlat0.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.zw).x);
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat1.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = select(float2(0.0, 0.0), u_xlat11.xy, bool2(bool2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat5.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x);
    u_xlat2.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x);
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = FGlobals._MainTex_TexelSize.yy * float2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.x = _MainTex.sample(sampler_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, float(u_xlat16_0.x));
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    output.SV_Target0 = fma(FGlobals._TaaParams.xxyz.wwww, u_xlat0.xxxx, u_xlat1.xxxx);
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
    float3 _TaaParams;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    sampler sampler_CoCTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float2 u_xlat3;
    float3 u_xlat5;
    bool u_xlatb5;
    bool u_xlatb6;
    float u_xlat8;
    bool u_xlatb9;
    float2 u_xlat11;
    float u_xlat12;
    u_xlat0.xy = FGlobals._MainTex_TexelSize.yy * float2(-0.0, -1.0);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 0.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat12 = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlat0.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.zw).x);
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat1.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = select(float2(0.0, 0.0), u_xlat11.xy, bool2(bool2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat5.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x);
    u_xlat2.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x);
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = FGlobals._MainTex_TexelSize.yy * float2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.x = _MainTex.sample(sampler_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, float(u_xlat16_0.x));
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    output.SV_Target0 = fma(FGlobals._TaaParams.xxyz.wwww, u_xlat0.xxxx, u_xlat1.xxxx);
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
    float3 _TaaParams;
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
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    sampler sampler_CoCTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float2 u_xlat3;
    float3 u_xlat5;
    bool u_xlatb5;
    bool u_xlatb6;
    float u_xlat8;
    bool u_xlatb9;
    float2 u_xlat11;
    float u_xlat12;
    u_xlat0.xy = FGlobals._MainTex_TexelSize.yy * float2(-0.0, -1.0);
    u_xlat1 = fma((-FGlobals._MainTex_TexelSize.xyyy), float4(1.0, 0.0, 0.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat12 = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlat0.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.zw).x);
    u_xlat1.xy = input.TEXCOORD0.xy + (-FGlobals._TaaParams.xxyz.yz);
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat1.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat1.xy).x);
    u_xlatb5 = u_xlat12<u_xlat1.x;
    u_xlat2.z = (u_xlatb5) ? u_xlat12 : u_xlat1.x;
    u_xlat12 = max(u_xlat12, u_xlat1.x);
    u_xlat12 = max(u_xlat0.z, u_xlat12);
    u_xlatb9 = u_xlat0.z<u_xlat2.z;
    u_xlat3.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, 0.0);
    u_xlat11.xy = (-u_xlat3.xy);
    u_xlat2.xy = select(float2(0.0, 0.0), u_xlat11.xy, bool2(bool2(u_xlatb5)));
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.yyxy, float4(0.0, 1.0, 1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat5.z = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x);
    u_xlat2.x = float(_CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x);
    u_xlatb6 = u_xlat5.z<u_xlat0.z;
    u_xlat5.xy = FGlobals._MainTex_TexelSize.yy * float2(0.0, 1.0);
    u_xlat12 = max(u_xlat12, u_xlat5.z);
    u_xlat12 = max(u_xlat2.x, u_xlat12);
    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat5.xyz : u_xlat0.xyz;
    u_xlatb5 = u_xlat2.x<u_xlat0.z;
    u_xlat8 = min(u_xlat2.x, u_xlat0.z);
    u_xlat0.xy = (bool(u_xlatb5)) ? u_xlat3.xy : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0.x = _MainTex.sample(sampler_MainTex, u_xlat0.xy).x;
    u_xlat0.x = max(u_xlat8, float(u_xlat16_0.x));
    u_xlat0.x = min(u_xlat12, u_xlat0.x);
    u_xlat0.x = (-u_xlat1.x) + u_xlat0.x;
    output.SV_Target0 = fma(FGlobals._TaaParams.xxyz.wwww, u_xlat0.xxxx, u_xlat1.xxxx);
    return output;
}
"
}
}
}
 Pass {
  Name "Downsample and Prefilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 796721
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat4;
    half u_xlat16_4;
    half u_xlat16_8;
    bool u_xlatb8;
    half u_xlat16_12;
    half u_xlat16_13;
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + half(1.0);
    u_xlat16_8 = _CoCTex.sample(sampler_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = fma(u_xlat16_8, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = half3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = fma(u_xlat16_0, half(2.0), half(-1.0));
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + half(1.0);
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_4), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_13 = _CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = fma(u_xlat16_13, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_12), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = _CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = fma(u_xlat16_12, half(2.0), half(-1.0));
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + half(1.0);
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xxx, u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = half(max(float(u_xlat16_4), 9.99999975e-06));
    u_xlat16_1.xyz = u_xlat16_1.xyz / half3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(float(u_xlat16_4), float(u_xlat16_0));
    u_xlat0.x = max(float(u_xlat16_8), float(u_xlat16_0));
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._MaxCoC;
    u_xlat4 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    output.SV_Target0.w = u_xlat0.x;
    u_xlat0.x = fma(u_xlat4, -2.0, 3.0);
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat4;
    half u_xlat16_4;
    half u_xlat16_8;
    bool u_xlatb8;
    half u_xlat16_12;
    half u_xlat16_13;
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + half(1.0);
    u_xlat16_8 = _CoCTex.sample(sampler_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = fma(u_xlat16_8, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = half3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = fma(u_xlat16_0, half(2.0), half(-1.0));
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + half(1.0);
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_4), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_13 = _CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = fma(u_xlat16_13, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_12), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = _CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = fma(u_xlat16_12, half(2.0), half(-1.0));
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + half(1.0);
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xxx, u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = half(max(float(u_xlat16_4), 9.99999975e-06));
    u_xlat16_1.xyz = u_xlat16_1.xyz / half3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(float(u_xlat16_4), float(u_xlat16_0));
    u_xlat0.x = max(float(u_xlat16_8), float(u_xlat16_0));
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._MaxCoC;
    u_xlat4 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    output.SV_Target0.w = u_xlat0.x;
    u_xlat0.x = fma(u_xlat4, -2.0, 3.0);
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float u_xlat4;
    half u_xlat16_4;
    half u_xlat16_8;
    bool u_xlatb8;
    half u_xlat16_12;
    half u_xlat16_13;
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.zw).xyz;
    u_xlat16_13 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_13 = max(u_xlat16_1.z, u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 + half(1.0);
    u_xlat16_8 = _CoCTex.sample(sampler_CoCTex, u_xlat0.zw).x;
    u_xlat16_8 = fma(u_xlat16_8, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_8) / u_xlat16_13;
    u_xlat16_1.xyz = half3(u_xlat16_12) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, u_xlat0.xy).x;
    u_xlat16_0 = fma(u_xlat16_0, half(2.0), half(-1.0));
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 + half(1.0);
    u_xlat16_4 = abs(u_xlat16_0) / u_xlat16_4;
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_4), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat2 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(-0.5, 0.5, 0.5, 0.5), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    u_xlat16_12 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_12 = max(u_xlat16_3.z, u_xlat16_12);
    u_xlat16_12 = u_xlat16_12 + half(1.0);
    u_xlat16_13 = _CoCTex.sample(sampler_CoCTex, u_xlat2.xy).x;
    u_xlat16_13 = fma(u_xlat16_13, half(2.0), half(-1.0));
    u_xlat16_12 = abs(u_xlat16_13) / u_xlat16_12;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, half3(u_xlat16_12), u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_12 + u_xlat16_4;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.zw).xyz;
    u_xlat16_12 = _CoCTex.sample(sampler_CoCTex, u_xlat2.zw).x;
    u_xlat16_12 = fma(u_xlat16_12, half(2.0), half(-1.0));
    u_xlat16_2.x = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_2.x = max(u_xlat16_3.z, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x + half(1.0);
    u_xlat16_2.x = abs(u_xlat16_12) / u_xlat16_2.x;
    u_xlat16_1.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xxx, u_xlat16_1.xyz);
    u_xlat16_4 = u_xlat16_4 + u_xlat16_2.x;
    u_xlat16_4 = half(max(float(u_xlat16_4), 9.99999975e-06));
    u_xlat16_1.xyz = u_xlat16_1.xyz / half3(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_8, u_xlat16_13);
    u_xlat16_8 = max(u_xlat16_12, u_xlat16_8);
    u_xlat16_4 = min(u_xlat16_12, u_xlat16_4);
    u_xlat4 = min(float(u_xlat16_4), float(u_xlat16_0));
    u_xlat0.x = max(float(u_xlat16_8), float(u_xlat16_0));
    u_xlatb8 = u_xlat0.x<(-u_xlat4);
    u_xlat0.x = (u_xlatb8) ? u_xlat4 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._MaxCoC;
    u_xlat4 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat4 = u_xlat4 * abs(u_xlat0.x);
    u_xlat4 = clamp(u_xlat4, 0.0f, 1.0f);
    output.SV_Target0.w = u_xlat0.x;
    u_xlat0.x = fma(u_xlat4, -2.0, 3.0);
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (small)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 878157
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

constant float4 ImmCB_0[16] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.545454562, 0.0, 0.0, 0.0),
	float4(0.168554723, 0.518758118, 0.0, 0.0),
	float4(-0.441282034, 0.320610106, 0.0, 0.0),
	float4(-0.441281974, -0.320610195, 0.0, 0.0),
	float4(0.168554798, -0.518758118, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.809017003, 0.587785244, 0.0, 0.0),
	float4(0.309016973, 0.95105654, 0.0, 0.0),
	float4(-0.309017032, 0.95105648, 0.0, 0.0),
	float4(-0.809017062, 0.587785184, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.809016943, -0.587785363, 0.0, 0.0),
	float4(-0.309016645, -0.9510566, 0.0, 0.0),
	float4(0.309017122, -0.95105648, 0.0, 0.0),
	float4(0.809016943, -0.587785304, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x10;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[16] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.545454562, 0.0, 0.0, 0.0),
	float4(0.168554723, 0.518758118, 0.0, 0.0),
	float4(-0.441282034, 0.320610106, 0.0, 0.0),
	float4(-0.441281974, -0.320610195, 0.0, 0.0),
	float4(0.168554798, -0.518758118, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.809017003, 0.587785244, 0.0, 0.0),
	float4(0.309016973, 0.95105654, 0.0, 0.0),
	float4(-0.309017032, 0.95105648, 0.0, 0.0),
	float4(-0.809017062, 0.587785184, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.809016943, -0.587785363, 0.0, 0.0),
	float4(-0.309016645, -0.9510566, 0.0, 0.0),
	float4(0.309017122, -0.95105648, 0.0, 0.0),
	float4(0.809016943, -0.587785304, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x10;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[16] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.545454562, 0.0, 0.0, 0.0),
	float4(0.168554723, 0.518758118, 0.0, 0.0),
	float4(-0.441282034, 0.320610106, 0.0, 0.0),
	float4(-0.441281974, -0.320610195, 0.0, 0.0),
	float4(0.168554798, -0.518758118, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.809017003, 0.587785244, 0.0, 0.0),
	float4(0.309016973, 0.95105654, 0.0, 0.0),
	float4(-0.309017032, 0.95105648, 0.0, 0.0),
	float4(-0.809017062, 0.587785184, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.809016943, -0.587785363, 0.0, 0.0),
	float4(-0.309016645, -0.9510566, 0.0, 0.0),
	float4(0.309017122, -0.95105648, 0.0, 0.0),
	float4(0.809016943, -0.587785304, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x10;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.196349546;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (medium)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 957142
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

constant float4 ImmCB_0[22] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.533333361, 0.0, 0.0, 0.0),
	float4(0.332527906, 0.41697681, 0.0, 0.0),
	float4(-0.118677847, 0.519961596, 0.0, 0.0),
	float4(-0.480516732, 0.231404707, 0.0, 0.0),
	float4(-0.480516732, -0.231404677, 0.0, 0.0),
	float4(-0.118677631, -0.519961655, 0.0, 0.0),
	float4(0.332527846, -0.416976899, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x16;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[22] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.533333361, 0.0, 0.0, 0.0),
	float4(0.332527906, 0.41697681, 0.0, 0.0),
	float4(-0.118677847, 0.519961596, 0.0, 0.0),
	float4(-0.480516732, 0.231404707, 0.0, 0.0),
	float4(-0.480516732, -0.231404677, 0.0, 0.0),
	float4(-0.118677631, -0.519961655, 0.0, 0.0),
	float4(0.332527846, -0.416976899, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x16;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[22] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.533333361, 0.0, 0.0, 0.0),
	float4(0.332527906, 0.41697681, 0.0, 0.0),
	float4(-0.118677847, 0.519961596, 0.0, 0.0),
	float4(-0.480516732, 0.231404707, 0.0, 0.0),
	float4(-0.480516732, -0.231404677, 0.0, 0.0),
	float4(-0.118677631, -0.519961655, 0.0, 0.0),
	float4(0.332527846, -0.416976899, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x16;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.142799661;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1009624
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

constant float4 ImmCB_0[43] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.363636374, 0.0, 0.0, 0.0),
	float4(0.226723567, 0.284302384, 0.0, 0.0),
	float4(-0.0809167102, 0.354519248, 0.0, 0.0),
	float4(-0.327625036, 0.157775939, 0.0, 0.0),
	float4(-0.327625036, -0.157775909, 0.0, 0.0),
	float4(-0.0809165612, -0.354519278, 0.0, 0.0),
	float4(0.226723522, -0.284302413, 0.0, 0.0),
	float4(0.681818187, 0.0, 0.0, 0.0),
	float4(0.614296973, 0.295829833, 0.0, 0.0),
	float4(0.425106674, 0.533066928, 0.0, 0.0),
	float4(0.151718855, 0.664723575, 0.0, 0.0),
	float4(-0.151718825, 0.664723575, 0.0, 0.0),
	float4(-0.425106794, 0.533066869, 0.0, 0.0),
	float4(-0.614296973, 0.295829862, 0.0, 0.0),
	float4(-0.681818187, 0.0, 0.0, 0.0),
	float4(-0.614296973, -0.295829833, 0.0, 0.0),
	float4(-0.425106555, -0.533067048, 0.0, 0.0),
	float4(-0.151718557, -0.664723635, 0.0, 0.0),
	float4(0.151719198, -0.664723516, 0.0, 0.0),
	float4(0.425106615, -0.533067048, 0.0, 0.0),
	float4(0.614296973, -0.295829833, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.955572784, 0.294755191, 0.0, 0.0),
	float4(0.826238751, 0.5633201, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.365340978, 0.930873752, 0.0, 0.0),
	float4(0.0747300014, 0.997203827, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.50000006, 0.866025388, 0.0, 0.0),
	float4(-0.733051956, 0.680172682, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.988830864, 0.149042085, 0.0, 0.0),
	float4(-0.988830805, -0.149042487, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.733051836, -0.680172801, 0.0, 0.0),
	float4(-0.499999911, -0.866025448, 0.0, 0.0),
	float4(-0.222521007, -0.974927902, 0.0, 0.0),
	float4(0.074730292, -0.997203767, 0.0, 0.0),
	float4(0.365341485, -0.930873573, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.826238811, -0.563319981, 0.0, 0.0),
	float4(0.955572903, -0.294754833, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x2b;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[43] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.363636374, 0.0, 0.0, 0.0),
	float4(0.226723567, 0.284302384, 0.0, 0.0),
	float4(-0.0809167102, 0.354519248, 0.0, 0.0),
	float4(-0.327625036, 0.157775939, 0.0, 0.0),
	float4(-0.327625036, -0.157775909, 0.0, 0.0),
	float4(-0.0809165612, -0.354519278, 0.0, 0.0),
	float4(0.226723522, -0.284302413, 0.0, 0.0),
	float4(0.681818187, 0.0, 0.0, 0.0),
	float4(0.614296973, 0.295829833, 0.0, 0.0),
	float4(0.425106674, 0.533066928, 0.0, 0.0),
	float4(0.151718855, 0.664723575, 0.0, 0.0),
	float4(-0.151718825, 0.664723575, 0.0, 0.0),
	float4(-0.425106794, 0.533066869, 0.0, 0.0),
	float4(-0.614296973, 0.295829862, 0.0, 0.0),
	float4(-0.681818187, 0.0, 0.0, 0.0),
	float4(-0.614296973, -0.295829833, 0.0, 0.0),
	float4(-0.425106555, -0.533067048, 0.0, 0.0),
	float4(-0.151718557, -0.664723635, 0.0, 0.0),
	float4(0.151719198, -0.664723516, 0.0, 0.0),
	float4(0.425106615, -0.533067048, 0.0, 0.0),
	float4(0.614296973, -0.295829833, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.955572784, 0.294755191, 0.0, 0.0),
	float4(0.826238751, 0.5633201, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.365340978, 0.930873752, 0.0, 0.0),
	float4(0.0747300014, 0.997203827, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.50000006, 0.866025388, 0.0, 0.0),
	float4(-0.733051956, 0.680172682, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.988830864, 0.149042085, 0.0, 0.0),
	float4(-0.988830805, -0.149042487, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.733051836, -0.680172801, 0.0, 0.0),
	float4(-0.499999911, -0.866025448, 0.0, 0.0),
	float4(-0.222521007, -0.974927902, 0.0, 0.0),
	float4(0.074730292, -0.997203767, 0.0, 0.0),
	float4(0.365341485, -0.930873573, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.826238811, -0.563319981, 0.0, 0.0),
	float4(0.955572903, -0.294754833, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x2b;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[43] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.363636374, 0.0, 0.0, 0.0),
	float4(0.226723567, 0.284302384, 0.0, 0.0),
	float4(-0.0809167102, 0.354519248, 0.0, 0.0),
	float4(-0.327625036, 0.157775939, 0.0, 0.0),
	float4(-0.327625036, -0.157775909, 0.0, 0.0),
	float4(-0.0809165612, -0.354519278, 0.0, 0.0),
	float4(0.226723522, -0.284302413, 0.0, 0.0),
	float4(0.681818187, 0.0, 0.0, 0.0),
	float4(0.614296973, 0.295829833, 0.0, 0.0),
	float4(0.425106674, 0.533066928, 0.0, 0.0),
	float4(0.151718855, 0.664723575, 0.0, 0.0),
	float4(-0.151718825, 0.664723575, 0.0, 0.0),
	float4(-0.425106794, 0.533066869, 0.0, 0.0),
	float4(-0.614296973, 0.295829862, 0.0, 0.0),
	float4(-0.681818187, 0.0, 0.0, 0.0),
	float4(-0.614296973, -0.295829833, 0.0, 0.0),
	float4(-0.425106555, -0.533067048, 0.0, 0.0),
	float4(-0.151718557, -0.664723635, 0.0, 0.0),
	float4(0.151719198, -0.664723516, 0.0, 0.0),
	float4(0.425106615, -0.533067048, 0.0, 0.0),
	float4(0.614296973, -0.295829833, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.955572784, 0.294755191, 0.0, 0.0),
	float4(0.826238751, 0.5633201, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.365340978, 0.930873752, 0.0, 0.0),
	float4(0.0747300014, 0.997203827, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.50000006, 0.866025388, 0.0, 0.0),
	float4(-0.733051956, 0.680172682, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.988830864, 0.149042085, 0.0, 0.0),
	float4(-0.988830805, -0.149042487, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.733051836, -0.680172801, 0.0, 0.0),
	float4(-0.499999911, -0.866025448, 0.0, 0.0),
	float4(-0.222521007, -0.974927902, 0.0, 0.0),
	float4(0.074730292, -0.997203767, 0.0, 0.0),
	float4(0.365341485, -0.930873573, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.826238811, -0.563319981, 0.0, 0.0),
	float4(0.955572903, -0.294754833, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x2b;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0730602965;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Bokeh Filter (very large)"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1076620
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

constant float4 ImmCB_0[71] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.275862098, 0.0, 0.0, 0.0),
	float4(0.171997204, 0.215677679, 0.0, 0.0),
	float4(-0.0613850951, 0.268945664, 0.0, 0.0),
	float4(-0.248543158, 0.119692102, 0.0, 0.0),
	float4(-0.248543158, -0.11969208, 0.0, 0.0),
	float4(-0.0613849834, -0.268945694, 0.0, 0.0),
	float4(0.171997175, -0.215677708, 0.0, 0.0),
	float4(0.517241359, 0.0, 0.0, 0.0),
	float4(0.466018349, 0.224422619, 0.0, 0.0),
	float4(0.322494715, 0.40439558, 0.0, 0.0),
	float4(0.115097053, 0.504273057, 0.0, 0.0),
	float4(-0.115097038, 0.504273057, 0.0, 0.0),
	float4(-0.322494805, 0.404395521, 0.0, 0.0),
	float4(-0.466018349, 0.224422649, 0.0, 0.0),
	float4(-0.517241359, 0.0, 0.0, 0.0),
	float4(-0.466018349, -0.224422619, 0.0, 0.0),
	float4(-0.322494626, -0.40439564, 0.0, 0.0),
	float4(-0.11509683, -0.504273117, 0.0, 0.0),
	float4(0.115097322, -0.504272997, 0.0, 0.0),
	float4(0.322494656, -0.40439564, 0.0, 0.0),
	float4(0.466018349, -0.224422619, 0.0, 0.0),
	float4(0.758620679, 0.0, 0.0, 0.0),
	float4(0.724917293, 0.223607376, 0.0, 0.0),
	float4(0.626801789, 0.427346289, 0.0, 0.0),
	float4(0.472992241, 0.593113542, 0.0, 0.0),
	float4(0.277155221, 0.706180096, 0.0, 0.0),
	float4(0.0566917248, 0.756499469, 0.0, 0.0),
	float4(-0.168808997, 0.73960048, 0.0, 0.0),
	float4(-0.379310399, 0.656984746, 0.0, 0.0),
	float4(-0.556108356, 0.515993059, 0.0, 0.0),
	float4(-0.683493614, 0.32915324, 0.0, 0.0),
	float4(-0.750147521, 0.113066405, 0.0, 0.0),
	float4(-0.750147521, -0.113066711, 0.0, 0.0),
	float4(-0.683493614, -0.32915318, 0.0, 0.0),
	float4(-0.556108296, -0.515993178, 0.0, 0.0),
	float4(-0.37931028, -0.656984806, 0.0, 0.0),
	float4(-0.168809041, -0.73960048, 0.0, 0.0),
	float4(0.0566919446, -0.75649941, 0.0, 0.0),
	float4(0.277155608, -0.706179917, 0.0, 0.0),
	float4(0.472992152, -0.593113661, 0.0, 0.0),
	float4(0.626801848, -0.4273462, 0.0, 0.0),
	float4(0.724917352, -0.223607108, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.974927902, 0.222520933, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.781831503, 0.623489797, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.433883637, 0.900968909, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(0.0, 1.0, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.433883846, 0.90096885, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.781831682, 0.623489559, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.974927902, 0.222520933, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.974927902, -0.222520873, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.781831384, -0.623489916, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.433883458, -0.900969028, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.0, -1.0, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.433883488, -0.900968969, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.781831443, -0.623489857, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0),
	float4(0.974927902, -0.222520858, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x47;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[71] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.275862098, 0.0, 0.0, 0.0),
	float4(0.171997204, 0.215677679, 0.0, 0.0),
	float4(-0.0613850951, 0.268945664, 0.0, 0.0),
	float4(-0.248543158, 0.119692102, 0.0, 0.0),
	float4(-0.248543158, -0.11969208, 0.0, 0.0),
	float4(-0.0613849834, -0.268945694, 0.0, 0.0),
	float4(0.171997175, -0.215677708, 0.0, 0.0),
	float4(0.517241359, 0.0, 0.0, 0.0),
	float4(0.466018349, 0.224422619, 0.0, 0.0),
	float4(0.322494715, 0.40439558, 0.0, 0.0),
	float4(0.115097053, 0.504273057, 0.0, 0.0),
	float4(-0.115097038, 0.504273057, 0.0, 0.0),
	float4(-0.322494805, 0.404395521, 0.0, 0.0),
	float4(-0.466018349, 0.224422649, 0.0, 0.0),
	float4(-0.517241359, 0.0, 0.0, 0.0),
	float4(-0.466018349, -0.224422619, 0.0, 0.0),
	float4(-0.322494626, -0.40439564, 0.0, 0.0),
	float4(-0.11509683, -0.504273117, 0.0, 0.0),
	float4(0.115097322, -0.504272997, 0.0, 0.0),
	float4(0.322494656, -0.40439564, 0.0, 0.0),
	float4(0.466018349, -0.224422619, 0.0, 0.0),
	float4(0.758620679, 0.0, 0.0, 0.0),
	float4(0.724917293, 0.223607376, 0.0, 0.0),
	float4(0.626801789, 0.427346289, 0.0, 0.0),
	float4(0.472992241, 0.593113542, 0.0, 0.0),
	float4(0.277155221, 0.706180096, 0.0, 0.0),
	float4(0.0566917248, 0.756499469, 0.0, 0.0),
	float4(-0.168808997, 0.73960048, 0.0, 0.0),
	float4(-0.379310399, 0.656984746, 0.0, 0.0),
	float4(-0.556108356, 0.515993059, 0.0, 0.0),
	float4(-0.683493614, 0.32915324, 0.0, 0.0),
	float4(-0.750147521, 0.113066405, 0.0, 0.0),
	float4(-0.750147521, -0.113066711, 0.0, 0.0),
	float4(-0.683493614, -0.32915318, 0.0, 0.0),
	float4(-0.556108296, -0.515993178, 0.0, 0.0),
	float4(-0.37931028, -0.656984806, 0.0, 0.0),
	float4(-0.168809041, -0.73960048, 0.0, 0.0),
	float4(0.0566919446, -0.75649941, 0.0, 0.0),
	float4(0.277155608, -0.706179917, 0.0, 0.0),
	float4(0.472992152, -0.593113661, 0.0, 0.0),
	float4(0.626801848, -0.4273462, 0.0, 0.0),
	float4(0.724917352, -0.223607108, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.974927902, 0.222520933, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.781831503, 0.623489797, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.433883637, 0.900968909, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(0.0, 1.0, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.433883846, 0.90096885, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.781831682, 0.623489559, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.974927902, 0.222520933, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.974927902, -0.222520873, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.781831384, -0.623489916, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.433883458, -0.900969028, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.0, -1.0, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.433883488, -0.900968969, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.781831443, -0.623489857, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0),
	float4(0.974927902, -0.222520858, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x47;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
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

constant float4 ImmCB_0[71] =
{
	float4(0.0, 0.0, 0.0, 0.0),
	float4(0.275862098, 0.0, 0.0, 0.0),
	float4(0.171997204, 0.215677679, 0.0, 0.0),
	float4(-0.0613850951, 0.268945664, 0.0, 0.0),
	float4(-0.248543158, 0.119692102, 0.0, 0.0),
	float4(-0.248543158, -0.11969208, 0.0, 0.0),
	float4(-0.0613849834, -0.268945694, 0.0, 0.0),
	float4(0.171997175, -0.215677708, 0.0, 0.0),
	float4(0.517241359, 0.0, 0.0, 0.0),
	float4(0.466018349, 0.224422619, 0.0, 0.0),
	float4(0.322494715, 0.40439558, 0.0, 0.0),
	float4(0.115097053, 0.504273057, 0.0, 0.0),
	float4(-0.115097038, 0.504273057, 0.0, 0.0),
	float4(-0.322494805, 0.404395521, 0.0, 0.0),
	float4(-0.466018349, 0.224422649, 0.0, 0.0),
	float4(-0.517241359, 0.0, 0.0, 0.0),
	float4(-0.466018349, -0.224422619, 0.0, 0.0),
	float4(-0.322494626, -0.40439564, 0.0, 0.0),
	float4(-0.11509683, -0.504273117, 0.0, 0.0),
	float4(0.115097322, -0.504272997, 0.0, 0.0),
	float4(0.322494656, -0.40439564, 0.0, 0.0),
	float4(0.466018349, -0.224422619, 0.0, 0.0),
	float4(0.758620679, 0.0, 0.0, 0.0),
	float4(0.724917293, 0.223607376, 0.0, 0.0),
	float4(0.626801789, 0.427346289, 0.0, 0.0),
	float4(0.472992241, 0.593113542, 0.0, 0.0),
	float4(0.277155221, 0.706180096, 0.0, 0.0),
	float4(0.0566917248, 0.756499469, 0.0, 0.0),
	float4(-0.168808997, 0.73960048, 0.0, 0.0),
	float4(-0.379310399, 0.656984746, 0.0, 0.0),
	float4(-0.556108356, 0.515993059, 0.0, 0.0),
	float4(-0.683493614, 0.32915324, 0.0, 0.0),
	float4(-0.750147521, 0.113066405, 0.0, 0.0),
	float4(-0.750147521, -0.113066711, 0.0, 0.0),
	float4(-0.683493614, -0.32915318, 0.0, 0.0),
	float4(-0.556108296, -0.515993178, 0.0, 0.0),
	float4(-0.37931028, -0.656984806, 0.0, 0.0),
	float4(-0.168809041, -0.73960048, 0.0, 0.0),
	float4(0.0566919446, -0.75649941, 0.0, 0.0),
	float4(0.277155608, -0.706179917, 0.0, 0.0),
	float4(0.472992152, -0.593113661, 0.0, 0.0),
	float4(0.626801848, -0.4273462, 0.0, 0.0),
	float4(0.724917352, -0.223607108, 0.0, 0.0),
	float4(1.0, 0.0, 0.0, 0.0),
	float4(0.974927902, 0.222520933, 0.0, 0.0),
	float4(0.90096885, 0.433883756, 0.0, 0.0),
	float4(0.781831503, 0.623489797, 0.0, 0.0),
	float4(0.623489797, 0.781831503, 0.0, 0.0),
	float4(0.433883637, 0.900968909, 0.0, 0.0),
	float4(0.222520977, 0.974927902, 0.0, 0.0),
	float4(0.0, 1.0, 0.0, 0.0),
	float4(-0.222520947, 0.974927902, 0.0, 0.0),
	float4(-0.433883846, 0.90096885, 0.0, 0.0),
	float4(-0.623489976, 0.781831384, 0.0, 0.0),
	float4(-0.781831682, 0.623489559, 0.0, 0.0),
	float4(-0.90096885, 0.433883816, 0.0, 0.0),
	float4(-0.974927902, 0.222520933, 0.0, 0.0),
	float4(-1.0, 0.0, 0.0, 0.0),
	float4(-0.974927902, -0.222520873, 0.0, 0.0),
	float4(-0.90096885, -0.433883756, 0.0, 0.0),
	float4(-0.781831384, -0.623489916, 0.0, 0.0),
	float4(-0.623489618, -0.781831622, 0.0, 0.0),
	float4(-0.433883458, -0.900969028, 0.0, 0.0),
	float4(-0.222520545, -0.974928021, 0.0, 0.0),
	float4(0.0, -1.0, 0.0, 0.0),
	float4(0.222521499, -0.974927783, 0.0, 0.0),
	float4(0.433883488, -0.900968969, 0.0, 0.0),
	float4(0.623489678, -0.781831622, 0.0, 0.0),
	float4(0.781831443, -0.623489857, 0.0, 0.0),
	float4(0.90096885, -0.433883756, 0.0, 0.0),
	float4(0.974927902, -0.222520858, 0.0, 0.0)
};
#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float _MaxCoC;
    float _RcpAspect;
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
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half u_xlat16_5;
    float u_xlat6;
    int u_xlati12;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat22;
    bool u_xlatb22;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat6 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat1.w = 1.0;
    u_xlat2.x = float(0.0);
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat3.x = float(0.0);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlati12 = 0x0;
    while(true){
        u_xlatb18 = u_xlati12>=0x47;
        if(u_xlatb18){break;}
        u_xlat4.yz = float2(FGlobals._MaxCoC) * ImmCB_0[u_xlati12].xy;
        u_xlat18 = dot(u_xlat4.yz, u_xlat4.yz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat4.x = u_xlat4.y * FGlobals._RcpAspect;
        u_xlat4.xy = u_xlat4.xz + input.TEXCOORD0.xy;
        u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
        u_xlat4.xy = u_xlat4.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
        u_xlat16_5 = min(u_xlat16_0, u_xlat16_4.w);
        u_xlat16_5 = max(u_xlat16_5, half(0.0));
        u_xlat5 = (-u_xlat18) + float(u_xlat16_5);
        u_xlat5 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat5);
        u_xlat5 = u_xlat5 / u_xlat6;
        u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
        u_xlat18 = (-u_xlat18) + (-float(u_xlat16_4.w));
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.y, 2.0, u_xlat18);
        u_xlat18 = u_xlat18 / u_xlat6;
        u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
        u_xlatb22 = (-float(u_xlat16_4.w))>=FGlobals._MainTex_TexelSize.y;
        u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
        u_xlat18 = u_xlat18 * u_xlat22;
        u_xlat1.xyz = float3(u_xlat16_4.xyz);
        u_xlat2 = fma(u_xlat1, float4(u_xlat5), u_xlat2);
        u_xlat3 = fma(u_xlat1, float4(u_xlat18), u_xlat3);
        u_xlati12 = u_xlati12 + 0x1;
    }
    u_xlatb0 = u_xlat2.w==0.0;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat2.w;
    u_xlat0.xyz = u_xlat2.xyz / u_xlat0.xxx;
    u_xlatb18 = u_xlat3.w==0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 + u_xlat3.w;
    u_xlat1.xyz = u_xlat3.xyz / float3(u_xlat18);
    u_xlat18 = u_xlat3.w * 0.0442477837;
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    output.SV_Target0.xyz = fma(float3(u_xlat18), u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = u_xlat18;
    return output;
}
"
}
}
}
 Pass {
  Name "Postfilter"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1170997
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
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
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
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
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
    u_xlat0 = fma((-FGlobals._MainTex_TexelSize.xyxy), float4(0.5, 0.5, -0.5, 0.5), input.TEXCOORD0.xyxy);
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
    output.SV_Target0 = float4(u_xlat16_0) * float4(0.25, 0.25, 0.25, 0.25);
    return output;
}
"
}
}
}
 Pass {
  Name "Combine"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1214230
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    sampler sampler_DepthOfFieldTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _DepthOfFieldTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, input.TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + half(-0.5);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = fma(float(u_xlat16_0), FGlobals._MaxCoC, (-u_xlat3));
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = float4(_DepthOfFieldTex.sample(sampler_DepthOfFieldTex, input.TEXCOORD1.xy));
    u_xlat0.x = fma(u_xlat3, u_xlat0.x, u_xlat1.w);
    u_xlat0.x = fma((-u_xlat6), u_xlat1.w, u_xlat0.x);
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = u_xlat0.w;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    sampler sampler_DepthOfFieldTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _DepthOfFieldTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, input.TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + half(-0.5);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = fma(float(u_xlat16_0), FGlobals._MaxCoC, (-u_xlat3));
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = float4(_DepthOfFieldTex.sample(sampler_DepthOfFieldTex, input.TEXCOORD1.xy));
    u_xlat0.x = fma(u_xlat3, u_xlat0.x, u_xlat1.w);
    u_xlat0.x = fma((-u_xlat6), u_xlat1.w, u_xlat0.x);
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = u_xlat0.w;
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
    float _MaxCoC;
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
    sampler sampler_CoCTex [[ sampler (1) ]],
    sampler sampler_DepthOfFieldTex [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CoCTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _DepthOfFieldTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat16_0 = _CoCTex.sample(sampler_CoCTex, input.TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat16_0 + half(-0.5);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_0;
    u_xlat3 = FGlobals._MainTex_TexelSize.y + FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = fma(float(u_xlat16_0), FGlobals._MaxCoC, (-u_xlat3));
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat0.x * u_xlat3;
    u_xlat1 = float4(_DepthOfFieldTex.sample(sampler_DepthOfFieldTex, input.TEXCOORD1.xy));
    u_xlat0.x = fma(u_xlat3, u_xlat0.x, u_xlat1.w);
    u_xlat0.x = fma((-u_xlat6), u_xlat1.w, u_xlat0.x);
    u_xlat3 = max(u_xlat1.y, u_xlat1.x);
    u_xlat1.w = max(u_xlat1.z, u_xlat3);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
    u_xlat2.xyz = u_xlat2.xyz * u_xlat2.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
    output.SV_Target0.xyz = sqrt(u_xlat0.xyz);
    output.SV_Target0.w = u_xlat0.w;
    return output;
}
"
}
}
}
 Pass {
  Name "Debug Overlay"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1256058
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
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
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float u_xlat2;
    half u_xlat16_6;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-FGlobals._Distance);
    u_xlat2 = u_xlat2 * FGlobals._LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(0.0, 1.0, 1.0), float3(1.0, 0.0, 0.0));
    u_xlat1.xyz = (-u_xlat0.xww) + float3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = fma(float3(u_xlat2), u_xlat1.xyz, u_xlat0.xzw);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, half3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + half(0.5);
    output.SV_Target0.xyz = float3(u_xlat16_6) * u_xlat0.xyz;
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
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
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float u_xlat2;
    half u_xlat16_6;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-FGlobals._Distance);
    u_xlat2 = u_xlat2 * FGlobals._LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(0.0, 1.0, 1.0), float3(1.0, 0.0, 0.0));
    u_xlat1.xyz = (-u_xlat0.xww) + float3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = fma(float3(u_xlat2), u_xlat1.xyz, u_xlat0.xzw);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, half3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + half(0.5);
    output.SV_Target0.xyz = float3(u_xlat16_6) * u_xlat0.xyz;
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
    float4 _ZBufferParams;
    float _Distance;
    float _LensCoeff;
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
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float u_xlat2;
    half u_xlat16_6;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat0.x + (-FGlobals._Distance);
    u_xlat2 = u_xlat2 * FGlobals._LensCoeff;
    u_xlat0.x = u_xlat2 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 80.0;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat0.x = (-u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(0.0, 1.0, 1.0), float3(1.0, 0.0, 0.0));
    u_xlat1.xyz = (-u_xlat0.xww) + float3(0.400000006, 0.400000006, 0.400000006);
    u_xlat0.xyz = fma(float3(u_xlat2), u_xlat1.xyz, u_xlat0.xzw);
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_6 = dot(u_xlat16_1.xyz, half3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat16_6 = u_xlat16_6 + half(0.5);
    output.SV_Target0.xyz = float3(u_xlat16_6) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
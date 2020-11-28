//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/DeferredFog" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52107
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = u_xlat0 * FGlobals._FogParams.xyzx.x;
    u_xlat0 = u_xlat0 * (-u_xlat0);
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = u_xlat0 * FGlobals._FogParams.xyzx.x;
    u_xlat0 = u_xlat0 * (-u_xlat0);
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = u_xlat0 * FGlobals._FogParams.xyzx.x;
    u_xlat0 = u_xlat0 * (-u_xlat0);
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = (-u_xlat0) + FGlobals._FogParams.xyzx.z;
    u_xlat3 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat0 = u_xlat0 / u_xlat3;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = (-u_xlat0) + FGlobals._FogParams.xyzx.z;
    u_xlat3 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat0 = u_xlat0 / u_xlat3;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat0 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat0 = (-u_xlat0) + FGlobals._FogParams.xyzx.z;
    u_xlat3 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat0 = u_xlat0 / u_xlat3;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
  GpuProgramID 126014
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat3 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlatb0 = u_xlat0<0.999899983;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * FGlobals._FogParams.xyzx.x;
    u_xlat3 = u_xlat3 * (-u_xlat3);
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat3 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlatb0 = u_xlat0<0.999899983;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * FGlobals._FogParams.xyzx.x;
    u_xlat3 = u_xlat3 * (-u_xlat3);
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat3 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlatb0 = u_xlat0<0.999899983;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * FGlobals._FogParams.xyzx.x;
    u_xlat3 = u_xlat3 * (-u_xlat3);
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat3 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlatb0 = u_xlat0<0.999899983;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = (-u_xlat3) + FGlobals._FogParams.xyzx.z;
    u_xlat6 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat3 = u_xlat3 / u_xlat6;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat3 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlatb0 = u_xlat0<0.999899983;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = (-u_xlat3) + FGlobals._FogParams.xyzx.z;
    u_xlat6 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat3 = u_xlat3 / u_xlat6;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
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
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _FogColor;
    float3 _FogParams;
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
    float u_xlat0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float u_xlat3;
    float u_xlat6;
    u_xlat0 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat3 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat3 = u_xlat3 * FGlobals._ZBufferParams.x;
    u_xlat0 = fma(u_xlat0, u_xlat3, FGlobals._ZBufferParams.y);
    u_xlat3 = fma((-FGlobals.unity_OrthoParams.w), u_xlat3, 1.0);
    u_xlat0 = u_xlat3 / u_xlat0;
    u_xlat3 = fma(u_xlat0, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlatb0 = u_xlat0<0.999899983;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = (-u_xlat3) + FGlobals._FogParams.xyzx.z;
    u_xlat6 = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat3 = u_xlat3 / u_xlat6;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._FogColor;
    output.SV_Target0 = fma(float4(u_xlat0), u_xlat2, float4(u_xlat16_1));
    return output;
}
"
}
}
}
}
}
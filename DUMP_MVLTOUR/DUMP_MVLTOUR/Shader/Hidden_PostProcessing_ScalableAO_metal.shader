//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/ScalableAO" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35749
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * FGlobals._ZBufferParams.x;
    u_xlat27 = fma((-FGlobals.unity_OrthoParams.w), u_xlat18.x, 1.0);
    u_xlat9 = fma(u_xlat9, u_xlat18.x, FGlobals._ZBufferParams.y);
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = fma(u_xlat9, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat9 = u_xlat9 * FGlobals._FogParams.xyzx.x;
    u_xlat9 = u_xlat9 * (-u_xlat9);
    u_xlat9 = exp2(u_xlat9);
    output.SV_Target0.x = u_xlat9 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * FGlobals._ZBufferParams.x;
    u_xlat27 = fma((-FGlobals.unity_OrthoParams.w), u_xlat18.x, 1.0);
    u_xlat9 = fma(u_xlat9, u_xlat18.x, FGlobals._ZBufferParams.y);
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = fma(u_xlat9, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat9 = u_xlat9 * FGlobals._FogParams.xyzx.x;
    u_xlat9 = u_xlat9 * (-u_xlat9);
    u_xlat9 = exp2(u_xlat9);
    output.SV_Target0.x = u_xlat9 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * FGlobals._ZBufferParams.x;
    u_xlat27 = fma((-FGlobals.unity_OrthoParams.w), u_xlat18.x, 1.0);
    u_xlat9 = fma(u_xlat9, u_xlat18.x, FGlobals._ZBufferParams.y);
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = fma(u_xlat9, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat9 = u_xlat9 * FGlobals._FogParams.xyzx.x;
    u_xlat9 = u_xlat9 * (-u_xlat9);
    u_xlat9 = exp2(u_xlat9);
    output.SV_Target0.x = u_xlat9 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * FGlobals._ZBufferParams.x;
    u_xlat27 = fma((-FGlobals.unity_OrthoParams.w), u_xlat18.x, 1.0);
    u_xlat9 = fma(u_xlat9, u_xlat18.x, FGlobals._ZBufferParams.y);
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = fma(u_xlat9, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat9 = (-u_xlat9) + FGlobals._FogParams.xyzx.z;
    u_xlat18.x = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat9 = u_xlat9 / u_xlat18.x;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    output.SV_Target0.x = u_xlat9 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * FGlobals._ZBufferParams.x;
    u_xlat27 = fma((-FGlobals.unity_OrthoParams.w), u_xlat18.x, 1.0);
    u_xlat9 = fma(u_xlat9, u_xlat18.x, FGlobals._ZBufferParams.y);
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = fma(u_xlat9, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat9 = (-u_xlat9) + FGlobals._FogParams.xyzx.z;
    u_xlat18.x = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat9 = u_xlat9 / u_xlat18.x;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    output.SV_Target0.x = u_xlat9 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    half3 u_xlat16_1;
    int u_xlati1;
    float3 u_xlat2;
    float3 u_xlat3;
    bool2 u_xlatb3;
    float2 u_xlat4;
    float2 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float2 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float3 u_xlat14;
    int u_xlati14;
    bool2 u_xlatb14;
    float2 u_xlat18;
    half u_xlat16_18;
    int2 u_xlati18;
    bool2 u_xlatb18;
    float2 u_xlat22;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    bool u_xlatb29;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb30;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat10.xy = float2(u_xlat16_1.xy) * float2(u_xlat16_18);
    u_xlat10.z = float(u_xlat16_18) + -1.0;
    u_xlat2.xyz = u_xlat10.xyz * float3(1.0, 1.0, -1.0);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat9 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat18.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat9, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat18.x / u_xlat0.x;
    u_xlatb18.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati18.x = int((uint(u_xlatb18.y) * 0xffffffffu) | (uint(u_xlatb18.x) * 0xffffffffu));
    u_xlatb3.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati18.y = int((uint(u_xlatb3.y) * 0xffffffffu) | (uint(u_xlatb3.x) * 0xffffffffu));
    u_xlati18.xy = int2(uint2(u_xlati18.xy) & uint2(0x1u, 0x1u));
    u_xlati18.x = u_xlati18.y + u_xlati18.x;
    u_xlat18.x = float(u_xlati18.x);
    u_xlatb27 = 9.99999975e-06>=u_xlat0.x;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18.x = u_xlat27 + u_xlat18.x;
    u_xlat18.x = u_xlat18.x * 100000000.0;
    u_xlat3.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat18.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat4.xy;
    u_xlat27 = (-u_xlat3.z) + 1.0;
    u_xlat27 = fma(FGlobals.unity_OrthoParams.w, u_xlat27, u_xlat3.z);
    u_xlat3.xy = float2(u_xlat27) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat18.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat18.xy = u_xlat18.xy * FGlobals._ScreenParams.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat18.x = dot(float2(0.0671105608, 0.00583714992), u_xlat18.xy);
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * 52.9829178;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat5.x = 12.9898005;
    u_xlat27 = 0.0;
    u_xlati1 = 0x0;
    while(true){
        u_xlatb29 = u_xlati1>=u_xlati0;
        if(u_xlatb29){break;}
        u_xlat29 = float(u_xlati1);
        u_xlat5.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat29);
        u_xlat30 = u_xlat5.y * 78.2330017;
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = fract(u_xlat30);
        u_xlat6.z = fma(u_xlat30, 2.0, -1.0);
        u_xlat30 = dot(u_xlat5.xy, float2(1.0, 78.2330017));
        u_xlat30 = sin(u_xlat30);
        u_xlat30 = u_xlat30 * 43758.5469;
        u_xlat30 = fract(u_xlat30);
        u_xlat30 = u_xlat18.x + u_xlat30;
        u_xlat30 = u_xlat30 * 6.28318548;
        u_xlat7 = sin(u_xlat30);
        u_xlat8.x = cos(u_xlat30);
        u_xlat30 = fma((-u_xlat6.z), u_xlat6.z, 1.0);
        u_xlat30 = sqrt(u_xlat30);
        u_xlat8.y = u_xlat7;
        u_xlat6.xy = float2(u_xlat30) * u_xlat8.xy;
        u_xlat29 = u_xlat29 + 1.0;
        u_xlat29 = u_xlat29 / FGlobals._AOParams.w;
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = u_xlat29 * FGlobals._AOParams.y;
        u_xlat14.xyz = float3(u_xlat29) * u_xlat6.xyz;
        u_xlat29 = dot((-u_xlat2.xyz), u_xlat14.xyz);
        u_xlatb29 = u_xlat29>=0.0;
        u_xlat14.xyz = (bool(u_xlatb29)) ? (-u_xlat14.xyz) : u_xlat14.xyz;
        u_xlat14.xyz = u_xlat3.xyz + u_xlat14.xyz;
        u_xlat22.xy = u_xlat14.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat14.xx, u_xlat22.xy);
        u_xlat22.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat14.zz, u_xlat22.xy);
        u_xlat29 = (-u_xlat14.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat14.z);
        u_xlat22.xy = u_xlat22.xy / float2(u_xlat29);
        u_xlat22.xy = u_xlat22.xy + float2(1.0, 1.0);
        u_xlat14.xy = u_xlat22.xy * float2(0.5, 0.5);
        u_xlat14.xy = clamp(u_xlat14.xy, 0.0f, 1.0f);
        u_xlat14.xy = u_xlat14.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat29 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat14.xy, level(0.0)).x;
        u_xlat29 = u_xlat29 * FGlobals._ZBufferParams.x;
        u_xlat30 = fma((-FGlobals.unity_OrthoParams.w), u_xlat29, 1.0);
        u_xlat29 = fma(u_xlat9, u_xlat29, FGlobals._ZBufferParams.y);
        u_xlat29 = u_xlat30 / u_xlat29;
        u_xlatb14.xy = (u_xlat22.xy<float2(0.0, 0.0));
        u_xlatb30 = u_xlatb14.y || u_xlatb14.x;
        u_xlati30 = u_xlatb30 ? 0x1 : int(0);
        u_xlatb14.xy = (float2(2.0, 2.0)<u_xlat22.xy);
        u_xlatb14.x = u_xlatb14.y || u_xlatb14.x;
        u_xlati14 = u_xlatb14.x ? 0x1 : int(0);
        u_xlati30 = u_xlati30 + u_xlati14;
        u_xlat30 = float(u_xlati30);
        u_xlatb14.x = 9.99999975e-06>=u_xlat29;
        u_xlat14.x = u_xlatb14.x ? 1.0 : float(0.0);
        u_xlat30 = u_xlat30 + u_xlat14.x;
        u_xlat30 = u_xlat30 * 100000000.0;
        u_xlat6.z = fma(u_xlat29, FGlobals._ProjectionParams.z, u_xlat30);
        u_xlat22.xy = u_xlat22.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat22.xy = u_xlat22.xy + float2(-1.0, -1.0);
        u_xlat22.xy = u_xlat22.xy / u_xlat4.xy;
        u_xlat29 = (-u_xlat6.z) + 1.0;
        u_xlat29 = fma(FGlobals.unity_OrthoParams.w, u_xlat29, u_xlat6.z);
        u_xlat6.xy = float2(u_xlat29) * u_xlat22.xy;
        u_xlat14.xyz = (-u_xlat3.xyz) + u_xlat6.xyz;
        u_xlat29 = dot(u_xlat14.xyz, u_xlat2.xyz);
        u_xlat29 = fma((-u_xlat3.z), 0.00200000009, u_xlat29);
        u_xlat29 = max(u_xlat29, 0.0);
        u_xlat30 = dot(u_xlat14.xyz, u_xlat14.xyz);
        u_xlat30 = u_xlat30 + 9.99999975e-05;
        u_xlat29 = u_xlat29 / u_xlat30;
        u_xlat27 = u_xlat27 + u_xlat29;
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat0.x = u_xlat27 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat18.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat18.x = u_xlat18.x * FGlobals._ZBufferParams.x;
    u_xlat27 = fma((-FGlobals.unity_OrthoParams.w), u_xlat18.x, 1.0);
    u_xlat9 = fma(u_xlat9, u_xlat18.x, FGlobals._ZBufferParams.y);
    u_xlat9 = u_xlat27 / u_xlat9;
    u_xlat9 = fma(u_xlat9, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat9 = (-u_xlat9) + FGlobals._FogParams.xyzx.z;
    u_xlat18.x = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat9 = u_xlat9 / u_xlat18.x;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    output.SV_Target0.x = u_xlat9 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat10.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
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
  GpuProgramID 70475
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    output.SV_Target0.x = exp2(u_xlat0.x);
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * FGlobals._ZBufferParams.x;
    u_xlat24 = fma((-FGlobals.unity_OrthoParams.w), u_xlat16.x, 1.0);
    u_xlat8 = fma(u_xlat8, u_xlat16.x, FGlobals._ZBufferParams.y);
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = fma(u_xlat8, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat8 = u_xlat8 * FGlobals._FogParams.xyzx.x;
    u_xlat8 = u_xlat8 * (-u_xlat8);
    u_xlat8 = exp2(u_xlat8);
    output.SV_Target0.x = u_xlat8 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * FGlobals._ZBufferParams.x;
    u_xlat24 = fma((-FGlobals.unity_OrthoParams.w), u_xlat16.x, 1.0);
    u_xlat8 = fma(u_xlat8, u_xlat16.x, FGlobals._ZBufferParams.y);
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = fma(u_xlat8, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat8 = u_xlat8 * FGlobals._FogParams.xyzx.x;
    u_xlat8 = u_xlat8 * (-u_xlat8);
    u_xlat8 = exp2(u_xlat8);
    output.SV_Target0.x = u_xlat8 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * FGlobals._ZBufferParams.x;
    u_xlat24 = fma((-FGlobals.unity_OrthoParams.w), u_xlat16.x, 1.0);
    u_xlat8 = fma(u_xlat8, u_xlat16.x, FGlobals._ZBufferParams.y);
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = fma(u_xlat8, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat8 = u_xlat8 * FGlobals._FogParams.xyzx.x;
    u_xlat8 = u_xlat8 * (-u_xlat8);
    u_xlat8 = exp2(u_xlat8);
    output.SV_Target0.x = u_xlat8 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * FGlobals._ZBufferParams.x;
    u_xlat24 = fma((-FGlobals.unity_OrthoParams.w), u_xlat16.x, 1.0);
    u_xlat8 = fma(u_xlat8, u_xlat16.x, FGlobals._ZBufferParams.y);
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = fma(u_xlat8, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat8 = (-u_xlat8) + FGlobals._FogParams.xyzx.z;
    u_xlat16.x = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat8 = u_xlat8 / u_xlat16.x;
    u_xlat8 = clamp(u_xlat8, 0.0f, 1.0f);
    output.SV_Target0.x = u_xlat8 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * FGlobals._ZBufferParams.x;
    u_xlat24 = fma((-FGlobals.unity_OrthoParams.w), u_xlat16.x, 1.0);
    u_xlat8 = fma(u_xlat8, u_xlat16.x, FGlobals._ZBufferParams.y);
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = fma(u_xlat8, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat8 = (-u_xlat8) + FGlobals._FogParams.xyzx.z;
    u_xlat16.x = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat8 = u_xlat8 / u_xlat16.x;
    u_xlat8 = clamp(u_xlat8, 0.0f, 1.0f);
    output.SV_Target0.x = u_xlat8 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
    float4 hlslcc_mtx4x4unity_CameraProjection[4];
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ZBufferParams;
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float3 _FogParams;
    float4 _AOParams;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    bool2 u_xlatb2;
    float2 u_xlat3;
    float2 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float2 u_xlat7;
    float u_xlat8;
    float3 u_xlat12;
    int2 u_xlati12;
    bool2 u_xlatb12;
    float2 u_xlat16;
    int2 u_xlati16;
    bool2 u_xlatb16;
    float2 u_xlat19;
    float u_xlat20;
    bool2 u_xlatb20;
    float u_xlat24;
    bool u_xlatb24;
    int u_xlati25;
    float u_xlat26;
    bool u_xlatb26;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, u_xlat0.xy).xyz;
    u_xlat16.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlatb16.x = u_xlat16.x!=0.0;
    u_xlat16.x = (u_xlatb16.x) ? -1.0 : -0.0;
    u_xlat1.xyz = fma(float3(u_xlat16_1.xyz), float3(2.0, 2.0, 2.0), u_xlat16.xxx);
    u_xlat2.xyz = u_xlat1.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat1.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat1.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat1.zzz, u_xlat1.xyw);
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy, level(0.0)).x;
    u_xlat8 = (-FGlobals.unity_OrthoParams.w) + 1.0;
    u_xlat0.x = u_xlat0.x * FGlobals._ZBufferParams.x;
    u_xlat16.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat0.x, 1.0);
    u_xlat0.x = fma(u_xlat8, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = u_xlat16.x / u_xlat0.x;
    u_xlatb16.xy = (input.TEXCOORD0.xy<float2(0.0, 0.0));
    u_xlati16.x = int((uint(u_xlatb16.y) * 0xffffffffu) | (uint(u_xlatb16.x) * 0xffffffffu));
    u_xlatb2.xy = (float2(1.0, 1.0)<input.TEXCOORD0.xy);
    u_xlati16.y = int((uint(u_xlatb2.y) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu));
    u_xlati16.xy = int2(uint2(u_xlati16.xy) & uint2(0x1u, 0x1u));
    u_xlati16.x = u_xlati16.y + u_xlati16.x;
    u_xlat16.x = float(u_xlati16.x);
    u_xlatb24 = 9.99999975e-06>=u_xlat0.x;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16.x = u_xlat24 + u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 100000000.0;
    u_xlat2.z = fma(u_xlat0.x, FGlobals._ProjectionParams.z, u_xlat16.x);
    u_xlat0.xz = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat0.xz = u_xlat0.xz + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
    u_xlat3.x = FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].x;
    u_xlat3.y = FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat0.xz = u_xlat0.xz / u_xlat3.xy;
    u_xlat24 = (-u_xlat2.z) + 1.0;
    u_xlat24 = fma(FGlobals.unity_OrthoParams.w, u_xlat24, u_xlat2.z);
    u_xlat2.xy = float2(u_xlat24) * u_xlat0.xz;
    u_xlati0 = int(FGlobals._AOParams.w);
    u_xlat16.xy = input.TEXCOORD0.xy * FGlobals._AOParams.zz;
    u_xlat16.xy = u_xlat16.xy * FGlobals._ScreenParams.xy;
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.x = dot(float2(0.0671105608, 0.00583714992), u_xlat16.xy);
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * 52.9829178;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat4.x = 12.9898005;
    u_xlat24 = 0.0;
    u_xlati25 = 0x0;
    while(true){
        u_xlatb26 = u_xlati25>=u_xlati0;
        if(u_xlatb26){break;}
        u_xlat26 = float(u_xlati25);
        u_xlat4.y = fma(input.TEXCOORD0.x, 1.00000001e-10, u_xlat26);
        u_xlat19.x = u_xlat4.y * 78.2330017;
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat5.z = fma(u_xlat19.x, 2.0, -1.0);
        u_xlat19.x = dot(u_xlat4.xy, float2(1.0, 78.2330017));
        u_xlat19.x = sin(u_xlat19.x);
        u_xlat19.x = u_xlat19.x * 43758.5469;
        u_xlat19.x = fract(u_xlat19.x);
        u_xlat19.x = u_xlat16.x + u_xlat19.x;
        u_xlat19.x = u_xlat19.x * 6.28318548;
        u_xlat6 = sin(u_xlat19.x);
        u_xlat7.x = cos(u_xlat19.x);
        u_xlat19.x = fma((-u_xlat5.z), u_xlat5.z, 1.0);
        u_xlat19.x = sqrt(u_xlat19.x);
        u_xlat7.y = u_xlat6;
        u_xlat5.xy = u_xlat19.xx * u_xlat7.xy;
        u_xlat26 = u_xlat26 + 1.0;
        u_xlat26 = u_xlat26 / FGlobals._AOParams.w;
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = u_xlat26 * FGlobals._AOParams.y;
        u_xlat12.xyz = float3(u_xlat26) * u_xlat5.xyz;
        u_xlat26 = dot((-u_xlat1.xyz), u_xlat12.xyz);
        u_xlatb26 = u_xlat26>=0.0;
        u_xlat12.xyz = (bool(u_xlatb26)) ? (-u_xlat12.xyz) : u_xlat12.xyz;
        u_xlat12.xyz = u_xlat2.xyz + u_xlat12.xyz;
        u_xlat19.xy = u_xlat12.yy * FGlobals.hlslcc_mtx4x4unity_CameraProjection[1].xy;
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[0].xy, u_xlat12.xx, u_xlat19.xy);
        u_xlat19.xy = fma(FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy, u_xlat12.zz, u_xlat19.xy);
        u_xlat26 = (-u_xlat12.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat12.z);
        u_xlat19.xy = u_xlat19.xy / float2(u_xlat26);
        u_xlat19.xy = u_xlat19.xy + float2(1.0, 1.0);
        u_xlat12.xy = u_xlat19.xy * float2(0.5, 0.5);
        u_xlat12.xy = clamp(u_xlat12.xy, 0.0f, 1.0f);
        u_xlat12.xy = u_xlat12.xy * float2(FGlobals._RenderViewportScaleFactor);
        u_xlat26 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat12.xy, level(0.0)).x;
        u_xlat26 = u_xlat26 * FGlobals._ZBufferParams.x;
        u_xlat12.x = fma((-FGlobals.unity_OrthoParams.w), u_xlat26, 1.0);
        u_xlat26 = fma(u_xlat8, u_xlat26, FGlobals._ZBufferParams.y);
        u_xlat26 = u_xlat12.x / u_xlat26;
        u_xlatb12.xy = (u_xlat19.xy<float2(0.0, 0.0));
        u_xlati12.x = int((uint(u_xlatb12.y) * 0xffffffffu) | (uint(u_xlatb12.x) * 0xffffffffu));
        u_xlatb20.xy = (float2(2.0, 2.0)<u_xlat19.xy);
        u_xlati12.y = int((uint(u_xlatb20.y) * 0xffffffffu) | (uint(u_xlatb20.x) * 0xffffffffu));
        u_xlati12.xy = int2(uint2(u_xlati12.xy) & uint2(0x1u, 0x1u));
        u_xlati12.x = u_xlati12.y + u_xlati12.x;
        u_xlat12.x = float(u_xlati12.x);
        u_xlatb20.x = 9.99999975e-06>=u_xlat26;
        u_xlat20 = u_xlatb20.x ? 1.0 : float(0.0);
        u_xlat12.x = u_xlat20 + u_xlat12.x;
        u_xlat12.x = u_xlat12.x * 100000000.0;
        u_xlat5.z = fma(u_xlat26, FGlobals._ProjectionParams.z, u_xlat12.x);
        u_xlat19.xy = u_xlat19.xy + (-FGlobals.hlslcc_mtx4x4unity_CameraProjection[2].xy);
        u_xlat19.xy = u_xlat19.xy + float2(-1.0, -1.0);
        u_xlat19.xy = u_xlat19.xy / u_xlat3.xy;
        u_xlat26 = (-u_xlat5.z) + 1.0;
        u_xlat26 = fma(FGlobals.unity_OrthoParams.w, u_xlat26, u_xlat5.z);
        u_xlat5.xy = float2(u_xlat26) * u_xlat19.xy;
        u_xlat12.xyz = (-u_xlat2.xyz) + u_xlat5.xyz;
        u_xlat26 = dot(u_xlat12.xyz, u_xlat1.xyz);
        u_xlat26 = fma((-u_xlat2.z), 0.00200000009, u_xlat26);
        u_xlat26 = max(u_xlat26, 0.0);
        u_xlat19.x = dot(u_xlat12.xyz, u_xlat12.xyz);
        u_xlat19.x = u_xlat19.x + 9.99999975e-05;
        u_xlat26 = u_xlat26 / u_xlat19.x;
        u_xlat24 = u_xlat24 + u_xlat26;
        u_xlati25 = u_xlati25 + 0x1;
    }
    u_xlat0.x = u_xlat24 * FGlobals._AOParams.y;
    u_xlat0.x = u_xlat0.x * FGlobals._AOParams.x;
    u_xlat0.x = u_xlat0.x / FGlobals._AOParams.w;
    u_xlat0.x = max(abs(u_xlat0.x), 1.1920929e-07);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.600000024;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlat16.x = u_xlat16.x * FGlobals._ZBufferParams.x;
    u_xlat24 = fma((-FGlobals.unity_OrthoParams.w), u_xlat16.x, 1.0);
    u_xlat8 = fma(u_xlat8, u_xlat16.x, FGlobals._ZBufferParams.y);
    u_xlat8 = u_xlat24 / u_xlat8;
    u_xlat8 = fma(u_xlat8, FGlobals._ProjectionParams.z, (-FGlobals._ProjectionParams.y));
    u_xlat8 = (-u_xlat8) + FGlobals._FogParams.xyzx.z;
    u_xlat16.x = (-FGlobals._FogParams.xyzx.y) + FGlobals._FogParams.xyzx.z;
    u_xlat8 = u_xlat8 / u_xlat16.x;
    u_xlat8 = clamp(u_xlat8, 0.0f, 1.0f);
    output.SV_Target0.x = u_xlat8 * u_xlat0.x;
    output.SV_Target0.yzw = fma(u_xlat1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
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
  GpuProgramID 132876
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat5;
    half3 u_xlat16_5;
    float u_xlat6;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float3 u_xlat9;
    half3 u_xlat16_9;
    float u_xlat10;
    float u_xlat11;
    float u_xlat12;
    half u_xlat16_12;
    half u_xlat16_13;
    float u_xlat17;
    u_xlat0.x = FGlobals._MainTex_TexelSize.x;
    u_xlat0.y = 0.0;
    u_xlat1 = fma((-u_xlat0.xyxy), float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xyxy, float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_3.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_13 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_13 = half(2.0) / u_xlat16_13;
    u_xlat9.xy = float2(u_xlat16_3.xy) * float2(u_xlat16_13);
    u_xlat9.z = float(u_xlat16_13) + -1.0;
    u_xlat3.xyz = u_xlat9.xyz * float3(1.0, 1.0, -1.0);
    output.SV_Target0.yzw = fma(u_xlat9.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
    u_xlat7 = dot(u_xlat3.xyz, float3(u_xlat16_7.xyz));
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat7, -2.0, 3.0);
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat7 = u_xlat7 * 0.31621623;
    u_xlat2 = u_xlat7 * float(u_xlat16_2.x);
    u_xlat16_12 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).x;
    u_xlat2 = fma(float(u_xlat16_12), 0.227027029, u_xlat2);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat12 = dot(u_xlat3.xyz, float3(u_xlat16_9.xyz));
    u_xlat12 = u_xlat12 + -0.800000012;
    u_xlat12 = u_xlat12 * 5.00000048;
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat17 = fma(u_xlat12, -2.0, 3.0);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat17;
    u_xlat17 = u_xlat12 * 0.31621623;
    u_xlat7 = fma(u_xlat12, 0.31621623, u_xlat7);
    u_xlat2 = fma(float(u_xlat16_4.x), u_xlat17, u_xlat2);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6 = dot(u_xlat3.xyz, float3(u_xlat16_6.xyz));
    u_xlat6 = u_xlat6 + -0.800000012;
    u_xlat6 = u_xlat6 * 5.00000048;
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat11 = fma(u_xlat6, -2.0, 3.0);
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat11;
    u_xlat11 = u_xlat6 * 0.0702702701;
    u_xlat6 = fma(u_xlat6, 0.0702702701, u_xlat7);
    u_xlat1.x = fma(float(u_xlat16_1.x), u_xlat11, u_xlat2);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5 = dot(u_xlat3.xyz, float3(u_xlat16_5.xyz));
    u_xlat5 = u_xlat5 + -0.800000012;
    u_xlat5 = u_xlat5 * 5.00000048;
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat10 = fma(u_xlat5, -2.0, 3.0);
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = u_xlat5 * 0.0702702701;
    u_xlat5 = fma(u_xlat5, 0.0702702701, u_xlat6);
    u_xlat5 = u_xlat5 + 0.227027029;
    u_xlat0.x = fma(float(u_xlat16_0.x), u_xlat10, u_xlat1.x);
    output.SV_Target0.x = u_xlat0.x / u_xlat5;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat5;
    half3 u_xlat16_5;
    float u_xlat6;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float3 u_xlat9;
    half3 u_xlat16_9;
    float u_xlat10;
    float u_xlat11;
    float u_xlat12;
    half u_xlat16_12;
    half u_xlat16_13;
    float u_xlat17;
    u_xlat0.x = FGlobals._MainTex_TexelSize.x;
    u_xlat0.y = 0.0;
    u_xlat1 = fma((-u_xlat0.xyxy), float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xyxy, float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_3.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_13 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_13 = half(2.0) / u_xlat16_13;
    u_xlat9.xy = float2(u_xlat16_3.xy) * float2(u_xlat16_13);
    u_xlat9.z = float(u_xlat16_13) + -1.0;
    u_xlat3.xyz = u_xlat9.xyz * float3(1.0, 1.0, -1.0);
    output.SV_Target0.yzw = fma(u_xlat9.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
    u_xlat7 = dot(u_xlat3.xyz, float3(u_xlat16_7.xyz));
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat7, -2.0, 3.0);
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat7 = u_xlat7 * 0.31621623;
    u_xlat2 = u_xlat7 * float(u_xlat16_2.x);
    u_xlat16_12 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).x;
    u_xlat2 = fma(float(u_xlat16_12), 0.227027029, u_xlat2);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat12 = dot(u_xlat3.xyz, float3(u_xlat16_9.xyz));
    u_xlat12 = u_xlat12 + -0.800000012;
    u_xlat12 = u_xlat12 * 5.00000048;
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat17 = fma(u_xlat12, -2.0, 3.0);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat17;
    u_xlat17 = u_xlat12 * 0.31621623;
    u_xlat7 = fma(u_xlat12, 0.31621623, u_xlat7);
    u_xlat2 = fma(float(u_xlat16_4.x), u_xlat17, u_xlat2);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6 = dot(u_xlat3.xyz, float3(u_xlat16_6.xyz));
    u_xlat6 = u_xlat6 + -0.800000012;
    u_xlat6 = u_xlat6 * 5.00000048;
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat11 = fma(u_xlat6, -2.0, 3.0);
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat11;
    u_xlat11 = u_xlat6 * 0.0702702701;
    u_xlat6 = fma(u_xlat6, 0.0702702701, u_xlat7);
    u_xlat1.x = fma(float(u_xlat16_1.x), u_xlat11, u_xlat2);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5 = dot(u_xlat3.xyz, float3(u_xlat16_5.xyz));
    u_xlat5 = u_xlat5 + -0.800000012;
    u_xlat5 = u_xlat5 * 5.00000048;
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat10 = fma(u_xlat5, -2.0, 3.0);
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = u_xlat5 * 0.0702702701;
    u_xlat5 = fma(u_xlat5, 0.0702702701, u_xlat6);
    u_xlat5 = u_xlat5 + 0.227027029;
    u_xlat0.x = fma(float(u_xlat16_0.x), u_xlat10, u_xlat1.x);
    output.SV_Target0.x = u_xlat0.x / u_xlat5;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat5;
    half3 u_xlat16_5;
    float u_xlat6;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float3 u_xlat9;
    half3 u_xlat16_9;
    float u_xlat10;
    float u_xlat11;
    float u_xlat12;
    half u_xlat16_12;
    half u_xlat16_13;
    float u_xlat17;
    u_xlat0.x = FGlobals._MainTex_TexelSize.x;
    u_xlat0.y = 0.0;
    u_xlat1 = fma((-u_xlat0.xyxy), float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0 = fma(u_xlat0.xyxy, float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_3.xyz = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_13 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_13 = half(2.0) / u_xlat16_13;
    u_xlat9.xy = float2(u_xlat16_3.xy) * float2(u_xlat16_13);
    u_xlat9.z = float(u_xlat16_13) + -1.0;
    u_xlat3.xyz = u_xlat9.xyz * float3(1.0, 1.0, -1.0);
    output.SV_Target0.yzw = fma(u_xlat9.xyz, float3(0.5, 0.5, -0.5), float3(0.5, 0.5, 0.5));
    u_xlat7 = dot(u_xlat3.xyz, float3(u_xlat16_7.xyz));
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat7, -2.0, 3.0);
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat7 = u_xlat7 * 0.31621623;
    u_xlat2 = u_xlat7 * float(u_xlat16_2.x);
    u_xlat16_12 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).x;
    u_xlat2 = fma(float(u_xlat16_12), 0.227027029, u_xlat2);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat12 = dot(u_xlat3.xyz, float3(u_xlat16_9.xyz));
    u_xlat12 = u_xlat12 + -0.800000012;
    u_xlat12 = u_xlat12 * 5.00000048;
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat17 = fma(u_xlat12, -2.0, 3.0);
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat17;
    u_xlat17 = u_xlat12 * 0.31621623;
    u_xlat7 = fma(u_xlat12, 0.31621623, u_xlat7);
    u_xlat2 = fma(float(u_xlat16_4.x), u_xlat17, u_xlat2);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6 = dot(u_xlat3.xyz, float3(u_xlat16_6.xyz));
    u_xlat6 = u_xlat6 + -0.800000012;
    u_xlat6 = u_xlat6 * 5.00000048;
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat11 = fma(u_xlat6, -2.0, 3.0);
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat11;
    u_xlat11 = u_xlat6 * 0.0702702701;
    u_xlat6 = fma(u_xlat6, 0.0702702701, u_xlat7);
    u_xlat1.x = fma(float(u_xlat16_1.x), u_xlat11, u_xlat2);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat5 = dot(u_xlat3.xyz, float3(u_xlat16_5.xyz));
    u_xlat5 = u_xlat5 + -0.800000012;
    u_xlat5 = u_xlat5 * 5.00000048;
    u_xlat5 = clamp(u_xlat5, 0.0f, 1.0f);
    u_xlat10 = fma(u_xlat5, -2.0, 3.0);
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = u_xlat5 * 0.0702702701;
    u_xlat5 = fma(u_xlat5, 0.0702702701, u_xlat6);
    u_xlat5 = u_xlat5 + 0.227027029;
    u_xlat0.x = fma(float(u_xlat16_0.x), u_xlat10, u_xlat1.x);
    output.SV_Target0.x = u_xlat0.x / u_xlat5;
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
  GpuProgramID 237591
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
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat5;
    float u_xlat6;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float u_xlat8;
    half3 u_xlat16_8;
    float u_xlat12;
    float u_xlat13;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat16_0.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy).xyz;
    u_xlat15 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlatb15 = u_xlat15!=0.0;
    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat0.xyz = fma(float3(u_xlat16_0.xyz), float3(2.0, 2.0, 2.0), float3(u_xlat15));
    u_xlat1.xyz = u_xlat0.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat0.zzz, u_xlat0.xyw);
    u_xlat1.x = FGlobals._MainTex_TexelSize.x;
    u_xlat1.y = 0.0;
    u_xlat2 = fma((-u_xlat1.xyxy), float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat1 = fma(u_xlat1.xyxy, float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_8.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat15 = dot(u_xlat0.xyz, float3(u_xlat16_8.xyz));
    u_xlat15 = u_xlat15 + -0.800000012;
    u_xlat15 = u_xlat15 * 5.00000048;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat8 = fma(u_xlat15, -2.0, 3.0);
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8;
    u_xlat15 = u_xlat15 * 0.31621623;
    u_xlat3 = u_xlat15 * float(u_xlat16_3.x);
    u_xlat16_8.x = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).x;
    u_xlat3 = fma(float(u_xlat16_8.x), 0.227027029, u_xlat3);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_8.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat8 = dot(u_xlat0.xyz, float3(u_xlat16_8.xyz));
    u_xlat8 = u_xlat8 + -0.800000012;
    u_xlat8 = u_xlat8 * 5.00000048;
    u_xlat8 = clamp(u_xlat8, 0.0f, 1.0f);
    u_xlat13 = fma(u_xlat8, -2.0, 3.0);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat13;
    u_xlat13 = u_xlat8 * 0.31621623;
    u_xlat15 = fma(u_xlat8, 0.31621623, u_xlat15);
    u_xlat3 = fma(float(u_xlat16_4.x), u_xlat13, u_xlat3);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat7 = dot(u_xlat0.xyz, float3(u_xlat16_7.xyz));
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat7, -2.0, 3.0);
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * 0.0702702701;
    u_xlat15 = fma(u_xlat7, 0.0702702701, u_xlat15);
    u_xlat2.x = fma(float(u_xlat16_2.x), u_xlat12, u_xlat3);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6 = dot(u_xlat0.xyz, float3(u_xlat16_6.xyz));
    output.SV_Target0.yzw = fma(u_xlat0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.x = u_xlat6 + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat5 = u_xlat0.x * 0.0702702701;
    u_xlat0.x = fma(u_xlat0.x, 0.0702702701, u_xlat15);
    u_xlat0.x = u_xlat0.x + 0.227027029;
    u_xlat5 = fma(float(u_xlat16_1.x), u_xlat5, u_xlat2.x);
    output.SV_Target0.x = u_xlat5 / u_xlat0.x;
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
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat5;
    float u_xlat6;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float u_xlat8;
    half3 u_xlat16_8;
    float u_xlat12;
    float u_xlat13;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat16_0.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy).xyz;
    u_xlat15 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlatb15 = u_xlat15!=0.0;
    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat0.xyz = fma(float3(u_xlat16_0.xyz), float3(2.0, 2.0, 2.0), float3(u_xlat15));
    u_xlat1.xyz = u_xlat0.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat0.zzz, u_xlat0.xyw);
    u_xlat1.x = FGlobals._MainTex_TexelSize.x;
    u_xlat1.y = 0.0;
    u_xlat2 = fma((-u_xlat1.xyxy), float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat1 = fma(u_xlat1.xyxy, float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_8.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat15 = dot(u_xlat0.xyz, float3(u_xlat16_8.xyz));
    u_xlat15 = u_xlat15 + -0.800000012;
    u_xlat15 = u_xlat15 * 5.00000048;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat8 = fma(u_xlat15, -2.0, 3.0);
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8;
    u_xlat15 = u_xlat15 * 0.31621623;
    u_xlat3 = u_xlat15 * float(u_xlat16_3.x);
    u_xlat16_8.x = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).x;
    u_xlat3 = fma(float(u_xlat16_8.x), 0.227027029, u_xlat3);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_8.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat8 = dot(u_xlat0.xyz, float3(u_xlat16_8.xyz));
    u_xlat8 = u_xlat8 + -0.800000012;
    u_xlat8 = u_xlat8 * 5.00000048;
    u_xlat8 = clamp(u_xlat8, 0.0f, 1.0f);
    u_xlat13 = fma(u_xlat8, -2.0, 3.0);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat13;
    u_xlat13 = u_xlat8 * 0.31621623;
    u_xlat15 = fma(u_xlat8, 0.31621623, u_xlat15);
    u_xlat3 = fma(float(u_xlat16_4.x), u_xlat13, u_xlat3);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat7 = dot(u_xlat0.xyz, float3(u_xlat16_7.xyz));
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat7, -2.0, 3.0);
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * 0.0702702701;
    u_xlat15 = fma(u_xlat7, 0.0702702701, u_xlat15);
    u_xlat2.x = fma(float(u_xlat16_2.x), u_xlat12, u_xlat3);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6 = dot(u_xlat0.xyz, float3(u_xlat16_6.xyz));
    output.SV_Target0.yzw = fma(u_xlat0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.x = u_xlat6 + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat5 = u_xlat0.x * 0.0702702701;
    u_xlat0.x = fma(u_xlat0.x, 0.0702702701, u_xlat15);
    u_xlat0.x = u_xlat0.x + 0.227027029;
    u_xlat5 = fma(float(u_xlat16_1.x), u_xlat5, u_xlat2.x);
    output.SV_Target0.x = u_xlat5 / u_xlat0.x;
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
    float4 hlslcc_mtx4x4unity_WorldToCamera[4];
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
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
    sampler sampler_CameraGBufferTexture2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat5;
    float u_xlat6;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float u_xlat8;
    half3 u_xlat16_8;
    float u_xlat12;
    float u_xlat13;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat16_0.xyz = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy).xyz;
    u_xlat15 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlatb15 = u_xlat15!=0.0;
    u_xlat15 = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat0.xyz = fma(float3(u_xlat16_0.xyz), float3(2.0, 2.0, 2.0), float3(u_xlat15));
    u_xlat1.xyz = u_xlat0.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToCamera[2].xyz, u_xlat0.zzz, u_xlat0.xyw);
    u_xlat1.x = FGlobals._MainTex_TexelSize.x;
    u_xlat1.y = 0.0;
    u_xlat2 = fma((-u_xlat1.xyxy), float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat2 = clamp(u_xlat2, 0.0f, 1.0f);
    u_xlat1 = fma(u_xlat1.xyxy, float4(2.76923084, 1.38461542, 6.46153831, 3.23076916), input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat2 = u_xlat2 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_8.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat15 = dot(u_xlat0.xyz, float3(u_xlat16_8.xyz));
    u_xlat15 = u_xlat15 + -0.800000012;
    u_xlat15 = u_xlat15 * 5.00000048;
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat8 = fma(u_xlat15, -2.0, 3.0);
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8;
    u_xlat15 = u_xlat15 * 0.31621623;
    u_xlat3 = u_xlat15 * float(u_xlat16_3.x);
    u_xlat16_8.x = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).x;
    u_xlat3 = fma(float(u_xlat16_8.x), 0.227027029, u_xlat3);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_8.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat8 = dot(u_xlat0.xyz, float3(u_xlat16_8.xyz));
    u_xlat8 = u_xlat8 + -0.800000012;
    u_xlat8 = u_xlat8 * 5.00000048;
    u_xlat8 = clamp(u_xlat8, 0.0f, 1.0f);
    u_xlat13 = fma(u_xlat8, -2.0, 3.0);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat8 * u_xlat13;
    u_xlat13 = u_xlat8 * 0.31621623;
    u_xlat15 = fma(u_xlat8, 0.31621623, u_xlat15);
    u_xlat3 = fma(float(u_xlat16_4.x), u_xlat13, u_xlat3);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat7 = dot(u_xlat0.xyz, float3(u_xlat16_7.xyz));
    u_xlat7 = u_xlat7 + -0.800000012;
    u_xlat7 = u_xlat7 * 5.00000048;
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat7, -2.0, 3.0);
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * 0.0702702701;
    u_xlat15 = fma(u_xlat7, 0.0702702701, u_xlat15);
    u_xlat2.x = fma(float(u_xlat16_2.x), u_xlat12, u_xlat3);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat6 = dot(u_xlat0.xyz, float3(u_xlat16_6.xyz));
    output.SV_Target0.yzw = fma(u_xlat0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat0.x = u_xlat6 + -0.800000012;
    u_xlat0.x = u_xlat0.x * 5.00000048;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat5 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat5 = u_xlat0.x * 0.0702702701;
    u_xlat0.x = fma(u_xlat0.x, 0.0702702701, u_xlat15);
    u_xlat0.x = u_xlat0.x + 0.227027029;
    u_xlat5 = fma(float(u_xlat16_1.x), u_xlat5, u_xlat2.x);
    output.SV_Target0.x = u_xlat5 / u_xlat0.x;
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
  GpuProgramID 274007
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
    float4 _AOParams;
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
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    half u_xlat16_11;
    half u_xlat16_12;
    half u_xlat16_17;
    u_xlat0.x = FGlobals._MainTex_TexelSize.y / FGlobals._AOParams.z;
    u_xlat0.y = float(1.38461542);
    u_xlat0.z = float(3.23076916);
    u_xlat1 = fma(float4(-0.0, -2.76923084, -0.0, -6.46153831), u_xlat0.yxzx, input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0 = fma(float4(0.0, 2.76923084, 0.0, 6.46153831), u_xlat0.yxzx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_8.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * half(0.31621623);
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
    u_xlat16_2.x = fma(u_xlat16_3.x, half(0.227027029), u_xlat16_2.x);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_12 = dot(u_xlat16_8.xyz, u_xlat16_9.xyz);
    u_xlat16_12 = u_xlat16_12 + half(-0.800000012);
    u_xlat16_12 = u_xlat16_12 * half(5.00000048);
    u_xlat16_12 = clamp(u_xlat16_12, 0.0h, 1.0h);
    u_xlat16_17 = fma(u_xlat16_12, half(-2.0), half(3.0));
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_12 * half(0.31621623);
    u_xlat16_7.x = fma(u_xlat16_12, half(0.31621623), u_xlat16_7.x);
    u_xlat16_2.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_2.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_6.x = dot(u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = u_xlat16_6.x + half(-0.800000012);
    u_xlat16_6.x = u_xlat16_6.x * half(5.00000048);
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0h, 1.0h);
    u_xlat16_11 = fma(u_xlat16_6.x, half(-2.0), half(3.0));
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6.x * half(0.0702702701);
    u_xlat16_6.x = fma(u_xlat16_6.x, half(0.0702702701), u_xlat16_7.x);
    u_xlat16_1.x = fma(u_xlat16_1.x, u_xlat16_11, u_xlat16_2.x);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_8.xyz, u_xlat16_5.xyz);
    output.SV_Target0.yzw = fma(float3(u_xlat16_8.xyz), float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * half(0.0702702701);
    u_xlat16_5.x = fma(u_xlat16_5.x, half(0.0702702701), u_xlat16_6.x);
    u_xlat16_5.x = u_xlat16_5.x + half(0.227027029);
    u_xlat16_0.x = fma(u_xlat16_0.x, u_xlat16_10, u_xlat16_1.x);
    output.SV_Target0.x = float(u_xlat16_0.x) / float(u_xlat16_5.x);
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
    float4 _AOParams;
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
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    half u_xlat16_11;
    half u_xlat16_12;
    half u_xlat16_17;
    u_xlat0.x = FGlobals._MainTex_TexelSize.y / FGlobals._AOParams.z;
    u_xlat0.y = float(1.38461542);
    u_xlat0.z = float(3.23076916);
    u_xlat1 = fma(float4(-0.0, -2.76923084, -0.0, -6.46153831), u_xlat0.yxzx, input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0 = fma(float4(0.0, 2.76923084, 0.0, 6.46153831), u_xlat0.yxzx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_8.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * half(0.31621623);
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
    u_xlat16_2.x = fma(u_xlat16_3.x, half(0.227027029), u_xlat16_2.x);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_12 = dot(u_xlat16_8.xyz, u_xlat16_9.xyz);
    u_xlat16_12 = u_xlat16_12 + half(-0.800000012);
    u_xlat16_12 = u_xlat16_12 * half(5.00000048);
    u_xlat16_12 = clamp(u_xlat16_12, 0.0h, 1.0h);
    u_xlat16_17 = fma(u_xlat16_12, half(-2.0), half(3.0));
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_12 * half(0.31621623);
    u_xlat16_7.x = fma(u_xlat16_12, half(0.31621623), u_xlat16_7.x);
    u_xlat16_2.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_2.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_6.x = dot(u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = u_xlat16_6.x + half(-0.800000012);
    u_xlat16_6.x = u_xlat16_6.x * half(5.00000048);
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0h, 1.0h);
    u_xlat16_11 = fma(u_xlat16_6.x, half(-2.0), half(3.0));
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6.x * half(0.0702702701);
    u_xlat16_6.x = fma(u_xlat16_6.x, half(0.0702702701), u_xlat16_7.x);
    u_xlat16_1.x = fma(u_xlat16_1.x, u_xlat16_11, u_xlat16_2.x);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_8.xyz, u_xlat16_5.xyz);
    output.SV_Target0.yzw = fma(float3(u_xlat16_8.xyz), float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * half(0.0702702701);
    u_xlat16_5.x = fma(u_xlat16_5.x, half(0.0702702701), u_xlat16_6.x);
    u_xlat16_5.x = u_xlat16_5.x + half(0.227027029);
    u_xlat16_0.x = fma(u_xlat16_0.x, u_xlat16_10, u_xlat16_1.x);
    output.SV_Target0.x = float(u_xlat16_0.x) / float(u_xlat16_5.x);
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
    float4 _AOParams;
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
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    half u_xlat16_11;
    half u_xlat16_12;
    half u_xlat16_17;
    u_xlat0.x = FGlobals._MainTex_TexelSize.y / FGlobals._AOParams.z;
    u_xlat0.y = float(1.38461542);
    u_xlat0.z = float(3.23076916);
    u_xlat1 = fma(float4(-0.0, -2.76923084, -0.0, -6.46153831), u_xlat0.yxzx, input.TEXCOORD0.xyxy);
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0 = fma(float4(0.0, 2.76923084, 0.0, 6.46153831), u_xlat0.yxzx, input.TEXCOORD0.xyxy);
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat0 = u_xlat0 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat1 = u_xlat1 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_8.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = u_xlat16_7.x * half(0.31621623);
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
    u_xlat16_2.x = fma(u_xlat16_3.x, half(0.227027029), u_xlat16_2.x);
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw);
    u_xlat16_9.xyz = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_12 = dot(u_xlat16_8.xyz, u_xlat16_9.xyz);
    u_xlat16_12 = u_xlat16_12 + half(-0.800000012);
    u_xlat16_12 = u_xlat16_12 * half(5.00000048);
    u_xlat16_12 = clamp(u_xlat16_12, 0.0h, 1.0h);
    u_xlat16_17 = fma(u_xlat16_12, half(-2.0), half(3.0));
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_12 * half(0.31621623);
    u_xlat16_7.x = fma(u_xlat16_12, half(0.31621623), u_xlat16_7.x);
    u_xlat16_2.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_2.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_6.x = dot(u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = u_xlat16_6.x + half(-0.800000012);
    u_xlat16_6.x = u_xlat16_6.x * half(5.00000048);
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0h, 1.0h);
    u_xlat16_11 = fma(u_xlat16_6.x, half(-2.0), half(3.0));
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6.x * half(0.0702702701);
    u_xlat16_6.x = fma(u_xlat16_6.x, half(0.0702702701), u_xlat16_7.x);
    u_xlat16_1.x = fma(u_xlat16_1.x, u_xlat16_11, u_xlat16_2.x);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_8.xyz, u_xlat16_5.xyz);
    output.SV_Target0.yzw = fma(float3(u_xlat16_8.xyz), float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * half(0.0702702701);
    u_xlat16_5.x = fma(u_xlat16_5.x, half(0.0702702701), u_xlat16_6.x);
    u_xlat16_5.x = u_xlat16_5.x + half(0.227027029);
    u_xlat16_0.x = fma(u_xlat16_0.x, u_xlat16_10, u_xlat16_1.x);
    output.SV_Target0.x = float(u_xlat16_0.x) / float(u_xlat16_5.x);
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
  GpuProgramID 385735
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
    float4 _AOParams;
    float3 _AOColor;
    float4 _SAOcclusionTexture_TexelSize;
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
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xy = FGlobals._SAOcclusionTexture_TexelSize.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_7.x, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0.xxx) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = float(u_xlat16_0.x);
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
    float4 _AOParams;
    float3 _AOColor;
    float4 _SAOcclusionTexture_TexelSize;
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
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xy = FGlobals._SAOcclusionTexture_TexelSize.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_7.x, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0.xxx) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = float(u_xlat16_0.x);
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
    float4 _AOParams;
    float3 _AOColor;
    float4 _SAOcclusionTexture_TexelSize;
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
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xy = FGlobals._SAOcclusionTexture_TexelSize.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_7.x, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.xyz = float3(u_xlat16_0.xxx) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.w = float(u_xlat16_0.x);
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
  GpuProgramID 455057
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
    float _RenderViewportScaleFactor;
    float4 _AOParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat1.xy = FGlobals._ScreenParams.zw + float2(-1.0, -1.0);
    u_xlat1.xy = u_xlat1.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_7.x, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    output.SV_Target0.w = float(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target1.xyz = float3(u_xlat16_0.xxx) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.xyz = float3(0.0, 0.0, 0.0);
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
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat1.xy = FGlobals._ScreenParams.zw + float2(-1.0, -1.0);
    u_xlat1.xy = u_xlat1.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_7.x, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    output.SV_Target0.w = float(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target1.xyz = float3(u_xlat16_0.xxx) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.xyz = float3(0.0, 0.0, 0.0);
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
    float4 _ScreenParams;
    float _RenderViewportScaleFactor;
    float4 _AOParams;
    float3 _AOColor;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat1.xy = FGlobals._ScreenParams.zw + float2(-1.0, -1.0);
    u_xlat1.xy = u_xlat1.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_7.x, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    output.SV_Target0.w = float(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target1.xyz = float3(u_xlat16_0.xxx) * FGlobals._AOColor.xyzx.xyz;
    output.SV_Target0.xyz = float3(0.0, 0.0, 0.0);
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
  GpuProgramID 502871
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
    float4 _AOParams;
    float4 _SAOcclusionTexture_TexelSize;
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
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xy = FGlobals._SAOcclusionTexture_TexelSize.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = fma(u_xlat16_12, u_xlat16_7.x, half(1.0));
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.xyz = (-float3(u_xlat16_0.xxx)) + float3(1.0, 1.0, 1.0);
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
    float4 _AOParams;
    float4 _SAOcclusionTexture_TexelSize;
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
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xy = FGlobals._SAOcclusionTexture_TexelSize.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = fma(u_xlat16_12, u_xlat16_7.x, half(1.0));
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.xyz = (-float3(u_xlat16_0.xxx)) + float3(1.0, 1.0, 1.0);
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
    float4 _AOParams;
    float4 _SAOcclusionTexture_TexelSize;
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
    sampler sampler_SAOcclusionTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _SAOcclusionTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float2 u_xlat2;
    half4 u_xlat16_2;
    float4 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_10;
    half u_xlat16_12;
    half u_xlat16_15;
    half u_xlat16_17;
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.xy = u_xlat0.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_0 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat0.xy);
    u_xlat16_5.xyz = fma(u_xlat16_0.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.xy = FGlobals._SAOcclusionTexture_TexelSize.xy / FGlobals._AOParams.zz;
    u_xlat2.xy = (-u_xlat1.xy) + input.TEXCOORD0.xy;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0f, 1.0f);
    u_xlat2.xy = u_xlat2.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_2 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat2.xy);
    u_xlat16_7.xyz = fma(u_xlat16_2.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.x = fma(u_xlat16_12, u_xlat16_7.x, half(1.0));
    u_xlat16_0.x = fma(u_xlat16_2.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat1.zw = (-u_xlat1.yx);
    u_xlat3 = u_xlat1.xzwy + input.TEXCOORD0.xyxy;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.xy = u_xlat1.xy * float2(FGlobals._RenderViewportScaleFactor);
    u_xlat16_1 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat1.xy);
    u_xlat3 = u_xlat3 * float4(FGlobals._RenderViewportScaleFactor);
    u_xlat16_4 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.xy);
    u_xlat16_3 = _SAOcclusionTexture.sample(sampler_SAOcclusionTexture, u_xlat3.zw);
    u_xlat16_2.xzw = fma(u_xlat16_4.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_2.x = dot(u_xlat16_5.xyz, u_xlat16_2.xzw);
    u_xlat16_2.x = u_xlat16_2.x + half(-0.800000012);
    u_xlat16_2.x = u_xlat16_2.x * half(5.00000048);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_2.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_2.x, u_xlat16_7.x);
    u_xlat16_0.x = fma(u_xlat16_4.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_7.xyz = fma(u_xlat16_3.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_7.x = dot(u_xlat16_5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_7.x + half(-0.800000012);
    u_xlat16_7.x = u_xlat16_7.x * half(5.00000048);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat16_12 = fma(u_xlat16_7.x, half(-2.0), half(3.0));
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_17 = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_2.x = fma(u_xlat16_12, u_xlat16_7.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_3.x, u_xlat16_17, u_xlat16_0.x);
    u_xlat16_6.xyz = fma(u_xlat16_1.yzw, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_6.xyz);
    u_xlat16_5.x = u_xlat16_5.x + half(-0.800000012);
    u_xlat16_5.x = u_xlat16_5.x * half(5.00000048);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_10 = fma(u_xlat16_5.x, half(-2.0), half(3.0));
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = fma(u_xlat16_10, u_xlat16_5.x, u_xlat16_2.x);
    u_xlat16_0.x = fma(u_xlat16_1.x, u_xlat16_15, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_5.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0h, 1.0h);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.xyz = (-float3(u_xlat16_0.xxx)) + float3(1.0, 1.0, 1.0);
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
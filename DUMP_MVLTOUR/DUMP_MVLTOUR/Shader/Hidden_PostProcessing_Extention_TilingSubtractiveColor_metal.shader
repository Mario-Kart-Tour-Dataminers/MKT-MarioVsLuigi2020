//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/TilingSubtractiveColor" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 61107
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
    float _TileScale;
    float _TileScaleParGrid;
    float _GridFineness;
    float _ChannelParColor;
    float _MaxGridAlpha;
    float _FinalColorScale;
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
    float4 u_xlat0;
    half4 u_xlat16_0;
    float u_xlat1;
    float u_xlat3;
    float2 u_xlat4;
    u_xlat0.x = FGlobals._MainTex_TexelSize.x / FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * FGlobals._TileScale;
    u_xlat0.y = FGlobals._TileScale;
    u_xlat4.xy = input.TEXCOORD1.xy / u_xlat0.xy;
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + float2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0 * half4(256.0, 256.0, 256.0, 256.0);
    u_xlat1 = FGlobals._ChannelParColor * 0.00390625;
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat1);
    u_xlat0 = floor(u_xlat0);
    u_xlat1 = float(1.0) / FGlobals._ChannelParColor;
    u_xlat0 = u_xlat0 * float4(u_xlat1);
    u_xlat0 = u_xlat0 * float4(FGlobals._FinalColorScale);
    u_xlat1 = FGlobals._TileScaleParGrid * FGlobals._TileScale;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = fma(input.TEXCOORD1.y, u_xlat1, 0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 + -0.5;
    u_xlat1 = abs(u_xlat1) * FGlobals._GridFineness;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat3 = (-FGlobals._MaxGridAlpha) + 1.0;
    u_xlat1 = max(u_xlat1, u_xlat3);
    u_xlat3 = (-u_xlat1) + 1.0;
    output.SV_Target0 = fma(u_xlat0, float4(u_xlat1), float4(u_xlat3));
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
    float _TileScale;
    float _TileScaleParGrid;
    float _GridFineness;
    float _ChannelParColor;
    float _MaxGridAlpha;
    float _FinalColorScale;
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
    float4 u_xlat0;
    half4 u_xlat16_0;
    float u_xlat1;
    float u_xlat3;
    float2 u_xlat4;
    u_xlat0.x = FGlobals._MainTex_TexelSize.x / FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * FGlobals._TileScale;
    u_xlat0.y = FGlobals._TileScale;
    u_xlat4.xy = input.TEXCOORD1.xy / u_xlat0.xy;
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + float2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0 * half4(256.0, 256.0, 256.0, 256.0);
    u_xlat1 = FGlobals._ChannelParColor * 0.00390625;
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat1);
    u_xlat0 = floor(u_xlat0);
    u_xlat1 = float(1.0) / FGlobals._ChannelParColor;
    u_xlat0 = u_xlat0 * float4(u_xlat1);
    u_xlat0 = u_xlat0 * float4(FGlobals._FinalColorScale);
    u_xlat1 = FGlobals._TileScaleParGrid * FGlobals._TileScale;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = fma(input.TEXCOORD1.y, u_xlat1, 0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 + -0.5;
    u_xlat1 = abs(u_xlat1) * FGlobals._GridFineness;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat3 = (-FGlobals._MaxGridAlpha) + 1.0;
    u_xlat1 = max(u_xlat1, u_xlat3);
    u_xlat3 = (-u_xlat1) + 1.0;
    output.SV_Target0 = fma(u_xlat0, float4(u_xlat1), float4(u_xlat3));
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
    float _TileScale;
    float _TileScaleParGrid;
    float _GridFineness;
    float _ChannelParColor;
    float _MaxGridAlpha;
    float _FinalColorScale;
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
    float4 u_xlat0;
    half4 u_xlat16_0;
    float u_xlat1;
    float u_xlat3;
    float2 u_xlat4;
    u_xlat0.x = FGlobals._MainTex_TexelSize.x / FGlobals._MainTex_TexelSize.y;
    u_xlat0.x = u_xlat0.x * FGlobals._TileScale;
    u_xlat0.y = FGlobals._TileScale;
    u_xlat4.xy = input.TEXCOORD1.xy / u_xlat0.xy;
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + float2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0 * half4(256.0, 256.0, 256.0, 256.0);
    u_xlat1 = FGlobals._ChannelParColor * 0.00390625;
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat1);
    u_xlat0 = floor(u_xlat0);
    u_xlat1 = float(1.0) / FGlobals._ChannelParColor;
    u_xlat0 = u_xlat0 * float4(u_xlat1);
    u_xlat0 = u_xlat0 * float4(FGlobals._FinalColorScale);
    u_xlat1 = FGlobals._TileScaleParGrid * FGlobals._TileScale;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = fma(input.TEXCOORD1.y, u_xlat1, 0.5);
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 + -0.5;
    u_xlat1 = abs(u_xlat1) * FGlobals._GridFineness;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat3 = (-FGlobals._MaxGridAlpha) + 1.0;
    u_xlat1 = max(u_xlat1, u_xlat3);
    u_xlat3 = (-u_xlat1) + 1.0;
    output.SV_Target0 = fma(u_xlat0, float4(u_xlat1), float4(u_xlat3));
    return output;
}
"
}
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Debug/Waveform" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 48263
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
    float3 _Params;
};

struct _WaveformBuffer_Type
{
    uint value[4];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    const device _WaveformBuffer_Type *_WaveformBuffer [[ buffer(1) ]],
    float4 mtl_FragCoord [[ position ]])
{
    Mtl_FragmentOut output;
    _WaveformBuffer = reinterpret_cast<const device _WaveformBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_WaveformBuffer) + 1);
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float4 u_xlat0;
    uint3 u_xlatu0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlat0.xy = float2(u_xlatu0.xy);
    u_xlat0.x = fma(u_xlat0.x, FGlobals._Params.xyzx.y, u_xlat0.y);
    u_xlatu0.x = uint(u_xlat0.x);
    u_xlatu0.xyz = uint3(_WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 0], _WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 1], _WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 2]);
    u_xlat0.xyz = float3(u_xlatu0.xyz);
    u_xlat1.xyz = u_xlat0.yyy * float3(0.0199999996, 1.10000002, 0.0500000007);
    u_xlat0.xyw = fma(u_xlat0.xxx, float3(1.39999998, 0.0299999993, 0.0199999996), u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat0.zzz, float3(0.0, 0.25, 1.5), u_xlat0.xyw);
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Params.xyzx.zzz, float3(-0.00400000019, -0.00400000019, -0.00400000019));
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(6.19999981, 6.19999981, 6.19999981), float3(0.5, 0.5, 0.5));
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(6.19999981, 6.19999981, 6.19999981), float3(1.70000005, 1.70000005, 1.70000005));
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(0.0599999987, 0.0599999987, 0.0599999987));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    output.SV_Target0.xyz = min(u_xlat0.xyz, float3(1.0, 1.0, 1.0));
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
    float3 _Params;
};

struct _WaveformBuffer_Type
{
    uint value[4];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    const device _WaveformBuffer_Type *_WaveformBuffer [[ buffer(1) ]],
    float4 mtl_FragCoord [[ position ]])
{
    Mtl_FragmentOut output;
    _WaveformBuffer = reinterpret_cast<const device _WaveformBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_WaveformBuffer) + 1);
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float4 u_xlat0;
    uint3 u_xlatu0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlat0.xy = float2(u_xlatu0.xy);
    u_xlat0.x = fma(u_xlat0.x, FGlobals._Params.xyzx.y, u_xlat0.y);
    u_xlatu0.x = uint(u_xlat0.x);
    u_xlatu0.xyz = uint3(_WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 0], _WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 1], _WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 2]);
    u_xlat0.xyz = float3(u_xlatu0.xyz);
    u_xlat1.xyz = u_xlat0.yyy * float3(0.0199999996, 1.10000002, 0.0500000007);
    u_xlat0.xyw = fma(u_xlat0.xxx, float3(1.39999998, 0.0299999993, 0.0199999996), u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat0.zzz, float3(0.0, 0.25, 1.5), u_xlat0.xyw);
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Params.xyzx.zzz, float3(-0.00400000019, -0.00400000019, -0.00400000019));
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(6.19999981, 6.19999981, 6.19999981), float3(0.5, 0.5, 0.5));
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(6.19999981, 6.19999981, 6.19999981), float3(1.70000005, 1.70000005, 1.70000005));
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(0.0599999987, 0.0599999987, 0.0599999987));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    output.SV_Target0.xyz = min(u_xlat0.xyz, float3(1.0, 1.0, 1.0));
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
    float3 _Params;
};

struct _WaveformBuffer_Type
{
    uint value[4];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    const device _WaveformBuffer_Type *_WaveformBuffer [[ buffer(1) ]],
    float4 mtl_FragCoord [[ position ]])
{
    Mtl_FragmentOut output;
    _WaveformBuffer = reinterpret_cast<const device _WaveformBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_WaveformBuffer) + 1);
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float4 u_xlat0;
    uint3 u_xlatu0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlat0.xy = float2(u_xlatu0.xy);
    u_xlat0.x = fma(u_xlat0.x, FGlobals._Params.xyzx.y, u_xlat0.y);
    u_xlatu0.x = uint(u_xlat0.x);
    u_xlatu0.xyz = uint3(_WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 0], _WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 1], _WaveformBuffer[u_xlatu0.x].value[(0x0 >> 2) + 2]);
    u_xlat0.xyz = float3(u_xlatu0.xyz);
    u_xlat1.xyz = u_xlat0.yyy * float3(0.0199999996, 1.10000002, 0.0500000007);
    u_xlat0.xyw = fma(u_xlat0.xxx, float3(1.39999998, 0.0299999993, 0.0199999996), u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat0.zzz, float3(0.0, 0.25, 1.5), u_xlat0.xyw);
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Params.xyzx.zzz, float3(-0.00400000019, -0.00400000019, -0.00400000019));
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(6.19999981, 6.19999981, 6.19999981), float3(0.5, 0.5, 0.5));
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(6.19999981, 6.19999981, 6.19999981), float3(1.70000005, 1.70000005, 1.70000005));
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(0.0599999987, 0.0599999987, 0.0599999987));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    output.SV_Target0.xyz = min(u_xlat0.xyz, float3(1.0, 1.0, 1.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
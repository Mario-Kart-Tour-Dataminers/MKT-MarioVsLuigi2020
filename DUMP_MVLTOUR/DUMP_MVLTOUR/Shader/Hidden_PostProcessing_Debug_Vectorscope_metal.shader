//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Debug/Vectorscope" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 9092
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

struct _VectorscopeBuffer_Type
{
    uint value[1];
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
    const device _VectorscopeBuffer_Type *_VectorscopeBuffer [[ buffer(1) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    _VectorscopeBuffer = reinterpret_cast<const device _VectorscopeBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_VectorscopeBuffer) + 1);
    float4 u_xlat0;
    float3 u_xlat1;
    float2 u_xlat4;
    uint2 u_xlatu4;
    float u_xlat6;
    u_xlat0 = fma(input.TEXCOORD0.xyxy, float4(-1.0, 1.0, -1.0, 1.0), float4(0.5, -0.5, 1.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * FGlobals._Params.xyzx.xy;
    u_xlatu4.xy = uint2(u_xlat4.xy);
    u_xlat4.xy = float2(u_xlatu4.xy);
    u_xlat4.x = fma(u_xlat4.y, FGlobals._Params.xyzx.x, u_xlat4.x);
    u_xlatu4.x = uint(u_xlat4.x);
    u_xlatu4.x = _VectorscopeBuffer[u_xlatu4.x].value[(0x0 >> 2) + 0];
    u_xlat4.x = float(u_xlatu4.x);
    u_xlat4.x = fma(u_xlat4.x, FGlobals._Params.xyzx.z, -0.00400000019);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat1.xy = fma(u_xlat4.xx, float2(6.19999981, 6.19999981), float2(0.5, 1.70000005));
    u_xlat6 = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = fma(u_xlat4.x, u_xlat1.y, 0.0599999987);
    u_xlat4.x = u_xlat6 / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = fma((-u_xlat0.x), 0.344000012, 0.5);
    u_xlat1.y = fma((-u_xlat0.y), 0.713999987, u_xlat0.x);
    u_xlat1.xz = fma(input.TEXCOORD0.yx, float2(1.403, 1.773), float2(-0.201499999, -0.386500001));
    output.SV_Target0.xyz = fma(u_xlat4.xxx, (-u_xlat1.xyz), u_xlat1.xyz);
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

struct _VectorscopeBuffer_Type
{
    uint value[1];
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
    const device _VectorscopeBuffer_Type *_VectorscopeBuffer [[ buffer(1) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    _VectorscopeBuffer = reinterpret_cast<const device _VectorscopeBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_VectorscopeBuffer) + 1);
    float4 u_xlat0;
    float3 u_xlat1;
    float2 u_xlat4;
    uint2 u_xlatu4;
    float u_xlat6;
    u_xlat0 = fma(input.TEXCOORD0.xyxy, float4(-1.0, 1.0, -1.0, 1.0), float4(0.5, -0.5, 1.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * FGlobals._Params.xyzx.xy;
    u_xlatu4.xy = uint2(u_xlat4.xy);
    u_xlat4.xy = float2(u_xlatu4.xy);
    u_xlat4.x = fma(u_xlat4.y, FGlobals._Params.xyzx.x, u_xlat4.x);
    u_xlatu4.x = uint(u_xlat4.x);
    u_xlatu4.x = _VectorscopeBuffer[u_xlatu4.x].value[(0x0 >> 2) + 0];
    u_xlat4.x = float(u_xlatu4.x);
    u_xlat4.x = fma(u_xlat4.x, FGlobals._Params.xyzx.z, -0.00400000019);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat1.xy = fma(u_xlat4.xx, float2(6.19999981, 6.19999981), float2(0.5, 1.70000005));
    u_xlat6 = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = fma(u_xlat4.x, u_xlat1.y, 0.0599999987);
    u_xlat4.x = u_xlat6 / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = fma((-u_xlat0.x), 0.344000012, 0.5);
    u_xlat1.y = fma((-u_xlat0.y), 0.713999987, u_xlat0.x);
    u_xlat1.xz = fma(input.TEXCOORD0.yx, float2(1.403, 1.773), float2(-0.201499999, -0.386500001));
    output.SV_Target0.xyz = fma(u_xlat4.xxx, (-u_xlat1.xyz), u_xlat1.xyz);
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

struct _VectorscopeBuffer_Type
{
    uint value[1];
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
    const device _VectorscopeBuffer_Type *_VectorscopeBuffer [[ buffer(1) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    _VectorscopeBuffer = reinterpret_cast<const device _VectorscopeBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_VectorscopeBuffer) + 1);
    float4 u_xlat0;
    float3 u_xlat1;
    float2 u_xlat4;
    uint2 u_xlatu4;
    float u_xlat6;
    u_xlat0 = fma(input.TEXCOORD0.xyxy, float4(-1.0, 1.0, -1.0, 1.0), float4(0.5, -0.5, 1.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * FGlobals._Params.xyzx.xy;
    u_xlatu4.xy = uint2(u_xlat4.xy);
    u_xlat4.xy = float2(u_xlatu4.xy);
    u_xlat4.x = fma(u_xlat4.y, FGlobals._Params.xyzx.x, u_xlat4.x);
    u_xlatu4.x = uint(u_xlat4.x);
    u_xlatu4.x = _VectorscopeBuffer[u_xlatu4.x].value[(0x0 >> 2) + 0];
    u_xlat4.x = float(u_xlatu4.x);
    u_xlat4.x = fma(u_xlat4.x, FGlobals._Params.xyzx.z, -0.00400000019);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat1.xy = fma(u_xlat4.xx, float2(6.19999981, 6.19999981), float2(0.5, 1.70000005));
    u_xlat6 = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = fma(u_xlat4.x, u_xlat1.y, 0.0599999987);
    u_xlat4.x = u_xlat6 / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = fma((-u_xlat0.x), 0.344000012, 0.5);
    u_xlat1.y = fma((-u_xlat0.y), 0.713999987, u_xlat0.x);
    u_xlat1.xz = fma(input.TEXCOORD0.yx, float2(1.403, 1.773), float2(-0.201499999, -0.386500001));
    output.SV_Target0.xyz = fma(u_xlat4.xxx, (-u_xlat1.xyz), u_xlat1.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
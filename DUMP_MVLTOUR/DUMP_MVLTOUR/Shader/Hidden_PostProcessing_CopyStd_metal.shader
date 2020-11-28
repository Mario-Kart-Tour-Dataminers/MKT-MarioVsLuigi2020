//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/CopyStd" {
Properties {
_MainTex ("", 2D) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 4475
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
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = fma(input.TEXCOORD0.xy, float2(1.0, -1.0), float2(0.0, 1.0));
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = fma(input.TEXCOORD0.xy, float2(1.0, -1.0), float2(0.0, 1.0));
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = fma(input.TEXCOORD0.xy, float2(1.0, -1.0), float2(0.0, 1.0));
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
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
  GpuProgramID 128253
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
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = fma(input.TEXCOORD0.xy, float2(1.0, -1.0), float2(0.0, 1.0));
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = fma(input.TEXCOORD0.xy, float2(1.0, -1.0), float2(0.0, 1.0));
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = fma(input.TEXCOORD0.xy, float2(1.0, -1.0), float2(0.0, 1.0));
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
    u_xlatb1 = (u_xlat0<float4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = (float4(0.0, 0.0, 0.0, 0.0)<u_xlat0);
    u_xlati1 = int4((uint4(u_xlatb1) * 0xffffffffu) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb2 = (u_xlat0==float4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = int4(uint4(u_xlati1) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb1 = (u_xlati1==int4(0x0, 0x0, 0x0, 0x0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    output.SV_Target0 = (u_xlatb1.x) ? float4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
    u_xlatb1 = (u_xlat0<float4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = (float4(0.0, 0.0, 0.0, 0.0)<u_xlat0);
    u_xlati1 = int4((uint4(u_xlatb1) * 0xffffffffu) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb2 = (u_xlat0==float4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = int4(uint4(u_xlati1) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb1 = (u_xlati1==int4(0x0, 0x0, 0x0, 0x0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    output.SV_Target0 = (u_xlatb1.x) ? float4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
    u_xlatb1 = (u_xlat0<float4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = (float4(0.0, 0.0, 0.0, 0.0)<u_xlat0);
    u_xlati1 = int4((uint4(u_xlatb1) * 0xffffffffu) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb2 = (u_xlat0==float4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = int4(uint4(u_xlati1) | (uint4(u_xlatb2) * 0xffffffffu));
    u_xlatb1 = (u_xlati1==int4(0x0, 0x0, 0x0, 0x0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    output.SV_Target0 = (u_xlatb1.x) ? float4(0.0, 0.0, 0.0, 0.0) : u_xlat0;
    return output;
}
"
}
}
}
}
}
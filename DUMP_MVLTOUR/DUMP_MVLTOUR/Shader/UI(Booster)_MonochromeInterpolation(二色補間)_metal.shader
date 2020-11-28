//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI(Booster)/MonochromeInterpolation(二色補間)" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ColorMin ("Color Min", Color) = (0,0,0,0)
_ColorMax ("Color Max", Color) = (1,1,1,1)
[KeywordEnum(FALSE,TRUE)] _ETC1 ("ETC1", Float) = 0
_Stencil ("Stencil ID", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 25661
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "_ETC1_FALSE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = input.POSITION0;
    output.COLOR0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_ETC1_FALSE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = input.POSITION0;
    output.COLOR0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_ETC1_FALSE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = input.POSITION0;
    output.COLOR0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_ETC1_TRUE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = input.POSITION0;
    output.COLOR0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_ETC1_TRUE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = input.POSITION0;
    output.COLOR0 = input.COLOR0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_ETC1_TRUE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.TEXCOORD0.xy = input.TEXCOORD0.xy;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = input.POSITION0;
    output.COLOR0 = input.COLOR0;
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal hw_tier00 " {
Keywords { "_ETC1_FALSE" }
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
    half4 _ColorMin;
    half4 _ColorMax;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat3;
    half u_xlat16_3;
    float u_xlat6;
    u_xlatb0.xy = (input.TEXCOORD4.xy>=FGlobals._ClipRect.xy);
    u_xlatb0.zw = (FGlobals._ClipRect.zw>=input.TEXCOORD4.xy);
    u_xlat0 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 1.0, 1.0), bool4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * half(0.333333343);
    u_xlat16_2 = (-FGlobals._ColorMin) + FGlobals._ColorMax;
    u_xlat2 = fma(float4(u_xlat16_3), float4(u_xlat16_2), float4(FGlobals._ColorMin));
    u_xlat3 = float(u_xlat16_1.w) * u_xlat2.w;
    u_xlat3 = u_xlat3 * float(input.COLOR0.w);
    u_xlat6 = fma(u_xlat3, u_xlat0.x, -0.00100000005);
    u_xlat2.w = u_xlat0.x * u_xlat3;
    output.SV_Target0 = half4(u_xlat2);
    u_xlatb0.x = u_xlat6<0.0;
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_ETC1_FALSE" }
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
    half4 _ColorMin;
    half4 _ColorMax;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat3;
    half u_xlat16_3;
    float u_xlat6;
    u_xlatb0.xy = (input.TEXCOORD4.xy>=FGlobals._ClipRect.xy);
    u_xlatb0.zw = (FGlobals._ClipRect.zw>=input.TEXCOORD4.xy);
    u_xlat0 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 1.0, 1.0), bool4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * half(0.333333343);
    u_xlat16_2 = (-FGlobals._ColorMin) + FGlobals._ColorMax;
    u_xlat2 = fma(float4(u_xlat16_3), float4(u_xlat16_2), float4(FGlobals._ColorMin));
    u_xlat3 = float(u_xlat16_1.w) * u_xlat2.w;
    u_xlat3 = u_xlat3 * float(input.COLOR0.w);
    u_xlat6 = fma(u_xlat3, u_xlat0.x, -0.00100000005);
    u_xlat2.w = u_xlat0.x * u_xlat3;
    output.SV_Target0 = half4(u_xlat2);
    u_xlatb0.x = u_xlat6<0.0;
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_ETC1_FALSE" }
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
    half4 _ColorMin;
    half4 _ColorMax;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat3;
    half u_xlat16_3;
    float u_xlat6;
    u_xlatb0.xy = (input.TEXCOORD4.xy>=FGlobals._ClipRect.xy);
    u_xlatb0.zw = (FGlobals._ClipRect.zw>=input.TEXCOORD4.xy);
    u_xlat0 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 1.0, 1.0), bool4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.z + u_xlat16_2.x;
    u_xlat16_3 = u_xlat16_2.x * half(0.333333343);
    u_xlat16_2 = (-FGlobals._ColorMin) + FGlobals._ColorMax;
    u_xlat2 = fma(float4(u_xlat16_3), float4(u_xlat16_2), float4(FGlobals._ColorMin));
    u_xlat3 = float(u_xlat16_1.w) * u_xlat2.w;
    u_xlat3 = u_xlat3 * float(input.COLOR0.w);
    u_xlat6 = fma(u_xlat3, u_xlat0.x, -0.00100000005);
    u_xlat2.w = u_xlat0.x * u_xlat3;
    output.SV_Target0 = half4(u_xlat2);
    u_xlatb0.x = u_xlat6<0.0;
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_ETC1_TRUE" }
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
    half4 _ColorMin;
    half4 _ColorMax;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AlphaTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float u_xlat2;
    half3 u_xlat16_2;
    float u_xlat4;
    u_xlatb0.xy = (input.TEXCOORD4.xy>=FGlobals._ClipRect.xy);
    u_xlatb0.zw = (FGlobals._ClipRect.zw>=input.TEXCOORD4.xy);
    u_xlat0 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 1.0, 1.0), bool4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.x * half(0.333333343);
    u_xlat16_1 = (-FGlobals._ColorMin) + FGlobals._ColorMax;
    u_xlat1 = fma(float4(u_xlat16_2.xxxx), float4(u_xlat16_1), float4(FGlobals._ColorMin));
    u_xlat16_2.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat2 = float(u_xlat16_2.x) * u_xlat1.w;
    u_xlat2 = u_xlat2 * float(input.COLOR0.w);
    u_xlat4 = fma(u_xlat2, u_xlat0.x, -0.00100000005);
    u_xlat1.w = u_xlat0.x * u_xlat2;
    output.SV_Target0 = half4(u_xlat1);
    u_xlatb0.x = u_xlat4<0.0;
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_ETC1_TRUE" }
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
    half4 _ColorMin;
    half4 _ColorMax;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AlphaTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float u_xlat2;
    half3 u_xlat16_2;
    float u_xlat4;
    u_xlatb0.xy = (input.TEXCOORD4.xy>=FGlobals._ClipRect.xy);
    u_xlatb0.zw = (FGlobals._ClipRect.zw>=input.TEXCOORD4.xy);
    u_xlat0 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 1.0, 1.0), bool4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.x * half(0.333333343);
    u_xlat16_1 = (-FGlobals._ColorMin) + FGlobals._ColorMax;
    u_xlat1 = fma(float4(u_xlat16_2.xxxx), float4(u_xlat16_1), float4(FGlobals._ColorMin));
    u_xlat16_2.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat2 = float(u_xlat16_2.x) * u_xlat1.w;
    u_xlat2 = u_xlat2 * float(input.COLOR0.w);
    u_xlat4 = fma(u_xlat2, u_xlat0.x, -0.00100000005);
    u_xlat1.w = u_xlat0.x * u_xlat2;
    output.SV_Target0 = half4(u_xlat1);
    u_xlatb0.x = u_xlat4<0.0;
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_ETC1_TRUE" }
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
    half4 _ColorMin;
    half4 _ColorMax;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AlphaTex [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool4 u_xlatb0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float u_xlat2;
    half3 u_xlat16_2;
    float u_xlat4;
    u_xlatb0.xy = (input.TEXCOORD4.xy>=FGlobals._ClipRect.xy);
    u_xlatb0.zw = (FGlobals._ClipRect.zw>=input.TEXCOORD4.xy);
    u_xlat0 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 1.0, 1.0), bool4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_1.x * half(0.333333343);
    u_xlat16_1 = (-FGlobals._ColorMin) + FGlobals._ColorMax;
    u_xlat1 = fma(float4(u_xlat16_2.xxxx), float4(u_xlat16_1), float4(FGlobals._ColorMin));
    u_xlat16_2.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat2 = float(u_xlat16_2.x) * u_xlat1.w;
    u_xlat2 = u_xlat2 * float(input.COLOR0.w);
    u_xlat4 = fma(u_xlat2, u_xlat0.x, -0.00100000005);
    u_xlat1.w = u_xlat0.x * u_xlat2;
    output.SV_Target0 = half4(u_xlat1);
    u_xlatb0.x = u_xlat4<0.0;
    if(((int(u_xlatb0.x) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}
"
}
}
}
}
}
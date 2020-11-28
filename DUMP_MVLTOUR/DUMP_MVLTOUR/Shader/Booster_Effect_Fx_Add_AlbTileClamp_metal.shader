//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_AlbTileClamp" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Clamp Repeat Tile)] _AlbedoTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlbedoTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlbedoTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlbedoClampCount ("繰り返すコマ数", Range(1, 512)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 42779
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    half2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    half2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    half2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
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
    float4 booster_Env;
    half4 _Color;
    half _AlbedoTileFreq;
    half _AlbedoTileSplitU;
    half _AlbedoTileSplitV;
    half _AlbedoClampCount;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
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
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    float u_xlat6;
    half u_xlat16_6;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat0.x = u_xlat0.x * float(FGlobals._AlbedoTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = input.TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = input.TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat2.y, float(FGlobals._AlbedoTileSplitU), u_xlat0.x);
    u_xlat2.xy = fma(u_xlat1.xy, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat2.xy));
    u_xlat16_6 = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat6 = min(float(u_xlat16_6), float(FGlobals._AlbedoClampCount));
    u_xlat1.x = u_xlat6 * u_xlat0.x;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlbedoTileSplitV, FGlobals._AlbedoTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
    output.SV_Target0.w = u_xlat1.w;
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
    float4 booster_Env;
    half4 _Color;
    half _AlbedoTileFreq;
    half _AlbedoTileSplitU;
    half _AlbedoTileSplitV;
    half _AlbedoClampCount;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
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
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    float u_xlat6;
    half u_xlat16_6;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat0.x = u_xlat0.x * float(FGlobals._AlbedoTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = input.TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = input.TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat2.y, float(FGlobals._AlbedoTileSplitU), u_xlat0.x);
    u_xlat2.xy = fma(u_xlat1.xy, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat2.xy));
    u_xlat16_6 = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat6 = min(float(u_xlat16_6), float(FGlobals._AlbedoClampCount));
    u_xlat1.x = u_xlat6 * u_xlat0.x;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlbedoTileSplitV, FGlobals._AlbedoTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
    output.SV_Target0.w = u_xlat1.w;
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
    float4 booster_Env;
    half4 _Color;
    half _AlbedoTileFreq;
    half _AlbedoTileSplitU;
    half _AlbedoTileSplitV;
    half _AlbedoClampCount;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
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
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    float u_xlat6;
    half u_xlat16_6;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat0.x = u_xlat0.x * float(FGlobals._AlbedoTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = input.TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat1.y = (-u_xlat2.x) + 1.0;
    u_xlat1.x = input.TEXCOORD0.x;
    u_xlat2.xy = u_xlat1.xy * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat2.y, float(FGlobals._AlbedoTileSplitU), u_xlat0.x);
    u_xlat2.xy = fma(u_xlat1.xy, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat2.xy));
    u_xlat16_6 = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat6 = min(float(u_xlat16_6), float(FGlobals._AlbedoClampCount));
    u_xlat1.x = u_xlat6 * u_xlat0.x;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat6 = (u_xlatb1) ? u_xlat6 : (-u_xlat6);
    u_xlat1.x = float(1.0) / u_xlat6;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat1.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat1.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat1.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlbedoTileSplitV, FGlobals._AlbedoTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.yz).xyz;
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
    output.SV_Target0.w = u_xlat1.w;
    return output;
}
"
}
}
}
}
}
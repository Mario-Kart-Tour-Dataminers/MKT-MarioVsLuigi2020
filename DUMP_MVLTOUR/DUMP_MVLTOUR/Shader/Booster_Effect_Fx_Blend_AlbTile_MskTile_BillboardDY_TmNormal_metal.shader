//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbTile_MskTile_BillboardDY_TmNormal" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Tile)] _AlbedoTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlbedoTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlbedoTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Tile)] _AlphaTextureTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlphaTextureTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlphaTextureTileSplitV ("V方向：分割数", Range(1, 32)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 26718
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
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
    float3 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float u_xlat12;
    u_xlat0.xyz = input.TEXCOORD1.xyz + (-VGlobals._WorldSpaceCameraPos.xyzx.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = fma(u_xlat0.yzx, u_xlat1.zxy, (-u_xlat2.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat3);
    u_xlat3.xyz = u_xlat3.xyz + (-input.TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = fma(u_xlat1.xyz, u_xlat3.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat3.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, u_xlat3.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_MatrixVP[3];
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
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
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
    float3 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float u_xlat12;
    u_xlat0.xyz = input.TEXCOORD1.xyz + (-VGlobals._WorldSpaceCameraPos.xyzx.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = fma(u_xlat0.yzx, u_xlat1.zxy, (-u_xlat2.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat3);
    u_xlat3.xyz = u_xlat3.xyz + (-input.TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = fma(u_xlat1.xyz, u_xlat3.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat3.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, u_xlat3.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_MatrixVP[3];
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
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
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
    float3 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float u_xlat12;
    u_xlat0.xyz = input.TEXCOORD1.xyz + (-VGlobals._WorldSpaceCameraPos.xyzx.xyz);
    u_xlat0.w = (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.x = u_xlat12 * u_xlat0.z;
    u_xlat1.z = u_xlat12 * (-u_xlat0.x);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.y = 0.0;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.zxy;
    u_xlat2.xyz = fma(u_xlat0.yzx, u_xlat1.zxy, (-u_xlat2.xyz));
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat2.xyz;
    u_xlat3 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat3);
    u_xlat3.xyz = u_xlat3.xyz + (-input.TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = fma(u_xlat1.xyz, u_xlat3.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat3.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(input.TEXCOORD1.xyz, u_xlat3.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_MatrixVP[3];
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
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
    half _AlphaTextureTileFreq;
    half _AlphaTextureTileSplitU;
    half _AlphaTextureTileSplitV;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
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
    sampler sampler_AlphaTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    float2 u_xlat3;
    half u_xlat16_9;
    bool u_xlatb10;
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._AlphaTextureTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = input.TEXCOORD1.xy * float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat3.y, float(FGlobals._AlphaTextureTileSplitU), u_xlat0.x);
    u_xlat3.xy = fma(input.TEXCOORD1.xy, float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV)), (-u_xlat3.xy));
    u_xlat16_9 = FGlobals._AlphaTextureTileSplitV * FGlobals._AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / float(u_xlat16_9);
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(u_xlat16_9) * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / float(FGlobals._AlphaTextureTileSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat1.w;
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._AlbedoTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = input.TEXCOORD0.xy * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat3.y, float(FGlobals._AlbedoTileSplitU), u_xlat0.x);
    u_xlat3.xy = fma(input.TEXCOORD0.xy, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat3.xy));
    u_xlat16_9 = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / float(u_xlat16_9);
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = float(u_xlat16_9) * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
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
    half _AlphaTextureTileFreq;
    half _AlphaTextureTileSplitU;
    half _AlphaTextureTileSplitV;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
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
    sampler sampler_AlphaTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    float2 u_xlat3;
    half u_xlat16_9;
    bool u_xlatb10;
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._AlphaTextureTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = input.TEXCOORD1.xy * float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat3.y, float(FGlobals._AlphaTextureTileSplitU), u_xlat0.x);
    u_xlat3.xy = fma(input.TEXCOORD1.xy, float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV)), (-u_xlat3.xy));
    u_xlat16_9 = FGlobals._AlphaTextureTileSplitV * FGlobals._AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / float(u_xlat16_9);
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(u_xlat16_9) * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / float(FGlobals._AlphaTextureTileSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat1.w;
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._AlbedoTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = input.TEXCOORD0.xy * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat3.y, float(FGlobals._AlbedoTileSplitU), u_xlat0.x);
    u_xlat3.xy = fma(input.TEXCOORD0.xy, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat3.xy));
    u_xlat16_9 = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / float(u_xlat16_9);
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = float(u_xlat16_9) * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
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
    half _AlphaTextureTileFreq;
    half _AlphaTextureTileSplitU;
    half _AlphaTextureTileSplitV;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
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
    sampler sampler_AlphaTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    float2 u_xlat3;
    half u_xlat16_9;
    bool u_xlatb10;
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._AlphaTextureTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = input.TEXCOORD1.xy * float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat3.y, float(FGlobals._AlphaTextureTileSplitU), u_xlat0.x);
    u_xlat3.xy = fma(input.TEXCOORD1.xy, float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV)), (-u_xlat3.xy));
    u_xlat16_9 = FGlobals._AlphaTextureTileSplitV * FGlobals._AlphaTextureTileSplitU;
    u_xlat0.x = u_xlat0.x / float(u_xlat16_9);
    u_xlatb1 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(u_xlat16_9) * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / float(FGlobals._AlphaTextureTileSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy / float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat1.w;
    u_xlat0.x = FGlobals.booster_Env.x * float(FGlobals._AlbedoTileFreq);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3.xy = input.TEXCOORD0.xy * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat3.xy = trunc(u_xlat3.xy);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = fma(u_xlat3.y, float(FGlobals._AlbedoTileSplitU), u_xlat0.x);
    u_xlat3.xy = fma(input.TEXCOORD0.xy, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat3.xy));
    u_xlat16_9 = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat0.x = u_xlat0.x / float(u_xlat16_9);
    u_xlatb10 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb10) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2.x = float(u_xlat16_9) * u_xlat0.x;
    u_xlat0.x = u_xlat2.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.y = (-u_xlat0.x);
    u_xlat0.xy = u_xlat3.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.xy / float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
    return output;
}
"
}
}
}
}
}
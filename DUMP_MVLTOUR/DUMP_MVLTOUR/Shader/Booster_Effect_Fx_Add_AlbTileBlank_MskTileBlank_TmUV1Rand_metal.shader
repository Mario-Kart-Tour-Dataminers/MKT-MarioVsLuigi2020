//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_AlbTileBlank_MskTileBlank_TmUV1Rand" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
[Header(UV Random Animation Time)] _uvRandMin ("最小開始時間", Float) = 0
_uvRandMax ("最大開始時間", Float) = 1
_uvRandSeed ("時間ばらつき乱数の種", Vector) = (0,0,0,0)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Blank Header and Clamp Repeat Tile)] _AlbedoTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlbedoTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlbedoTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlbedoClampCount ("繰り返すコマ数", Range(1, 512)) = 1
_AlbedoBlankCount ("先頭の空白コマ数", Range(0, 10000)) = 1
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Blank Header and Clamp Repeat Tile)] _AlphaTextureTileFreq ("コマ送り速度", Range(-1000, 1000)) = 0
_AlphaTextureTileSplitU ("U方向：分割数", Range(1, 32)) = 1
_AlphaTextureTileSplitV ("V方向：分割数", Range(1, 32)) = 1
_AlphaTextureClampCount ("繰り返すコマ数", Range(1, 512)) = 1
_AlphaTextureBlankCount ("先頭の空白コマ数", Range(0, 10000)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 7018
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
    float4 booster_Env;
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
    half _uvRandMin;
    half _uvRandMax;
    half3 _uvRandSeed;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    half2 TEXCOORD0 [[ attribute(2) ]] ;
    half2 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float NORMAL0 [[ user(NORMAL0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    half u_xlat16_5;
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    u_xlat16_2 = dot(input.TEXCOORD1.xy, VGlobals._uvRandSeed.xyzx.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-VGlobals._uvRandMin) + VGlobals._uvRandMax;
    u_xlat16_2 = fma(u_xlat16_2, u_xlat16_5, VGlobals._uvRandMin);
    output.NORMAL0 = (-float(u_xlat16_2)) + VGlobals.booster_Env.x;
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
    float4 booster_Env;
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
    half _uvRandMin;
    half _uvRandMax;
    half3 _uvRandSeed;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    half2 TEXCOORD0 [[ attribute(2) ]] ;
    half2 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float NORMAL0 [[ user(NORMAL0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    half u_xlat16_5;
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    u_xlat16_2 = dot(input.TEXCOORD1.xy, VGlobals._uvRandSeed.xyzx.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-VGlobals._uvRandMin) + VGlobals._uvRandMax;
    u_xlat16_2 = fma(u_xlat16_2, u_xlat16_5, VGlobals._uvRandMin);
    output.NORMAL0 = (-float(u_xlat16_2)) + VGlobals.booster_Env.x;
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
    float4 booster_Env;
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
    half _uvRandMin;
    half _uvRandMax;
    half3 _uvRandSeed;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    half2 TEXCOORD0 [[ attribute(2) ]] ;
    half2 TEXCOORD1 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float NORMAL0 [[ user(NORMAL0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    half u_xlat16_5;
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    u_xlat16_2 = dot(input.TEXCOORD1.xy, VGlobals._uvRandSeed.xyzx.xy);
    u_xlat16_2 = fract(u_xlat16_2);
    u_xlat16_5 = (-VGlobals._uvRandMin) + VGlobals._uvRandMax;
    u_xlat16_2 = fma(u_xlat16_2, u_xlat16_5, VGlobals._uvRandMin);
    output.NORMAL0 = (-float(u_xlat16_2)) + VGlobals.booster_Env.x;
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
    half4 _Color;
    half _AlbedoTileFreq;
    half _AlbedoTileSplitU;
    half _AlbedoTileSplitV;
    half _AlbedoClampCount;
    float _AlbedoBlankCount;
    half _AlphaTextureTileFreq;
    half _AlphaTextureTileSplitU;
    half _AlphaTextureTileSplitV;
    half _AlphaTextureClampCount;
    float _AlphaTextureBlankCount;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float NORMAL0 [[ user(NORMAL0) ]] ;
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
        float4 phase0_Input0_2;
        phase0_Input0_2 = float4(input.TEXCOORD0, input.TEXCOORD1);
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    bool u_xlatb2;
    float4 u_xlat3;
    float u_xlat4;
    float2 u_xlat5;
    float2 u_xlat8;
    float u_xlat13;
    half u_xlat16_13;
    u_xlat16_0.x = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat16_0.x = min(u_xlat16_0.x, FGlobals._AlbedoClampCount);
    u_xlat0.x = float(u_xlat16_0.x) + FGlobals._AlbedoBlankCount;
    u_xlat4 = input.NORMAL0 * float(FGlobals._AlbedoTileFreq);
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0f, 1.0f);
    u_xlat1.xy = (-u_xlat8.xy) + float2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = fma(u_xlat8.y, float(FGlobals._AlbedoTileSplitU), u_xlat4);
    u_xlat8.xy = fma(u_xlat1.zx, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat8.xy));
    u_xlat1.x = u_xlat0.x * u_xlat4;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = fma(u_xlat0.x, u_xlat4, (-FGlobals._AlbedoBlankCount));
    u_xlatb1 = u_xlat0.x<0.0;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.x = input.NORMAL0 * float(FGlobals._AlphaTextureTileFreq);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = fma(u_xlat2.y, float(FGlobals._AlphaTextureTileSplitU), u_xlat1.x);
    u_xlat5.xy = fma(u_xlat1.wy, float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV)), (-u_xlat2.xy));
    u_xlat16_13 = FGlobals._AlphaTextureTileSplitV * FGlobals._AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, FGlobals._AlphaTextureClampCount);
    u_xlat13 = float(u_xlat16_13) + FGlobals._AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = fma(u_xlat13, u_xlat1.x, (-FGlobals._AlphaTextureBlankCount));
    u_xlatb1 = u_xlat2.x<0.0;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.x = u_xlat0.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlbedoTileSplitV, FGlobals._AlbedoTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / float(FGlobals._AlphaTextureTileSplitU);
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlphaTextureTileSplitV, FGlobals._AlphaTextureTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat3.w;
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
    half4 _Color;
    half _AlbedoTileFreq;
    half _AlbedoTileSplitU;
    half _AlbedoTileSplitV;
    half _AlbedoClampCount;
    float _AlbedoBlankCount;
    half _AlphaTextureTileFreq;
    half _AlphaTextureTileSplitU;
    half _AlphaTextureTileSplitV;
    half _AlphaTextureClampCount;
    float _AlphaTextureBlankCount;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float NORMAL0 [[ user(NORMAL0) ]] ;
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
        float4 phase0_Input0_2;
        phase0_Input0_2 = float4(input.TEXCOORD0, input.TEXCOORD1);
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    bool u_xlatb2;
    float4 u_xlat3;
    float u_xlat4;
    float2 u_xlat5;
    float2 u_xlat8;
    float u_xlat13;
    half u_xlat16_13;
    u_xlat16_0.x = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat16_0.x = min(u_xlat16_0.x, FGlobals._AlbedoClampCount);
    u_xlat0.x = float(u_xlat16_0.x) + FGlobals._AlbedoBlankCount;
    u_xlat4 = input.NORMAL0 * float(FGlobals._AlbedoTileFreq);
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0f, 1.0f);
    u_xlat1.xy = (-u_xlat8.xy) + float2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = fma(u_xlat8.y, float(FGlobals._AlbedoTileSplitU), u_xlat4);
    u_xlat8.xy = fma(u_xlat1.zx, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat8.xy));
    u_xlat1.x = u_xlat0.x * u_xlat4;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = fma(u_xlat0.x, u_xlat4, (-FGlobals._AlbedoBlankCount));
    u_xlatb1 = u_xlat0.x<0.0;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.x = input.NORMAL0 * float(FGlobals._AlphaTextureTileFreq);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = fma(u_xlat2.y, float(FGlobals._AlphaTextureTileSplitU), u_xlat1.x);
    u_xlat5.xy = fma(u_xlat1.wy, float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV)), (-u_xlat2.xy));
    u_xlat16_13 = FGlobals._AlphaTextureTileSplitV * FGlobals._AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, FGlobals._AlphaTextureClampCount);
    u_xlat13 = float(u_xlat16_13) + FGlobals._AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = fma(u_xlat13, u_xlat1.x, (-FGlobals._AlphaTextureBlankCount));
    u_xlatb1 = u_xlat2.x<0.0;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.x = u_xlat0.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlbedoTileSplitV, FGlobals._AlbedoTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / float(FGlobals._AlphaTextureTileSplitU);
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlphaTextureTileSplitV, FGlobals._AlphaTextureTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat3.w;
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
    half4 _Color;
    half _AlbedoTileFreq;
    half _AlbedoTileSplitU;
    half _AlbedoTileSplitV;
    half _AlbedoClampCount;
    float _AlbedoBlankCount;
    half _AlphaTextureTileFreq;
    half _AlphaTextureTileSplitU;
    half _AlphaTextureTileSplitV;
    half _AlphaTextureClampCount;
    float _AlphaTextureBlankCount;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float NORMAL0 [[ user(NORMAL0) ]] ;
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
        float4 phase0_Input0_2;
        phase0_Input0_2 = float4(input.TEXCOORD0, input.TEXCOORD1);
    float3 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    float2 u_xlat2;
    bool u_xlatb2;
    float4 u_xlat3;
    float u_xlat4;
    float2 u_xlat5;
    float2 u_xlat8;
    float u_xlat13;
    half u_xlat16_13;
    u_xlat16_0.x = FGlobals._AlbedoTileSplitV * FGlobals._AlbedoTileSplitU;
    u_xlat16_0.x = min(u_xlat16_0.x, FGlobals._AlbedoClampCount);
    u_xlat0.x = float(u_xlat16_0.x) + FGlobals._AlbedoBlankCount;
    u_xlat4 = input.NORMAL0 * float(FGlobals._AlbedoTileFreq);
    u_xlat4 = floor(u_xlat4);
    u_xlat8.xy = phase0_Input0_2.yw;
    u_xlat8.xy = clamp(u_xlat8.xy, 0.0f, 1.0f);
    u_xlat1.xy = (-u_xlat8.xy) + float2(1.0, 1.0);
    u_xlat1.zw = phase0_Input0_2.xz;
    u_xlat8.xy = u_xlat1.zx * float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV));
    u_xlat8.xy = trunc(u_xlat8.xy);
    u_xlat4 = u_xlat8.x + u_xlat4;
    u_xlat4 = fma(u_xlat8.y, float(FGlobals._AlbedoTileSplitU), u_xlat4);
    u_xlat8.xy = fma(u_xlat1.zx, float2(half2(FGlobals._AlbedoTileSplitU, FGlobals._AlbedoTileSplitV)), (-u_xlat8.xy));
    u_xlat1.x = u_xlat0.x * u_xlat4;
    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
    u_xlat0.x = (u_xlatb1) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat1.x = float(1.0) / u_xlat0.x;
    u_xlat4 = u_xlat4 * u_xlat1.x;
    u_xlat4 = fract(u_xlat4);
    u_xlat0.x = fma(u_xlat0.x, u_xlat4, (-FGlobals._AlbedoBlankCount));
    u_xlatb1 = u_xlat0.x<0.0;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.x = input.NORMAL0 * float(FGlobals._AlphaTextureTileFreq);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat2.xy = u_xlat1.wy * float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV));
    u_xlat2.xy = trunc(u_xlat2.xy);
    u_xlat1.x = u_xlat1.x + u_xlat2.x;
    u_xlat1.x = fma(u_xlat2.y, float(FGlobals._AlphaTextureTileSplitU), u_xlat1.x);
    u_xlat5.xy = fma(u_xlat1.wy, float2(half2(FGlobals._AlphaTextureTileSplitU, FGlobals._AlphaTextureTileSplitV)), (-u_xlat2.xy));
    u_xlat16_13 = FGlobals._AlphaTextureTileSplitV * FGlobals._AlphaTextureTileSplitU;
    u_xlat16_13 = min(u_xlat16_13, FGlobals._AlphaTextureClampCount);
    u_xlat13 = float(u_xlat16_13) + FGlobals._AlphaTextureBlankCount;
    u_xlat2.x = u_xlat13 * u_xlat1.x;
    u_xlatb2 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
    u_xlat2.x = float(1.0) / u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat2.x = fma(u_xlat13, u_xlat1.x, (-FGlobals._AlphaTextureBlankCount));
    u_xlatb1 = u_xlat2.x<0.0;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat1.x = u_xlat0.x / float(FGlobals._AlbedoTileSplitU);
    u_xlat0.y = floor(u_xlat1.x);
    u_xlat0.xy = u_xlat8.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlbedoTileSplitV, FGlobals._AlbedoTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.yz).xyz;
    u_xlat3 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat3.xyz;
    u_xlat0.x = u_xlat2.x / float(FGlobals._AlphaTextureTileSplitU);
    u_xlat2.y = floor(u_xlat0.x);
    u_xlat0.xy = u_xlat5.xy + u_xlat2.xy;
    u_xlat0.xy = u_xlat0.yx / float2(half2(FGlobals._AlphaTextureTileSplitV, FGlobals._AlphaTextureTileSplitU));
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.z = (-u_xlat0.x) + 1.0;
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.yz).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat3.w;
    return output;
}
"
}
}
}
}
}
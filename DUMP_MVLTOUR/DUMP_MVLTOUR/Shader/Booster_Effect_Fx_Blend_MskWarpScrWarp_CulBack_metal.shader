//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_MskWarpScrWarp_CulBack" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_WarpTexture ("Warp(UV0)", 2D) = "black" { }
_WarpScale ("Warp Scale", Range(0, 1024)) = 0
[Header(W UV Scroll)] _WarpScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_WarpScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 4619
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
    float4 _AlphaTexture_ST;
    float4 _WarpTexture_ST;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    output.TEXCOORD3.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._WarpTexture_ST.xy, VGlobals._WarpTexture_ST.zw);
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
    float4 _AlphaTexture_ST;
    float4 _WarpTexture_ST;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    output.TEXCOORD3.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._WarpTexture_ST.xy, VGlobals._WarpTexture_ST.zw);
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
    float4 _AlphaTexture_ST;
    float4 _WarpTexture_ST;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    output.TEXCOORD3.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._WarpTexture_ST.xy, VGlobals._WarpTexture_ST.zw);
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
    float4 _AlphaTexture_TexelSize;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    half _WarpScale;
    half _WarpScrollSpeedU;
    half _WarpScrollSpeedV;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    sampler sampler_WarpTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _WarpTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half2 u_xlat16_2;
    half u_xlat16_3;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat0.yz = u_xlat0.xx * float2(half2(FGlobals._WarpScrollSpeedU, FGlobals._WarpScrollSpeedV));
    u_xlat0.xw = u_xlat0.xx * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + input.TEXCOORD3.xy;
    u_xlat16_1.xyz = _WarpTexture.sample(sampler_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat16_1.xy + half2(-0.5, -0.5);
    u_xlat16_1.x = u_xlat16_1.z * FGlobals._WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = rsqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * half2(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_1.xx * u_xlat16_2.xy;
    u_xlat0.xy = fma(float2(u_xlat16_2.xy), FGlobals._AlphaTexture_TexelSize.xy, u_xlat0.xw);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.xy;
    u_xlat16_0 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0) * u_xlat1.w;
    output.SV_Target0.xyz = u_xlat1.xyz;
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
    float4 _AlphaTexture_TexelSize;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    half _WarpScale;
    half _WarpScrollSpeedU;
    half _WarpScrollSpeedV;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    sampler sampler_WarpTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _WarpTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half2 u_xlat16_2;
    half u_xlat16_3;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat0.yz = u_xlat0.xx * float2(half2(FGlobals._WarpScrollSpeedU, FGlobals._WarpScrollSpeedV));
    u_xlat0.xw = u_xlat0.xx * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + input.TEXCOORD3.xy;
    u_xlat16_1.xyz = _WarpTexture.sample(sampler_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat16_1.xy + half2(-0.5, -0.5);
    u_xlat16_1.x = u_xlat16_1.z * FGlobals._WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = rsqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * half2(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_1.xx * u_xlat16_2.xy;
    u_xlat0.xy = fma(float2(u_xlat16_2.xy), FGlobals._AlphaTexture_TexelSize.xy, u_xlat0.xw);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.xy;
    u_xlat16_0 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0) * u_xlat1.w;
    output.SV_Target0.xyz = u_xlat1.xyz;
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
    float4 _AlphaTexture_TexelSize;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    half _WarpScale;
    half _WarpScrollSpeedU;
    half _WarpScrollSpeedV;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    sampler sampler_WarpTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _WarpTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half2 u_xlat16_2;
    half u_xlat16_3;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat0.yz = u_xlat0.xx * float2(half2(FGlobals._WarpScrollSpeedU, FGlobals._WarpScrollSpeedV));
    u_xlat0.xw = u_xlat0.xx * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = u_xlat0.yz + input.TEXCOORD3.xy;
    u_xlat16_1.xyz = _WarpTexture.sample(sampler_WarpTexture, u_xlat2.xy).xyz;
    u_xlat16_2.xy = u_xlat16_1.xy + half2(-0.5, -0.5);
    u_xlat16_1.x = u_xlat16_1.z * FGlobals._WarpScale;
    u_xlat16_3 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat16_3 = rsqrt(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_2.xy * half2(u_xlat16_3);
    u_xlat16_2.xy = u_xlat16_1.xx * u_xlat16_2.xy;
    u_xlat0.xy = fma(float2(u_xlat16_2.xy), FGlobals._AlphaTexture_TexelSize.xy, u_xlat0.xw);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.xy;
    u_xlat16_0 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0) * u_xlat1.w;
    output.SV_Target0.xyz = u_xlat1.xyz;
    return output;
}
"
}
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbScr_MskScr_Msk2Scr_DissolScr" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Header(Alpha 2)] _Alpha2Texture ("A2(UV0)", 2D) = "black" { }
[Header(A2 UV Scroll)] _Alpha2TextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_Alpha2TextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_DissolveTexture ("Dissolve(UV0)", 2D) = "black" { }
_DissolveStart ("開始時間", Float) = 0
_DissolveTime ("溶解時間", Float) = 1
[Header(D UV Scroll)] _DissolveScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_DissolveScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 32185
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
    float4 _AlphaTexture_ST;
    float4 _Alpha2Texture_ST;
    float4 _DissolveTexture_ST;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float2 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    output.TEXCOORD2.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._DissolveTexture_ST.xy, VGlobals._DissolveTexture_ST.zw);
    output.TEXCOORD5.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._Alpha2Texture_ST.xy, VGlobals._Alpha2Texture_ST.zw);
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
    float4 _AlphaTexture_ST;
    float4 _Alpha2Texture_ST;
    float4 _DissolveTexture_ST;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float2 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    output.TEXCOORD2.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._DissolveTexture_ST.xy, VGlobals._DissolveTexture_ST.zw);
    output.TEXCOORD5.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._Alpha2Texture_ST.xy, VGlobals._Alpha2Texture_ST.zw);
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
    float4 _AlphaTexture_ST;
    float4 _Alpha2Texture_ST;
    float4 _DissolveTexture_ST;
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
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float2 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    output.TEXCOORD2.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._DissolveTexture_ST.xy, VGlobals._DissolveTexture_ST.zw);
    output.TEXCOORD5.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._Alpha2Texture_ST.xy, VGlobals._Alpha2Texture_ST.zw);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    half _Alpha2TextureScrollSpeedU;
    half _Alpha2TextureScrollSpeedV;
    float _DissolveStart;
    float _DissolveTime;
    half _DissolveScrollSpeedU;
    half _DissolveScrollSpeedV;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float2 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AlphaTexture [[ sampler (1) ]],
    sampler sampler_Alpha2Texture [[ sampler (2) ]],
    sampler sampler_DissolveTexture [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _Alpha2Texture [[ texture(2) ]] ,
    texture2d<half, access::sample > _DissolveTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    float2 u_xlat3;
    half u_xlat16_3;
    float2 u_xlat6;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0 = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat3.xy = float2(u_xlat0) * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD1.xy;
    u_xlat16_3 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat3.x = float(u_xlat16_3) * u_xlat1.w;
    u_xlat6.xy = float2(u_xlat0) * float2(half2(FGlobals._Alpha2TextureScrollSpeedU, FGlobals._Alpha2TextureScrollSpeedV));
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD5.xy;
    u_xlat16_6 = _Alpha2Texture.sample(sampler_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + half(1.0);
    u_xlat3.x = float(u_xlat16_6) * u_xlat3.x;
    u_xlat6.xy = float2(u_xlat0) * float2(half2(FGlobals._DissolveScrollSpeedU, FGlobals._DissolveScrollSpeedV));
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD2.xy;
    u_xlat16_6 = _DissolveTexture.sample(sampler_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + half(1.0);
    u_xlat6.x = float(u_xlat16_6) * FGlobals._DissolveTime;
    u_xlat9 = u_xlat0 + (-FGlobals._DissolveStart);
    u_xlat2.xy = float2(u_xlat0) * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    output.SV_Target0.xyz = u_xlat1.xyz * float3(u_xlat16_2.xyz);
    u_xlatb0 = u_xlat9<u_xlat6.x;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    output.SV_Target0.w = u_xlat0 * u_xlat3.x;
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    half _Alpha2TextureScrollSpeedU;
    half _Alpha2TextureScrollSpeedV;
    float _DissolveStart;
    float _DissolveTime;
    half _DissolveScrollSpeedU;
    half _DissolveScrollSpeedV;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float2 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AlphaTexture [[ sampler (1) ]],
    sampler sampler_Alpha2Texture [[ sampler (2) ]],
    sampler sampler_DissolveTexture [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _Alpha2Texture [[ texture(2) ]] ,
    texture2d<half, access::sample > _DissolveTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    float2 u_xlat3;
    half u_xlat16_3;
    float2 u_xlat6;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0 = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat3.xy = float2(u_xlat0) * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD1.xy;
    u_xlat16_3 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat3.x = float(u_xlat16_3) * u_xlat1.w;
    u_xlat6.xy = float2(u_xlat0) * float2(half2(FGlobals._Alpha2TextureScrollSpeedU, FGlobals._Alpha2TextureScrollSpeedV));
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD5.xy;
    u_xlat16_6 = _Alpha2Texture.sample(sampler_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + half(1.0);
    u_xlat3.x = float(u_xlat16_6) * u_xlat3.x;
    u_xlat6.xy = float2(u_xlat0) * float2(half2(FGlobals._DissolveScrollSpeedU, FGlobals._DissolveScrollSpeedV));
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD2.xy;
    u_xlat16_6 = _DissolveTexture.sample(sampler_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + half(1.0);
    u_xlat6.x = float(u_xlat16_6) * FGlobals._DissolveTime;
    u_xlat9 = u_xlat0 + (-FGlobals._DissolveStart);
    u_xlat2.xy = float2(u_xlat0) * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    output.SV_Target0.xyz = u_xlat1.xyz * float3(u_xlat16_2.xyz);
    u_xlatb0 = u_xlat9<u_xlat6.x;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    output.SV_Target0.w = u_xlat0 * u_xlat3.x;
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    half _Alpha2TextureScrollSpeedU;
    half _Alpha2TextureScrollSpeedV;
    float _DissolveStart;
    float _DissolveTime;
    half _DissolveScrollSpeedU;
    half _DissolveScrollSpeedV;
    float _effectStart;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float2 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_AlphaTexture [[ sampler (1) ]],
    sampler sampler_Alpha2Texture [[ sampler (2) ]],
    sampler sampler_DissolveTexture [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AlphaTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _Alpha2Texture [[ texture(2) ]] ,
    texture2d<half, access::sample > _DissolveTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    float2 u_xlat3;
    half u_xlat16_3;
    float2 u_xlat6;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0 = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat3.xy = float2(u_xlat0) * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD1.xy;
    u_xlat16_3 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat3.xy).x;
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat3.x = float(u_xlat16_3) * u_xlat1.w;
    u_xlat6.xy = float2(u_xlat0) * float2(half2(FGlobals._Alpha2TextureScrollSpeedU, FGlobals._Alpha2TextureScrollSpeedV));
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD5.xy;
    u_xlat16_6 = _Alpha2Texture.sample(sampler_Alpha2Texture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + half(1.0);
    u_xlat3.x = float(u_xlat16_6) * u_xlat3.x;
    u_xlat6.xy = float2(u_xlat0) * float2(half2(FGlobals._DissolveScrollSpeedU, FGlobals._DissolveScrollSpeedV));
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD2.xy;
    u_xlat16_6 = _DissolveTexture.sample(sampler_DissolveTexture, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat16_6) + half(1.0);
    u_xlat6.x = float(u_xlat16_6) * FGlobals._DissolveTime;
    u_xlat9 = u_xlat0 + (-FGlobals._DissolveStart);
    u_xlat2.xy = float2(u_xlat0) * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat2.xy).xyz;
    output.SV_Target0.xyz = u_xlat1.xyz * float3(u_xlat16_2.xyz);
    u_xlatb0 = u_xlat9<u_xlat6.x;
    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
    output.SV_Target0.w = u_xlat0 * u_xlat3.x;
    return output;
}
"
}
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/BuiltinCustom/AdditiveUVScroll" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_MainTex2 ("Particle Texture2", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_ScrollSpeedU ("U Scroll Speed", Range(-10, 10)) = 0
_ScrollSpeedV ("V Scroll Speed", Range(-10, 10)) = 0
_ScrollSpeedU2 ("U Scroll Speed2", Range(-10, 10)) = 0
_ScrollSpeedV2 ("V Scroll Speed2", Range(-10, 10)) = 0
[KeywordEnum(ENABLE, DISABLE)] _USE_TEXTURE ("Use Texture", Float) = 0
[KeywordEnum(ONE, TOW)] _NUM_TEXTURE ("Num Texture", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 43662
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float4 u_xlat3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float4 u_xlat3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float4 u_xlat3;
    float u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float u_xlat3;
    float2 u_xlat8;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat8.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat8.xy;
    u_xlat3 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat3);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" }
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" }
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" }
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat4;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat4.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
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
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
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
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
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
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = input.COLOR0;
    u_xlat0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat1.zw + u_xlat0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float4 u_xlat3;
    half u_xlat16_4;
    float u_xlat5;
    float u_xlat11;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat11 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 * VGlobals._ProjectionParams.z;
    u_xlat11 = max(u_xlat11, 0.0);
    u_xlat11 = fma(u_xlat11, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat11, float(u_xlat16_4));
    u_xlat5 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat5);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float4 u_xlat3;
    half u_xlat16_4;
    float u_xlat5;
    float u_xlat11;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat11 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 * VGlobals._ProjectionParams.z;
    u_xlat11 = max(u_xlat11, 0.0);
    u_xlat11 = fma(u_xlat11, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat11, float(u_xlat16_4));
    u_xlat5 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat5);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    float4 u_xlat3;
    half u_xlat16_4;
    float u_xlat5;
    float u_xlat11;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat3 = fract(u_xlat3);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat3.xy;
    u_xlat2.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat3.zw + u_xlat2.xy;
    u_xlat11 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 * VGlobals._ProjectionParams.z;
    u_xlat11 = max(u_xlat11, 0.0);
    u_xlat11 = fma(u_xlat11, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat11, float(u_xlat16_4));
    u_xlat5 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat5);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float2 u_xlat2;
    half u_xlat16_3;
    float u_xlat4;
    float u_xlat9;
    float2 u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.COLOR0 = input.COLOR0;
    u_xlat2.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat10.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat2.xy + u_xlat10.xy;
    u_xlat9 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 * VGlobals._ProjectionParams.z;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = fma(u_xlat9, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_3 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat9, float(u_xlat16_3));
    u_xlat4 = u_xlat0.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat0.x, u_xlat4);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat0.w, u_xlat0.x);
    output.TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD3.w = u_xlat1.w;
    output.TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.xy = float2(half2(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV)) * VGlobals.booster_Env.xx;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat6.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat3.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    output.TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat3.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    output.TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _MainTex2_ST;
    half _ScrollSpeedU;
    half _ScrollSpeedV;
    half _ScrollSpeedU2;
    half _ScrollSpeedV2;
    float4 booster_Env;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float2 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = input.COLOR0;
    u_xlat3.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1 = float4(half4(VGlobals._ScrollSpeedU, VGlobals._ScrollSpeedV, VGlobals._ScrollSpeedU2, VGlobals._ScrollSpeedV2)) * VGlobals.booster_Env.xxxx;
    u_xlat1 = fract(u_xlat1);
    output.TEXCOORD0.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat3.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex2_ST.xy, VGlobals._MainTex2_ST.zw);
    output.TEXCOORD1.xy = u_xlat1.zw + u_xlat3.xy;
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD2 = max(u_xlat0.x, float(u_xlat16_2));
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    sampler sampler_CameraDepthTexture [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    sampler sampler_CameraDepthTexture [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    sampler sampler_CameraDepthTexture [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = input.COLOR0 + input.COLOR0;
    u_xlat16_1 = u_xlat16_1 * FGlobals._TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = input.COLOR0 + input.COLOR0;
    u_xlat16_1 = u_xlat16_1 * FGlobals._TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = input.COLOR0 + input.COLOR0;
    u_xlat16_1 = u_xlat16_1 * FGlobals._TintColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    output.SV_Target0 = u_xlat16_0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    sampler sampler_CameraDepthTexture [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    sampler sampler_CameraDepthTexture [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    sampler sampler_CameraDepthTexture [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_2 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 + u_xlat16_2;
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
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
    float4 _ZBufferParams;
    half4 _TintColor;
    float _InvFade;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat0.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.z, u_xlat0.x, FGlobals._ZBufferParams.w);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-input.TEXCOORD3.z);
    u_xlat0.x = u_xlat0.x * FGlobals._InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.w = dot(float2(input.COLOR0.ww), u_xlat0.xx);
    u_xlat0.xyz = float3(input.COLOR0.xyz) + float3(input.COLOR0.xyz);
    u_xlat0 = u_xlat0 * float4(FGlobals._TintColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = u_xlat0 * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_NUM_TEXTURE_ONE" "_USE_TEXTURE_ENABLE" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = input.COLOR0 + input.COLOR0;
    u_xlat16_0 = u_xlat16_0 * FGlobals._TintColor;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = input.COLOR0 + input.COLOR0;
    u_xlat16_1 = u_xlat16_1 * FGlobals._TintColor;
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = input.COLOR0 + input.COLOR0;
    u_xlat16_1 = u_xlat16_1 * FGlobals._TintColor;
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_USE_TEXTURE_ENABLE" "_NUM_TEXTURE_TOW" }
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
    half4 _TintColor;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_MainTex2 [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _MainTex2 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float u_xlat1;
    half4 u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = _MainTex2.sample(sampler_MainTex2, input.TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = input.COLOR0 + input.COLOR0;
    u_xlat16_1 = u_xlat16_1 * FGlobals._TintColor;
    u_xlat0 = float4(u_xlat16_0) * float4(u_xlat16_1);
    u_xlat1 = input.TEXCOORD2;
    u_xlat1 = clamp(u_xlat1, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat1);
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
}
}
}
}
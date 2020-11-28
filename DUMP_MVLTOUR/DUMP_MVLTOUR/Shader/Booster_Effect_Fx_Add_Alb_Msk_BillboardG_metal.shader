//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_Alb_Msk_BillboardG" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
_AlphaTexture ("A(UV0)", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 16651
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
    half2 TEXCOORD0 [[ attribute(2) ]] ;
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
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0.xyz = (-VGlobals._WorldSpaceCameraPos.xyzx.xyz) + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
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
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat3.x = sqrt(u_xlat12);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat3.y = sqrt(u_xlat12);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat3.z = sqrt(u_xlat12);
    u_xlat3.xyz = u_xlat3.xyz * input.POSITION0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = fma(u_xlat1.xyz, u_xlat3.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat3.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_MatrixVP[3];
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
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
    half2 TEXCOORD0 [[ attribute(2) ]] ;
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
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0.xyz = (-VGlobals._WorldSpaceCameraPos.xyzx.xyz) + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
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
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat3.x = sqrt(u_xlat12);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat3.y = sqrt(u_xlat12);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat3.z = sqrt(u_xlat12);
    u_xlat3.xyz = u_xlat3.xyz * input.POSITION0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = fma(u_xlat1.xyz, u_xlat3.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat3.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_MatrixVP[3];
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
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
    half2 TEXCOORD0 [[ attribute(2) ]] ;
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
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0.xyz = (-VGlobals._WorldSpaceCameraPos.xyzx.xyz) + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
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
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat3.x = sqrt(u_xlat12);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat3.y = sqrt(u_xlat12);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat3.z = sqrt(u_xlat12);
    u_xlat3.xyz = u_xlat3.xyz * input.POSITION0.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
    u_xlat1.xyz = fma(u_xlat1.xyz, u_xlat3.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat3.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_MatrixVP[3];
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD0.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
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
    half3 u_xlat16_0;
    float4 u_xlat1;
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat1.w;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
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
    half4 _Color;
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
    half3 u_xlat16_0;
    float4 u_xlat1;
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat1.w;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
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
    half4 _Color;
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
    half3 u_xlat16_0;
    float4 u_xlat1;
    u_xlat16_0.x = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0.x) * u_xlat1.w;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * u_xlat1.xyz;
    return output;
}
"
}
}
}
}
}
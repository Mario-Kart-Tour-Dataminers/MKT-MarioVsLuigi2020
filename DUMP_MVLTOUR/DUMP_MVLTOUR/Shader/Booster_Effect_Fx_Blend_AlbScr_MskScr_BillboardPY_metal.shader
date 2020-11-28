//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbScr_MskScr_BillboardPY" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 56397
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
    float4 hlslcc_mtx4x4_EmitterPose[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float TEXCOORD1 [[ attribute(3) ]] ;
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
    float2 u_xlat3;
    float u_xlat12;
    u_xlat0.xy = input.TEXCOORD0.zw;
    u_xlat0.z = input.TEXCOORD1;
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, u_xlat1.xyz);
    u_xlat2.y = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, u_xlat1.xyz);
    u_xlat12 = dot((-u_xlat2.xy), (-u_xlat2.xy));
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * (-u_xlat2.xy);
    u_xlat2.xyz = (-u_xlat0.xyz) + input.POSITION0.xyz;
    u_xlat3.x = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, u_xlat2.xyz);
    u_xlat3.y = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, u_xlat2.xyz);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[1].xyz, u_xlat2.xyz);
    u_xlat2.xyz = float3(u_xlat12) * VGlobals.hlslcc_mtx4x4_EmitterPose[1].xyz;
    u_xlat12 = dot(u_xlat1.yx, u_xlat3.xy);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat12 = dot(u_xlat1.zy, u_xlat3.xy);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
    float4 hlslcc_mtx4x4_EmitterPose[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float TEXCOORD1 [[ attribute(3) ]] ;
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
    float2 u_xlat3;
    float u_xlat12;
    u_xlat0.xy = input.TEXCOORD0.zw;
    u_xlat0.z = input.TEXCOORD1;
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, u_xlat1.xyz);
    u_xlat2.y = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, u_xlat1.xyz);
    u_xlat12 = dot((-u_xlat2.xy), (-u_xlat2.xy));
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * (-u_xlat2.xy);
    u_xlat2.xyz = (-u_xlat0.xyz) + input.POSITION0.xyz;
    u_xlat3.x = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, u_xlat2.xyz);
    u_xlat3.y = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, u_xlat2.xyz);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[1].xyz, u_xlat2.xyz);
    u_xlat2.xyz = float3(u_xlat12) * VGlobals.hlslcc_mtx4x4_EmitterPose[1].xyz;
    u_xlat12 = dot(u_xlat1.yx, u_xlat3.xy);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat12 = dot(u_xlat1.zy, u_xlat3.xy);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _AlphaTexture_ST;
    float4 hlslcc_mtx4x4_EmitterPose[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    half4 COLOR0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float TEXCOORD1 [[ attribute(3) ]] ;
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
    float2 u_xlat3;
    float u_xlat12;
    u_xlat0.xy = input.TEXCOORD0.zw;
    u_xlat0.z = input.TEXCOORD1;
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, u_xlat1.xyz);
    u_xlat2.y = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, u_xlat1.xyz);
    u_xlat12 = dot((-u_xlat2.xy), (-u_xlat2.xy));
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * (-u_xlat2.xy);
    u_xlat2.xyz = (-u_xlat0.xyz) + input.POSITION0.xyz;
    u_xlat3.x = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, u_xlat2.xyz);
    u_xlat3.y = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, u_xlat2.xyz);
    u_xlat12 = dot(VGlobals.hlslcc_mtx4x4_EmitterPose[1].xyz, u_xlat2.xyz);
    u_xlat2.xyz = float3(u_xlat12) * VGlobals.hlslcc_mtx4x4_EmitterPose[1].xyz;
    u_xlat12 = dot(u_xlat1.yx, u_xlat3.xy);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4_EmitterPose[0].xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat1.z = (-u_xlat1.x);
    u_xlat12 = dot(u_xlat1.zy, u_xlat3.xy);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_EmitterPose[2].xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _AlphaTextureScrollSpeedU;
    half _AlphaTextureScrollSpeedV;
    float _effectStart;
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
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    float2 u_xlat3;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat3.xy = u_xlat0.xx * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat0.xw = u_xlat0.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + input.TEXCOORD0.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.xy;
    u_xlat16_0 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    u_xlat2 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0) * u_xlat2.w;
    output.SV_Target0.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
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
    float _effectStart;
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
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    float2 u_xlat3;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat3.xy = u_xlat0.xx * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat0.xw = u_xlat0.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + input.TEXCOORD0.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.xy;
    u_xlat16_0 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    u_xlat2 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0) * u_xlat2.w;
    output.SV_Target0.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
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
    float _effectStart;
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
    float4 u_xlat0;
    half u_xlat16_0;
    half3 u_xlat16_1;
    float4 u_xlat2;
    float2 u_xlat3;
    u_xlat0.x = FGlobals.booster_Env.x + (-FGlobals._effectStart);
    u_xlat3.xy = u_xlat0.xx * float2(half2(FGlobals._AlphaTextureScrollSpeedU, FGlobals._AlphaTextureScrollSpeedV));
    u_xlat0.xw = u_xlat0.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + input.TEXCOORD0.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.xy;
    u_xlat16_0 = _AlphaTexture.sample(sampler_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    u_xlat2 = input.COLOR0 * float4(FGlobals._Color);
    output.SV_Target0.w = float(u_xlat16_0) * u_xlat2.w;
    output.SV_Target0.xyz = float3(u_xlat16_1.xyz) * u_xlat2.xyz;
    return output;
}
"
}
}
}
}
}
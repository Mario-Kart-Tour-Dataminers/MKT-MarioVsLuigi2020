//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_FixedAreaLoop" {
Properties {
_MainTex ("RGB(UV0)", 2D) = "white" { }
_AlphaTex ("A(UV0)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_TileX ("TileX", Float) = 1
_TileY ("TileY", Float) = 1
_PtclScaleX ("ParticleScaleX", Float) = 1
_PtclScaleY ("ParticleScaleY", Float) = 1
_PtclScaleRnd ("ParticleScaleRnd", Float) = 1
_BoxSize ("BoxSize", Vector) = (10,10,10,0)
_Speed ("Speed", Vector) = (0,0,0,0)
_RotSpeed ("RotSpeed", Vector) = (0,0,0,0)
_SinCycle ("Sin Cycle", Vector) = (1,1,1,0)
_SinAmp ("Sin Amplitude", Vector) = (1,1,1,0)
_CamNearFadeAlphaZeroDist ("Camera Near Alpha Zero Distance", Float) = 1
_CamNearFadeAlphaOneDist ("Camera Near Alpha One Distance", Float) = 1
_CamFarFadeAlphaZeroDist ("Camera Far Alpha Zero Distance", Float) = 1000
_CamFarFadeAlphaOneDist ("Camera Far Alpha One Distance", Float) = 1000
_CamScaleLimitDist ("Camera Scale Limit Distance", Float) = 1
_BoxEdgeFadeXZ ("BoxEdgeFade XZ", Range(0, 1)) = 0.1
_BoxEdgeFadeY ("BoxEdgeFade Y", Range(0, 1)) = 0.1
}
SubShader {
 LOD 100
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 30757
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
    float4 _Time;
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    int _TileX;
    int _TileY;
    float _PtclScaleX;
    float _PtclScaleY;
    float _PtclScaleRnd;
    float4 _BoxSize;
    float4 _Speed;
    float4 _RotSpeed;
    float4 _SinCycle;
    float4 _SinAmp;
    float _CamNearFadeAlphaZeroDist;
    float _CamNearFadeAlphaOneDist;
    float _CamFarFadeAlphaZeroDist;
    float _CamFarFadeAlphaOneDist;
    float _CamScaleLimitDist;
    float _BoxEdgeFadeXZ;
    float _BoxEdgeFadeY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    float2 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
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
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float4 u_xlat8;
    float2 u_xlat9;
    float2 u_xlat18;
    float u_xlat27;
    float u_xlat28;
    u_xlat0.xy = input.POSITION0.xy + float2(0.5, 0.5);
    u_xlat18.xy = float2(int2(VGlobals._TileX, VGlobals._TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * input.TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = fma(u_xlat18.xy, float2(0.5, 0.5), u_xlat0.xy);
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.z = input.TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * float3(10.0, 10.0, 10.0);
    u_xlat27 = fma((-VGlobals._Speed.w), input.TEXCOORD0.x, 1.0);
    u_xlat1.xyz = float3(u_xlat27) * VGlobals._Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * VGlobals._Time.yyy;
    u_xlat27 = VGlobals._BoxSize.y + VGlobals._BoxSize.x;
    u_xlat27 = u_xlat27 + VGlobals._BoxSize.z;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat27 = fma((-VGlobals._SinCycle.w), input.TEXCOORD1.x, 1.0);
    u_xlat1.xyz = float3(u_xlat27) * VGlobals._SinCycle.xyz;
    u_xlat27 = input.TEXCOORD0.x + VGlobals._Time.y;
    u_xlat28 = input.TEXCOORD0.y + input.TEXCOORD0.x;
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat27), float3(u_xlat28));
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = fma((-VGlobals._SinAmp.w), input.TEXCOORD1.y, 1.0);
    u_xlat2.xyz = float3(u_xlat27) * VGlobals._SinAmp.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz / VGlobals._BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = VGlobals._BoxSize.xyz * float3(0.5, 0.5, 0.5);
    u_xlat1.xyz = fma(u_xlat0.xyz, VGlobals._BoxSize.xyz, (-u_xlat1.xyz));
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = fma(-abs(u_xlat0.xyz), float3(2.0, 2.0, 2.0), float3(1.0, 1.0, 1.0));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(VGlobals._BoxEdgeFadeXZ, VGlobals._BoxEdgeFadeY, VGlobals._BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / float3(VGlobals._BoxEdgeFadeXZ, VGlobals._BoxEdgeFadeY, VGlobals._BoxEdgeFadeXZ);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat2.xyz = u_xlat1.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, u_xlat1.zzz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-VGlobals._WorldSpaceCameraPos.xyzx.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, VGlobals._CamScaleLimitDist);
    u_xlat2.xy = float2(u_xlat27) + (-float2(VGlobals._CamNearFadeAlphaZeroDist, VGlobals._CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / VGlobals._CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = fma((-VGlobals._PtclScaleRnd), input.TEXCOORD1.x, 1.0);
    u_xlat3.xy = input.POSITION0.xy * float2(VGlobals._PtclScaleX, VGlobals._PtclScaleY);
    u_xlat3.z = input.POSITION0.z;
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = fma((-VGlobals._RotSpeed.w), input.TEXCOORD0.y, 1.0);
    u_xlat4.xyz = float3(u_xlat28) * VGlobals._RotSpeed.xyz;
    u_xlat28 = input.TEXCOORD1.y + input.TEXCOORD1.x;
    u_xlat28 = u_xlat28 + VGlobals._Time.y;
    u_xlat4.xyz = float3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = fma(u_xlat28, u_xlat4.y, u_xlat6.x);
    u_xlat8.z = fma(u_xlat6.x, u_xlat4.y, u_xlat28);
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = fma(u_xlat5.zx, u_xlat4.yy, (-u_xlat5.xz));
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = fma(u_xlat4.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat3 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat1.xxxx, u_xlat3);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.zzzz, u_xlat3);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat3);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-float2(VGlobals._CamNearFadeAlphaZeroDist, VGlobals._CamFarFadeAlphaOneDist)) + float2(VGlobals._CamNearFadeAlphaOneDist, VGlobals._CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0f, 1.0f);
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    output.COLOR0 = half4(u_xlat0);
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
    float4 _Time;
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    int _TileX;
    int _TileY;
    float _PtclScaleX;
    float _PtclScaleY;
    float _PtclScaleRnd;
    float4 _BoxSize;
    float4 _Speed;
    float4 _RotSpeed;
    float4 _SinCycle;
    float4 _SinAmp;
    float _CamNearFadeAlphaZeroDist;
    float _CamNearFadeAlphaOneDist;
    float _CamFarFadeAlphaZeroDist;
    float _CamFarFadeAlphaOneDist;
    float _CamScaleLimitDist;
    float _BoxEdgeFadeXZ;
    float _BoxEdgeFadeY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    float2 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
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
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float4 u_xlat8;
    float2 u_xlat9;
    float2 u_xlat18;
    float u_xlat27;
    float u_xlat28;
    u_xlat0.xy = input.POSITION0.xy + float2(0.5, 0.5);
    u_xlat18.xy = float2(int2(VGlobals._TileX, VGlobals._TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * input.TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = fma(u_xlat18.xy, float2(0.5, 0.5), u_xlat0.xy);
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.z = input.TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * float3(10.0, 10.0, 10.0);
    u_xlat27 = fma((-VGlobals._Speed.w), input.TEXCOORD0.x, 1.0);
    u_xlat1.xyz = float3(u_xlat27) * VGlobals._Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * VGlobals._Time.yyy;
    u_xlat27 = VGlobals._BoxSize.y + VGlobals._BoxSize.x;
    u_xlat27 = u_xlat27 + VGlobals._BoxSize.z;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat27 = fma((-VGlobals._SinCycle.w), input.TEXCOORD1.x, 1.0);
    u_xlat1.xyz = float3(u_xlat27) * VGlobals._SinCycle.xyz;
    u_xlat27 = input.TEXCOORD0.x + VGlobals._Time.y;
    u_xlat28 = input.TEXCOORD0.y + input.TEXCOORD0.x;
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat27), float3(u_xlat28));
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = fma((-VGlobals._SinAmp.w), input.TEXCOORD1.y, 1.0);
    u_xlat2.xyz = float3(u_xlat27) * VGlobals._SinAmp.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz / VGlobals._BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = VGlobals._BoxSize.xyz * float3(0.5, 0.5, 0.5);
    u_xlat1.xyz = fma(u_xlat0.xyz, VGlobals._BoxSize.xyz, (-u_xlat1.xyz));
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = fma(-abs(u_xlat0.xyz), float3(2.0, 2.0, 2.0), float3(1.0, 1.0, 1.0));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(VGlobals._BoxEdgeFadeXZ, VGlobals._BoxEdgeFadeY, VGlobals._BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / float3(VGlobals._BoxEdgeFadeXZ, VGlobals._BoxEdgeFadeY, VGlobals._BoxEdgeFadeXZ);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat2.xyz = u_xlat1.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, u_xlat1.zzz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-VGlobals._WorldSpaceCameraPos.xyzx.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, VGlobals._CamScaleLimitDist);
    u_xlat2.xy = float2(u_xlat27) + (-float2(VGlobals._CamNearFadeAlphaZeroDist, VGlobals._CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / VGlobals._CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = fma((-VGlobals._PtclScaleRnd), input.TEXCOORD1.x, 1.0);
    u_xlat3.xy = input.POSITION0.xy * float2(VGlobals._PtclScaleX, VGlobals._PtclScaleY);
    u_xlat3.z = input.POSITION0.z;
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = fma((-VGlobals._RotSpeed.w), input.TEXCOORD0.y, 1.0);
    u_xlat4.xyz = float3(u_xlat28) * VGlobals._RotSpeed.xyz;
    u_xlat28 = input.TEXCOORD1.y + input.TEXCOORD1.x;
    u_xlat28 = u_xlat28 + VGlobals._Time.y;
    u_xlat4.xyz = float3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = fma(u_xlat28, u_xlat4.y, u_xlat6.x);
    u_xlat8.z = fma(u_xlat6.x, u_xlat4.y, u_xlat28);
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = fma(u_xlat5.zx, u_xlat4.yy, (-u_xlat5.xz));
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = fma(u_xlat4.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat3 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat1.xxxx, u_xlat3);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.zzzz, u_xlat3);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat3);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-float2(VGlobals._CamNearFadeAlphaZeroDist, VGlobals._CamFarFadeAlphaOneDist)) + float2(VGlobals._CamNearFadeAlphaOneDist, VGlobals._CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0f, 1.0f);
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    output.COLOR0 = half4(u_xlat0);
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
    float4 _Time;
    float3 _WorldSpaceCameraPos;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    int _TileX;
    int _TileY;
    float _PtclScaleX;
    float _PtclScaleY;
    float _PtclScaleRnd;
    float4 _BoxSize;
    float4 _Speed;
    float4 _RotSpeed;
    float4 _SinCycle;
    float4 _SinAmp;
    float _CamNearFadeAlphaZeroDist;
    float _CamNearFadeAlphaOneDist;
    float _CamFarFadeAlphaZeroDist;
    float _CamFarFadeAlphaOneDist;
    float _CamScaleLimitDist;
    float _BoxEdgeFadeXZ;
    float _BoxEdgeFadeY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float2 TEXCOORD0 [[ attribute(1) ]] ;
    float2 TEXCOORD1 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 mtl_Position [[ position ]];
    half4 COLOR0 [[ user(COLOR0) ]];
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
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float4 u_xlat8;
    float2 u_xlat9;
    float2 u_xlat18;
    float u_xlat27;
    float u_xlat28;
    u_xlat0.xy = input.POSITION0.xy + float2(0.5, 0.5);
    u_xlat18.xy = float2(int2(VGlobals._TileX, VGlobals._TileY));
    u_xlat0.xy = u_xlat0.xy / u_xlat18.xy;
    u_xlat18.xy = u_xlat18.xy * input.TEXCOORD0.xy;
    u_xlat18.xy = trunc(u_xlat18.xy);
    u_xlat0.xy = fma(u_xlat18.xy, float2(0.5, 0.5), u_xlat0.xy);
    output.TEXCOORD0.xy = fma(u_xlat0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.xy = input.TEXCOORD0.xy;
    u_xlat0.z = input.TEXCOORD1.x;
    u_xlat0.xyz = u_xlat0.xyz * float3(10.0, 10.0, 10.0);
    u_xlat27 = fma((-VGlobals._Speed.w), input.TEXCOORD0.x, 1.0);
    u_xlat1.xyz = float3(u_xlat27) * VGlobals._Speed.xyz;
    u_xlat1.xyz = u_xlat1.xyz * VGlobals._Time.yyy;
    u_xlat27 = VGlobals._BoxSize.y + VGlobals._BoxSize.x;
    u_xlat27 = u_xlat27 + VGlobals._BoxSize.z;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat27 = fma((-VGlobals._SinCycle.w), input.TEXCOORD1.x, 1.0);
    u_xlat1.xyz = float3(u_xlat27) * VGlobals._SinCycle.xyz;
    u_xlat27 = input.TEXCOORD0.x + VGlobals._Time.y;
    u_xlat28 = input.TEXCOORD0.y + input.TEXCOORD0.x;
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat27), float3(u_xlat28));
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat27 = fma((-VGlobals._SinAmp.w), input.TEXCOORD1.y, 1.0);
    u_xlat2.xyz = float3(u_xlat27) * VGlobals._SinAmp.xyz;
    u_xlat0.xyz = fma(u_xlat2.xyz, u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz / VGlobals._BoxSize.xyz;
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = VGlobals._BoxSize.xyz * float3(0.5, 0.5, 0.5);
    u_xlat1.xyz = fma(u_xlat0.xyz, VGlobals._BoxSize.xyz, (-u_xlat1.xyz));
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.5, -0.5, -0.5);
    u_xlat0.xyz = fma(-abs(u_xlat0.xyz), float3(2.0, 2.0, 2.0), float3(1.0, 1.0, 1.0));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(VGlobals._BoxEdgeFadeXZ, VGlobals._BoxEdgeFadeY, VGlobals._BoxEdgeFadeXZ));
    u_xlat0.xyz = u_xlat0.xyz / float3(VGlobals._BoxEdgeFadeXZ, VGlobals._BoxEdgeFadeY, VGlobals._BoxEdgeFadeXZ);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat2.xyz = u_xlat1.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, u_xlat1.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, u_xlat1.zzz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-VGlobals._WorldSpaceCameraPos.xyzx.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = sqrt(u_xlat27);
    u_xlat28 = min(u_xlat27, VGlobals._CamScaleLimitDist);
    u_xlat2.xy = float2(u_xlat27) + (-float2(VGlobals._CamNearFadeAlphaZeroDist, VGlobals._CamFarFadeAlphaOneDist));
    u_xlat27 = u_xlat28 / VGlobals._CamScaleLimitDist;
    u_xlat27 = u_xlat27 + 0.00100000005;
    u_xlat28 = fma((-VGlobals._PtclScaleRnd), input.TEXCOORD1.x, 1.0);
    u_xlat3.xy = input.POSITION0.xy * float2(VGlobals._PtclScaleX, VGlobals._PtclScaleY);
    u_xlat3.z = input.POSITION0.z;
    u_xlat3.xyz = float3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = fma((-VGlobals._RotSpeed.w), input.TEXCOORD0.y, 1.0);
    u_xlat4.xyz = float3(u_xlat28) * VGlobals._RotSpeed.xyz;
    u_xlat28 = input.TEXCOORD1.y + input.TEXCOORD1.x;
    u_xlat28 = u_xlat28 + VGlobals._Time.y;
    u_xlat4.xyz = float3(u_xlat28) * u_xlat4.xyz;
    u_xlat5.xyz = cos(u_xlat4.xyz);
    u_xlat4.xyz = sin(u_xlat4.xyz);
    u_xlat28 = u_xlat4.z * u_xlat4.x;
    u_xlat6.xyz = u_xlat5.zzy * u_xlat5.xyx;
    u_xlat7.y = fma(u_xlat28, u_xlat4.y, u_xlat6.x);
    u_xlat8.z = fma(u_xlat6.x, u_xlat4.y, u_xlat28);
    u_xlat5 = u_xlat4.zxxz * u_xlat5.xyzy;
    u_xlat8.xy = fma(u_xlat5.zx, u_xlat4.yy, (-u_xlat5.xz));
    u_xlat5.x = (-u_xlat4.y);
    u_xlat7.z = u_xlat8.y;
    u_xlat7.x = u_xlat5.w;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat7.xyz);
    u_xlat8.w = u_xlat6.y;
    u_xlat5.z = u_xlat6.z;
    u_xlat4.z = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat4.x = dot(u_xlat3.yzx, u_xlat8.xzw);
    u_xlat1.xyz = fma(u_xlat4.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat3 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat1.xxxx, u_xlat3);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat1.zzzz, u_xlat3);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat3);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat9.xy = (-float2(VGlobals._CamNearFadeAlphaZeroDist, VGlobals._CamFarFadeAlphaOneDist)) + float2(VGlobals._CamNearFadeAlphaOneDist, VGlobals._CamFarFadeAlphaZeroDist);
    u_xlat9.xy = u_xlat2.xy / u_xlat9.xy;
    u_xlat9.xy = clamp(u_xlat9.xy, 0.0f, 1.0f);
    u_xlat18.x = (-u_xlat9.y) + 1.0;
    u_xlat9.x = u_xlat18.x * u_xlat9.x;
    u_xlat0.w = u_xlat0.x * u_xlat9.x;
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    output.COLOR0 = half4(u_xlat0);
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.w = u_xlat16_1 * FGlobals._Color.w;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    output.SV_Target0 = u_xlat16_0 * input.COLOR0;
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.w = u_xlat16_1 * FGlobals._Color.w;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    output.SV_Target0 = u_xlat16_0 * input.COLOR0;
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
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    half4 u_xlat16_0;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + half(1.0);
    u_xlat16_0.w = u_xlat16_1 * FGlobals._Color.w;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * FGlobals._Color.xyz;
    output.SV_Target0 = u_xlat16_0 * input.COLOR0;
    return output;
}
"
}
}
}
}
}
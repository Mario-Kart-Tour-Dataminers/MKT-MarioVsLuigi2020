//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_Fireworks" {
Properties {
_MainTex ("RGB(UV0)", 2D) = "white" { }
_AlphaTex ("A(UV0)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_TileX ("TileX", Float) = 1
_TileY ("TileY", Float) = 1
_PtclScaleX ("ParticleScaleX", Float) = 1
_PtclScaleY ("ParticleScaleY", Float) = 1
_PtclScaleRnd ("ParticleScaleRnd", Float) = 1
_EmitRadius ("EmitRadius", Float) = 0
_Speed ("Speed", Vector) = (0,0,0,0)
_RndSpeed ("RndSpeed", Float) = 1
_Gravity ("Gravity", Float) = -1
_PtclLife ("Life", Float) = 3
_FinalScale ("FinalScale", Float) = 0
_EmitterTime ("Time", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 40980
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    int _TileX;
    int _TileY;
    float _PtclScaleX;
    float _PtclScaleY;
    float _PtclScaleRnd;
    float _EmitRadius;
    float4 _Speed;
    float _RndSpeed;
    float _Gravity;
    float _PtclLife;
    float _FinalScale;
    float _EmitterTime;
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
    float3 u_xlat4;
    float u_xlat8;
    int u_xlati8;
    float2 u_xlat9;
    float u_xlat12;
    u_xlat0.x = VGlobals._EmitterTime / VGlobals._PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, float2(1.0, 0.999000013));
    u_xlati8 = VGlobals._TileY * VGlobals._TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = float2(int2(VGlobals._TileX, VGlobals._TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = input.POSITION0.xy + float2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = float2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = fma(u_xlat1.y, u_xlat4.y, u_xlat9.y);
    u_xlat2.x = fma(u_xlat1.x, u_xlat4.x, u_xlat9.x);
    output.TEXCOORD0.xy = fma(u_xlat2.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat4.x = VGlobals._FinalScale + -1.0;
    u_xlat0.x = fma(u_xlat0.x, u_xlat4.x, 1.0);
    u_xlat4.x = input.TEXCOORD0.y + input.TEXCOORD0.x;
    u_xlat8 = input.TEXCOORD1.y + input.TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * VGlobals._PtclScaleRnd;
    u_xlat4.x = fma((-u_xlat4.x), 0.25, 1.0);
    u_xlat1.xy = input.POSITION0.xy * float2(VGlobals._PtclScaleX, VGlobals._PtclScaleY);
    u_xlat1.z = input.POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = VGlobals._WorldSpaceCameraPos.xyzx.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals._WorldSpaceCameraPos.xyzx.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals._WorldSpaceCameraPos.xyzx.zzz, u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat2.xyz);
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = fma(u_xlat1.yzx, u_xlat2.zxy, (-u_xlat3.xyz));
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = fma(u_xlat0.xxx, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.zzz, u_xlat1.xyz, u_xlat0.xyw);
    u_xlat1.xy = input.TEXCOORD0.xy;
    u_xlat1.z = input.TEXCOORD1.x;
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = fma(float3(VGlobals._RndSpeed), u_xlat1.xyz, VGlobals._Speed.xyz);
    u_xlat1.xyz = u_xlat1.xyz * float3(VGlobals._EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * float3(VGlobals._EmitRadius);
    u_xlat12 = fma((-VGlobals._Speed.w), input.TEXCOORD1.y, 1.0);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat12 = VGlobals._EmitterTime * VGlobals._EmitterTime;
    u_xlat1.w = fma(u_xlat12, VGlobals._Gravity, u_xlat1.y);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    int _TileX;
    int _TileY;
    float _PtclScaleX;
    float _PtclScaleY;
    float _PtclScaleRnd;
    float _EmitRadius;
    float4 _Speed;
    float _RndSpeed;
    float _Gravity;
    float _PtclLife;
    float _FinalScale;
    float _EmitterTime;
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
    float3 u_xlat4;
    float u_xlat8;
    int u_xlati8;
    float2 u_xlat9;
    float u_xlat12;
    u_xlat0.x = VGlobals._EmitterTime / VGlobals._PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, float2(1.0, 0.999000013));
    u_xlati8 = VGlobals._TileY * VGlobals._TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = float2(int2(VGlobals._TileX, VGlobals._TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = input.POSITION0.xy + float2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = float2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = fma(u_xlat1.y, u_xlat4.y, u_xlat9.y);
    u_xlat2.x = fma(u_xlat1.x, u_xlat4.x, u_xlat9.x);
    output.TEXCOORD0.xy = fma(u_xlat2.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat4.x = VGlobals._FinalScale + -1.0;
    u_xlat0.x = fma(u_xlat0.x, u_xlat4.x, 1.0);
    u_xlat4.x = input.TEXCOORD0.y + input.TEXCOORD0.x;
    u_xlat8 = input.TEXCOORD1.y + input.TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * VGlobals._PtclScaleRnd;
    u_xlat4.x = fma((-u_xlat4.x), 0.25, 1.0);
    u_xlat1.xy = input.POSITION0.xy * float2(VGlobals._PtclScaleX, VGlobals._PtclScaleY);
    u_xlat1.z = input.POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = VGlobals._WorldSpaceCameraPos.xyzx.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals._WorldSpaceCameraPos.xyzx.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals._WorldSpaceCameraPos.xyzx.zzz, u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat2.xyz);
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = fma(u_xlat1.yzx, u_xlat2.zxy, (-u_xlat3.xyz));
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = fma(u_xlat0.xxx, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.zzz, u_xlat1.xyz, u_xlat0.xyw);
    u_xlat1.xy = input.TEXCOORD0.xy;
    u_xlat1.z = input.TEXCOORD1.x;
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = fma(float3(VGlobals._RndSpeed), u_xlat1.xyz, VGlobals._Speed.xyz);
    u_xlat1.xyz = u_xlat1.xyz * float3(VGlobals._EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * float3(VGlobals._EmitRadius);
    u_xlat12 = fma((-VGlobals._Speed.w), input.TEXCOORD1.y, 1.0);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat12 = VGlobals._EmitterTime * VGlobals._EmitterTime;
    u_xlat1.w = fma(u_xlat12, VGlobals._Gravity, u_xlat1.y);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    int _TileX;
    int _TileY;
    float _PtclScaleX;
    float _PtclScaleY;
    float _PtclScaleRnd;
    float _EmitRadius;
    float4 _Speed;
    float _RndSpeed;
    float _Gravity;
    float _PtclLife;
    float _FinalScale;
    float _EmitterTime;
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
    float3 u_xlat4;
    float u_xlat8;
    int u_xlati8;
    float2 u_xlat9;
    float u_xlat12;
    u_xlat0.x = VGlobals._EmitterTime / VGlobals._PtclLife;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = min(u_xlat0.xx, float2(1.0, 0.999000013));
    u_xlati8 = VGlobals._TileY * VGlobals._TileX;
    u_xlat8 = float(u_xlati8);
    u_xlat4.x = u_xlat8 * u_xlat0.y;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = max(u_xlat8, 0.0);
    u_xlat8 = min(u_xlat8, 0.999000013);
    u_xlat1.xy = float2(int2(VGlobals._TileX, VGlobals._TileY));
    u_xlat4.y = u_xlat8 * u_xlat1.y;
    u_xlat4.xy = trunc(u_xlat4.xy);
    u_xlat9.xy = input.POSITION0.xy + float2(0.5, 0.5);
    u_xlat9.xy = u_xlat9.xy / u_xlat1.xy;
    u_xlat1.xy = float2(1.0, 1.0) / u_xlat1.xy;
    u_xlat2.y = fma(u_xlat1.y, u_xlat4.y, u_xlat9.y);
    u_xlat2.x = fma(u_xlat1.x, u_xlat4.x, u_xlat9.x);
    output.TEXCOORD0.xy = fma(u_xlat2.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat4.x = VGlobals._FinalScale + -1.0;
    u_xlat0.x = fma(u_xlat0.x, u_xlat4.x, 1.0);
    u_xlat4.x = input.TEXCOORD0.y + input.TEXCOORD0.x;
    u_xlat8 = input.TEXCOORD1.y + input.TEXCOORD1.x;
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * VGlobals._PtclScaleRnd;
    u_xlat4.x = fma((-u_xlat4.x), 0.25, 1.0);
    u_xlat1.xy = input.POSITION0.xy * float2(VGlobals._PtclScaleX, VGlobals._PtclScaleY);
    u_xlat1.z = input.POSITION0.z;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat1.xyz = VGlobals._WorldSpaceCameraPos.xyzx.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals._WorldSpaceCameraPos.xyzx.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals._WorldSpaceCameraPos.xyzx.zzz, u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat2.xyz);
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat3.xyz = fma(u_xlat1.yzx, u_xlat2.zxy, (-u_xlat3.xyz));
    u_xlat2.xyz = u_xlat0.yyy * u_xlat2.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat3.xyz = u_xlat4.xxx * u_xlat3.xyz;
    u_xlat0.xyw = fma(u_xlat0.xxx, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat0.xyz = fma(u_xlat0.zzz, u_xlat1.xyz, u_xlat0.xyw);
    u_xlat1.xy = input.TEXCOORD0.xy;
    u_xlat1.z = input.TEXCOORD1.x;
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat2.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = fma(float3(VGlobals._RndSpeed), u_xlat1.xyz, VGlobals._Speed.xyz);
    u_xlat1.xyz = u_xlat1.xyz * float3(VGlobals._EmitterTime);
    u_xlat2.xyz = u_xlat2.xyz * float3(VGlobals._EmitRadius);
    u_xlat12 = fma((-VGlobals._Speed.w), input.TEXCOORD1.y, 1.0);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat12), u_xlat2.xyz);
    u_xlat12 = VGlobals._EmitterTime * VGlobals._EmitterTime;
    u_xlat1.w = fma(u_xlat12, VGlobals._Gravity, u_xlat1.y);
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xwz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
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
    half3 u_xlat16_0;
    half u_xlat16_1;
    u_xlat16_0.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_1 * FGlobals._Color.w;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    output.SV_Target0.xyz = u_xlat16_0.xyz * FGlobals._Color.xyz;
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
    half3 u_xlat16_0;
    half u_xlat16_1;
    u_xlat16_0.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_1 * FGlobals._Color.w;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    output.SV_Target0.xyz = u_xlat16_0.xyz * FGlobals._Color.xyz;
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
    half3 u_xlat16_0;
    half u_xlat16_1;
    u_xlat16_0.x = _AlphaTex.sample(sampler_AlphaTex, input.TEXCOORD0.xy).x;
    u_xlat16_1 = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_1 * FGlobals._Color.w;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    output.SV_Target0.xyz = u_xlat16_0.xyz * FGlobals._Color.xyz;
    return output;
}
"
}
}
}
}
}
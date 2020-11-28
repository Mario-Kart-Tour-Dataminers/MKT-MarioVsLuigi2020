//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Nature/Tree Soft Occlusion Leaves" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0.25, 0.9)) = 0.5
_BaseLight ("Base Light", Range(0, 1)) = 0.35
_AO ("Amb. Occlusion", Range(0, 10)) = 2.4
_Occlusion ("Dir Occlusion", Range(0, 20)) = 7.5
_TreeInstanceColor ("TreeInstanceColor", Vector) = (1,1,1,1)
_TreeInstanceScale ("TreeInstanceScale", Vector) = (1,1,1,1)
_SquashAmount ("Squash", Float) = 1
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TreeTransparentCutout" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TreeTransparentCutout" }
  Cull Off
  Lighting On
  GpuProgramID 62944
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _TreeInstanceColor;
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
    float _Occlusion;
    float _AO;
    float _BaseLight;
    half4 _Color;
    float4 hlslcc_mtx4x4_CameraToWorld[4];
    float _HalfOverCutoff;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    float3 u_xlat5;
    float u_xlat16;
    float u_xlat18;
    int u_xlati19;
    float u_xlat20;
    bool u_xlatb20;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat18 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat18)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, u_xlat0.www, u_xlat1.xyz);
    u_xlat2 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat2);
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat0.w = VGlobals._AO;
    u_xlat2.xyz = float3(u_xlat16_3.xyz);
    u_xlati19 = 0x0;
    while(true){
        u_xlatb20 = u_xlati19>=0x4;
        if(u_xlatb20){break;}
        u_xlat4.xyz = fma((-u_xlat1.xyz), VGlobals.unity_LightPosition[u_xlati19].www, VGlobals.unity_LightPosition[u_xlati19].xyz);
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = rsqrt(u_xlat20);
        u_xlat4.xyz = float3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * VGlobals.hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[0].xyz, u_xlat4.xxx, u_xlat5.xyz);
        u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[2].xyz, u_xlat4.zzz, u_xlat4.xyw);
        u_xlat20 = fma(u_xlat20, float(VGlobals.unity_LightAtten[u_xlati19].z), 1.0);
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * float3(VGlobals._Occlusion);
        u_xlat0.x = dot(input.TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + VGlobals._BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = fma(float3(VGlobals.unity_LightColor[u_xlati19].xyz), u_xlat0.xxx, u_xlat2.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = u_xlat2.xyz * float3(VGlobals._Color.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat0.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat0);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _TreeInstanceColor;
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
    float _Occlusion;
    float _AO;
    float _BaseLight;
    half4 _Color;
    float4 hlslcc_mtx4x4_CameraToWorld[4];
    float _HalfOverCutoff;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    float3 u_xlat5;
    float u_xlat16;
    float u_xlat18;
    int u_xlati19;
    float u_xlat20;
    bool u_xlatb20;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat18 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat18)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, u_xlat0.www, u_xlat1.xyz);
    u_xlat2 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat2);
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat0.w = VGlobals._AO;
    u_xlat2.xyz = float3(u_xlat16_3.xyz);
    u_xlati19 = 0x0;
    while(true){
        u_xlatb20 = u_xlati19>=0x4;
        if(u_xlatb20){break;}
        u_xlat4.xyz = fma((-u_xlat1.xyz), VGlobals.unity_LightPosition[u_xlati19].www, VGlobals.unity_LightPosition[u_xlati19].xyz);
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = rsqrt(u_xlat20);
        u_xlat4.xyz = float3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * VGlobals.hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[0].xyz, u_xlat4.xxx, u_xlat5.xyz);
        u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[2].xyz, u_xlat4.zzz, u_xlat4.xyw);
        u_xlat20 = fma(u_xlat20, float(VGlobals.unity_LightAtten[u_xlati19].z), 1.0);
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * float3(VGlobals._Occlusion);
        u_xlat0.x = dot(input.TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + VGlobals._BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = fma(float3(VGlobals.unity_LightColor[u_xlati19].xyz), u_xlat0.xxx, u_xlat2.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = u_xlat2.xyz * float3(VGlobals._Color.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat0.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat0);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _TreeInstanceColor;
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
    float _Occlusion;
    float _AO;
    float _BaseLight;
    half4 _Color;
    float4 hlslcc_mtx4x4_CameraToWorld[4];
    float _HalfOverCutoff;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    float3 u_xlat5;
    float u_xlat16;
    float u_xlat18;
    int u_xlati19;
    float u_xlat20;
    bool u_xlatb20;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat18 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat18 = u_xlat18 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat18)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, u_xlat0.www, u_xlat1.xyz);
    u_xlat2 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat2);
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat0.w = VGlobals._AO;
    u_xlat2.xyz = float3(u_xlat16_3.xyz);
    u_xlati19 = 0x0;
    while(true){
        u_xlatb20 = u_xlati19>=0x4;
        if(u_xlatb20){break;}
        u_xlat4.xyz = fma((-u_xlat1.xyz), VGlobals.unity_LightPosition[u_xlati19].www, VGlobals.unity_LightPosition[u_xlati19].xyz);
        u_xlat4.w = (-u_xlat4.z);
        u_xlat20 = dot(u_xlat4.xyw, u_xlat4.xyw);
        u_xlat16 = rsqrt(u_xlat20);
        u_xlat4.xyz = float3(u_xlat16) * u_xlat4.xyw;
        u_xlat5.xyz = u_xlat4.yyy * VGlobals.hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat4.xyw = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[0].xyz, u_xlat4.xxx, u_xlat5.xyz);
        u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[2].xyz, u_xlat4.zzz, u_xlat4.xyw);
        u_xlat20 = fma(u_xlat20, float(VGlobals.unity_LightAtten[u_xlati19].z), 1.0);
        u_xlat20 = float(1.0) / u_xlat20;
        u_xlat0.xyz = u_xlat4.xyz * float3(VGlobals._Occlusion);
        u_xlat0.x = dot(input.TANGENT0, u_xlat0);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + VGlobals._BaseLight;
        u_xlat0.x = u_xlat20 * u_xlat0.x;
        u_xlat2.xyz = fma(float3(VGlobals.unity_LightColor[u_xlati19].xyz), u_xlat0.xxx, u_xlat2.xyz);
        u_xlati19 = u_xlati19 + 0x1;
    }
    u_xlat0.xyz = u_xlat2.xyz * float3(VGlobals._Color.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat0.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat0);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _TreeInstanceColor;
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
    float _Occlusion;
    float _AO;
    float _BaseLight;
    half4 _Color;
    float4 hlslcc_mtx4x4_CameraToWorld[4];
    float _HalfOverCutoff;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float u_xlat19;
    float u_xlat21;
    int u_xlati22;
    float u_xlat25;
    bool u_xlatb25;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat21)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, u_xlat0.www, u_xlat1.xyz);
    u_xlat2 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat2);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat2);
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat2.w = VGlobals._AO;
    u_xlat4.xyz = float3(u_xlat16_3.xyz);
    u_xlati22 = 0x0;
    while(true){
        u_xlatb25 = u_xlati22>=0x4;
        if(u_xlatb25){break;}
        u_xlat5.xyz = fma((-u_xlat1.xyz), VGlobals.unity_LightPosition[u_xlati22].www, VGlobals.unity_LightPosition[u_xlati22].xyz);
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = rsqrt(u_xlat25);
        u_xlat5.xyz = float3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * VGlobals.hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[0].xyz, u_xlat5.xxx, u_xlat6.xyz);
        u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[2].xyz, u_xlat5.zzz, u_xlat5.xyw);
        u_xlat25 = fma(u_xlat25, float(VGlobals.unity_LightAtten[u_xlati22].z), 1.0);
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * float3(VGlobals._Occlusion);
        u_xlat2.x = dot(input.TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + VGlobals._BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = fma(float3(VGlobals.unity_LightColor[u_xlati22].xyz), u_xlat2.xxx, u_xlat4.xyz);
        u_xlati22 = u_xlati22 + 0x1;
    }
    u_xlat1.xyz = u_xlat4.xyz * float3(VGlobals._Color.xyz);
    u_xlat1.xyz = u_xlat1.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    u_xlat2.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * VGlobals._ProjectionParams.z;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    output.TEXCOORD2 = fma(u_xlat2.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat1.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat1);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _TreeInstanceColor;
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
    float _Occlusion;
    float _AO;
    float _BaseLight;
    half4 _Color;
    float4 hlslcc_mtx4x4_CameraToWorld[4];
    float _HalfOverCutoff;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float u_xlat19;
    float u_xlat21;
    int u_xlati22;
    float u_xlat25;
    bool u_xlatb25;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat21)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, u_xlat0.www, u_xlat1.xyz);
    u_xlat2 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat2);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat2);
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat2.w = VGlobals._AO;
    u_xlat4.xyz = float3(u_xlat16_3.xyz);
    u_xlati22 = 0x0;
    while(true){
        u_xlatb25 = u_xlati22>=0x4;
        if(u_xlatb25){break;}
        u_xlat5.xyz = fma((-u_xlat1.xyz), VGlobals.unity_LightPosition[u_xlati22].www, VGlobals.unity_LightPosition[u_xlati22].xyz);
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = rsqrt(u_xlat25);
        u_xlat5.xyz = float3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * VGlobals.hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[0].xyz, u_xlat5.xxx, u_xlat6.xyz);
        u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[2].xyz, u_xlat5.zzz, u_xlat5.xyw);
        u_xlat25 = fma(u_xlat25, float(VGlobals.unity_LightAtten[u_xlati22].z), 1.0);
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * float3(VGlobals._Occlusion);
        u_xlat2.x = dot(input.TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + VGlobals._BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = fma(float3(VGlobals.unity_LightColor[u_xlati22].xyz), u_xlat2.xxx, u_xlat4.xyz);
        u_xlati22 = u_xlati22 + 0x1;
    }
    u_xlat1.xyz = u_xlat4.xyz * float3(VGlobals._Color.xyz);
    u_xlat1.xyz = u_xlat1.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    u_xlat2.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * VGlobals._ProjectionParams.z;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    output.TEXCOORD2 = fma(u_xlat2.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat1.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat1);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _TreeInstanceColor;
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
    float _Occlusion;
    float _AO;
    float _BaseLight;
    half4 _Color;
    float4 hlslcc_mtx4x4_CameraToWorld[4];
    float _HalfOverCutoff;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_3;
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float u_xlat19;
    float u_xlat21;
    int u_xlati22;
    float u_xlat25;
    bool u_xlatb25;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat21)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, u_xlat0.www, u_xlat1.xyz);
    u_xlat2 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat2);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat2);
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat2.w = VGlobals._AO;
    u_xlat4.xyz = float3(u_xlat16_3.xyz);
    u_xlati22 = 0x0;
    while(true){
        u_xlatb25 = u_xlati22>=0x4;
        if(u_xlatb25){break;}
        u_xlat5.xyz = fma((-u_xlat1.xyz), VGlobals.unity_LightPosition[u_xlati22].www, VGlobals.unity_LightPosition[u_xlati22].xyz);
        u_xlat5.w = (-u_xlat5.z);
        u_xlat25 = dot(u_xlat5.xyw, u_xlat5.xyw);
        u_xlat19 = rsqrt(u_xlat25);
        u_xlat5.xyz = float3(u_xlat19) * u_xlat5.xyw;
        u_xlat6.xyz = u_xlat5.yyy * VGlobals.hlslcc_mtx4x4_CameraToWorld[1].xyz;
        u_xlat5.xyw = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[0].xyz, u_xlat5.xxx, u_xlat6.xyz);
        u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4_CameraToWorld[2].xyz, u_xlat5.zzz, u_xlat5.xyw);
        u_xlat25 = fma(u_xlat25, float(VGlobals.unity_LightAtten[u_xlati22].z), 1.0);
        u_xlat25 = float(1.0) / u_xlat25;
        u_xlat2.xyz = u_xlat5.xyz * float3(VGlobals._Occlusion);
        u_xlat2.x = dot(input.TANGENT0, u_xlat2);
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat2.x = u_xlat2.x + VGlobals._BaseLight;
        u_xlat2.x = u_xlat25 * u_xlat2.x;
        u_xlat4.xyz = fma(float3(VGlobals.unity_LightColor[u_xlati22].xyz), u_xlat2.xxx, u_xlat4.xyz);
        u_xlati22 = u_xlati22 + 0x1;
    }
    u_xlat1.xyz = u_xlat4.xyz * float3(VGlobals._Color.xyz);
    u_xlat1.xyz = u_xlat1.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    u_xlat2.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * VGlobals._ProjectionParams.z;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    output.TEXCOORD2 = fma(u_xlat2.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat1.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat1);
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_1;
    bool u_xlatb2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-FGlobals._Cutoff);
    u_xlatb2 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0.xyz = u_xlat16_0.xyz * input.TEXCOORD1.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_1;
    bool u_xlatb2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-FGlobals._Cutoff);
    u_xlatb2 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0.xyz = u_xlat16_0.xyz * input.TEXCOORD1.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_1;
    bool u_xlatb2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-FGlobals._Cutoff);
    u_xlatb2 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0.xyz = u_xlat16_0.xyz * input.TEXCOORD1.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float u_xlat11;
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
    u_xlat16_1 = half(u_xlat0.w + (-float(FGlobals._Cutoff)));
    u_xlatb2 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(input.TEXCOORD1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat11 = input.TEXCOORD2;
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat11), u_xlat2.xyz, float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float u_xlat11;
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
    u_xlat16_1 = half(u_xlat0.w + (-float(FGlobals._Cutoff)));
    u_xlatb2 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(input.TEXCOORD1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat11 = input.TEXCOORD2;
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat11), u_xlat2.xyz, float3(FGlobals.unity_FogColor.xyz));
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_1;
    float3 u_xlat2;
    bool u_xlatb2;
    float u_xlat11;
    u_xlat0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy));
    u_xlat16_1 = half(u_xlat0.w + (-float(FGlobals._Cutoff)));
    u_xlatb2 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(input.TEXCOORD1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat11 = input.TEXCOORD2;
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat11), u_xlat2.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
}
}
 Pass {
  Name "ShadowCaster"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "TreeTransparentCutout" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 124597
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_LightShadowBias;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
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
    float u_xlat6;
    float u_xlat9;
    float u_xlat10;
    bool u_xlatb10;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat9 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat9)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = fma((-u_xlat0.xyz), VGlobals._WorldSpaceLightPos0.www, VGlobals._WorldSpaceLightPos0.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * VGlobals.unity_LightShadowBias.z;
    u_xlat1.xyz = fma((-u_xlat2.xyz), u_xlat1.xxx, u_xlat0.xyz);
    u_xlatb10 = VGlobals.unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    u_xlat1.x = VGlobals.unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = min(u_xlat0.w, u_xlat6);
    output.mtl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    output.mtl_Position.z = fma(VGlobals.unity_LightShadowBias.y, u_xlat0.x, u_xlat6);
    output.TEXCOORD1.xy = input.TEXCOORD0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_LightShadowBias;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
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
    float u_xlat6;
    float u_xlat9;
    float u_xlat10;
    bool u_xlatb10;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat9 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat9)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = fma((-u_xlat0.xyz), VGlobals._WorldSpaceLightPos0.www, VGlobals._WorldSpaceLightPos0.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * VGlobals.unity_LightShadowBias.z;
    u_xlat1.xyz = fma((-u_xlat2.xyz), u_xlat1.xxx, u_xlat0.xyz);
    u_xlatb10 = VGlobals.unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    u_xlat1.x = VGlobals.unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = min(u_xlat0.w, u_xlat6);
    output.mtl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    output.mtl_Position.z = fma(VGlobals.unity_LightShadowBias.y, u_xlat0.x, u_xlat6);
    output.TEXCOORD1.xy = input.TEXCOORD0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_LightShadowBias;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
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
    float u_xlat6;
    float u_xlat9;
    float u_xlat10;
    bool u_xlatb10;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat9 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat9)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = fma((-u_xlat0.xyz), VGlobals._WorldSpaceLightPos0.www, VGlobals._WorldSpaceLightPos0.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * VGlobals.unity_LightShadowBias.z;
    u_xlat1.xyz = fma((-u_xlat2.xyz), u_xlat1.xxx, u_xlat0.xyz);
    u_xlatb10 = VGlobals.unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    u_xlat1.x = VGlobals.unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = min(u_xlat1.x, 0.0);
    u_xlat1.x = max(u_xlat1.x, -1.0);
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = min(u_xlat0.w, u_xlat6);
    output.mtl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    output.mtl_Position.z = fma(VGlobals.unity_LightShadowBias.y, u_xlat0.x, u_xlat6);
    output.TEXCOORD1.xy = input.TEXCOORD0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_LightShadowBias;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
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
    float u_xlat9;
    float u_xlat10;
    bool u_xlatb10;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat9 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat9)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = fma((-u_xlat0.xyz), VGlobals._WorldSpaceLightPos0.www, VGlobals._WorldSpaceLightPos0.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * VGlobals.unity_LightShadowBias.z;
    u_xlat1.xyz = fma((-u_xlat2.xyz), u_xlat1.xxx, u_xlat0.xyz);
    u_xlatb10 = VGlobals.unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    output.mtl_Position.z = fma(VGlobals.unity_LightShadowBias.y, u_xlat1.x, u_xlat0.z);
    output.mtl_Position.xyw = u_xlat0.xyw;
    output.TEXCOORD1.xy = input.TEXCOORD0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_LightShadowBias;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
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
    float u_xlat9;
    float u_xlat10;
    bool u_xlatb10;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat9 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat9)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = fma((-u_xlat0.xyz), VGlobals._WorldSpaceLightPos0.www, VGlobals._WorldSpaceLightPos0.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * VGlobals.unity_LightShadowBias.z;
    u_xlat1.xyz = fma((-u_xlat2.xyz), u_xlat1.xxx, u_xlat0.xyz);
    u_xlatb10 = VGlobals.unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    output.mtl_Position.z = fma(VGlobals.unity_LightShadowBias.y, u_xlat1.x, u_xlat0.z);
    output.mtl_Position.xyw = u_xlat0.xyw;
    output.TEXCOORD1.xy = input.TEXCOORD0.xy;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_LightShadowBias;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _TreeInstanceScale;
    float4 hlslcc_mtx4x4_TerrainEngineBendTree[4];
    float4 _SquashPlaneNormal;
    float _SquashAmount;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
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
    float u_xlat9;
    float u_xlat10;
    bool u_xlatb10;
    u_xlat0.xyz = input.POSITION0.xyz * VGlobals._TreeInstanceScale.xyz;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4_TerrainEngineBendTree[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma((-input.POSITION0.xyz), VGlobals._TreeInstanceScale.xyz, u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(input.COLOR0.www), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat9 = dot(VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat9 = u_xlat9 + VGlobals._SquashPlaneNormal.w;
    u_xlat1.xyz = fma((-float3(u_xlat9)), VGlobals._SquashPlaneNormal.xyz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(float3(VGlobals._SquashAmount), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], u_xlat0.xxxx, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = fma((-u_xlat0.xyz), VGlobals._WorldSpaceLightPos0.www, VGlobals._WorldSpaceLightPos0.xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat2.xyz = float3(u_xlat10) * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * VGlobals.unity_LightShadowBias.z;
    u_xlat1.xyz = fma((-u_xlat2.xyz), u_xlat1.xxx, u_xlat0.xyz);
    u_xlatb10 = VGlobals.unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    output.mtl_Position.z = fma(VGlobals.unity_LightShadowBias.y, u_xlat1.x, u_xlat0.z);
    output.mtl_Position.xyw = u_xlat0.xyw;
    output.TEXCOORD1.xy = input.TEXCOORD0.xy;
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_0;
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-FGlobals._Cutoff);
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_0;
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-FGlobals._Cutoff);
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_0;
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-FGlobals._Cutoff);
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_0;
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-FGlobals._Cutoff);
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_0;
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-FGlobals._Cutoff);
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
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
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    half u_xlat16_0;
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 + (-FGlobals._Cutoff);
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
}
}
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 148057
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb1;
    float3 u_xlat2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    int u_xlati18;
    half u_xlat16_21;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.y = dot(u_xlat1.xyz, input.NORMAL0.xyz);
    u_xlat0.z = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz;
    u_xlati18 = 0x0;
    while(true){
        u_xlatb1 = u_xlati18>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb1){break;}
        u_xlat16_21 = dot(u_xlat0.xyz, VGlobals.unity_LightPosition[u_xlati18].xyz);
        u_xlat16_21 = max(u_xlat16_21, half(0.0));
        u_xlat16_5.xyz = half3(u_xlat16_21) * VGlobals._Color.xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * VGlobals.unity_LightColor[u_xlati18].xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.5, 0.5, 0.5);
        u_xlat16_5.xyz = min(u_xlat16_5.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlati18 = u_xlati18 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_4.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb1;
    float3 u_xlat2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    int u_xlati18;
    half u_xlat16_21;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.y = dot(u_xlat1.xyz, input.NORMAL0.xyz);
    u_xlat0.z = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz;
    u_xlati18 = 0x0;
    while(true){
        u_xlatb1 = u_xlati18>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb1){break;}
        u_xlat16_21 = dot(u_xlat0.xyz, VGlobals.unity_LightPosition[u_xlati18].xyz);
        u_xlat16_21 = max(u_xlat16_21, half(0.0));
        u_xlat16_5.xyz = half3(u_xlat16_21) * VGlobals._Color.xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * VGlobals.unity_LightColor[u_xlati18].xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.5, 0.5, 0.5);
        u_xlat16_5.xyz = min(u_xlat16_5.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlati18 = u_xlati18 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_4.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb1;
    float3 u_xlat2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    int u_xlati18;
    half u_xlat16_21;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.y = dot(u_xlat1.xyz, input.NORMAL0.xyz);
    u_xlat0.z = dot(u_xlat2.xyz, input.NORMAL0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz;
    u_xlati18 = 0x0;
    while(true){
        u_xlatb1 = u_xlati18>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb1){break;}
        u_xlat16_21 = dot(u_xlat0.xyz, VGlobals.unity_LightPosition[u_xlati18].xyz);
        u_xlat16_21 = max(u_xlat16_21, half(0.0));
        u_xlat16_5.xyz = half3(u_xlat16_21) * VGlobals._Color.xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * VGlobals.unity_LightColor[u_xlati18].xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * half3(0.5, 0.5, 0.5);
        u_xlat16_5.xyz = min(u_xlat16_5.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
        u_xlati18 = u_xlati18 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_4.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "POINT" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat31);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
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
Keywords { "POINT" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat31);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
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
Keywords { "POINT" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat31);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SPOT" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 unity_SpotDirection[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat32);
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, VGlobals.unity_SpotDirection[u_xlati30].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = half(u_xlat31 + (-float(VGlobals.unity_LightAtten[u_xlati30].x)));
        u_xlat16_38 = u_xlat16_38 * VGlobals.unity_LightAtten[u_xlati30].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * half(0.5);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
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
Keywords { "SPOT" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 unity_SpotDirection[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat32);
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, VGlobals.unity_SpotDirection[u_xlati30].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = half(u_xlat31 + (-float(VGlobals.unity_LightAtten[u_xlati30].x)));
        u_xlat16_38 = u_xlat16_38 * VGlobals.unity_LightAtten[u_xlati30].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * half(0.5);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
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
Keywords { "SPOT" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 unity_SpotDirection[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
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
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat32);
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, VGlobals.unity_SpotDirection[u_xlati30].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = half(u_xlat31 + (-float(VGlobals.unity_LightAtten[u_xlati30].x)));
        u_xlat16_38 = u_xlat16_38 * VGlobals.unity_LightAtten[u_xlati30].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * half(0.5);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb31;
    half u_xlat16_37;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat16_37 = dot(u_xlat1.xyz, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat16_37 = max(u_xlat16_37, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_37) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * half3(0.5, 0.5, 0.5);
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb31;
    half u_xlat16_37;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat16_37 = dot(u_xlat1.xyz, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat16_37 = max(u_xlat16_37, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_37) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * half3(0.5, 0.5, 0.5);
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
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
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat30;
    int u_xlati30;
    bool u_xlatb31;
    half u_xlat16_37;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat16_37 = dot(u_xlat1.xyz, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat16_37 = max(u_xlat16_37, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_37) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * half3(0.5, 0.5, 0.5);
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat31);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat31);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = u_xlat32 * 0.5;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat31);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 unity_SpotDirection[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat32);
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, VGlobals.unity_SpotDirection[u_xlati30].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = half(u_xlat31 + (-float(VGlobals.unity_LightAtten[u_xlati30].x)));
        u_xlat16_38 = u_xlat16_38 * VGlobals.unity_LightAtten[u_xlati30].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * half(0.5);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 unity_SpotDirection[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat32);
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, VGlobals.unity_SpotDirection[u_xlati30].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = half(u_xlat31 + (-float(VGlobals.unity_LightAtten[u_xlati30].x)));
        u_xlat16_38 = u_xlat16_38 * VGlobals.unity_LightAtten[u_xlati30].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * half(0.5);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_LightColor[8];
    float4 unity_LightPosition[8];
    half4 unity_LightAtten[8];
    float4 unity_SpotDirection[8];
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    half4 glstate_lightmodel_ambient;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixInvV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    half4 _Color;
    int4 unity_VertexLightParams;
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float3 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    half4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    half TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 mtl_Position [[ position ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    bool u_xlatb3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    bool u_xlatb13;
    float u_xlat30;
    int u_xlati30;
    float u_xlat31;
    bool u_xlatb31;
    float u_xlat32;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xxx, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].zzz, u_xlat0.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].www, u_xlat0.xyz);
    u_xlat1.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].zzz, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].www, u_xlat1.xyz);
    u_xlat2.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].zzz, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].www, u_xlat2.xyz);
    u_xlat3.xyz = VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xxx, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].zzz, u_xlat3.xyz);
    u_xlat3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].xyz, VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].www, u_xlat3.xyz);
    u_xlat4.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].xxx, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].zzz, u_xlat4.xyz);
    u_xlat4.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[0].www, u_xlat4.xyz);
    u_xlat5.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].zzz, u_xlat5.xyz);
    u_xlat5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[1].www, u_xlat5.xyz);
    u_xlat6.xyz = VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz * VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].zzz, u_xlat6.xyz);
    u_xlat6.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToObject[3].xyz, VGlobals.hlslcc_mtx4x4unity_MatrixInvV[2].www, u_xlat6.xyz);
    u_xlat1.xyz = u_xlat1.xyz * input.POSITION0.yyy;
    u_xlat0.xyz = fma(u_xlat0.xyz, input.POSITION0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat2.xyz, input.POSITION0.zzz, u_xlat0.xyz);
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, input.NORMAL0.xyz);
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat1.xyz = float3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_7.xyz = VGlobals.glstate_lightmodel_ambient.xyz * VGlobals._Color.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlati30 = 0x0;
    while(true){
        u_xlatb31 = u_xlati30>=VGlobals.unity_VertexLightParams.x;
        if(u_xlatb31){break;}
        u_xlat2.xyz = fma((-u_xlat0.xyz), VGlobals.unity_LightPosition[u_xlati30].www, VGlobals.unity_LightPosition[u_xlati30].xyz);
        u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat32 = fma(float(VGlobals.unity_LightAtten[u_xlati30].z), u_xlat31, 1.0);
        u_xlat32 = float(1.0) / u_xlat32;
        u_xlatb3 = 0.0!=VGlobals.unity_LightPosition[u_xlati30].w;
        u_xlatb13 = float(VGlobals.unity_LightAtten[u_xlati30].w)<u_xlat31;
        u_xlatb3 = u_xlatb13 && u_xlatb3;
        u_xlat16_37 = (u_xlatb3) ? half(0.0) : half(u_xlat32);
        u_xlat31 = max(u_xlat31, 9.99999997e-07);
        u_xlat31 = rsqrt(u_xlat31);
        u_xlat2.xyz = float3(u_xlat31) * u_xlat2.xyz;
        u_xlat31 = dot(u_xlat2.xyz, VGlobals.unity_SpotDirection[u_xlati30].xyz);
        u_xlat31 = max(u_xlat31, 0.0);
        u_xlat16_38 = half(u_xlat31 + (-float(VGlobals.unity_LightAtten[u_xlati30].x)));
        u_xlat16_38 = u_xlat16_38 * VGlobals.unity_LightAtten[u_xlati30].y;
        u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
        u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
        u_xlat16_37 = u_xlat16_37 * half(0.5);
        u_xlat16_38 = dot(u_xlat1.xyz, u_xlat2.xyz);
        u_xlat16_38 = max(u_xlat16_38, half(0.0));
        u_xlat16_9.xyz = half3(u_xlat16_38) * VGlobals._Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * VGlobals.unity_LightColor[u_xlati30].xyz;
        u_xlat16_9.xyz = half3(u_xlat16_37) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, half3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
        u_xlati30 = u_xlati30 + 0x1;
    }
    output.COLOR0.xyz = u_xlat16_8.xyz;
    output.COLOR0.xyz = clamp(output.COLOR0.xyz, 0.0h, 1.0h);
    output.COLOR0.w = VGlobals._Color.w;
    output.COLOR0.w = clamp(output.COLOR0.w, 0.0h, 1.0h);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat1 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat1 = u_xlat1 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD1 = half(u_xlat0.x);
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "POINT" }
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "POINT" }
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "POINT" }
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SPOT" }
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SPOT" }
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SPOT" }
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
    half _Cutoff;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    output.SV_Target0.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
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
    half4 unity_FogColor;
    half _Cutoff;
};

struct Mtl_FragmentIn
{
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    half TEXCOORD1 [[ user(TEXCOORD1) ]] ;
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
    bool u_xlatb1;
    half3 u_xlat16_2;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.w<FGlobals._Cutoff;
    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_2.xyz = u_xlat16_0.xyz * input.COLOR0.xyz;
    output.SV_Target0.w = u_xlat16_0.w;
    u_xlat16_2.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), (-FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = fma(input.TEXCOORD1, u_xlat16_2.xyz, FGlobals.unity_FogColor.xyz);
    return output;
}
"
}
}
}
}
}
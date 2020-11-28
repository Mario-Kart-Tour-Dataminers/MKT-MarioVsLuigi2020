//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Nature/Tree Soft Occlusion Leaves Rendertex" {
Properties {
_Color ("Main Color", Color) = (1,1,1,0)
_MainTex ("Main Texture", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_HalfOverCutoff ("0.5 / Alpha cutoff", Range(0, 1)) = 1
_BaseLight ("Base Light", Range(0, 1)) = 0.35
_AO ("Amb. Occlusion", Range(0, 10)) = 2.4
_Occlusion ("Dir Occlusion", Range(0, 20)) = 7.5
_TreeInstanceColor ("TreeInstanceColor", Vector) = (1,1,1,1)
_TreeInstanceScale ("TreeInstanceScale", Vector) = (1,1,1,1)
_SquashAmount ("Squash", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "AlphaTest" }
 Pass {
  Tags { "QUEUE" = "AlphaTest" }
  Cull Off
  Lighting On
  GpuProgramID 49758
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
    half4 glstate_lightmodel_ambient;
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
    float3 _TerrainTreeLightDirections[4];
    float4 _TerrainTreeLightColors[4];
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
    half3 u_xlat16_2;
    float u_xlat9;
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
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat0.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[0].xyzx.xyz;
    u_xlat0.w = VGlobals._AO;
    u_xlat0.x = dot(input.TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + VGlobals._BaseLight;
    u_xlat16_2.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[0].xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[1].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[1].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[2].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[2].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[3].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[3].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._Color.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._TreeInstanceColor.xyz);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
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
    float3 _TerrainTreeLightDirections[4];
    float4 _TerrainTreeLightColors[4];
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
    half3 u_xlat16_2;
    float u_xlat9;
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
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat0.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[0].xyzx.xyz;
    u_xlat0.w = VGlobals._AO;
    u_xlat0.x = dot(input.TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + VGlobals._BaseLight;
    u_xlat16_2.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[0].xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[1].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[1].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[2].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[2].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[3].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[3].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._Color.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._TreeInstanceColor.xyz);
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
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    half4 glstate_lightmodel_ambient;
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
    float3 _TerrainTreeLightDirections[4];
    float4 _TerrainTreeLightColors[4];
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
    half3 u_xlat16_2;
    float u_xlat9;
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
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD0 = input.TEXCOORD0;
    u_xlat0.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[0].xyzx.xyz;
    u_xlat0.w = VGlobals._AO;
    u_xlat0.x = dot(input.TANGENT0, u_xlat0);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x + VGlobals._BaseLight;
    u_xlat16_2.xyz = VGlobals.glstate_lightmodel_ambient.xyz + VGlobals.glstate_lightmodel_ambient.xyz;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[0].xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[1].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[1].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[2].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[2].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat1.xyz = float3(VGlobals._Occlusion) * VGlobals._TerrainTreeLightDirections[3].xyzx.xyz;
    u_xlat1.w = VGlobals._AO;
    u_xlat9 = dot(input.TANGENT0, u_xlat1);
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat9 = u_xlat9 + VGlobals._BaseLight;
    u_xlat0.xyz = fma(VGlobals._TerrainTreeLightColors[3].xyz, float3(u_xlat9), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._Color.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(VGlobals._TreeInstanceColor.xyz);
    u_xlat0.w = VGlobals._HalfOverCutoff * 0.5;
    output.TEXCOORD1 = half4(u_xlat0);
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
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-FGlobals._Cutoff);
    output.SV_Target0.xyz = u_xlat16_0.xyz * input.TEXCOORD1.xyz;
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0.w = half(1.0);
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
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-FGlobals._Cutoff);
    output.SV_Target0.xyz = u_xlat16_0.xyz * input.TEXCOORD1.xyz;
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0.w = half(1.0);
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
    bool u_xlatb0;
    half u_xlat16_1;
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w + (-FGlobals._Cutoff);
    output.SV_Target0.xyz = u_xlat16_0.xyz * input.TEXCOORD1.xyz;
    u_xlatb0 = u_xlat16_1<half(0.0);
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
}
}
}
}
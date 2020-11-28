//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_Msk_EzLight_Zoff" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
[Header(Simple Lighting)] _reflectance ("Reflectance", Range(0, 1)) = 1
_Occlusion ("Occlusion", Range(0, 1)) = 1
[KeywordEnum(DISABLE, ENABLE)] _FOG ("Fog", Float) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(Z Offset)] _zOffset ("Z Offset", Float) = 0
}
SubShader {
 LOD 200
 Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 33076
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "_FOG_DISABLE" }
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
    float4 _AlphaTexture_ST;
    float _zOffset;
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
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_FOG_DISABLE" }
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
    float4 _AlphaTexture_ST;
    float _zOffset;
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
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_FOG_DISABLE" }
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
    float4 _AlphaTexture_ST;
    float _zOffset;
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
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 _AlphaTexture_ST;
    float _zOffset;
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
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    output.TEXCOORD5 = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 _AlphaTexture_ST;
    float _zOffset;
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
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    output.TEXCOORD5 = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 _AlphaTexture_ST;
    float _zOffset;
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
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    output.TEXCOORD5 = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_FOG_ENABLE" }
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
    float4 _AlphaTexture_ST;
    float _zOffset;
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
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_FOG_ENABLE" }
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
    float4 _AlphaTexture_ST;
    float _zOffset;
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
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_FOG_ENABLE" }
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
    float4 _AlphaTexture_ST;
    float _zOffset;
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
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 _AlphaTexture_ST;
    float _zOffset;
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
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    output.TEXCOORD5 = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 _AlphaTexture_ST;
    float _zOffset;
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
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    output.TEXCOORD5 = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_FogParams;
    float4 _AlphaTexture_ST;
    float _zOffset;
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
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = (-u_xlat0.xyz) + VGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    u_xlat1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(VGlobals._zOffset), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    output.TEXCOORD5 = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.COLOR0 = float4(input.COLOR0);
    output.TEXCOORD1.xy = fma(float2(input.TEXCOORD0.xy), VGlobals._AlphaTexture_ST.xy, VGlobals._AlphaTexture_ST.zw);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal hw_tier00 " {
Keywords { "_FOG_DISABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_FOG_DISABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_FOG_DISABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_DISABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "_FOG_ENABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "_FOG_ENABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "_FOG_ENABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    half3 u_xlat16_2;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    output.SV_Target0.xyz = float3(u_xlat16_0.xyz) * float3(u_xlat16_2.xyz);
    u_xlat16_1 = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1 = (-u_xlat16_1) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, u_xlat16_0.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat3 = input.TEXCOORD5;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    output.SV_Target0.xyz = fma(float3(u_xlat3), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_1.x = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_1.x) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1.x) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, u_xlat16_0.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat3 = input.TEXCOORD5;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    output.SV_Target0.xyz = fma(float3(u_xlat3), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_1.x = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_1.x) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1.x) * u_xlat1.w;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "FOG_LINEAR" "_FOG_ENABLE" }
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
    half4 _LightColor0;
    half4 _Color;
    half _reflectance;
    half _Occlusion;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_AlphaTexture [[ sampler (0) ]],
    texture2d<half, access::sample > _AlphaTexture [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    u_xlat16_0.xyz = fma(FGlobals._LightColor0.xyz, half3(FGlobals._reflectance), half3(FGlobals._Occlusion));
    u_xlat1 = input.COLOR0 * float4(FGlobals._Color);
    u_xlat16_2.xyz = half3(u_xlat1.xyz * float3(0.779083729, 0.779083729, 0.779083729));
    u_xlat16_1.xyz = fma(u_xlat16_2.xyz, u_xlat16_0.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat3 = input.TEXCOORD5;
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    output.SV_Target0.xyz = fma(float3(u_xlat3), float3(u_xlat16_1.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_1.x = _AlphaTexture.sample(sampler_AlphaTexture, input.TEXCOORD1.xy).x;
    u_xlat16_1.x = (-u_xlat16_1.x) + half(1.0);
    output.SV_Target0.w = float(u_xlat16_1.x) * u_xlat1.w;
    return output;
}
"
}
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/ドライバー/Character_Ambient_AddUVScrollUV1" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_FixedAmbientColor ("固定環境光色", Color) = (1,1,1,1)
_MinMSA ("Min MSA", Vector) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map", 2D) = "black" { }
_Occlusion ("Occlusion", Range(0, 1)) = 1
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_Add ("Add(UV1)", 2D) = "black" { }
[Header(Add UV Scroll)] _AddScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AddScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Space(10)] _SphereMap ("SphereMap", 2D) = "black" { }
_SphereMapScale ("SphereMap Scale", Vector) = (1,1,1,1)
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 128
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 20852
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_0 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = fma(u_xlat2.ywx, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.z = u_xlat2.x;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.TEXCOORD3.z = u_xlat2.y;
    output.TEXCOORD4.z = u_xlat2.w;
    output.COLOR0 = input.COLOR0;
    u_xlat16_4 = half(u_xlat2.y * u_xlat2.y);
    u_xlat16_4 = half(fma(u_xlat2.x, u_xlat2.x, (-float(u_xlat16_4))));
    u_xlat16_1 = half4(u_xlat2.ywzx * u_xlat2);
    u_xlat16_5.x = dot(VGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(VGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(VGlobals.unity_SHBb, u_xlat16_1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_4), u_xlat16_5.xyz);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat18, float(u_xlat16_4));
    output.TEXCOORD7.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    half u_xlat16_4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z / VGlobals._ProjectionParams.y;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 * VGlobals._ProjectionParams.z;
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat15 = fma(u_xlat15, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    output.TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = fma(u_xlat1.zxy, u_xlat2.yzx, (-u_xlat3.xyz));
    u_xlat0.x = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat2.z;
    output.TEXCOORD2.z = u_xlat1.y;
    output.TEXCOORD3.x = u_xlat2.x;
    output.TEXCOORD4.x = u_xlat2.y;
    output.TEXCOORD3.z = u_xlat1.z;
    output.TEXCOORD4.z = u_xlat1.x;
    output.TEXCOORD3.w = u_xlat0.y;
    output.TEXCOORD4.w = u_xlat0.z;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat15, float(u_xlat16_4));
    output.TEXCOORD7.zw = float2(0.0, 0.0);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat39) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_11.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_11.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat39 = input.TEXCOORD6;
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat39), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat39) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_11.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_11.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float u_xlat11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    half u_xlat16_14;
    float u_xlat22;
    half u_xlat16_25;
    float u_xlat33;
    float u_xlat34;
    bool u_xlatb34;
    float u_xlat35;
    half u_xlat16_35;
    half u_xlat16_36;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat12.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat12.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat1.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat33), float3(u_xlat16_3.xyz));
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + half(-1.0);
    u_xlat16_25 = fma(FGlobals._Occlusion, u_xlat16_25, half(1.0));
    u_xlat16_25 = max(u_xlat16_25, FGlobals._MinMSA.z);
    u_xlat33 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb34 = u_xlat33<0.00499999989;
    u_xlat35 = u_xlat33 * 8.29800034;
    u_xlat16_6.x = (u_xlatb34) ? half(0.0) : half(u_xlat35);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat33 * u_xlat33;
    u_xlat16_39 = half(u_xlat33 * u_xlat1.x);
    u_xlat33 = fma(u_xlat33, u_xlat33, 1.5);
    u_xlat16_39 = fma((-u_xlat16_39), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_39);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD1.zw;
    u_xlat16_2 = _Add.sample(sampler_Add, u_xlat2.xy);
    u_xlat16_35 = u_xlat16_2.w * input.COLOR0.w;
    u_xlat16_2.xyz = half3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    u_xlat16_9.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + half3(u_xlat16_14);
    u_xlat16_10.xyz = fma(half3(u_xlat16_36), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_10.xyz;
    u_xlat12.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12.x = max(u_xlat12.x, 0.00100000005);
    u_xlat12.x = rsqrt(u_xlat12.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat12.xxx;
    u_xlat12.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat11 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat22 = max(u_xlat12.x, 0.319999993);
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat33, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_10.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat11), float3(u_xlat16_6.xyz));
    u_xlat16_14 = rint(u_xlat16_25);
    u_xlat16_25 = fma(u_xlat16_25, half(2.0), half(-1.0));
    u_xlat16_3.xyw = fma((-u_xlat16_7.xyz), u_xlat16_3.xxx, half3(u_xlat16_14));
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_25)), u_xlat16_3.xyw, u_xlat16_10.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float u_xlat11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    half u_xlat16_14;
    float u_xlat22;
    half u_xlat16_25;
    float u_xlat33;
    float u_xlat34;
    bool u_xlatb34;
    float u_xlat35;
    half u_xlat16_35;
    half u_xlat16_36;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat12.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat12.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat1.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat33), float3(u_xlat16_3.xyz));
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + half(-1.0);
    u_xlat16_25 = fma(FGlobals._Occlusion, u_xlat16_25, half(1.0));
    u_xlat16_25 = max(u_xlat16_25, FGlobals._MinMSA.z);
    u_xlat33 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb34 = u_xlat33<0.00499999989;
    u_xlat35 = u_xlat33 * 8.29800034;
    u_xlat16_6.x = (u_xlatb34) ? half(0.0) : half(u_xlat35);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat33 * u_xlat33;
    u_xlat16_39 = half(u_xlat33 * u_xlat1.x);
    u_xlat33 = fma(u_xlat33, u_xlat33, 1.5);
    u_xlat16_39 = fma((-u_xlat16_39), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_39);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD1.zw;
    u_xlat16_2 = _Add.sample(sampler_Add, u_xlat2.xy);
    u_xlat16_35 = u_xlat16_2.w * input.COLOR0.w;
    u_xlat16_2.xyz = half3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    u_xlat16_9.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + half3(u_xlat16_14);
    u_xlat16_10.xyz = fma(half3(u_xlat16_36), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_10.xyz;
    u_xlat12.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12.x = max(u_xlat12.x, 0.00100000005);
    u_xlat12.x = rsqrt(u_xlat12.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat12.xxx;
    u_xlat12.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat11 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat22 = max(u_xlat12.x, 0.319999993);
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat33, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_10.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat11), float3(u_xlat16_6.xyz));
    u_xlat16_14 = rint(u_xlat16_25);
    u_xlat16_25 = fma(u_xlat16_25, half(2.0), half(-1.0));
    u_xlat16_3.xyw = fma((-u_xlat16_7.xyz), u_xlat16_3.xxx, half3(u_xlat16_14));
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_25)), u_xlat16_3.xyw, u_xlat16_10.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float u_xlat11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    half u_xlat16_14;
    float u_xlat22;
    half u_xlat16_25;
    float u_xlat33;
    float u_xlat34;
    bool u_xlatb34;
    float u_xlat35;
    half u_xlat16_35;
    half u_xlat16_36;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat12.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat12.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat1.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat33), float3(u_xlat16_3.xyz));
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + half(-1.0);
    u_xlat16_25 = fma(FGlobals._Occlusion, u_xlat16_25, half(1.0));
    u_xlat16_25 = max(u_xlat16_25, FGlobals._MinMSA.z);
    u_xlat33 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb34 = u_xlat33<0.00499999989;
    u_xlat35 = u_xlat33 * 8.29800034;
    u_xlat16_6.x = (u_xlatb34) ? half(0.0) : half(u_xlat35);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat33 * u_xlat33;
    u_xlat16_39 = half(u_xlat33 * u_xlat1.x);
    u_xlat33 = fma(u_xlat33, u_xlat33, 1.5);
    u_xlat16_39 = fma((-u_xlat16_39), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_39);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD1.zw;
    u_xlat16_2 = _Add.sample(sampler_Add, u_xlat2.xy);
    u_xlat16_35 = u_xlat16_2.w * input.COLOR0.w;
    u_xlat16_2.xyz = half3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    u_xlat16_9.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + half3(u_xlat16_14);
    u_xlat16_10.xyz = fma(half3(u_xlat16_36), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_10.xyz;
    u_xlat12.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12.x = max(u_xlat12.x, 0.00100000005);
    u_xlat12.x = rsqrt(u_xlat12.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat12.xxx;
    u_xlat12.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat11 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat22 = max(u_xlat12.x, 0.319999993);
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat33, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_10.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat11), float3(u_xlat16_6.xyz));
    u_xlat16_14 = rint(u_xlat16_25);
    u_xlat16_25 = fma(u_xlat16_25, half(2.0), half(-1.0));
    u_xlat16_3.xyw = fma((-u_xlat16_7.xyz), u_xlat16_3.xxx, half3(u_xlat16_14));
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_25)), u_xlat16_3.xyw, u_xlat16_10.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float u_xlat11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    half u_xlat16_14;
    float u_xlat22;
    half u_xlat16_25;
    float u_xlat33;
    float u_xlat34;
    bool u_xlatb34;
    float u_xlat35;
    half u_xlat16_35;
    half u_xlat16_36;
    half u_xlat16_39;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat12.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = half3(fma(u_xlat4.xyz, (-float3(u_xlat16_3.xxx)), (-u_xlat12.xyz)));
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_36 = half((-u_xlat1.x) + 1.0);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * u_xlat16_36;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_3.z) : (-float(u_xlat16_3.z));
    u_xlat5.z = u_xlat1.x * float(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * float(u_xlat16_3.z);
    u_xlat5.xy = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.yz);
    u_xlat1.yz = (-float2(u_xlat16_3.xy)) * float2(u_xlat16_3.xy);
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = rsqrt(u_xlat34);
    u_xlat1.xyz = float3(u_xlat34) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * float3(FGlobals._NormalDiff);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(u_xlat33), float3(u_xlat16_3.xyz));
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat1.xyz = float3(u_xlat33) * u_xlat1.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + half(-1.0);
    u_xlat16_25 = fma(FGlobals._Occlusion, u_xlat16_25, half(1.0));
    u_xlat16_25 = max(u_xlat16_25, FGlobals._MinMSA.z);
    u_xlat33 = (-float(u_xlat16_3.y)) + 1.0;
    u_xlatb34 = u_xlat33<0.00499999989;
    u_xlat35 = u_xlat33 * 8.29800034;
    u_xlat16_6.x = (u_xlatb34) ? half(0.0) : half(u_xlat35);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat1.xyz, bias(float(u_xlat16_6.x)));
    u_xlat16_6.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat33 * u_xlat33;
    u_xlat16_39 = half(u_xlat33 * u_xlat1.x);
    u_xlat33 = fma(u_xlat33, u_xlat33, 1.5);
    u_xlat16_39 = fma((-u_xlat16_39), half(0.280000001), half(1.0));
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(u_xlat16_39);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_12.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD1.zw;
    u_xlat16_2 = _Add.sample(sampler_Add, u_xlat2.xy);
    u_xlat16_35 = u_xlat16_2.w * input.COLOR0.w;
    u_xlat16_2.xyz = half3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_8.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_5.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_12.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_2.xyz);
    u_xlat16_9.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = fma(u_xlat16_3.xxx, u_xlat16_9.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.x = fma((-u_xlat16_3.x), half(0.779083729), half(0.779083729));
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + half3(u_xlat16_14);
    u_xlat16_10.xyz = fma(half3(u_xlat16_36), u_xlat16_10.xyz, u_xlat16_9.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_10.xyz;
    u_xlat12.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12.x = max(u_xlat12.x, 0.00100000005);
    u_xlat12.x = rsqrt(u_xlat12.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat12.xxx;
    u_xlat12.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat11 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat11 = clamp(u_xlat11, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat22 = max(u_xlat12.x, 0.319999993);
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat0.x = fma(u_xlat0.x, u_xlat33, 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_9.xyz), float3(u_xlat16_10.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xzw, float3(u_xlat11), float3(u_xlat16_6.xyz));
    u_xlat16_14 = rint(u_xlat16_25);
    u_xlat16_25 = fma(u_xlat16_25, half(2.0), half(-1.0));
    u_xlat16_3.xyw = fma((-u_xlat16_7.xyz), u_xlat16_3.xxx, half3(u_xlat16_14));
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_25)), u_xlat16_3.xyw, u_xlat16_10.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    half u_xlat16_16;
    half u_xlat16_30;
    float u_xlat42;
    half u_xlat16_42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    half u_xlat16_44;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat42 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat42 = sin(u_xlat42);
    u_xlat42 = u_xlat42 * FGlobals._NormalRand.w;
    u_xlat42 = fract(u_xlat42);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat43 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat3.xyz = float3(u_xlat43) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat43 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb43 = u_xlat43<9.99999975e-06;
    u_xlat43 = (u_xlatb43) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat43 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat43 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat4.xyz = float3(u_xlat43) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat42), float3(u_xlat16_2.xyz));
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat4.xyz = float3(u_xlat42) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_5.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb42 = u_xlat5.z<0.00499999989;
    u_xlat43 = u_xlat5.z * 8.29800034;
    u_xlat16_44 = (u_xlatb42) ? half(0.0) : half(u_xlat43);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_44)));
    u_xlat16_44 = u_xlat16_4.w + half(-1.0);
    u_xlat16_44 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_44, half(1.0));
    u_xlat16_44 = u_xlat16_44 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_44);
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_42 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_42) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_16 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + half(1.0);
    u_xlat16_16 = clamp(u_xlat16_16, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_16);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat42;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat42 = u_xlat42 + u_xlat42;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat42)), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat42) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_16 = half((-u_xlat1.x) + 1.0);
    u_xlat16_14 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_11.xyz = fma(half3(u_xlat16_14), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(float3(u_xlat16_11.xyz));
    u_xlat0 = u_xlat0 * float4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat14.xyz = exp2(u_xlat0.yzw);
    u_xlat14.xyz = fma(u_xlat14.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat14.xyz = max(u_xlat14.xyz, float3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = half3(float3(u_xlat16_30) * u_xlat14.xyz);
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_13.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_13.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_16 = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_16));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_2.xyw, u_xlat16_13.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_34;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_7.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_34 = half((-u_xlat0.x) + 1.0);
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_4.xyz = fma(half3(u_xlat16_34), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_7.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_34;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_7.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_34 = half((-u_xlat0.x) + 1.0);
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_4.xyz = fma(half3(u_xlat16_34), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_7.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    half u_xlat16_16;
    half u_xlat16_30;
    float u_xlat42;
    half u_xlat16_42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    half u_xlat16_44;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat42 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat42 = sin(u_xlat42);
    u_xlat42 = u_xlat42 * FGlobals._NormalRand.w;
    u_xlat42 = fract(u_xlat42);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat43 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat3.xyz = float3(u_xlat43) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat43 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb43 = u_xlat43<9.99999975e-06;
    u_xlat43 = (u_xlatb43) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat43 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat43 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat4.xyz = float3(u_xlat43) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat42), float3(u_xlat16_2.xyz));
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat4.xyz = float3(u_xlat42) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_5.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb42 = u_xlat5.z<0.00499999989;
    u_xlat43 = u_xlat5.z * 8.29800034;
    u_xlat16_44 = (u_xlatb42) ? half(0.0) : half(u_xlat43);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_44)));
    u_xlat16_44 = u_xlat16_4.w + half(-1.0);
    u_xlat16_44 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_44, half(1.0));
    u_xlat16_44 = u_xlat16_44 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_44);
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_42 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_42) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_16 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + half(1.0);
    u_xlat16_16 = clamp(u_xlat16_16, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_16);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat42;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat42 = u_xlat42 + u_xlat42;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat42)), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat42) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_16 = half((-u_xlat1.x) + 1.0);
    u_xlat16_14 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_11.xyz = fma(half3(u_xlat16_14), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(float3(u_xlat16_11.xyz));
    u_xlat0 = u_xlat0 * float4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat14.xyz = exp2(u_xlat0.yzw);
    u_xlat14.xyz = fma(u_xlat14.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat14.xyz = max(u_xlat14.xyz, float3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = half3(float3(u_xlat16_30) * u_xlat14.xyz);
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_13.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_13.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_16 = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_16));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_2.xyw, u_xlat16_13.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD6;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = half3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_12.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_15 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = half3(u_xlat16_15) * FGlobals._LightColor0.xyz;
    u_xlat16_11.xyz = half3(float3(u_xlat39) * float3(u_xlat16_11.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_12.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_1.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_1.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_34;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_7.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_34 = half((-u_xlat0.x) + 1.0);
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_4.xyz = fma(half3(u_xlat16_34), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_7.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_34;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_7.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_34 = half((-u_xlat0.x) + 1.0);
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_4.xyz = fma(half3(u_xlat16_34), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_7.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    half3 u_xlat16_14;
    half u_xlat16_16;
    half u_xlat16_30;
    float u_xlat42;
    half u_xlat16_42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    half u_xlat16_44;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat42 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat42 = sin(u_xlat42);
    u_xlat42 = u_xlat42 * FGlobals._NormalRand.w;
    u_xlat42 = fract(u_xlat42);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat43 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat3.xyz = float3(u_xlat43) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat43 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb43 = u_xlat43<9.99999975e-06;
    u_xlat43 = (u_xlatb43) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat43 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat43 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat4.xyz = float3(u_xlat43) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat42), float3(u_xlat16_2.xyz));
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat4.xyz = float3(u_xlat42) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_5.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb42 = u_xlat5.z<0.00499999989;
    u_xlat43 = u_xlat5.z * 8.29800034;
    u_xlat16_44 = (u_xlatb42) ? half(0.0) : half(u_xlat43);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_44)));
    u_xlat16_44 = u_xlat16_4.w + half(-1.0);
    u_xlat16_44 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_44, half(1.0));
    u_xlat16_44 = u_xlat16_44 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_44);
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_42 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_42) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_16 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + half(1.0);
    u_xlat16_16 = clamp(u_xlat16_16, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_16);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat42;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat42 = u_xlat42 + u_xlat42;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat42)), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat42) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_16 = half((-u_xlat1.x) + 1.0);
    u_xlat16_14.x = u_xlat16_16 * u_xlat16_16;
    u_xlat16_14.x = u_xlat16_16 * u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_16 * u_xlat16_14.x;
    u_xlat16_11.xyz = fma(u_xlat16_14.xxx, u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_14.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_13.xyz = u_xlat16_14.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_13.xyz = half3(u_xlat16_30) * u_xlat16_13.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_13.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_11.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_16 = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_16));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_2.xyw, u_xlat16_11.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_35;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xzw * u_xlat16_8.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_8.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_8.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_8.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat0.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_4.xyz = fma(half3(u_xlat16_35), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_8.z) : (-float(u_xlat16_8.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_8.z);
    u_xlat2.xy = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.yz);
    u_xlat0.yz = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_8.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_35;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xzw * u_xlat16_8.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_8.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_8.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_8.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat0.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_4.xyz = fma(half3(u_xlat16_35), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_8.z) : (-float(u_xlat16_8.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_8.z);
    u_xlat2.xy = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.yz);
    u_xlat0.yz = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_8.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = half3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_12.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_15 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = half3(u_xlat16_15) * FGlobals._LightColor0.xyz;
    u_xlat16_11.xyz = half3(float3(u_xlat39) * float3(u_xlat16_11.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_12.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat39 = input.TEXCOORD6;
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat39), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    half u_xlat16_16;
    half u_xlat16_30;
    float u_xlat42;
    half u_xlat16_42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    half u_xlat16_44;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat42 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat42 = sin(u_xlat42);
    u_xlat42 = u_xlat42 * FGlobals._NormalRand.w;
    u_xlat42 = fract(u_xlat42);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat43 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat3.xyz = float3(u_xlat43) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat43 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb43 = u_xlat43<9.99999975e-06;
    u_xlat43 = (u_xlatb43) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat43 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat43 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat4.xyz = float3(u_xlat43) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat42), float3(u_xlat16_2.xyz));
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat4.xyz = float3(u_xlat42) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_5.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb42 = u_xlat5.z<0.00499999989;
    u_xlat43 = u_xlat5.z * 8.29800034;
    u_xlat16_44 = (u_xlatb42) ? half(0.0) : half(u_xlat43);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_44)));
    u_xlat16_44 = u_xlat16_4.w + half(-1.0);
    u_xlat16_44 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_44, half(1.0));
    u_xlat16_44 = u_xlat16_44 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_44);
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_42 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_42) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_16 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + half(1.0);
    u_xlat16_16 = clamp(u_xlat16_16, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_16);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat42;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat42 = u_xlat42 + u_xlat42;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat42)), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat42) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_16 = half((-u_xlat1.x) + 1.0);
    u_xlat16_14 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_11.xyz = fma(half3(u_xlat16_14), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(float3(u_xlat16_11.xyz));
    u_xlat0 = u_xlat0 * float4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat14.xyz = exp2(u_xlat0.yzw);
    u_xlat14.xyz = fma(u_xlat14.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat14.xyz = max(u_xlat14.xyz, float3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_11.xyz = half3(fma(float3(FGlobals.unity_Lightmap_HDR.xxx), float3(u_xlat16_1.xyz), u_xlat14.xyz));
    u_xlat16_11.xyz = half3(u_xlat16_30) * u_xlat16_11.xyz;
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_13.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_13.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_16 = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_16));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_2.xyw, u_xlat16_13.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat11;
    half u_xlat16_15;
    float u_xlat21;
    float u_xlat30;
    half u_xlat16_30;
    float u_xlat31;
    float u_xlat32;
    bool u_xlatb32;
    half u_xlat16_33;
    half u_xlat16_34;
    half u_xlat16_36;
    half u_xlat16_37;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_33 = u_xlat16_0.z + half(-1.0);
    u_xlat16_33 = fma(FGlobals._Occlusion, u_xlat16_33, half(1.0));
    u_xlat16_33 = max(u_xlat16_33, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_34);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat11.x = u_xlat31 * u_xlat31;
    u_xlat21 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_15 = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_15);
    u_xlat31 = u_xlat21 * u_xlat21;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat21, u_xlat21, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat11.x * u_xlat1.x;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat16_15 = half(u_xlat21 * u_xlat31);
    u_xlat16_15 = fma((-u_xlat16_15), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = half3(u_xlat16_33) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat32), float3(u_xlat16_7.xyz));
    u_xlatb32 = u_xlat21<0.00499999989;
    u_xlat21 = u_xlat21 * 8.29800034;
    u_xlat16_36 = (u_xlatb32) ? half(0.0) : half(u_xlat21);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_37 = half((-u_xlat0.x) + 1.0);
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_4.xyz = fma(half3(u_xlat16_37), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_36)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_15) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_33);
    u_xlat16_33 = fma(u_xlat16_33, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_34), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_33)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat11;
    half u_xlat16_15;
    float u_xlat21;
    float u_xlat30;
    half u_xlat16_30;
    float u_xlat31;
    float u_xlat32;
    bool u_xlatb32;
    half u_xlat16_33;
    half u_xlat16_34;
    half u_xlat16_36;
    half u_xlat16_37;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_33 = u_xlat16_0.z + half(-1.0);
    u_xlat16_33 = fma(FGlobals._Occlusion, u_xlat16_33, half(1.0));
    u_xlat16_33 = max(u_xlat16_33, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_34);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat11.x = u_xlat31 * u_xlat31;
    u_xlat21 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_15 = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_15);
    u_xlat31 = u_xlat21 * u_xlat21;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat21, u_xlat21, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat11.x * u_xlat1.x;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat16_15 = half(u_xlat21 * u_xlat31);
    u_xlat16_15 = fma((-u_xlat16_15), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = half3(u_xlat16_33) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat32), float3(u_xlat16_7.xyz));
    u_xlatb32 = u_xlat21<0.00499999989;
    u_xlat21 = u_xlat21 * 8.29800034;
    u_xlat16_36 = (u_xlatb32) ? half(0.0) : half(u_xlat21);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_37 = half((-u_xlat0.x) + 1.0);
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_4.xyz = fma(half3(u_xlat16_37), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_36)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_15) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_33);
    u_xlat16_33 = fma(u_xlat16_33, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_34), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_33)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_3.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler samplerunity_NHxRoughness [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_Add [[ sampler (6) ]],
    sampler sampler_MSA [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_1.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_12.xyz = u_xlat16_1.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_12.xyz = half3(u_xlat16_28) * u_xlat16_12.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_12.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_11.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_15 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_12.xyz = half3(u_xlat16_15) * FGlobals._LightColor0.xyz;
    u_xlat16_12.xyz = half3(float3(u_xlat39) * float3(u_xlat16_12.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_11.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_8.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_1.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_8.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_1.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    half3 u_xlat16_14;
    half u_xlat16_16;
    half u_xlat16_30;
    float u_xlat42;
    half u_xlat16_42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    half u_xlat16_44;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat42 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat42 = sin(u_xlat42);
    u_xlat42 = u_xlat42 * FGlobals._NormalRand.w;
    u_xlat42 = fract(u_xlat42);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat43 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat3.xyz = float3(u_xlat43) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat43 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb43 = u_xlat43<9.99999975e-06;
    u_xlat43 = (u_xlatb43) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat43 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat43 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat4.xyz = float3(u_xlat43) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat42), float3(u_xlat16_2.xyz));
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat4.xyz = float3(u_xlat42) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_5.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb42 = u_xlat5.z<0.00499999989;
    u_xlat43 = u_xlat5.z * 8.29800034;
    u_xlat16_44 = (u_xlatb42) ? half(0.0) : half(u_xlat43);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_44)));
    u_xlat16_44 = u_xlat16_4.w + half(-1.0);
    u_xlat16_44 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_44, half(1.0));
    u_xlat16_44 = u_xlat16_44 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_44);
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_42 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_42) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_16 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + half(1.0);
    u_xlat16_16 = clamp(u_xlat16_16, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_16);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat42;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat42 = u_xlat42 + u_xlat42;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat42)), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat42) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_16 = half((-u_xlat1.x) + 1.0);
    u_xlat16_14.x = u_xlat16_16 * u_xlat16_16;
    u_xlat16_14.x = u_xlat16_16 * u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_16 * u_xlat16_14.x;
    u_xlat16_11.xyz = fma(u_xlat16_14.xxx, u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_14.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_13.xyz = u_xlat16_14.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_13.xyz = half3(u_xlat16_30) * u_xlat16_13.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_13.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_11.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_16 = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_16));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_2.xyw, u_xlat16_11.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD6;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler samplerunity_NHxRoughness [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_Add [[ sampler (6) ]],
    sampler sampler_MSA [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_11.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_11.xyz = half3(u_xlat16_28) * u_xlat16_11.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_12.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_15 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = half3(u_xlat16_15) * FGlobals._LightColor0.xyz;
    u_xlat16_11.xyz = half3(float3(u_xlat39) * float3(u_xlat16_11.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_12.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat33;
    half u_xlat16_33;
    half u_xlat16_34;
    float u_xlat35;
    float u_xlat36;
    bool u_xlatb36;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_33 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_33) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_34 = u_xlat16_0.z + half(-1.0);
    u_xlat16_34 = fma(FGlobals._Occlusion, u_xlat16_34, half(1.0));
    u_xlat16_34 = max(u_xlat16_34, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_37) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat13.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat13.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat13.x = u_xlat35 * u_xlat35;
    u_xlat24 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_38 = (-u_xlat16_37) + u_xlat16_6.y;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_38);
    u_xlat35 = u_xlat24 * u_xlat24;
    u_xlat36 = fma(u_xlat35, u_xlat35, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat36, 1.00001001);
    u_xlat36 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat2.x = u_xlat35 / u_xlat2.x;
    u_xlat16_38 = half(u_xlat24 * u_xlat35);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat36), float3(u_xlat16_1.xyz));
    u_xlatb36 = u_xlat24<0.00499999989;
    u_xlat24 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? half(0.0) : half(u_xlat24);
    u_xlat16_12 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12 = u_xlat16_12 + u_xlat16_12;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_12)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_12 = half((-u_xlat0.x) + 1.0);
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_5.xyz = fma(half3(u_xlat16_12), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_10.zxy, (-u_xlat16_10.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_10.z) : (-float(u_xlat16_10.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_10.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_10.z);
    u_xlat3.xy = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.yz);
    u_xlat0.yz = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_10.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_38);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_34);
    u_xlat16_12 = fma(u_xlat16_34, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_37), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_12)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_1.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat33;
    half u_xlat16_33;
    half u_xlat16_34;
    float u_xlat35;
    float u_xlat36;
    bool u_xlatb36;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_33 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_33) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_34 = u_xlat16_0.z + half(-1.0);
    u_xlat16_34 = fma(FGlobals._Occlusion, u_xlat16_34, half(1.0));
    u_xlat16_34 = max(u_xlat16_34, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_37) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat13.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat13.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat13.x = u_xlat35 * u_xlat35;
    u_xlat24 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_38 = (-u_xlat16_37) + u_xlat16_6.y;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_38);
    u_xlat35 = u_xlat24 * u_xlat24;
    u_xlat36 = fma(u_xlat35, u_xlat35, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat36, 1.00001001);
    u_xlat36 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat2.x = u_xlat35 / u_xlat2.x;
    u_xlat16_38 = half(u_xlat24 * u_xlat35);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat36), float3(u_xlat16_1.xyz));
    u_xlatb36 = u_xlat24<0.00499999989;
    u_xlat24 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? half(0.0) : half(u_xlat24);
    u_xlat16_12 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12 = u_xlat16_12 + u_xlat16_12;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_12)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_12 = half((-u_xlat0.x) + 1.0);
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_5.xyz = fma(half3(u_xlat16_12), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_10.zxy, (-u_xlat16_10.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_10.z) : (-float(u_xlat16_10.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_10.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_10.z);
    u_xlat3.xy = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.yz);
    u_xlat0.yz = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_10.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_38);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_34);
    u_xlat16_12 = fma(u_xlat16_34, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_37), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_12)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_1.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_35;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xzw * u_xlat16_8.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_8.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_8.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_8.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat0.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_4.xyz = fma(half3(u_xlat16_35), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_8.z) : (-float(u_xlat16_8.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_8.z);
    u_xlat2.xy = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.yz);
    u_xlat0.yz = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_8.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    float3 u_xlat10;
    half u_xlat16_14;
    float u_xlat19;
    float u_xlat27;
    half u_xlat16_27;
    float u_xlat28;
    float u_xlat29;
    bool u_xlatb29;
    half u_xlat16_30;
    half u_xlat16_31;
    half u_xlat16_33;
    half u_xlat16_35;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_27 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_0.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_31);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat10.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_14 = (-u_xlat16_31) + u_xlat16_5.y;
    u_xlat16_14 = u_xlat16_14 + half(1.0);
    u_xlat16_14 = clamp(u_xlat16_14, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_14);
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat29 = fma(u_xlat28, u_xlat28, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat29, 1.00001001);
    u_xlat29 = fma(u_xlat19, u_xlat19, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat29;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_14 = half(u_xlat19 * u_xlat28);
    u_xlat16_14 = fma((-u_xlat16_14), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xzw * u_xlat16_8.xyz;
    u_xlat29 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat29), float3(u_xlat16_8.xyz));
    u_xlatb29 = u_xlat19<0.00499999989;
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb29) ? half(0.0) : half(u_xlat19);
    u_xlat16_8.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_8.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat0.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_4.xyz = fma(half3(u_xlat16_35), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_8.z) : (-float(u_xlat16_8.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_8.z);
    u_xlat2.xy = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.yz);
    u_xlat0.yz = (-float2(u_xlat16_8.xy)) * float2(u_xlat16_8.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), float3(u_xlat16_8.xyz));
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_33)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_14) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_31), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat27 = input.TEXCOORD6;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler samplerunity_NHxRoughness [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half3 u_xlat16_13;
    float3 u_xlat14;
    half u_xlat16_14;
    half u_xlat16_16;
    half u_xlat16_30;
    float u_xlat42;
    half u_xlat16_42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    half u_xlat16_44;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat42 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat42 = sin(u_xlat42);
    u_xlat42 = u_xlat42 * FGlobals._NormalRand.w;
    u_xlat42 = fract(u_xlat42);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat43 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat3.xyz = float3(u_xlat43) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat43 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb43 = u_xlat43<9.99999975e-06;
    u_xlat43 = (u_xlatb43) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat43 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat43 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat43 = rsqrt(u_xlat43);
    u_xlat4.xyz = float3(u_xlat43) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat42), float3(u_xlat16_2.xyz));
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = rsqrt(u_xlat42);
    u_xlat4.xyz = float3(u_xlat42) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_30 = u_xlat16_5.z + half(-1.0);
    u_xlat16_30 = fma(FGlobals._Occlusion, u_xlat16_30, half(1.0));
    u_xlat16_30 = max(u_xlat16_30, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb42 = u_xlat5.z<0.00499999989;
    u_xlat43 = u_xlat5.z * 8.29800034;
    u_xlat16_44 = (u_xlatb42) ? half(0.0) : half(u_xlat43);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_44)));
    u_xlat16_44 = u_xlat16_4.w + half(-1.0);
    u_xlat16_44 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_44, half(1.0));
    u_xlat16_44 = u_xlat16_44 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_44);
    u_xlat16_6.xyz = half3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_42 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_42) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_16 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_16 = u_xlat16_16 + half(1.0);
    u_xlat16_16 = clamp(u_xlat16_16, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_16);
    u_xlat42 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat42;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat42 = u_xlat42 + u_xlat42;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat42)), u_xlat0.xyz);
    u_xlat42 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat16_12.xyz = half3(float3(u_xlat42) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_16 = half((-u_xlat1.x) + 1.0);
    u_xlat16_14 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_16 * u_xlat16_14;
    u_xlat16_11.xyz = fma(half3(u_xlat16_14), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(float3(u_xlat16_11.xyz));
    u_xlat0 = u_xlat0 * float4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat14.xyz = exp2(u_xlat0.yzw);
    u_xlat14.xyz = fma(u_xlat14.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat14.xyz = max(u_xlat14.xyz, float3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_11.xyz = half3(fma(float3(FGlobals.unity_Lightmap_HDR.xxx), float3(u_xlat16_1.xyz), u_xlat14.xyz));
    u_xlat16_11.xyz = half3(u_xlat16_30) * u_xlat16_11.xyz;
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_13.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_13.xyz)));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_16 = rint(u_xlat16_30);
    u_xlat16_30 = fma(u_xlat16_30, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_16));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_30)), u_xlat16_2.xyw, u_xlat16_13.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat42 = input.TEXCOORD6;
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat42), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat11;
    half u_xlat16_15;
    float u_xlat21;
    float u_xlat30;
    half u_xlat16_30;
    float u_xlat31;
    float u_xlat32;
    bool u_xlatb32;
    half u_xlat16_33;
    half u_xlat16_34;
    half u_xlat16_36;
    half u_xlat16_37;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_33 = u_xlat16_0.z + half(-1.0);
    u_xlat16_33 = fma(FGlobals._Occlusion, u_xlat16_33, half(1.0));
    u_xlat16_33 = max(u_xlat16_33, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_34);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat11.x = u_xlat31 * u_xlat31;
    u_xlat21 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_15 = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_15);
    u_xlat31 = u_xlat21 * u_xlat21;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat21, u_xlat21, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat11.x * u_xlat1.x;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat16_15 = half(u_xlat21 * u_xlat31);
    u_xlat16_15 = fma((-u_xlat16_15), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = half3(u_xlat16_33) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat32), float3(u_xlat16_7.xyz));
    u_xlatb32 = u_xlat21<0.00499999989;
    u_xlat21 = u_xlat21 * 8.29800034;
    u_xlat16_36 = (u_xlatb32) ? half(0.0) : half(u_xlat21);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_37 = half((-u_xlat0.x) + 1.0);
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_4.xyz = fma(half3(u_xlat16_37), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_36)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_15) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_33);
    u_xlat16_33 = fma(u_xlat16_33, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_34), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_33)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_BumpMap [[ sampler (3) ]],
    sampler sampler_Add [[ sampler (4) ]],
    sampler sampler_MSA [[ sampler (5) ]],
    sampler sampler_SphereMap [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half4 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat11;
    half u_xlat16_15;
    float u_xlat21;
    float u_xlat30;
    half u_xlat16_30;
    float u_xlat31;
    float u_xlat32;
    bool u_xlatb32;
    half u_xlat16_33;
    half u_xlat16_34;
    half u_xlat16_36;
    half u_xlat16_37;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_33 = u_xlat16_0.z + half(-1.0);
    u_xlat16_33 = fma(FGlobals._Occlusion, u_xlat16_33, half(1.0));
    u_xlat16_33 = max(u_xlat16_33, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat16_5.xzw = u_xlat16_3.xyz * half3(u_xlat16_34);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.x = input.TEXCOORD2.w;
    u_xlat1.y = input.TEXCOORD3.w;
    u_xlat1.z = input.TEXCOORD4.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat1.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = fma(u_xlat2.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat11.xyz;
    u_xlat31 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat1.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat11.x = u_xlat31 * u_xlat31;
    u_xlat21 = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_15 = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + half3(u_xlat16_15);
    u_xlat31 = u_xlat21 * u_xlat21;
    u_xlat32 = fma(u_xlat31, u_xlat31, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat32, 1.00001001);
    u_xlat32 = fma(u_xlat21, u_xlat21, 1.5);
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat11.x * u_xlat1.x;
    u_xlat1.x = u_xlat31 / u_xlat1.x;
    u_xlat16_15 = half(u_xlat21 * u_xlat31);
    u_xlat16_15 = fma((-u_xlat16_15), half(0.280000001), half(1.0));
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat1.xyw = fma(u_xlat1.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xzw));
    u_xlat1.xyw = u_xlat1.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_7.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_7.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_7.xyz = half3(u_xlat16_33) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xzw * u_xlat16_7.xyz;
    u_xlat32 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat1.xyw = fma(u_xlat1.xyw, float3(u_xlat32), float3(u_xlat16_7.xyz));
    u_xlatb32 = u_xlat21<0.00499999989;
    u_xlat21 = u_xlat21 * 8.29800034;
    u_xlat16_36 = (u_xlatb32) ? half(0.0) : half(u_xlat21);
    u_xlat16_7.x = dot((-u_xlat2.xyz), u_xlat0.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_7.xxx)), (-u_xlat2.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_37 = half((-u_xlat0.x) + 1.0);
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_4.xyz = fma(half3(u_xlat16_37), u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_7.z) : (-float(u_xlat16_7.z));
    u_xlat2.z = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.z);
    u_xlat2.xy = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.yz);
    u_xlat0.yz = (-float2(u_xlat16_7.xy)) * float2(u_xlat16_7.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_36)));
    u_xlat16_6.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_6.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_6.x, half(1.0));
    u_xlat16_6.x = u_xlat16_6.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = half3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_6.xyz = half3(u_xlat16_15) * u_xlat16_6.xyz;
    u_xlat0.xyz = fma(float3(u_xlat16_6.xyz), float3(u_xlat16_4.xyz), u_xlat1.xyw);
    u_xlat16_4.x = rint(u_xlat16_33);
    u_xlat16_33 = fma(u_xlat16_33, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_34), u_xlat16_4.xxx);
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_33)), u_xlat16_3.xyz, u_xlat16_5.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_3.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler samplerunity_NHxRoughness [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_Add [[ sampler (6) ]],
    sampler sampler_MSA [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_1.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_12.xyz = u_xlat16_1.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_12.xyz = half3(u_xlat16_28) * u_xlat16_12.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_12.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_11.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_15 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_12.xyz = half3(u_xlat16_15) * FGlobals._LightColor0.xyz;
    u_xlat16_12.xyz = half3(float3(u_xlat39) * float3(u_xlat16_12.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_11.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat39 = input.TEXCOORD6;
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat39), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_8.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_11;
    float3 u_xlat12;
    float u_xlat22;
    float u_xlat30;
    half u_xlat16_30;
    half u_xlat16_31;
    float u_xlat32;
    float u_xlat33;
    bool u_xlatb33;
    half u_xlat16_34;
    half u_xlat16_35;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_30 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + half(-1.0);
    u_xlat16_31 = fma(FGlobals._Occlusion, u_xlat16_31, half(1.0));
    u_xlat16_31 = max(u_xlat16_31, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_34 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_34) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat12.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = clamp(u_xlat32, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_35 = (-u_xlat16_34) + u_xlat16_6.y;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_35);
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat33 = fma(u_xlat32, u_xlat32, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat33, 1.00001001);
    u_xlat33 = fma(u_xlat22, u_xlat22, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat33;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_35 = half(u_xlat22 * u_xlat32);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_8.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat33), float3(u_xlat16_1.xyz));
    u_xlatb33 = u_xlat22<0.00499999989;
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? half(0.0) : half(u_xlat22);
    u_xlat16_11 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_11)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_11 = half((-u_xlat0.x) + 1.0);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_5.xyz = fma(half3(u_xlat16_11), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_9.z) : (-float(u_xlat16_9.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_9.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_9.z);
    u_xlat3.xy = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.yz);
    u_xlat0.yz = (-float2(u_xlat16_9.xy)) * float2(u_xlat16_9.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_9.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_35);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_31);
    u_xlat16_11 = fma(u_xlat16_31, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_34), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_11)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat30 = input.TEXCOORD6;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler samplerunity_NHxRoughness [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    sampler sampler_BumpMap [[ sampler (5) ]],
    sampler sampler_Add [[ sampler (6) ]],
    sampler sampler_MSA [[ sampler (7) ]],
    sampler sampler_SphereMap [[ sampler (8) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(6) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(7) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(8) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    float3 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    half u_xlat16_13;
    half u_xlat16_15;
    half u_xlat16_28;
    float u_xlat39;
    half u_xlat16_39;
    bool u_xlatb39;
    float u_xlat40;
    bool u_xlatb40;
    half u_xlat16_41;
    u_xlat0.x = input.TEXCOORD2.w;
    u_xlat0.y = input.TEXCOORD3.w;
    u_xlat0.z = input.TEXCOORD4.w;
    u_xlat39 = dot(u_xlat0.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = sin(u_xlat39);
    u_xlat39 = u_xlat39 * FGlobals._NormalRand.w;
    u_xlat39 = fract(u_xlat39);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat1.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_2.xyz));
    u_xlat1.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_2.xyz));
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(u_xlat3.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat0.xyz)));
    u_xlat40 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb40 = u_xlat40<9.99999975e-06;
    u_xlat40 = (u_xlatb40) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = u_xlat40 * float(u_xlat16_2.x);
    u_xlat5.x = u_xlat40 * float(u_xlat16_2.z);
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat39), float3(u_xlat16_2.xyz));
    u_xlat39 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat4.xyz = float3(u_xlat39) * u_xlat4.xyz;
    u_xlat16_5.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, FGlobals._MinMSA.xy);
    u_xlat16_28 = u_xlat16_5.z + half(-1.0);
    u_xlat16_28 = fma(FGlobals._Occlusion, u_xlat16_28, half(1.0));
    u_xlat16_28 = max(u_xlat16_28, FGlobals._MinMSA.z);
    u_xlat5.z = (-float(u_xlat16_2.y)) + 1.0;
    u_xlatb39 = u_xlat5.z<0.00499999989;
    u_xlat40 = u_xlat5.z * 8.29800034;
    u_xlat16_41 = (u_xlatb39) ? half(0.0) : half(u_xlat40);
    u_xlat16_4 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_41)));
    u_xlat16_41 = u_xlat16_4.w + half(-1.0);
    u_xlat16_41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_41, half(1.0));
    u_xlat16_41 = u_xlat16_41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * half3(u_xlat16_41);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = fma(u_xlat16_7.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_7.xy)).xyz;
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD1.zw;
    u_xlat16_4 = _Add.sample(sampler_Add, u_xlat4.xy);
    u_xlat16_39 = u_xlat16_4.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_39) * u_xlat16_4.xyz;
    u_xlat16_8.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_9.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_9.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_10.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_10.xyz = fma(u_xlat16_2.xxx, u_xlat16_10.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_15 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_15 = u_xlat16_15 + half(1.0);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = (-u_xlat16_10.xyz) + half3(u_xlat16_15);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat39;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat39)), u_xlat0.xyz);
    u_xlat39 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_15 = half((-u_xlat1.x) + 1.0);
    u_xlat16_13 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_15 * u_xlat16_13;
    u_xlat16_11.xyz = fma(half3(u_xlat16_13), u_xlat16_11.xyz, u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz;
    u_xlat16_11.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_11.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_11.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_11.xyz = half3(u_xlat16_28) * u_xlat16_11.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_11.xyz, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_10.xyz), float3(u_xlat16_12.xyz)));
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_15 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_15 = clamp(u_xlat16_15, 0.0h, 1.0h);
    u_xlat16_11.xyz = half3(u_xlat16_15) * FGlobals._LightColor0.xyz;
    u_xlat16_11.xyz = half3(float3(u_xlat39) * float3(u_xlat16_11.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_10.xyz, u_xlat16_11.xyz, u_xlat16_6.xyz);
    u_xlat16_15 = rint(u_xlat16_28);
    u_xlat16_28 = fma(u_xlat16_28, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, half3(u_xlat16_15));
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_28)), u_xlat16_2.xyw, u_xlat16_12.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, (-FGlobals.unity_FogColor.xyz));
    u_xlat39 = input.TEXCOORD6;
    u_xlat39 = clamp(u_xlat39, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat39), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat33;
    half u_xlat16_33;
    half u_xlat16_34;
    float u_xlat35;
    float u_xlat36;
    bool u_xlatb36;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_33 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_33) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_34 = u_xlat16_0.z + half(-1.0);
    u_xlat16_34 = fma(FGlobals._Occlusion, u_xlat16_34, half(1.0));
    u_xlat16_34 = max(u_xlat16_34, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_37) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat13.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat13.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat13.x = u_xlat35 * u_xlat35;
    u_xlat24 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_38 = (-u_xlat16_37) + u_xlat16_6.y;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_38);
    u_xlat35 = u_xlat24 * u_xlat24;
    u_xlat36 = fma(u_xlat35, u_xlat35, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat36, 1.00001001);
    u_xlat36 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat2.x = u_xlat35 / u_xlat2.x;
    u_xlat16_38 = half(u_xlat24 * u_xlat35);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat36), float3(u_xlat16_1.xyz));
    u_xlatb36 = u_xlat24<0.00499999989;
    u_xlat24 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? half(0.0) : half(u_xlat24);
    u_xlat16_12 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12 = u_xlat16_12 + u_xlat16_12;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_12)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_12 = half((-u_xlat0.x) + 1.0);
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_5.xyz = fma(half3(u_xlat16_12), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_10.zxy, (-u_xlat16_10.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_10.z) : (-float(u_xlat16_10.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_10.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_10.z);
    u_xlat3.xy = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.yz);
    u_xlat0.yz = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_10.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_38);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_34);
    u_xlat16_12 = fma(u_xlat16_34, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_37), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_12)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    half4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _FixedAmbientColor;
    half4 _MinMSA;
    float4 _NormalRand;
    half _NormalDiff;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_ShadowMask [[ sampler (1) ]],
    sampler samplerunity_SpecCube0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    sampler sampler_BumpMap [[ sampler (4) ]],
    sampler sampler_Add [[ sampler (5) ]],
    sampler sampler_MSA [[ sampler (6) ]],
    sampler sampler_SphereMap [[ sampler (7) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(5) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(6) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(7) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half4 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat33;
    half u_xlat16_33;
    half u_xlat16_34;
    float u_xlat35;
    float u_xlat36;
    bool u_xlatb36;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat16_0 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0h, 1.0h);
    u_xlat16_1.xyz = u_xlat16_1.xxx * FGlobals._LightColor0.xyz;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_33 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_33) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_2.xyz, u_xlat16_3.xyz, u_xlat16_0.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat3.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_4.xyz));
    u_xlat3.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_4.xyz));
    u_xlat16_4.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_4.xy = fma(u_xlat16_4.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_2.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_4.xy)).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_2.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_6.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_34 = u_xlat16_0.z + half(-1.0);
    u_xlat16_34 = fma(FGlobals._Occlusion, u_xlat16_34, half(1.0));
    u_xlat16_34 = max(u_xlat16_34, FGlobals._MinMSA.z);
    u_xlat16_5.xyz = fma(u_xlat16_6.xxx, u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-u_xlat16_6.x), half(0.779083729), half(0.779083729));
    u_xlat16_6.xzw = half3(u_xlat16_37) * u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat2.x = input.TEXCOORD2.w;
    u_xlat2.y = input.TEXCOORD3.w;
    u_xlat2.z = input.TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = dot(u_xlat2.xyz, FGlobals._NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat13.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat13.xyz;
    u_xlat35 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat35 = clamp(u_xlat35, 0.0f, 1.0f);
    u_xlat2.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat13.x = u_xlat35 * u_xlat35;
    u_xlat24 = (-float(u_xlat16_6.y)) + 1.0;
    u_xlat16_38 = (-u_xlat16_37) + u_xlat16_6.y;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + half3(u_xlat16_38);
    u_xlat35 = u_xlat24 * u_xlat24;
    u_xlat36 = fma(u_xlat35, u_xlat35, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat36, 1.00001001);
    u_xlat36 = fma(u_xlat24, u_xlat24, 1.5);
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat13.x * u_xlat2.x;
    u_xlat2.x = u_xlat35 / u_xlat2.x;
    u_xlat16_38 = half(u_xlat24 * u_xlat35);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyw = fma(u_xlat2.xxx, float3(u_xlat16_5.xyz), float3(u_xlat16_6.xzw));
    u_xlat2.xyw = float3(u_xlat16_1.xyz) * u_xlat2.xyw;
    u_xlat16_1.xyz = max(FGlobals._FixedAmbientColor.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_8.xyz = exp2(u_xlat16_8.xyz);
    u_xlat16_8.xyz = fma(u_xlat16_8.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xzw * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat2.xyw = fma(u_xlat2.xyw, float3(u_xlat36), float3(u_xlat16_1.xyz));
    u_xlatb36 = u_xlat24<0.00499999989;
    u_xlat24 = u_xlat24 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? half(0.0) : half(u_xlat24);
    u_xlat16_12 = dot((-u_xlat3.xyz), u_xlat0.xyz);
    u_xlat16_12 = u_xlat16_12 + u_xlat16_12;
    u_xlat16_10.xyz = half3(fma(u_xlat0.xyz, (-float3(u_xlat16_12)), (-u_xlat3.xyz)));
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_12 = half((-u_xlat0.x) + 1.0);
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_5.xyz = fma(half3(u_xlat16_12), u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat0.x = dot(u_xlat16_10.zxy, (-u_xlat16_10.xyz));
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
    u_xlat0.x = (u_xlatb0) ? float(u_xlat16_10.z) : (-float(u_xlat16_10.z));
    u_xlat3.z = u_xlat0.x * float(u_xlat16_10.x);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_10.z);
    u_xlat3.xy = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.yz);
    u_xlat0.yz = (-float2(u_xlat16_10.xy)) * float2(u_xlat16_10.xy);
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._NormalDiff);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat33), float3(u_xlat16_10.xyz));
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat0.xyz = float3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat0.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_1.x = u_xlat16_0.w + half(-1.0);
    u_xlat16_1.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_1.x, half(1.0));
    u_xlat16_1.x = u_xlat16_1.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = half3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * half3(u_xlat16_38);
    u_xlat0.xyz = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_5.xyz), u_xlat2.xyw);
    u_xlat16_1.x = rint(u_xlat16_34);
    u_xlat16_12 = fma(u_xlat16_34, half(2.0), half(-1.0));
    u_xlat16_1.xzw = fma((-u_xlat16_4.xyz), half3(u_xlat16_37), u_xlat16_1.xxx);
    u_xlat16_1.xyz = fma(abs(half3(u_xlat16_12)), u_xlat16_1.xzw, u_xlat16_6.xzw);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat16_1.xyz), (-float3(FGlobals.unity_FogColor.xyz)));
    u_xlat33 = input.TEXCOORD6;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 86458
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
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
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat2.xyz));
    u_xlat9 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.y = u_xlat2.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat2.y;
    output.TEXCOORD4.y = u_xlat2.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
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
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat2.xyz));
    u_xlat9 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.y = u_xlat2.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat2.y;
    output.TEXCOORD4.y = u_xlat2.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
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
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat1.xyz = float3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat2.xyz));
    u_xlat9 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat2.xyz = float3(u_xlat9) * u_xlat2.xyz;
    output.TEXCOORD2.y = u_xlat2.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat2.y;
    output.TEXCOORD4.y = u_xlat2.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD8 [[ user(TEXCOORD8) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat12 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat12) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD8 [[ user(TEXCOORD8) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat12 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat12) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 unity_WorldTransformParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 _MainTex_ST;
    float4 _BumpMap_ST;
    float4 _MSA_ST;
    float4 _Add_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 TANGENT0 [[ attribute(1) ]] ;
    float3 NORMAL0 [[ attribute(2) ]] ;
    float4 TEXCOORD0 [[ attribute(3) ]] ;
    float4 TEXCOORD1 [[ attribute(4) ]] ;
    half4 COLOR0 [[ attribute(5) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD8 [[ user(TEXCOORD8) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD5.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._BumpMap_ST.xy, VGlobals._BumpMap_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, VGlobals._MSA_ST.xy, VGlobals._MSA_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD1.xy, VGlobals._Add_ST.xy, VGlobals._Add_ST.zw);
    u_xlat16_2 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD8 = max(u_xlat0.x, float(u_xlat16_2));
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = input.TANGENT0.yyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].yzx, input.TANGENT0.xxx, u_xlat1.xyz);
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].yzx, input.TANGENT0.zzz, u_xlat1.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = fma(u_xlat0.zxy, u_xlat1.yzx, (-u_xlat3.xyz));
    u_xlat12 = input.TANGENT0.w * VGlobals.unity_WorldTransformParams.w;
    u_xlat3.xyz = float3(u_xlat12) * u_xlat3.xyz;
    output.TEXCOORD2.y = u_xlat3.x;
    output.TEXCOORD2.x = u_xlat1.z;
    output.TEXCOORD2.z = u_xlat0.y;
    output.TEXCOORD3.x = u_xlat1.x;
    output.TEXCOORD4.x = u_xlat1.y;
    output.TEXCOORD3.z = u_xlat0.z;
    output.TEXCOORD4.z = u_xlat0.x;
    output.TEXCOORD3.y = u_xlat3.y;
    output.TEXCOORD4.y = u_xlat3.z;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat21;
    half u_xlat16_21;
    half u_xlat16_24;
    half u_xlat16_25;
    half u_xlat16_26;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_21 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_24 = u_xlat16_0.z + half(-1.0);
    u_xlat16_24 = fma(FGlobals._Occlusion, u_xlat16_24, half(1.0));
    u_xlat16_24 = max(u_xlat16_24, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = fma(u_xlat0.xyz, (-float3(u_xlat21)), u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_25 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_25);
    u_xlat16_4.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xyz)));
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz;
    u_xlat16_26 = rint(u_xlat16_24);
    u_xlat16_24 = fma(u_xlat16_24, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_25), half3(u_xlat16_26));
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_24)), u_xlat16_3.xyz, u_xlat16_5.xyz);
    output.SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_Add [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_SphereMap [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float2 u_xlat20;
    half u_xlat16_20;
    half u_xlat16_22;
    float u_xlat30;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_1.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_22 = u_xlat16_1.z + half(-1.0);
    u_xlat16_22 = fma(FGlobals._Occlusion, u_xlat16_22, half(1.0));
    u_xlat16_22 = max(u_xlat16_22, FGlobals._MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_11.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat30 = u_xlat30 * float(u_xlat16_11.x);
    u_xlat16_11.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_11.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat4.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat11.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat11.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_20 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_20), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_12.xz = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_12.xz)).xyz;
    u_xlat20.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + input.TEXCOORD1.zw;
    u_xlat16_3 = _Add.sample(sampler_Add, u_xlat20.xy);
    u_xlat16_20 = u_xlat16_3.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_9.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat10) * u_xlat0.xzw;
    u_xlat16_12.x = rint(u_xlat16_22);
    u_xlat16_22 = fma(u_xlat16_22, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, u_xlat16_12.xxx);
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_22)), u_xlat16_2.xyw, u_xlat16_9.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_2.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_Add [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_SphereMap [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float2 u_xlat20;
    half u_xlat16_20;
    half u_xlat16_22;
    float u_xlat30;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_1.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_22 = u_xlat16_1.z + half(-1.0);
    u_xlat16_22 = fma(FGlobals._Occlusion, u_xlat16_22, half(1.0));
    u_xlat16_22 = max(u_xlat16_22, FGlobals._MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_11.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat30 = u_xlat30 * float(u_xlat16_11.x);
    u_xlat16_11.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_11.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat4.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat11.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat11.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_20 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_20), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_12.xz = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_12.xz)).xyz;
    u_xlat20.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + input.TEXCOORD1.zw;
    u_xlat16_3 = _Add.sample(sampler_Add, u_xlat20.xy);
    u_xlat16_20 = u_xlat16_3.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_9.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat10) * u_xlat0.xzw;
    u_xlat16_12.x = rint(u_xlat16_22);
    u_xlat16_22 = fma(u_xlat16_22, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, u_xlat16_12.xxx);
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_22)), u_xlat16_2.xyw, u_xlat16_9.xyz);
    output.SV_Target0.xyz = half3(u_xlat0.xyz * float3(u_xlat16_2.xyz));
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD8 [[ user(TEXCOORD8) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_BumpMap [[ sampler (2) ]],
    sampler sampler_Add [[ sampler (3) ]],
    sampler sampler_MSA [[ sampler (4) ]],
    sampler sampler_SphereMap [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat21;
    half u_xlat16_21;
    half u_xlat16_24;
    half u_xlat16_25;
    half u_xlat16_26;
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD1.zw;
    u_xlat16_0 = _Add.sample(sampler_Add, u_xlat0.xy);
    u_xlat16_21 = u_xlat16_0.w * input.COLOR0.w;
    u_xlat16_0.xyz = half3(u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_1.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = fma(u_xlat16_1.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_2.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat2.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.xy = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_3.xy)).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_0.xyz);
    u_xlat16_4.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, FGlobals._MinMSA.xy);
    u_xlat16_24 = u_xlat16_0.z + half(-1.0);
    u_xlat16_24 = fma(FGlobals._Occlusion, u_xlat16_24, half(1.0));
    u_xlat16_24 = max(u_xlat16_24, FGlobals._MinMSA.z);
    u_xlat16_4.xyz = fma(u_xlat16_5.xxx, u_xlat16_4.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = fma(u_xlat0.xyz, (-float3(u_xlat21)), u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(u_xlat16_5.y)) + 1.0;
    u_xlat16_25 = fma((-u_xlat16_5.x), half(0.779083729), half(0.779083729));
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat16_3.xyz * half3(u_xlat16_25);
    u_xlat16_4.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_5.xyz)));
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz;
    u_xlat16_26 = rint(u_xlat16_24);
    u_xlat16_24 = fma(u_xlat16_24, half(2.0), half(-1.0));
    u_xlat16_3.xyz = fma((-u_xlat16_3.xyz), half3(u_xlat16_25), half3(u_xlat16_26));
    u_xlat16_3.xyz = fma(abs(half3(u_xlat16_24)), u_xlat16_3.xyz, u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat0.x = input.TEXCOORD8;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_3.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD8 [[ user(TEXCOORD8) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_Add [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_SphereMap [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float2 u_xlat20;
    half u_xlat16_20;
    half u_xlat16_22;
    float u_xlat30;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_1.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_22 = u_xlat16_1.z + half(-1.0);
    u_xlat16_22 = fma(FGlobals._Occlusion, u_xlat16_22, half(1.0));
    u_xlat16_22 = max(u_xlat16_22, FGlobals._MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_11.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat30 = u_xlat30 * float(u_xlat16_11.x);
    u_xlat16_11.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_11.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat4.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat11.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat11.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_20 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_20), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_12.xz = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_12.xz)).xyz;
    u_xlat20.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + input.TEXCOORD1.zw;
    u_xlat16_3 = _Add.sample(sampler_Add, u_xlat20.xy);
    u_xlat16_20 = u_xlat16_3.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_9.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat10) * u_xlat0.xzw;
    u_xlat16_12.x = rint(u_xlat16_22);
    u_xlat16_22 = fma(u_xlat16_22, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, u_xlat16_12.xxx);
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_22)), u_xlat16_2.xyw, u_xlat16_9.xyz);
    u_xlat16_2.xyz = half3(u_xlat0.xyz * float3(u_xlat16_2.xyz));
    u_xlat0.x = input.TEXCOORD8;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_2.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
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
    float3 _WorldSpaceCameraPos;
    half4 _WorldSpaceLightPos0;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half4 _MinMSA;
    half _AddScrollSpeedU;
    half _AddScrollSpeedV;
    half4 _SphereMapScale;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD8 [[ user(TEXCOORD8) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_BumpMap [[ sampler (1) ]],
    sampler sampler_Add [[ sampler (2) ]],
    sampler sampler_MSA [[ sampler (3) ]],
    sampler sampler_SphereMap [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Add [[ texture(1) ]] ,
    texture2d<half, access::sample > _MSA [[ texture(2) ]] ,
    texture2d<half, access::sample > _BumpMap [[ texture(3) ]] ,
    texture2d<half, access::sample > _SphereMap [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float u_xlat10;
    float3 u_xlat11;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float2 u_xlat20;
    half u_xlat16_20;
    half u_xlat16_22;
    float u_xlat30;
    u_xlat0.xyz = (-input.TEXCOORD5.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_1.xyz = _MSA.sample(sampler_MSA, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, FGlobals._MinMSA.xy);
    u_xlat16_22 = u_xlat16_1.z + half(-1.0);
    u_xlat16_22 = fma(FGlobals._Occlusion, u_xlat16_22, half(1.0));
    u_xlat16_22 = max(u_xlat16_22, FGlobals._MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + half(1.0);
    u_xlat16_11.x = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat30 = u_xlat30 * float(u_xlat16_11.x);
    u_xlat16_11.xyz = _BumpMap.sample(sampler_BumpMap, input.TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = fma(u_xlat16_11.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat4.x = dot(input.TEXCOORD2.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.y = dot(input.TEXCOORD3.xyz, float3(u_xlat16_3.xyz));
    u_xlat4.z = dot(input.TEXCOORD4.xyz, float3(u_xlat16_3.xyz));
    u_xlat11.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat11.x = rsqrt(u_xlat11.x);
    u_xlat11.xyz = u_xlat11.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat11.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat10 = dot(u_xlat11.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_20 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_20), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_12.xz = fma(u_xlat16_3.xy, half2(0.5, 0.5), half2(0.5, 0.5));
    u_xlat16_1.xyz = _SphereMap.sample(sampler_SphereMap, float2(u_xlat16_12.xz)).xyz;
    u_xlat20.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AddScrollSpeedU, FGlobals._AddScrollSpeedV));
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + input.TEXCOORD1.zw;
    u_xlat16_3 = _Add.sample(sampler_Add, u_xlat20.xy);
    u_xlat16_20 = u_xlat16_3.w * input.COLOR0.w;
    u_xlat16_4.xyz = half3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = input.COLOR0.xyz * FGlobals._Color.xyz;
    u_xlat16_6.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = fma(u_xlat16_1.xyz, FGlobals._SphereMapScale.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(u_xlat16_2.xxx, u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_2.x = fma((-u_xlat16_2.x), half(0.779083729), half(0.779083729));
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_9.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat10) * u_xlat0.xzw;
    u_xlat16_12.x = rint(u_xlat16_22);
    u_xlat16_22 = fma(u_xlat16_22, half(2.0), half(-1.0));
    u_xlat16_2.xyw = fma((-u_xlat16_7.xyz), u_xlat16_2.xxx, u_xlat16_12.xxx);
    u_xlat16_2.xyz = fma(abs(half3(u_xlat16_22)), u_xlat16_2.xyw, u_xlat16_9.xyz);
    u_xlat16_2.xyz = half3(u_xlat0.xyz * float3(u_xlat16_2.xyz));
    u_xlat0.x = input.TEXCOORD8;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_2.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(1.0);
    return output;
}
"
}
}
}
}
Fallback "Booster/Black"
}
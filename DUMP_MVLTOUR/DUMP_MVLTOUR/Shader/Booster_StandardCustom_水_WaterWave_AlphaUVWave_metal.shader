//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/水/WaterWave_AlphaUVWave" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_TransparencyLM ("AlphaMask(UV0)", 2D) = "black" { }
[Header(AlphaMask UV Wave)] _AlphaMaskScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaMaskScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaMaskScrollSinScaleU ("U方向：波打つ幅", Range(-10, 10)) = 0
_AlphaMaskScrollSinScaleV ("V方向：波打つ幅", Range(-10, 10)) = 0
_AlphaMaskScrollSinSpeedU ("U方向：波打つ速度", Range(0, 10)) = 0
_AlphaMaskScrollSinSpeedV ("V方向：波打つ速度", Range(0, 10)) = 0
[Space(10)] _Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Vertex Wave Animation)] _WaveFreq ("波打つ頻度", Range(0, 10)) = 1
_WaveSpeed ("波打つ速度", Range(-100, 100)) = 1
_WaveHeight ("波の高さ", Range(0, 100)) = 1
_Wave2Freq ("波打つ頻度2", Range(0, 10)) = 1
_Wave2Speed ("波打つ速度2", Range(-100, 100)) = 1
_Wave2Height ("波の高さ2", Range(0, 100)) = 0
_WaveSlopeMag ("法線の傾きの強さ", Range(0, 1)) = 1
_WaveCenterPos ("波紋の中心", Vector) = (0,0,0,0)
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 37334
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 * VGlobals._ProjectionParams.z;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = fma(u_xlat21, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat21, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 * VGlobals._ProjectionParams.z;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = fma(u_xlat21, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat21, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    half4 COLOR0 [[ attribute(3) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 * VGlobals._ProjectionParams.z;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = fma(u_xlat21, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat21, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 * VGlobals._ProjectionParams.z;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = fma(u_xlat21, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat21, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 * VGlobals._ProjectionParams.z;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = fma(u_xlat21, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat21, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
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
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    bool u_xlatb14;
    float u_xlat21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat7 = fma((-u_xlat21), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat21), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb14 = 0.0<u_xlat21;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat21 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat21 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat21);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat7);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat21 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 * VGlobals._ProjectionParams.z;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = fma(u_xlat21, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat21, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat2.xy = float2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat0.y * u_xlat0.y);
    u_xlat16_5 = half(fma(u_xlat0.x, u_xlat0.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat0.yzzx * u_xlat0.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD5.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _TransparencyLM_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
    float4 TEXCOORD1 [[ attribute(3) ]] ;
    half4 COLOR0 [[ attribute(4) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._TransparencyLM_ST.xy, VGlobals._TransparencyLM_ST.zw);
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xy = float2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD3.xy = u_xlat0.xy;
    output.TEXCOORD5.xy = u_xlat0.xy;
    output.TEXCOORD5.zw = float2(0.0, 0.0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat24) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_28), u_xlat16_6.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat2.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat2.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat2.xy).x;
    u_xlat0.w = (-float(u_xlat16_2.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    half u_xlat16_29;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat24) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = half3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(u_xlat0.xxx * float3(u_xlat16_6.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_2.xyz, half3(u_xlat16_28), u_xlat16_6.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat2.x = u_xlat0.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat2.y = u_xlat0.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat0.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat2.xy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat16_0 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + half(1.0);
    output.SV_Target0.w = u_xlat16_0;
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half u_xlat16_6;
    half3 u_xlat16_7;
    float3 u_xlat8;
    float3 u_xlat9;
    half3 u_xlat16_9;
    half3 u_xlat16_14;
    float u_xlat16;
    float u_xlat24;
    float u_xlat27;
    half u_xlat16_29;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = fma(u_xlat8.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat9.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat9.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat27);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_29 = fma((-u_xlat16_29), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_29);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0f, 1.0f);
    u_xlat16_29 = half((-u_xlat9.x) + 1.0);
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_14.x = (-u_xlat16_6) + FGlobals._Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + half(1.0);
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0h, 1.0h);
    u_xlat16_9.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = fma(half3(u_xlat16_29), u_xlat16_14.xyz, u_xlat16_7.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * float3(u_xlat27);
    u_xlat27 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat8.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0f, 1.0f);
    u_xlat16 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16 = clamp(u_xlat16, 0.0f, 1.0f);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat8.x = fma(u_xlat8.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_7.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_9.xyz), float3(u_xlat16_6), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat16), float3(u_xlat16_5.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_31;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_1.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_1.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_31 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_31)), (-u_xlat0.xyz)));
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat30 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat30 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat30 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat30), float3(u_xlat16_2.xyz));
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb30 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_31)));
    u_xlat16_31 = u_xlat16_2.w + half(-1.0);
    u_xlat16_31 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_31, half(1.0));
    u_xlat16_31 = u_xlat16_31 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat30 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * input.TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat30;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(float3(u_xlat30) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = half((-u_xlat33) + 1.0);
    u_xlat16_10 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_35 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = half3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_10), u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat3.x = u_xlat0.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat0.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat0.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat16_0.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_0.x;
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    float u_xlat30;
    bool u_xlatb30;
    half u_xlat16_31;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_1.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_1.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat0.xyz = float3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_31 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_31)), (-u_xlat0.xyz)));
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat30 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat30 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat30 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat30), float3(u_xlat16_2.xyz));
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb30 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_31)));
    u_xlat16_31 = u_xlat16_2.w + half(-1.0);
    u_xlat16_31 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_31, half(1.0));
    u_xlat16_31 = u_xlat16_31 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat30 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * input.TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat30;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat30)), u_xlat0.xyz);
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(float3(u_xlat30) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = half((-u_xlat33) + 1.0);
    u_xlat16_10 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_35 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = half3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_10), u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_8.xyz, u_xlat16_5.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat4.y = u_xlat3.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat3.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_3.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-float(u_xlat16_3.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_1.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_1.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_28)), (-u_xlat0.xyz)));
    u_xlat27 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat27 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat27 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat27 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat27), float3(u_xlat16_2.xyz));
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_2.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat27;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat30) + 1.0);
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(u_xlat16_5.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat3.x = u_xlat0.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat0.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat0.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat16_0.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_0.x;
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_TransparencyLM [[ sampler (1) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    half u_xlat16_31;
    half u_xlat16_32;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat27 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat27 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat27 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb27 = u_xlat3.z<0.00499999989;
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_4.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat2.x = u_xlat0.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat2.y = u_xlat0.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat0.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat2.xy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat16_0.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_0.x;
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    bool u_xlatb27;
    half u_xlat16_28;
    float u_xlat30;
    half u_xlat16_32;
    u_xlat0.xyz = input.TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat0));
    u_xlat16_1.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat0));
    u_xlat16_1.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat0));
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_28)), (-u_xlat0.xyz)));
    u_xlat27 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat27 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat27 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat27 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = fma(u_xlat3.xyz, float3(u_xlat27), float3(u_xlat16_2.xyz));
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * u_xlat3.xyz;
    u_xlat4.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? half(0.0) : half(u_xlat30);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_28)));
    u_xlat16_28 = u_xlat16_2.w + half(-1.0);
    u_xlat16_28 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_28, half(1.0));
    u_xlat16_28 = u_xlat16_28 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * half3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat3.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat27;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat3.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat30) + 1.0);
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(u_xlat16_5.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD4;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat4.y = u_xlat3.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat3.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_3.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-float(u_xlat16_3.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_13;
    half u_xlat16_30;
    half u_xlat16_32;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    u_xlat16_0.x = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_0.x = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_0.x))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_2.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_0.xxx, u_xlat16_2.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat3.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat3.xyz = float3(u_xlat33) * u_xlat3.xyz;
    u_xlat16_30 = dot((-u_xlat3.xyz), input.TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_30)), (-u_xlat3.xyz)));
    u_xlat33 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb33 = u_xlat33<9.99999975e-06;
    u_xlat33 = (u_xlatb33) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat33;
    u_xlat5.x = float(u_xlat16_2.z) * u_xlat33;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat33 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_30 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_30)));
    u_xlat16_30 = u_xlat16_1.w + half(-1.0);
    u_xlat16_30 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_30, half(1.0));
    u_xlat16_30 = u_xlat16_30 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * half3(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(FGlobals._Occlusion);
    u_xlat33 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * input.TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat34 = u_xlat33;
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat3.xyz = fma(u_xlat4.xyz, (-float3(u_xlat33)), u_xlat3.xyz);
    u_xlat33 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(float3(u_xlat33) * float3(FGlobals._LightColor0.xyz));
    u_xlat3.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_30 = half((-u_xlat34) + 1.0);
    u_xlat16_13 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_30 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_30) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = half3(u_xlat16_32) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_13), u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat4.y = u_xlat3.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat3.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_3.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat3.xy).x;
    u_xlat16_3.x = (-u_xlat16_3.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_3.x;
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ShadowMask [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_9.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_9.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + input.TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half3 u_xlat16_13;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_5.x = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_13.xyz = u_xlat16_2.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_2.xyz;
    u_xlat16_13.xyz = fma(half3(FGlobals._Metallic), u_xlat16_13.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = (-u_xlat16_13.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_13.xyz);
    u_xlat16_5.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_13.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat24) * float3(u_xlat16_6.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat0.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat2.x = u_xlat0.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat2.y = u_xlat0.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat0.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat2.xy);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + input.TEXCOORD0.xy;
    u_xlat16_0.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_0.x;
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat29;
    half u_xlat16_31;
    half u_xlat16_32;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat27 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat27 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat27 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * FGlobals._NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat27), float3(u_xlat16_1.xyz));
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb27 = u_xlat3.z<0.00499999989;
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? half(0.0) : half(u_xlat29);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat27 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * input.TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat27)), u_xlat0.xyz);
    u_xlat27 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = half((-u_xlat29) + 1.0);
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_7.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat27 = input.TEXCOORD4;
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat27), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat2.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat2.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat2.xy).x;
    u_xlat0.w = (-float(u_xlat16_2.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_12;
    half u_xlat16_27;
    half u_xlat16_29;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    u_xlat16_0.x = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_0.x = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_0.x))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_2.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_0.xxx, u_xlat16_2.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat3.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat3.xyz)));
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat30;
    u_xlat5.x = float(u_xlat16_2.z) * u_xlat30;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat30 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_2.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat5.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_27 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_27)));
    u_xlat16_27 = u_xlat16_1.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * half3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(FGlobals._Occlusion);
    u_xlat30 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * input.TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = fma(u_xlat4.xyz, (-float3(u_xlat30)), u_xlat3.xyz);
    u_xlat30 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_27 = half((-u_xlat31) + 1.0);
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_12), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_2.xyz);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_2.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat16_2.xyz = half3(float3(u_xlat30) * float3(u_xlat16_2.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat4.y = u_xlat3.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat3.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_3.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat3.xy).x;
    u_xlat16_3.x = (-u_xlat16_3.x) + half(1.0);
    output.SV_Target0.w = u_xlat16_3.x;
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_41) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_41) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_13;
    half u_xlat16_30;
    half u_xlat16_32;
    float u_xlat33;
    bool u_xlatb33;
    float u_xlat34;
    u_xlat16_0.x = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_0.x = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_0.x))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_2.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_0.xxx, u_xlat16_2.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat3.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat3.xyz = float3(u_xlat33) * u_xlat3.xyz;
    u_xlat16_30 = dot((-u_xlat3.xyz), input.TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_30)), (-u_xlat3.xyz)));
    u_xlat33 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb33 = u_xlat33<9.99999975e-06;
    u_xlat33 = (u_xlatb33) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat33;
    u_xlat5.x = float(u_xlat16_2.z) * u_xlat33;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat33 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * FGlobals._NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat33), float3(u_xlat16_2.xyz));
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_30 = (u_xlatb33) ? half(0.0) : half(u_xlat34);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_30)));
    u_xlat16_30 = u_xlat16_1.w + half(-1.0);
    u_xlat16_30 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_30, half(1.0));
    u_xlat16_30 = u_xlat16_30 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * half3(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(FGlobals._Occlusion);
    u_xlat33 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat33 = rsqrt(u_xlat33);
    u_xlat4.xyz = float3(u_xlat33) * input.TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat34 = u_xlat33;
    u_xlat34 = clamp(u_xlat34, 0.0f, 1.0f);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat3.xyz = fma(u_xlat4.xyz, (-float3(u_xlat33)), u_xlat3.xyz);
    u_xlat33 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat16_6.xyz = half3(float3(u_xlat33) * float3(FGlobals._LightColor0.xyz));
    u_xlat3.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_30 = half((-u_xlat34) + 1.0);
    u_xlat16_13 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_30 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_30) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = half3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_9.xyz = half3(u_xlat16_32) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = fma(half3(u_xlat16_13), u_xlat16_9.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_8.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_8.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat33 = input.TEXCOORD4;
    u_xlat33 = clamp(u_xlat33, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat33), float3(u_xlat16_3.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat4.y = u_xlat3.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat3.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_3.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-float(u_xlat16_3.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD4;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_Lightmap [[ sampler (0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (1) ]],
    sampler sampler_TransparencyLM [[ sampler (2) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = u_xlat0.xyz * float3(FGlobals._LightColor0.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD4;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half3 u_xlat16_13;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat26;
    half u_xlat16_28;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), input.TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_1.xxx)), (-u_xlat0.xyz)));
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? float(u_xlat16_1.z) : (-float(u_xlat16_1.z));
    u_xlat2.z = u_xlat24 * float(u_xlat16_1.x);
    u_xlat3.x = u_xlat24 * float(u_xlat16_1.z);
    u_xlat2.xy = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.yz);
    u_xlat3.yz = (-float2(u_xlat16_1.xy)) * float2(u_xlat16_1.xy);
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(FGlobals._NormalDiff);
    u_xlat24 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * FGlobals._NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(u_xlat24), float3(u_xlat16_1.xyz));
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? half(0.0) : half(u_xlat26);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat2.xyz, bias(float(u_xlat16_1.x)));
    u_xlat16_4.x = u_xlat16_1.w + half(-1.0);
    u_xlat16_4.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_4.x, half(1.0));
    u_xlat16_4.x = u_xlat16_4.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat24 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat2.xyz = float3(u_xlat24) * input.TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = fma(u_xlat2.xyz, (-float3(u_xlat24)), u_xlat0.xyz);
    u_xlat24 = dot(u_xlat2.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_5.x = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + half(1.0);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0h, 1.0h);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_13.xyz = u_xlat16_2.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_2.xyz;
    u_xlat16_13.xyz = fma(half3(FGlobals._Metallic), u_xlat16_13.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_7.xyz = (-u_xlat16_13.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_13.xyz);
    u_xlat16_5.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_13.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat24) * float3(u_xlat16_6.xyz));
    u_xlat16_4.xyz = fma(u_xlat16_5.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat24 = input.TEXCOORD4;
    u_xlat24 = clamp(u_xlat24, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat24), float3(u_xlat16_0.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat2.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat2.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat2.xy).x;
    u_xlat0.w = (-float(u_xlat16_2.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    float3 u_xlat10;
    half3 u_xlat16_10;
    float3 u_xlat11;
    float u_xlat20;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = fma(u_xlat10.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat33);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat20, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_35 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_10.xyz * half3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + FGlobals._Smoothness;
    u_xlat16_35 = u_xlat16_35 + half(1.0);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_35);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_35) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat1.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = fma(half3(u_xlat16_35), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat30), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (4) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_12;
    half u_xlat16_27;
    half u_xlat16_29;
    float u_xlat30;
    bool u_xlatb30;
    float u_xlat31;
    u_xlat16_0.x = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_0.x = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_0.x))));
    u_xlat16_1 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_2.x = dot(FGlobals.unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(FGlobals.unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(FGlobals.unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = fma(FGlobals.unity_SHC.xyz, u_xlat16_0.xxx, u_xlat16_2.xyz);
    u_xlat1.xyz = input.TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat1));
    u_xlat16_2.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat1));
    u_xlat16_2.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat1));
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = fma(u_xlat16_3.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * half3(FGlobals._Occlusion);
    u_xlat3.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat3.xyz = float3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), input.TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_27)), (-u_xlat3.xyz)));
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat4.z = float(u_xlat16_2.x) * u_xlat30;
    u_xlat5.x = float(u_xlat16_2.z) * u_xlat30;
    u_xlat4.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat5.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * float3(FGlobals._NormalDiff);
    u_xlat30 = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * FGlobals._NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat4.xyz = fma(u_xlat4.xyz, float3(u_xlat30), float3(u_xlat16_2.xyz));
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * u_xlat4.xyz;
    u_xlat5.z = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_27 = (u_xlatb30) ? half(0.0) : half(u_xlat31);
    u_xlat16_1 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat4.xyz, bias(float(u_xlat16_27)));
    u_xlat16_27 = u_xlat16_1.w + half(-1.0);
    u_xlat16_27 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_27, half(1.0));
    u_xlat16_27 = u_xlat16_27 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * half3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * half3(FGlobals._Occlusion);
    u_xlat30 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat30 = rsqrt(u_xlat30);
    u_xlat4.xyz = float3(u_xlat30) * input.TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0f, 1.0f);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = fma(u_xlat4.xyz, (-float3(u_xlat30)), u_xlat3.xyz);
    u_xlat30 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_27 = half((-u_xlat31) + 1.0);
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_29 = u_xlat16_29 + half(1.0);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0h, 1.0h);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = half3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_8.xyz = half3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = fma(half3(u_xlat16_12), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_2.xyz);
    u_xlat16_1 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_1, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_2.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat16_2.xyz = half3(float3(u_xlat30) * float3(u_xlat16_2.xyz));
    u_xlat16_0.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat30 = input.TEXCOORD4;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), float3(u_xlat16_3.xyz), float3(FGlobals.unity_FogColor.xyz));
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat4.y = u_xlat3.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat3.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_3.x = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-float(u_xlat16_3.x)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_41) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD4;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
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
    half4 unity_SHAr;
    half4 unity_SHAg;
    half4 unity_SHAb;
    half4 unity_SHBr;
    half4 unity_SHBg;
    half4 unity_SHBb;
    half4 unity_SHC;
    half4 unity_OcclusionMaskSelector;
    half4 unity_FogColor;
    half4 unity_SpecCube0_HDR;
    half4 unity_Lightmap_HDR;
    half4 _LightColor0;
    float4 booster_Env;
    half4 _Color;
    half _Occlusion;
    half _Metallic;
    half _Smoothness;
    float4 _NormalRand;
    half _NormalDiff;
    half _AlphaMaskScrollSpeedU;
    half _AlphaMaskScrollSpeedV;
    half _AlphaMaskScrollSinScaleU;
    half _AlphaMaskScrollSinScaleV;
    half _AlphaMaskScrollSinSpeedU;
    half _AlphaMaskScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_TransparencyLM [[ sampler (3) ]],
    texture2d<half, access::sample > _TransparencyLM [[ texture(0) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(1) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float2 u_xlat1;
    half u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    float3 u_xlat12;
    half3 u_xlat16_12;
    float3 u_xlat13;
    float u_xlat24;
    float u_xlat36;
    float u_xlat39;
    half u_xlat16_41;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = fma(u_xlat12.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat13.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat13.xyz)));
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    u_xlat1.x = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1.x * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1.x * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * float3(FGlobals._NormalDiff);
    u_xlat3.xyz = fma(u_xlat3.xyz, u_xlat0.xxx, float3(u_xlat16_2.xyz));
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat39);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_41 = fma((-u_xlat16_41), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat12.x = fma(u_xlat12.x, u_xlat24, 1.00001001);
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_41 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = u_xlat16_12.xyz * half3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + FGlobals._Smoothness;
    u_xlat16_41 = u_xlat16_41 + half(1.0);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_41);
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0h, 1.0h);
    u_xlat16_9.xyz = half3(u_xlat16_41) * FGlobals._LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat16_9.xyz);
    u_xlat16_41 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_41 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_41))));
    u_xlat16_2 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_9.x = dot(FGlobals.unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(FGlobals.unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(FGlobals.unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_41), u_xlat16_9.xyz);
    u_xlat2.xyz = input.TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat2));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat2));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat2));
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_11.xyz, u_xlat16_4.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat16_41 = half((-u_xlat1.x) + 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = fma(half3(u_xlat16_41), u_xlat16_8.xyz, u_xlat16_6.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), float3(u_xlat16_7.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_6.xyz), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat36 = input.TEXCOORD4;
    u_xlat36 = clamp(u_xlat36, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat36), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlphaMaskScrollSinSpeedU, FGlobals._AlphaMaskScrollSinSpeedV));
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * float(FGlobals._AlphaMaskScrollSinScaleU);
    u_xlat3.y = u_xlat1.y * float(FGlobals._AlphaMaskScrollSinScaleV);
    u_xlat1.xy = fma(float2(half2(FGlobals._AlphaMaskScrollSpeedU, FGlobals._AlphaMaskScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _TransparencyLM.sample(sampler_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-float(u_xlat16_1)) + 1.0;
    output.SV_Target0 = half4(u_xlat0);
    return output;
}
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 100392
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    bool u_xlatb10;
    float u_xlat15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat5 = fma((-u_xlat15), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat15), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb10 = 0.0<u_xlat15;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat15 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat15 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat15);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat5);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat15 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat2.xy = float2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.y = 1.0;
    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat0.xy * u_xlat2.xx;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.y = 1.0;
    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat0.xy * u_xlat2.xx;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    half4 COLOR0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    half u_xlat16_5;
    float u_xlat6;
    float u_xlat12;
    bool u_xlatb12;
    float u_xlat18;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xyzx.xz));
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * float2(half2(VGlobals._WaveSpeed, VGlobals._Wave2Speed));
    u_xlat6 = fma((-u_xlat18), float(VGlobals._Wave2Freq), u_xlat0.y);
    u_xlat0.x = fma((-u_xlat18), float(VGlobals._WaveFreq), u_xlat0.x);
    u_xlatb12 = 0.0<u_xlat18;
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * float(VGlobals._Wave2Height);
    u_xlat18 = u_xlat4.x * float(VGlobals._Wave2Height);
    u_xlat18 = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat18);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat0.x, u_xlat6);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat2);
    u_xlat0.x = u_xlat18 * float(VGlobals._WaveSlopeMag);
    u_xlat3 = u_xlat2 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat2.xyz);
    u_xlat2 = u_xlat3.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat3.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat3.zzzz, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat3.wwww, u_xlat2);
    output.mtl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z / VGlobals._ProjectionParams.y;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 * VGlobals._ProjectionParams.z;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = fma(u_xlat18, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    u_xlat0.y = 1.0;
    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2.x = rsqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat0.xy * u_xlat2.xx;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD4 = max(u_xlat18, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD3 = float4(0.0, 0.0, 0.0, 0.0);
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
    half4 _LightColor0;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat12;
    half u_xlat16_14;
    u_xlat0.xyz = (-input.TEXCOORD1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * input.TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat12)), u_xlat0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.xyz = half3(u_xlat0.xxx * float3(u_xlat16_3.xyz));
    u_xlat16_14 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_3.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_14), u_xlat16_3.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    output.SV_Target0.w = half(0.0);
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
    half4 _LightColor0;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    half4 _LightColor0;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    half4 _LightColor0;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float u_xlat12;
    half u_xlat16_14;
    u_xlat0.xyz = (-input.TEXCOORD1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat1.xyz = float3(u_xlat12) * input.TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat12)), u_xlat0.xyz);
    u_xlat12 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat12) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = fma(half3(FGlobals._Metallic), u_xlat16_3.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_3.xyz = half3(u_xlat0.xxx * float3(u_xlat16_3.xyz));
    u_xlat16_14 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_3.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_14), u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = input.TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.xyz = float3(u_xlat16_2.xyz) * u_xlat0.xxx;
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    half4 _LightColor0;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = input.TEXCOORD4;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat9);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
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
    half4 _LightColor0;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
};

struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    float u_xlat3;
    float3 u_xlat4;
    half u_xlat16_4;
    half u_xlat16_6;
    float u_xlat9;
    u_xlat0.xyz = (-input.TEXCOORD1.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat9), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_4 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * float(u_xlat16_4);
    u_xlat4.x = dot(input.TEXCOORD0.xyz, input.TEXCOORD0.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * input.TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat3 = dot(u_xlat4.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat3 = clamp(u_xlat3, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_6), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = fma(half3(FGlobals._Metallic), u_xlat16_2.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_2.xyz);
    u_xlat16_2.x = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_1.xyz), float3(u_xlat16_2.xxx), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = input.TEXCOORD4;
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat9);
    output.SV_Target0.xyz = half3(u_xlat0.xyz);
    output.SV_Target0.w = half(0.0);
    return output;
}
"
}
}
}
}
Fallback "Booster/Black"
}
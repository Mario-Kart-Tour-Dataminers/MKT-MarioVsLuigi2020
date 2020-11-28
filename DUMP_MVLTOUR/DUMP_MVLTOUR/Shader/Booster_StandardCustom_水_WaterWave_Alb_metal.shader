//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/水/WaterWave_Alb" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
[Header(Albedo UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Space(10)] _Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Booster Whitecaps)] _Whitecaps ("白波テクスチャRGB(UV0)", 2D) = "black" { }
_WhitecapsAlpha ("白波テクスチャA(UV0)", 2D) = "white" { }
[Header(Whitecaps UV Wave)] _WhitecapsScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_WhitecapsScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_WhitecapsScrollSinScaleU ("U方向：波打つ幅", Range(-10, 10)) = 0
_WhitecapsScrollSinScaleV ("V方向：波打つ幅", Range(-10, 10)) = 0
_WhitecapsScrollSinSpeedU ("U方向：波打つ速度", Range(0, 10)) = 0
_WhitecapsScrollSinSpeedV ("V方向：波打つ速度", Range(0, 10)) = 0
[Header(Whitecaps Parameters)] _WhitecapsBaseAlpha ("カメラ距離による透明度", Range(0, 1)) = 0.117647
_WhitecapsDepthMin ("透明が始まる距離", Range(0, 200)) = 10
_WhitecapsDepthMax ("透明が終わる距離", Range(0, 200)) = 50
[Space(10)] [Header(Vertex Wave Animation)] _WaveFreq ("波打つ頻度", Range(0, 10)) = 1
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
  GpuProgramID 51895
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7 = fma(u_xlat7, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat7 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat7;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : input.NORMAL0.xyz;
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
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7 = fma(u_xlat7, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat7 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat7;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : input.NORMAL0.xyz;
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
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7 = fma(u_xlat7, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat7 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat7;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : input.NORMAL0.xyz;
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
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7 = fma(u_xlat7, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat7 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat7;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : input.NORMAL0.xyz;
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
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7 = fma(u_xlat7, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat7 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat7;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : input.NORMAL0.xyz;
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
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7 = fma(u_xlat7, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat7 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat7;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : input.NORMAL0.xyz;
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
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat7.y * u_xlat7.y);
    u_xlat16_5 = half(fma(u_xlat7.x, u_xlat7.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat7.yzzx * u_xlat7.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat7.y * u_xlat7.y);
    u_xlat16_5 = half(fma(u_xlat7.x, u_xlat7.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat7.yzzx * u_xlat7.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat7.y * u_xlat7.y);
    u_xlat16_5 = half(fma(u_xlat7.x, u_xlat7.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat7.yzzx * u_xlat7.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat7.y * u_xlat7.y);
    u_xlat16_5 = half(fma(u_xlat7.x, u_xlat7.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat7.yzzx * u_xlat7.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat7.y * u_xlat7.y);
    u_xlat16_5 = half(fma(u_xlat7.x, u_xlat7.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat7.yzzx * u_xlat7.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    half u_xlat16_5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_5));
    output.COLOR0 = input.COLOR0;
    u_xlat16_5 = half(u_xlat7.y * u_xlat7.y);
    u_xlat16_5 = half(fma(u_xlat7.x, u_xlat7.x, (-float(u_xlat16_5))));
    u_xlat16_0 = half4(u_xlat7.yzzx * u_xlat7.xyzz);
    u_xlat16_6.x = dot(VGlobals.unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(VGlobals.unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(VGlobals.unity_SHBb, u_xlat16_0);
    output.TEXCOORD4.xyz = fma(VGlobals.unity_SHC.xyz, half3(u_xlat16_5), u_xlat16_6.xyz);
    output.TEXCOORD6.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 unity_LightmapST;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD5 [[ user(TEXCOORD5) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD5 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD4.zw = float2(0.0, 0.0);
    u_xlat0.xy = fma(input.TEXCOORD1.xy, VGlobals.unity_LightmapST.xy, VGlobals.unity_LightmapST.zw);
    output.TEXCOORD4.xy = u_xlat0.xy;
    output.TEXCOORD6.xy = u_xlat0.xy;
    output.TEXCOORD6.zw = float2(0.0, 0.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float2 u_xlat18;
    half u_xlat16_18;
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
    u_xlat18.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat18.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat18.xy);
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + input.TEXCOORD0.zw;
    u_xlat16_2.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_3.xyz, u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_32);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(u_xlat0.xxx * float3(u_xlat16_7.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_31), u_xlat16_7.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyw = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat2.x = input.TEXCOORD5;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_0.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0.x = (-u_xlat16_18) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_18));
    u_xlat16_9 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_9), float(u_xlat16_1.w), u_xlat0.x);
    u_xlat2.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat2);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (2) ]],
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float2 u_xlat18;
    half u_xlat16_18;
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
    u_xlat18.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat18.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat18.xy);
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + input.TEXCOORD0.zw;
    u_xlat16_2.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_3.xyz, u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_32 = u_xlat16_32 + half(1.0);
    u_xlat16_32 = clamp(u_xlat16_32, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_32);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(u_xlat0.xxx * float3(u_xlat16_7.xyz));
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(u_xlat16_31), u_xlat16_7.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0 = (-u_xlat16_18) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_18));
    u_xlat16_9 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_9), float(u_xlat16_1.w), u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    output.SV_Target0.w = half(u_xlat0.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
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
    float3 u_xlat11;
    half u_xlat16_11;
    float u_xlat20;
    float2 u_xlat21;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat11.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat21.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_38 = (-u_xlat16_37) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat16_9.xyz = fma(half3(u_xlat16_35), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = rsqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat21.x = clamp(u_xlat21.x, 0.0f, 1.0f);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat20 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_37), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat20), float3(u_xlat16_5.xyz));
    u_xlat16_1 = (-u_xlat16_11) + half(1.0);
    u_xlat1 = fma(input.TEXCOORD3, float(u_xlat16_1), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat1 = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat1);
    u_xlat0.w = min(u_xlat1, 1.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
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
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
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
    float3 u_xlat11;
    half u_xlat16_11;
    float u_xlat20;
    float2 u_xlat21;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat11.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat21.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_38 = (-u_xlat16_37) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat16_9.xyz = fma(half3(u_xlat16_35), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = rsqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat21.x = clamp(u_xlat21.x, 0.0f, 1.0f);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat20 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_37), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat20), float3(u_xlat16_5.xyz));
    u_xlat16_1 = (-u_xlat16_11) + half(1.0);
    u_xlat1 = fma(input.TEXCOORD3, float(u_xlat16_1), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat1 = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat1);
    u_xlat0.w = min(u_xlat1, 1.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
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
    float3 u_xlat11;
    half u_xlat16_11;
    float u_xlat20;
    float2 u_xlat21;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat11.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat21.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_38 = (-u_xlat16_37) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat16_9.xyz = fma(half3(u_xlat16_35), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = rsqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat21.x = clamp(u_xlat21.x, 0.0f, 1.0f);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat20 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_37), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat20), float3(u_xlat16_5.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD5;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_1 = (-u_xlat16_11) + half(1.0);
    u_xlat1 = fma(input.TEXCOORD3, float(u_xlat16_1), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat1 = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat1);
    u_xlat0.w = min(u_xlat1, 1.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float u_xlat1;
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
    float3 u_xlat11;
    half u_xlat16_11;
    float u_xlat20;
    float2 u_xlat21;
    float u_xlat30;
    float u_xlat33;
    half u_xlat16_35;
    half u_xlat16_37;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * float3(u_xlat1);
    u_xlat10.xyz = fma(u_xlat10.xyz, float3(u_xlat1), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat11.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat11.xyz)));
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? float(u_xlat16_2.z) : (-float(u_xlat16_2.z));
    u_xlat3.z = u_xlat1 * float(u_xlat16_2.x);
    u_xlat4.x = u_xlat1 * float(u_xlat16_2.z);
    u_xlat3.xy = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.yz);
    u_xlat4.yz = (-float2(u_xlat16_2.xy)) * float2(u_xlat16_2.xy);
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = rsqrt(u_xlat1);
    u_xlat3.xyz = float3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = half(u_xlat0.x * u_xlat1);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_35 = fma((-u_xlat16_35), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_35);
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat16_35 = half((-u_xlat11.x) + 1.0);
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat21.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_37 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_38 = (-u_xlat16_37) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat16_9.xyz = fma(half3(u_xlat16_35), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = rsqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat10.xyz);
    u_xlat21.x = clamp(u_xlat21.x, 0.0f, 1.0f);
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0f, 1.0f);
    u_xlat20 = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = fma(u_xlat1, u_xlat1, -1.0);
    u_xlat10.x = fma(u_xlat10.x, u_xlat30, 1.00001001);
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = float3(u_xlat16_8.xyz) * u_xlat0.xxx;
    u_xlat0.xyw = fma(float3(u_xlat16_7.xyz), float3(u_xlat16_37), u_xlat0.xyw);
    u_xlat0.xyw = u_xlat0.xyw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyw, float3(u_xlat20), float3(u_xlat16_5.xyz));
    u_xlat0.xyz = u_xlat0.xyz + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat30 = input.TEXCOORD5;
    u_xlat30 = clamp(u_xlat30, 0.0f, 1.0f);
    u_xlat0.xyz = fma(float3(u_xlat30), u_xlat0.xyz, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_1 = (-u_xlat16_11) + half(1.0);
    u_xlat1 = fma(input.TEXCOORD3, float(u_xlat16_1), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat1 = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat1);
    u_xlat0.w = min(u_xlat1, 1.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
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
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    float2 u_xlat20;
    half u_xlat16_20;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD4.xyz;
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
    u_xlat20.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat20.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat20.xy);
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + input.TEXCOORD0.zw;
    u_xlat16_3.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat20.xy).xyz;
    u_xlat16_20 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat20.xy).x;
    u_xlat16_20 = (-u_xlat16_20) + half(1.0);
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_35 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_7.xyz = half3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = u_xlat16_35 + half(1.0);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_31);
    u_xlat16_9.xyz = fma(half3(u_xlat16_10), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_7.xyz, u_xlat16_5.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = (-u_xlat16_20) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_20));
    u_xlat16_10 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_10), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    output.SV_Target0.w = half(u_xlat0.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_10;
    float2 u_xlat20;
    half u_xlat16_20;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD4.xyz;
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
    u_xlat20.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat20.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat20.xy);
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + input.TEXCOORD0.zw;
    u_xlat16_3.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat20.xy).xyz;
    u_xlat16_20 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat20.xy).x;
    u_xlat16_20 = (-u_xlat16_20) + half(1.0);
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_35 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_7.xyz = half3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = u_xlat16_35 + half(1.0);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_31);
    u_xlat16_9.xyz = fma(half3(u_xlat16_10), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_7.xyz, u_xlat16_5.xyz);
    u_xlat16_1.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyw = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat3.x = input.TEXCOORD5;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat3.xxx, float3(u_xlat16_0.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0.x = (-u_xlat16_20) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_20));
    u_xlat16_10 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_10), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_18;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD4.xyz;
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
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat3.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat3.xy).xyz;
    u_xlat16_18 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat3.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_28 = u_xlat16_32 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_28);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_3 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_3, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(u_xlat16_5.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.x = (-u_xlat16_18) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_18));
    u_xlat16_9 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_9), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    output.SV_Target0.w = half(u_xlat0.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float2 u_xlat18;
    half u_xlat16_18;
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
    u_xlat18.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat18.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat18.xy);
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + input.TEXCOORD0.zw;
    u_xlat16_2.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_3.xyz, u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_6.xyz = half3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_31 = u_xlat16_32 + half(1.0);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_31);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyw = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyw * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.x = (-u_xlat16_18) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_18));
    u_xlat16_9 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_9), float(u_xlat16_1.w), u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    output.SV_Target0.w = half(u_xlat0.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
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
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
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
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half3 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_18;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + input.TEXCOORD4.xyz;
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
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat3.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat3.xy);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat3.xy).xyz;
    u_xlat16_18 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat3.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_6.xyz = half3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_28 = u_xlat16_32 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_28);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = fma(u_xlat16_1.xyz, u_xlat16_6.xyz, u_xlat16_5.xyz);
    u_xlat16_3 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_3, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat27) * float3(u_xlat16_5.xyz));
    u_xlat16_1.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_1.xyz);
    u_xlat16_0.xyw = u_xlat16_1.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat3.x = input.TEXCOORD5;
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat3.xxx, float3(u_xlat16_0.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0.x = (-u_xlat16_18) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_18));
    u_xlat16_9 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_9), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
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
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_13;
    float2 u_xlat23;
    half u_xlat16_23;
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
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
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
    u_xlat23.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat23.xy = sin(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat23.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat23.xy);
    u_xlat23.xy = fract(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat23.xy).xyz;
    u_xlat16_23 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat23.xy).x;
    u_xlat16_23 = (-u_xlat16_23) + half(1.0);
    u_xlat5.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat5.xy);
    u_xlat16_5.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_1.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_30) + FGlobals._Smoothness;
    u_xlat16_7.xyz = half3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_32 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_30);
    u_xlat16_9.xyz = fma(half3(u_xlat16_13), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_2.xyz);
    output.SV_Target0.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat16_3.x = (-u_xlat16_23) + half(1.0);
    u_xlat3.x = fma(input.TEXCOORD3, float(u_xlat16_3.x), float(u_xlat16_23));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat3.x = fma(float(u_xlat16_13), float(u_xlat16_1.w), u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, 1.0);
    output.SV_Target0.w = half(u_xlat3.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    half3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_10.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_10.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + input.TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (5) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half u_xlat16_0;
    half4 u_xlat16_1;
    float3 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half u_xlat16_16;
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
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat2.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat2.xy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.zw;
    u_xlat16_3.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat2.xy).xyz;
    u_xlat16_16 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat2.xy).x;
    u_xlat16_16 = (-u_xlat16_16) + half(1.0);
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_2.xyz, u_xlat16_1.xyz, u_xlat16_3.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_5.xyz = half3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_28 = u_xlat16_29 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_28);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_5.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat24) * float3(u_xlat16_5.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0 = (-u_xlat16_16) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_16));
    u_xlat16_8 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_8), float(u_xlat16_1.w), u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    output.SV_Target0.w = half(u_xlat0.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_9;
    float2 u_xlat18;
    half u_xlat16_18;
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
    u_xlat18.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat18.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat18.xy);
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + input.TEXCOORD0.zw;
    u_xlat16_2.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + half(1.0);
    u_xlat3.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_3.xyz, u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_31 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_31) + FGlobals._Smoothness;
    u_xlat16_6.xyz = half3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_31 = u_xlat16_32 + half(1.0);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_31);
    u_xlat16_8.xyz = fma(half3(u_xlat16_9), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyw = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyw * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyw = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat2.x = input.TEXCOORD5;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_0.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0.x = (-u_xlat16_18) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_18));
    u_xlat16_9 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_9), float(u_xlat16_1.w), u_xlat0.x);
    u_xlat2.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat2);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (5) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_12;
    half u_xlat16_21;
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
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
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
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat4.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD0.zw;
    u_xlat16_5.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat4.xy).xyz;
    u_xlat16_21 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat4.xy).x;
    u_xlat16_21 = (-u_xlat16_21) + half(1.0);
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_4.xyz, u_xlat16_1.xyz, u_xlat16_5.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_6.xyz = half3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_29 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_27);
    u_xlat16_8.xyz = fma(half3(u_xlat16_12), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_2.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat30) * float3(u_xlat16_6.xyz));
    output.SV_Target0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat16_3.x = (-u_xlat16_21) + half(1.0);
    u_xlat3.x = fma(input.TEXCOORD3, float(u_xlat16_3.x), float(u_xlat16_21));
    u_xlat16_12 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat3.x = fma(float(u_xlat16_12), float(u_xlat16_1.w), u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, 1.0);
    output.SV_Target0.w = half(u_xlat3.x);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_44) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_44) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat1.xyz = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
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
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
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
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half u_xlat16_13;
    float2 u_xlat23;
    half u_xlat16_23;
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
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
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
    u_xlat23.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat23.xy = sin(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat23.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat23.xy);
    u_xlat23.xy = fract(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat23.xy).xyz;
    u_xlat16_23 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat23.xy).x;
    u_xlat16_23 = (-u_xlat16_23) + half(1.0);
    u_xlat5.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat5.xy);
    u_xlat16_5.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, u_xlat16_1.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_30 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_32 = (-u_xlat16_30) + FGlobals._Smoothness;
    u_xlat16_7.xyz = half3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_32 + half(1.0);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_30);
    u_xlat16_9.xyz = fma(half3(u_xlat16_13), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat16_8.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_7.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = fma(u_xlat16_8.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat16_3.xyw = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat4.x = input.TEXCOORD5;
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat4.xxx, float3(u_xlat16_3.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_3.x = (-u_xlat16_23) + half(1.0);
    u_xlat3.x = fma(input.TEXCOORD3, float(u_xlat16_3.x), float(u_xlat16_23));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat3.x = fma(float(u_xlat16_13), float(u_xlat16_1.w), u_xlat3.x);
    u_xlat0.w = min(u_xlat3.x, 1.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (3) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (4) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (5) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    half4 u_xlat16_0;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half u_xlat16_16;
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
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = half((-u_xlat26) + 1.0);
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat2.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat2.xy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.zw;
    u_xlat16_3.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat2.xy).xyz;
    u_xlat16_16 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat2.xy).x;
    u_xlat16_16 = (-u_xlat16_16) + half(1.0);
    u_xlat2.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_5.xyz = fma(u_xlat16_2.xyz, u_xlat16_1.xyz, u_xlat16_3.xyz);
    u_xlat16_6.xyz = u_xlat16_5.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = fma(half3(FGlobals._Metallic), u_xlat16_6.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_28 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_28) + FGlobals._Smoothness;
    u_xlat16_5.xyz = half3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_28 = u_xlat16_29 + half(1.0);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + half3(u_xlat16_28);
    u_xlat16_7.xyz = fma(half3(u_xlat16_8), u_xlat16_7.xyz, u_xlat16_6.xyz);
    u_xlat16_6.xyz = half3(fma(u_xlat0.xxx, float3(u_xlat16_6.xyz), float3(u_xlat16_5.xyz)));
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_2.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * half3(FGlobals._Occlusion);
    u_xlat16_4.xyz = fma(u_xlat16_7.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0h, 1.0h);
    u_xlat16_5.xyz = half3(u_xlat16_28) * FGlobals._LightColor0.xyz;
    u_xlat16_5.xyz = half3(float3(u_xlat24) * float3(u_xlat16_5.xyz));
    u_xlat16_4.xyz = fma(u_xlat16_6.xyz, u_xlat16_5.xyz, u_xlat16_4.xyz);
    u_xlat16_0.xyw = u_xlat16_4.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat2.x = input.TEXCOORD5;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.xyz = fma(u_xlat2.xxx, float3(u_xlat16_0.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0.x = (-u_xlat16_16) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0.x), float(u_xlat16_16));
    u_xlat16_8 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_8), float(u_xlat16_1.w), u_xlat0.x);
    u_xlat2.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat2);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float3 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    float3 u_xlat11;
    half u_xlat16_11;
    float3 u_xlat12;
    float2 u_xlat22;
    float u_xlat36;
    half u_xlat16_38;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = fma(u_xlat11.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat12.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat12.xyz)));
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat36);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_38 = fma((-u_xlat16_38), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat11.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat11.x = clamp(u_xlat11.x, 0.0f, 1.0f);
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat11.x = fma(u_xlat11.x, u_xlat22.x, 1.00001001);
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat11.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat11.xy);
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + half(1.0);
    u_xlat22.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_38 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + FGlobals._Smoothness;
    u_xlat16_38 = u_xlat16_38 + half(1.0);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_38);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_38 = clamp(u_xlat16_38, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_38) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * FGlobals.unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0f, 1.0f);
    u_xlat16_38 = half((-u_xlat12.x) + 1.0);
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = fma(half3(u_xlat16_38), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_11) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_11));
    u_xlat16_11 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_11), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (5) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (6) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(4) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(5) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float3 u_xlat4;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half u_xlat16_12;
    half u_xlat16_21;
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
    u_xlat16_4.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
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
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat4.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat4.xy);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD0.zw;
    u_xlat16_5.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat4.xy).xyz;
    u_xlat16_21 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat4.xy).x;
    u_xlat16_21 = (-u_xlat16_21) + half(1.0);
    u_xlat4.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + input.TEXCOORD0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_6.xyz = fma(u_xlat16_4.xyz, u_xlat16_1.xyz, u_xlat16_5.xyz);
    u_xlat16_7.xyz = u_xlat16_6.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = fma(half3(FGlobals._Metallic), u_xlat16_7.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_27 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_29 = (-u_xlat16_27) + FGlobals._Smoothness;
    u_xlat16_6.xyz = half3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_29 + half(1.0);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + half3(u_xlat16_27);
    u_xlat16_8.xyz = fma(half3(u_xlat16_12), u_xlat16_8.xyz, u_xlat16_7.xyz);
    u_xlat16_7.xyz = half3(fma(u_xlat3.xxx, float3(u_xlat16_7.xyz), float3(u_xlat16_6.xyz)));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, u_xlat16_6.xyz, u_xlat16_2.xyz);
    u_xlat16_2 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat16_2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0h, 1.0h);
    u_xlat16_6.xyz = half3(u_xlat16_27) * FGlobals._LightColor0.xyz;
    u_xlat16_6.xyz = half3(float3(u_xlat30) * float3(u_xlat16_6.xyz));
    u_xlat16_0.xyz = fma(u_xlat16_7.xyz, u_xlat16_6.xyz, u_xlat16_0.xyz);
    u_xlat16_3.xyw = u_xlat16_0.xyz + (-FGlobals.unity_FogColor.xyz);
    u_xlat4.x = input.TEXCOORD5;
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat4.xxx, float3(u_xlat16_3.xyw), float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_3.x = (-u_xlat16_21) + half(1.0);
    u_xlat3.x = fma(input.TEXCOORD3, float(u_xlat16_3.x), float(u_xlat16_21));
    u_xlat16_12 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat3.x = fma(float(u_xlat16_12), float(u_xlat16_1.w), u_xlat3.x);
    u_xlat0.w = min(u_xlat3.x, 1.0);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_44) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsBaseAlpha;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (4) ]],
    sampler sampler_WhitecapsAlpha [[ sampler (5) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<half, access::sample > _WhitecapsAlpha [[ texture(2) ]] ,
    texture2d<half, access::sample > unity_Lightmap [[ texture(3) ]] ,
    texture2d<half, access::sample > unity_ShadowMask [[ texture(4) ]] ,
    texturecube<half, access::sample > unity_SpecCube0 [[ texture(5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    bool u_xlatb1;
    half4 u_xlat16_2;
    float3 u_xlat3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    half3 u_xlat16_5;
    half3 u_xlat16_6;
    half3 u_xlat16_7;
    half3 u_xlat16_8;
    half3 u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_11;
    half3 u_xlat16_12;
    float3 u_xlat13;
    half u_xlat16_13;
    float3 u_xlat14;
    float2 u_xlat26;
    float u_xlat42;
    half u_xlat16_44;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, FGlobals._NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat16_2.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = half3(fma(input.TEXCOORD1.xyz, (-float3(u_xlat16_2.xxx)), (-u_xlat14.xyz)));
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? half(0.0) : half(u_xlat42);
    u_xlat16_2 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat3.xyz, bias(float(u_xlat16_2.x)));
    u_xlat16_5.x = u_xlat16_2.w + half(-1.0);
    u_xlat16_5.x = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat16_5.x, half(1.0));
    u_xlat16_5.x = u_xlat16_5.x * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(FGlobals._Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = half(u_xlat0.x * u_xlat1.x);
    u_xlat0.x = fma(u_xlat0.x, u_xlat0.x, 1.5);
    u_xlat16_44 = fma((-u_xlat16_44), half(0.280000001), half(1.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz * half3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat13.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat3.x = rsqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * input.TEXCOORD1.xyz;
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = fma(u_xlat1.x, u_xlat1.x, -1.0);
    u_xlat13.x = fma(u_xlat13.x, u_xlat26.x, 1.00001001);
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat13.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat13.xy);
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + input.TEXCOORD0.zw;
    u_xlat16_4.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = _WhitecapsAlpha.sample(sampler_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + half(1.0);
    u_xlat26.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_7.xyz = fma(u_xlat16_6.xyz, u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_8.xyz = u_xlat16_7.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = fma(half3(FGlobals._Metallic), u_xlat16_8.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_44 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_7.xyz = half3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + FGlobals._Smoothness;
    u_xlat16_44 = u_xlat16_44 + half(1.0);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + half3(u_xlat16_44);
    u_xlat0.xzw = fma(u_xlat0.xxx, float3(u_xlat16_8.xyz), float3(u_xlat16_7.xyz));
    u_xlat16_4 = unity_ShadowMask.sample(samplerunity_ShadowMask, input.TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat16_44 = clamp(u_xlat16_44, 0.0h, 1.0h);
    u_xlat16_10.xyz = half3(u_xlat16_44) * FGlobals._LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * float3(u_xlat16_10.xyz);
    u_xlat16_44 = half(input.TEXCOORD1.y * input.TEXCOORD1.y);
    u_xlat16_44 = half(fma(input.TEXCOORD1.x, input.TEXCOORD1.x, (-float(u_xlat16_44))));
    u_xlat16_4 = half4(input.TEXCOORD1.yzzx * input.TEXCOORD1.xyzz);
    u_xlat16_10.x = dot(FGlobals.unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(FGlobals.unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(FGlobals.unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = fma(FGlobals.unity_SHC.xyz, half3(u_xlat16_44), u_xlat16_10.xyz);
    u_xlat4.xyz = input.TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = half(dot(float4(FGlobals.unity_SHAr), u_xlat4));
    u_xlat16_11.y = half(dot(float4(FGlobals.unity_SHAg), u_xlat4));
    u_xlat16_11.z = half(dot(float4(FGlobals.unity_SHAb), u_xlat4));
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * half3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = fma(u_xlat16_6.xyz, half3(1.05499995, 1.05499995, 1.05499995), half3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = unity_Lightmap.sample(samplerunity_Lightmap, input.TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = fma(FGlobals.unity_Lightmap_HDR.xxx, u_xlat16_12.xyz, u_xlat16_6.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * half3(FGlobals._Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat16_44 = half((-u_xlat14.x) + 1.0);
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = fma(half3(u_xlat16_44), u_xlat16_9.xyz, u_xlat16_8.xyz);
    u_xlat0.xzw = fma(u_xlat0.xzw, u_xlat1.xxx, float3(u_xlat16_7.xyz));
    u_xlat0.xzw = fma(float3(u_xlat16_5.xyz), float3(u_xlat16_8.xyz), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw + (-float3(FGlobals.unity_FogColor.xyz));
    u_xlat1.x = input.TEXCOORD5;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xxx, u_xlat0.xzw, float3(FGlobals.unity_FogColor.xyz));
    u_xlat16_0 = (-u_xlat16_13) + half(1.0);
    u_xlat0.x = fma(input.TEXCOORD3, float(u_xlat16_0), float(u_xlat16_13));
    u_xlat16_13 = input.COLOR0.w + FGlobals._WhitecapsBaseAlpha;
    u_xlat0.x = fma(float(u_xlat16_13), float(u_xlat16_2.w), u_xlat0.x);
    u_xlat1.w = min(u_xlat0.x, 1.0);
    output.SV_Target0 = half4(u_xlat1);
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
  GpuProgramID 121540
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat5;
    float u_xlat10;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xy = float2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * float(VGlobals._Wave2Freq);
    u_xlat5 = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat5, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat10 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat15 * float(VGlobals._WaveFreq);
    u_xlatb15 = 0.0<u_xlat15;
    u_xlat5 = fma(u_xlat5, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat5 = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat10);
    u_xlat2.x = u_xlat5 * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, input.NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, input.NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat0.x);
    u_xlat0.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat5 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat0.x / u_xlat5;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat0.x, float(u_xlat16_6));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat0.x, float(u_xlat16_6));
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
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    half4 unity_FogColor;
    float4 unity_FogParams;
    float4 booster_Env;
    float _WhitecapsDepthMin;
    float _WhitecapsDepthMax;
    half _WaveFreq;
    half _WaveSpeed;
    half _WaveHeight;
    half _Wave2Freq;
    half _Wave2Speed;
    half _Wave2Height;
    half _WaveSlopeMag;
    half3 _WaveCenterPos;
    float4 _MainTex_ST;
    float4 _Whitecaps_ST;
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
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float TEXCOORD6 [[ user(TEXCOORD6) ]];
    half4 COLOR0 [[ user(COLOR0) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    half u_xlat16_6;
    float3 u_xlat7;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.POSITION0.yy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0].xz, input.POSITION0.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2].xz, input.POSITION0.zz, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xz, input.POSITION0.ww, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + (-float2(VGlobals._WaveCenterPos.xxyz.yw));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = rsqrt(u_xlat14);
    u_xlat1.xy = float2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * float(VGlobals._Wave2Freq);
    u_xlat7.x = VGlobals.booster_Env.x * 0.0500000007;
    u_xlat0.x = fma(u_xlat7.x, float(VGlobals._Wave2Speed), (-u_xlat0.x));
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * float(VGlobals._Wave2Height);
    u_xlat14 = u_xlat2.x * float(VGlobals._Wave2Height);
    u_xlat2.x = u_xlat21 * float(VGlobals._WaveFreq);
    u_xlatb21 = 0.0<u_xlat21;
    u_xlat7.x = fma(u_xlat7.x, float(VGlobals._WaveSpeed), (-u_xlat2.x));
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = fma(float(VGlobals._WaveHeight), u_xlat2.x, u_xlat0.x);
    u_xlat7.x = fma(float(VGlobals._WaveHeight), u_xlat3.x, u_xlat14);
    u_xlat2.x = u_xlat7.x * float(VGlobals._WaveSlopeMag);
    u_xlat0.x = u_xlat0.x + input.POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat3);
    u_xlat4 = u_xlat3 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat3.xyz);
    u_xlat3 = u_xlat4.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat4.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat4.zzzz, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat4.wwww, u_xlat3);
    output.mtl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z / VGlobals._ProjectionParams.y;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * VGlobals._ProjectionParams.z;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = fma(u_xlat0.x, VGlobals.unity_FogParams.z, VGlobals.unity_FogParams.w);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, VGlobals._Whitecaps_ST.xy, VGlobals._Whitecaps_ST.zw);
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, input.NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, input.NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, input.NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : input.NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    output.TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * VGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[0].z, u_xlat4.x, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[2].z, u_xlat4.z, u_xlat7.x);
    u_xlat7.x = fma(VGlobals.hlslcc_mtx4x4unity_MatrixV[3].z, u_xlat4.w, u_xlat7.x);
    u_xlat7.x = abs(u_xlat7.x) + (-VGlobals._WhitecapsDepthMin);
    u_xlat14 = (-VGlobals._WhitecapsDepthMin) + VGlobals._WhitecapsDepthMax;
    output.TEXCOORD3 = u_xlat7.x / u_xlat14;
    output.TEXCOORD3 = clamp(output.TEXCOORD3, 0.0f, 1.0f);
    u_xlat16_6 = (-VGlobals.unity_FogColor.w) + half(1.0);
    output.TEXCOORD6 = max(u_xlat0.x, float(u_xlat16_6));
    output.COLOR0 = input.COLOR0;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
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
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    sampler samplerunity_NHxRoughness [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    sampler sampler_Whitecaps [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half3 u_xlat16_6;
    float u_xlat18;
    half u_xlat16_20;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * input.TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat18)), u_xlat0.xyz);
    u_xlat18 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat18) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat6.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat6.xy = sin(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat6.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD0.zw;
    u_xlat16_6.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat6.xy).xyz;
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, u_xlat16_1.xyz, u_xlat16_6.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.xyz = half3(u_xlat0.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_20 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_20), u_xlat16_5.xyz);
    output.SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
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
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_Whitecaps [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_12;
    float u_xlat18;
    half u_xlat16_22;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_7 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * float(u_xlat16_7);
    u_xlat7.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = dot(u_xlat7.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat12.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat12.xy);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.zw;
    u_xlat16_1.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_5.xyz);
    u_xlat16_22 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_22), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xzw;
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
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
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
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_Whitecaps [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_12;
    float u_xlat18;
    half u_xlat16_22;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_7 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * float(u_xlat16_7);
    u_xlat7.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = dot(u_xlat7.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat12.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat12.xy);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.zw;
    u_xlat16_1.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_5.xyz);
    u_xlat16_22 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_22), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xzw;
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
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
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
    sampler sampler_Whitecaps [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    texture2d<float, access::sample > unity_NHxRoughness [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half3 u_xlat16_6;
    float u_xlat18;
    half u_xlat16_20;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * input.TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = fma(u_xlat1.xyz, (-float3(u_xlat18)), u_xlat0.xyz);
    u_xlat18 = dot(u_xlat1.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat16_2.xyz = half3(float3(u_xlat18) * float3(FGlobals._LightColor0.xyz));
    u_xlat0.x = dot(u_xlat0.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-float(FGlobals._Smoothness)) + 1.0;
    u_xlat0.x = unity_NHxRoughness.sample(samplerunity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat6.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat6.xy = sin(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat6.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + input.TEXCOORD0.zw;
    u_xlat16_6.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat6.xy).xyz;
    u_xlat1.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + input.TEXCOORD0.xy;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, u_xlat16_1.xyz, u_xlat16_6.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat16_5.xyz = half3(u_xlat0.xxx * float3(u_xlat16_5.xyz));
    u_xlat16_20 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat16_4.xyz = fma(u_xlat16_4.xyz, half3(u_xlat16_20), u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat0.x = input.TEXCOORD6;
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
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_Whitecaps [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_12;
    float u_xlat18;
    half u_xlat16_22;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_7 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * float(u_xlat16_7);
    u_xlat7.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = dot(u_xlat7.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat12.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat12.xy);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.zw;
    u_xlat16_1.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_5.xyz);
    u_xlat16_22 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_22), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = input.TEXCOORD6;
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat18);
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
    float4 booster_Env;
    half4 _Color;
    half _Metallic;
    half _Smoothness;
    half _AlbedoScrollSpeedU;
    half _AlbedoScrollSpeedV;
    half _WhitecapsScrollSpeedU;
    half _WhitecapsScrollSpeedV;
    half _WhitecapsScrollSinScaleU;
    half _WhitecapsScrollSinScaleV;
    half _WhitecapsScrollSinSpeedU;
    half _WhitecapsScrollSinSpeedV;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float TEXCOORD6 [[ user(TEXCOORD6) ]] ;
    half4 COLOR0 [[ user(COLOR0) ]] ;
};

struct Mtl_FragmentOut
{
    half4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_Whitecaps [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Whitecaps [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_1;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float u_xlat6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_12;
    float u_xlat18;
    half u_xlat16_22;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(float3(FGlobals._WorldSpaceLightPos0.xyz), u_xlat0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-FGlobals._Smoothness) + half(1.0);
    u_xlat16_7 = fma(u_xlat16_1.x, u_xlat16_1.x, half(1.5));
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * float(u_xlat16_7);
    u_xlat7.x = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * input.TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6 = dot(u_xlat7.xyz, float3(FGlobals._WorldSpaceLightPos0.xyz));
    u_xlat6 = clamp(u_xlat6, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = fma(u_xlat16_1.x, u_xlat16_1.x, half(-1.0));
    u_xlat0.x = fma(u_xlat0.x, float(u_xlat16_12), 1.00001001);
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = float(u_xlat16_1.x) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._WhitecapsScrollSinSpeedU, FGlobals._WhitecapsScrollSinSpeedV));
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * float2(half2(FGlobals._WhitecapsScrollSinScaleU, FGlobals._WhitecapsScrollSinScaleV));
    u_xlat12.xy = fma(float2(half2(FGlobals._WhitecapsScrollSpeedU, FGlobals._WhitecapsScrollSpeedV)), FGlobals.booster_Env.xx, u_xlat12.xy);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.zw;
    u_xlat16_1.xyz = _Whitecaps.sample(sampler_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = FGlobals.booster_Env.xx * float2(half2(FGlobals._AlbedoScrollSpeedU, FGlobals._AlbedoScrollSpeedV));
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + input.TEXCOORD0.xy;
    u_xlat16_2.xyz = _MainTex.sample(sampler_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = input.COLOR0.xyz + FGlobals._Color.xyz;
    u_xlat16_4.xyz = fma(u_xlat16_3.xyz, u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_5.xyz = u_xlat16_4.xyz + half3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = fma(half3(FGlobals._Metallic), u_xlat16_5.xyz, half3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.xzw = u_xlat0.xxx * float3(u_xlat16_5.xyz);
    u_xlat16_22 = fma((-FGlobals._Metallic), half(0.779083729), half(0.779083729));
    u_xlat0.xzw = fma(float3(u_xlat16_4.xyz), float3(u_xlat16_22), u_xlat0.xzw);
    u_xlat0.xzw = u_xlat0.xzw * float3(FGlobals._LightColor0.xyz);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = input.TEXCOORD6;
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat18);
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
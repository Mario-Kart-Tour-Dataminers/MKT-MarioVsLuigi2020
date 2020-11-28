//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/Outline" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 13682
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float _RenderViewportScaleFactor;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float2 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.xy * float2(VGlobals._RenderViewportScaleFactor);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
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
    float4 _CameraDepthNormalsTexture_TexelSize;
    int _UseBaseColor;
    float4 _BaseColor;
    float4 _OutlineColor;
    float _NormalIntensityFactor;
    float _NormalAttenuationBias;
    float _DepthIntensityFactor;
    float _DepthAttenuationBias;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    float u_xlat18;
    half u_xlat16_18;
    half u_xlat16_19;
    half u_xlat16_20;
    half u_xlat16_21;
    u_xlat0 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(1.0, 0.0, -1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat16_1 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat16_0 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_1.x = dot(u_xlat16_1.zw, half2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = half(2.0) / u_xlat16_7.x;
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(u_xlat16_7.xx);
    u_xlat2.z = float(u_xlat16_7.x) + -1.0;
    u_xlat16_3 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy);
    u_xlat16_7.xyz = fma(u_xlat16_3.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_20 = dot(u_xlat16_3.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat3.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat3.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = fma(u_xlat16_0.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.x = dot(u_xlat16_0.zw, half2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = half(2.0) / u_xlat16_6;
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(u_xlat16_6);
    u_xlat2.z = float(u_xlat16_6) + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(0.0, 1.0, 0.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat16_5 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.z = dot(u_xlat16_5.zw, half2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat2.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_18);
    u_xlat2.z = float(u_xlat16_18) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.w = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + float3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat2.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat2.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = input.TEXCOORD0.xy + FGlobals._CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.x = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat16_5 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.y = dot(u_xlat16_5.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat5.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat5.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.z = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + float3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = input.TEXCOORD0.xy + (-FGlobals._CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_21 = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * FGlobals._NormalIntensityFactor;
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * FGlobals._NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + half(0.600000024);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat0.x = u_xlat0.x + float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = float(u_xlat16_21) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = fma(u_xlat6.x, u_xlat6.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat6.x = float(FGlobals._UseBaseColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._BaseColor;
    u_xlat1 = fma(u_xlat6.xxxx, u_xlat2, float4(u_xlat16_1));
    u_xlat2 = (-u_xlat1) + FGlobals._OutlineColor;
    output.SV_TARGET0 = fma(u_xlat0.xxxx, u_xlat2, u_xlat1);
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
    float4 _CameraDepthNormalsTexture_TexelSize;
    int _UseBaseColor;
    float4 _BaseColor;
    float4 _OutlineColor;
    float _NormalIntensityFactor;
    float _NormalAttenuationBias;
    float _DepthIntensityFactor;
    float _DepthAttenuationBias;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    float u_xlat18;
    half u_xlat16_18;
    half u_xlat16_19;
    half u_xlat16_20;
    half u_xlat16_21;
    u_xlat0 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(1.0, 0.0, -1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat16_1 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat16_0 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_1.x = dot(u_xlat16_1.zw, half2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = half(2.0) / u_xlat16_7.x;
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(u_xlat16_7.xx);
    u_xlat2.z = float(u_xlat16_7.x) + -1.0;
    u_xlat16_3 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy);
    u_xlat16_7.xyz = fma(u_xlat16_3.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_20 = dot(u_xlat16_3.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat3.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat3.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = fma(u_xlat16_0.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.x = dot(u_xlat16_0.zw, half2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = half(2.0) / u_xlat16_6;
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(u_xlat16_6);
    u_xlat2.z = float(u_xlat16_6) + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(0.0, 1.0, 0.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat16_5 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.z = dot(u_xlat16_5.zw, half2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat2.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_18);
    u_xlat2.z = float(u_xlat16_18) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.w = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + float3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat2.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat2.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = input.TEXCOORD0.xy + FGlobals._CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.x = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat16_5 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.y = dot(u_xlat16_5.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat5.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat5.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.z = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + float3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = input.TEXCOORD0.xy + (-FGlobals._CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_21 = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * FGlobals._NormalIntensityFactor;
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * FGlobals._NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + half(0.600000024);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat0.x = u_xlat0.x + float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = float(u_xlat16_21) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = fma(u_xlat6.x, u_xlat6.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat6.x = float(FGlobals._UseBaseColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._BaseColor;
    u_xlat1 = fma(u_xlat6.xxxx, u_xlat2, float4(u_xlat16_1));
    u_xlat2 = (-u_xlat1) + FGlobals._OutlineColor;
    output.SV_TARGET0 = fma(u_xlat0.xxxx, u_xlat2, u_xlat1);
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
    float4 _CameraDepthNormalsTexture_TexelSize;
    int _UseBaseColor;
    float4 _BaseColor;
    float4 _OutlineColor;
    float _NormalIntensityFactor;
    float _NormalAttenuationBias;
    float _DepthIntensityFactor;
    float _DepthAttenuationBias;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_TARGET0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthNormalsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraDepthNormalsTexture [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    half4 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    float u_xlat18;
    half u_xlat16_18;
    half u_xlat16_19;
    half u_xlat16_20;
    half u_xlat16_21;
    u_xlat0 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(1.0, 0.0, -1.0, 0.0), input.TEXCOORD0.xyxy);
    u_xlat16_1 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.xy);
    u_xlat16_0 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat0.zw);
    u_xlat16_2.xyz = fma(u_xlat16_1.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_1.x = dot(u_xlat16_1.zw, half2(1.0, 0.00392156886));
    u_xlat16_7.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = half(2.0) / u_xlat16_7.x;
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(u_xlat16_7.xx);
    u_xlat2.z = float(u_xlat16_7.x) + -1.0;
    u_xlat16_3 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, input.TEXCOORD1.xy);
    u_xlat16_7.xyz = fma(u_xlat16_3.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_20 = dot(u_xlat16_3.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat3.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat3.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat16_2.xyz = fma(u_xlat16_0.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.x = dot(u_xlat16_0.zw, half2(1.0, 0.00392156886));
    u_xlat16_6 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_6 = half(2.0) / u_xlat16_6;
    u_xlat2.xy = float2(u_xlat16_2.xy) * float2(u_xlat16_6);
    u_xlat2.z = float(u_xlat16_6) + -1.0;
    u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat6.x = u_xlat6.y + u_xlat6.x;
    u_xlat6.x = u_xlat6.z + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(0.0, 1.0, 0.0, -1.0), input.TEXCOORD0.xyxy);
    u_xlat16_5 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.z = dot(u_xlat16_5.zw, half2(1.0, 0.00392156886));
    u_xlat16_18 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_18 = half(2.0) / u_xlat16_18;
    u_xlat2.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_18);
    u_xlat2.z = float(u_xlat16_18) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat18 = u_xlat7.y + u_xlat7.x;
    u_xlat18 = u_xlat7.z + u_xlat18;
    u_xlat6.x = u_xlat18 + u_xlat6.x;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat0.w = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat0.xzw = (-u_xlat0.xzw) + float3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat2.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat2.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = input.TEXCOORD0.xy + FGlobals._CameraDepthNormalsTexture_TexelSize.xy;
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.x = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat4 = fma(FGlobals._CameraDepthNormalsTexture_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat16_5 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat4.zw);
    u_xlat16_7.xyz = fma(u_xlat16_5.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.y = dot(u_xlat16_5.zw, half2(1.0, 0.00392156886));
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat5.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat5.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat5.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat2.z = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat2.xyz = (-u_xlat2.xyz) + float3(u_xlat16_20);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat7.xy = input.TEXCOORD0.xy + (-FGlobals._CameraDepthNormalsTexture_TexelSize.xy);
    u_xlat16_4 = _CameraDepthNormalsTexture.sample(sampler_CameraDepthNormalsTexture, u_xlat7.xy);
    u_xlat16_7.xyz = fma(u_xlat16_4.xyz, half3(3.55539989, 3.55539989, 0.0), half3(-1.77769995, -1.77769995, 1.0));
    u_xlat16_21 = dot(u_xlat16_4.zw, half2(1.0, 0.00392156886));
    u_xlat16_21 = u_xlat16_20 + (-u_xlat16_21);
    u_xlat16_19 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_19 = half(2.0) / u_xlat16_19;
    u_xlat4.xy = float2(u_xlat16_7.xy) * float2(u_xlat16_19);
    u_xlat4.z = float(u_xlat16_19) + -1.0;
    u_xlat7.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat7.z + u_xlat7.x;
    u_xlat6.x = u_xlat6.x + u_xlat7.x;
    u_xlat6.x = u_xlat6.x * FGlobals._NormalIntensityFactor;
    u_xlat6.x = clamp(u_xlat6.x, 0.0f, 1.0f);
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * FGlobals._NormalAttenuationBias;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + u_xlat16_20;
    u_xlat16_7.x = (-u_xlat16_20) + half(0.600000024);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0h, 1.0h);
    u_xlat0.x = u_xlat0.x + float(u_xlat16_1.x);
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat2.x + u_xlat0.x;
    u_xlat0.x = u_xlat2.y + u_xlat0.x;
    u_xlat0.x = u_xlat2.z + u_xlat0.x;
    u_xlat0.x = float(u_xlat16_21) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * FGlobals._DepthIntensityFactor;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * FGlobals._DepthAttenuationBias;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = fma(u_xlat6.x, u_xlat6.x, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = u_xlat0.x * float(u_xlat16_7.x);
    u_xlat6.x = float(FGlobals._UseBaseColor);
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat2 = (-float4(u_xlat16_1)) + FGlobals._BaseColor;
    u_xlat1 = fma(u_xlat6.xxxx, u_xlat2, float4(u_xlat16_1));
    u_xlat2 = (-u_xlat1) + FGlobals._OutlineColor;
    output.SV_TARGET0 = fma(u_xlat0.xxxx, u_xlat2, u_xlat1);
    return output;
}
"
}
}
}
}
}
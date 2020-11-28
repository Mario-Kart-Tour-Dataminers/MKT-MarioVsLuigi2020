//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/TemporalAntialiasing" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 58585
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _CameraDepthTexture_TexelSize;
    float2 _Jitter;
    float4 _FinalBlendParameters;
    float _Sharpness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_HistoryTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _HistoryTex [[ texture(1) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(2) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    constexpr sampler sampler_LinearClamp(filter::linear,address::clamp_to_edge);
    float4 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat10_2;
    float3 u_xlat3;
    half4 u_xlat10_3;
    float4 u_xlat4;
    half4 u_xlat10_4;
    float3 u_xlat5;
    half4 u_xlat16_5;
    float4 u_xlat6;
    half4 u_xlat16_6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat14;
    half u_xlat16_14;
    bool u_xlatb14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.TEXCOORD1.xy + (-FGlobals._CameraDepthTexture_TexelSize.xy);
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat0.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat1.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlatb21 = u_xlat0.z>=u_xlat1.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat0.x = float(-1.0);
    u_xlat0.y = float(-1.0);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.yyz);
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = float(1.0);
    u_xlat1.y = float(-1.0);
    u_xlat2 = fma(FGlobals._CameraDepthTexture_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD1.xyxy);
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = min(u_xlat2, float4(FGlobals._RenderViewportScaleFactor));
    u_xlat1.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat2.zw).x;
    u_xlatb21 = u_xlat1.z>=u_xlat0.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-u_xlat0.yyz) + u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat2.x = float(-1.0);
    u_xlat2.y = float(1.0);
    u_xlatb21 = u_xlat2.z>=u_xlat0.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1.xy = input.TEXCOORD1.xy + FGlobals._CameraDepthTexture_TexelSize.xy;
    u_xlat1.xy = max(u_xlat1.xy, float2(0.0, 0.0));
    u_xlat1.xy = min(u_xlat1.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat21 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat1.xy).x;
    u_xlatb14 = u_xlat21>=u_xlat0.z;
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat1.xy = (-u_xlat0.xy) + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat14.xx, u_xlat1.xy, u_xlat0.xy);
    u_xlat0.xy = fma(u_xlat0.xy, FGlobals._CameraDepthTexture_TexelSize.xy, input.TEXCOORD1.xy);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat16_14 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD1.xy;
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat1 = float4(_HistoryTex.sample(sampler_HistoryTex, u_xlat0.xy));
    u_xlat16_0.x = sqrt(u_xlat16_14);
    u_xlat16_7 = u_xlat16_0.x * half(100.0);
    u_xlat0.x = float(u_xlat16_0.x) * FGlobals._FinalBlendParameters.z;
    u_xlat16_7 = min(u_xlat16_7, half(1.0));
    u_xlat16_7 = fma(u_xlat16_7, half(-3.75), half(4.0));
    u_xlat14.xy = input.TEXCOORD1.xy + (-FGlobals._Jitter.xyxx.xy);
    u_xlat14.xy = max(u_xlat14.xy, float2(0.0, 0.0));
    u_xlat14.xy = min(u_xlat14.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat2.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(0.5, 0.5), u_xlat14.xy);
    u_xlat2.xy = max(u_xlat2.xy, float2(0.0, 0.0));
    u_xlat2.xy = min(u_xlat2.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_2 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat2.xy));
    u_xlat3.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.5, 0.5), u_xlat14.xy);
    u_xlat10_4 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat14.xy));
    u_xlat14.xy = max(u_xlat3.xy, float2(0.0, 0.0));
    u_xlat14.xy = min(u_xlat14.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_3 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat14.xy));
    u_xlat16_5 = half4(float4(u_xlat10_2) + float4(u_xlat10_3));
    u_xlat16_6 = half4(float4(u_xlat10_4) + float4(u_xlat10_4));
    u_xlat16_5 = fma(u_xlat16_5, half4(4.0, 4.0, 4.0, 4.0), (-u_xlat16_6));
    u_xlat16_6 = half4(fma((-float4(u_xlat16_5)), float4(0.166666999, 0.166666999, 0.166666999, 0.166666999), float4(u_xlat10_4)));
    u_xlat6 = float4(u_xlat16_6) * float4(FGlobals._Sharpness);
    u_xlat4 = fma(u_xlat6, float4(2.71828198, 2.71828198, 2.71828198, 2.71828198), float4(u_xlat10_4));
    u_xlat4 = max(u_xlat4, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat4 = min(u_xlat4, float4(65472.0, 65472.0, 65472.0, 65472.0));
    u_xlat5.xyz = u_xlat4.xyz + float3(u_xlat16_5.xyz);
    u_xlat5.xyz = u_xlat5.xyz * float3(0.142857, 0.142857, 0.142857);
    u_xlat14.x = dot(u_xlat5.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat21 = dot(u_xlat4.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat14.x = (-u_xlat21) + u_xlat14.x;
    u_xlat16_5.xyz = half3(min(float3(u_xlat10_2.xyz), float3(u_xlat10_3.xyz)));
    u_xlat16_2.xyz = half3(max(float3(u_xlat10_2.xyz), float3(u_xlat10_3.xyz)));
    u_xlat2.xyz = fma(float3(u_xlat16_7), abs(u_xlat14.xxx), float3(u_xlat16_2.xyz));
    u_xlat7.xyz = fma((-float3(u_xlat16_7)), abs(u_xlat14.xxx), float3(u_xlat16_5.xyz));
    u_xlat3.xyz = (-u_xlat7.xyz) + u_xlat2.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = fma((-u_xlat7.xyz), float3(0.5, 0.5, 0.5), u_xlat1.xyz);
    u_xlat7.xyz = u_xlat7.xyz * float3(0.5, 0.5, 0.5);
    u_xlat5.xyz = u_xlat3.xyz + float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat2.xyz = u_xlat2.xyz / u_xlat5.xyz;
    u_xlat2.x = min(abs(u_xlat2.y), abs(u_xlat2.x));
    u_xlat2.x = min(abs(u_xlat2.z), u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat1.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, u_xlat7.xyz);
    u_xlat1 = (-u_xlat4) + u_xlat1;
    u_xlat7.x = (-FGlobals._FinalBlendParameters.x) + FGlobals._FinalBlendParameters.y;
    u_xlat0.x = fma(u_xlat0.x, u_xlat7.x, FGlobals._FinalBlendParameters.x);
    u_xlat0.x = max(u_xlat0.x, FGlobals._FinalBlendParameters.y);
    u_xlat0.x = min(u_xlat0.x, FGlobals._FinalBlendParameters.x);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat4);
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = min(u_xlat0, float4(65472.0, 65472.0, 65472.0, 65472.0));
    output.SV_Target0 = u_xlat0;
    output.SV_Target1 = u_xlat0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _CameraDepthTexture_TexelSize;
    float2 _Jitter;
    float4 _FinalBlendParameters;
    float _Sharpness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_HistoryTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _HistoryTex [[ texture(1) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(2) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    constexpr sampler sampler_LinearClamp(filter::linear,address::clamp_to_edge);
    float4 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat10_2;
    float3 u_xlat3;
    half4 u_xlat10_3;
    float4 u_xlat4;
    half4 u_xlat10_4;
    float3 u_xlat5;
    half4 u_xlat16_5;
    float4 u_xlat6;
    half4 u_xlat16_6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat14;
    half u_xlat16_14;
    bool u_xlatb14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.TEXCOORD1.xy + (-FGlobals._CameraDepthTexture_TexelSize.xy);
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat0.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat1.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlatb21 = u_xlat0.z>=u_xlat1.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat0.x = float(-1.0);
    u_xlat0.y = float(-1.0);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.yyz);
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = float(1.0);
    u_xlat1.y = float(-1.0);
    u_xlat2 = fma(FGlobals._CameraDepthTexture_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD1.xyxy);
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = min(u_xlat2, float4(FGlobals._RenderViewportScaleFactor));
    u_xlat1.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat2.zw).x;
    u_xlatb21 = u_xlat1.z>=u_xlat0.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-u_xlat0.yyz) + u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat2.x = float(-1.0);
    u_xlat2.y = float(1.0);
    u_xlatb21 = u_xlat2.z>=u_xlat0.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1.xy = input.TEXCOORD1.xy + FGlobals._CameraDepthTexture_TexelSize.xy;
    u_xlat1.xy = max(u_xlat1.xy, float2(0.0, 0.0));
    u_xlat1.xy = min(u_xlat1.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat21 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat1.xy).x;
    u_xlatb14 = u_xlat21>=u_xlat0.z;
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat1.xy = (-u_xlat0.xy) + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat14.xx, u_xlat1.xy, u_xlat0.xy);
    u_xlat0.xy = fma(u_xlat0.xy, FGlobals._CameraDepthTexture_TexelSize.xy, input.TEXCOORD1.xy);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat16_14 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD1.xy;
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat1 = float4(_HistoryTex.sample(sampler_HistoryTex, u_xlat0.xy));
    u_xlat16_0.x = sqrt(u_xlat16_14);
    u_xlat16_7 = u_xlat16_0.x * half(100.0);
    u_xlat0.x = float(u_xlat16_0.x) * FGlobals._FinalBlendParameters.z;
    u_xlat16_7 = min(u_xlat16_7, half(1.0));
    u_xlat16_7 = fma(u_xlat16_7, half(-3.75), half(4.0));
    u_xlat14.xy = input.TEXCOORD1.xy + (-FGlobals._Jitter.xyxx.xy);
    u_xlat14.xy = max(u_xlat14.xy, float2(0.0, 0.0));
    u_xlat14.xy = min(u_xlat14.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat2.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(0.5, 0.5), u_xlat14.xy);
    u_xlat2.xy = max(u_xlat2.xy, float2(0.0, 0.0));
    u_xlat2.xy = min(u_xlat2.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_2 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat2.xy));
    u_xlat3.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.5, 0.5), u_xlat14.xy);
    u_xlat10_4 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat14.xy));
    u_xlat14.xy = max(u_xlat3.xy, float2(0.0, 0.0));
    u_xlat14.xy = min(u_xlat14.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_3 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat14.xy));
    u_xlat16_5 = half4(float4(u_xlat10_2) + float4(u_xlat10_3));
    u_xlat16_6 = half4(float4(u_xlat10_4) + float4(u_xlat10_4));
    u_xlat16_5 = fma(u_xlat16_5, half4(4.0, 4.0, 4.0, 4.0), (-u_xlat16_6));
    u_xlat16_6 = half4(fma((-float4(u_xlat16_5)), float4(0.166666999, 0.166666999, 0.166666999, 0.166666999), float4(u_xlat10_4)));
    u_xlat6 = float4(u_xlat16_6) * float4(FGlobals._Sharpness);
    u_xlat4 = fma(u_xlat6, float4(2.71828198, 2.71828198, 2.71828198, 2.71828198), float4(u_xlat10_4));
    u_xlat4 = max(u_xlat4, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat4 = min(u_xlat4, float4(65472.0, 65472.0, 65472.0, 65472.0));
    u_xlat5.xyz = u_xlat4.xyz + float3(u_xlat16_5.xyz);
    u_xlat5.xyz = u_xlat5.xyz * float3(0.142857, 0.142857, 0.142857);
    u_xlat14.x = dot(u_xlat5.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat21 = dot(u_xlat4.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat14.x = (-u_xlat21) + u_xlat14.x;
    u_xlat16_5.xyz = half3(min(float3(u_xlat10_2.xyz), float3(u_xlat10_3.xyz)));
    u_xlat16_2.xyz = half3(max(float3(u_xlat10_2.xyz), float3(u_xlat10_3.xyz)));
    u_xlat2.xyz = fma(float3(u_xlat16_7), abs(u_xlat14.xxx), float3(u_xlat16_2.xyz));
    u_xlat7.xyz = fma((-float3(u_xlat16_7)), abs(u_xlat14.xxx), float3(u_xlat16_5.xyz));
    u_xlat3.xyz = (-u_xlat7.xyz) + u_xlat2.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = fma((-u_xlat7.xyz), float3(0.5, 0.5, 0.5), u_xlat1.xyz);
    u_xlat7.xyz = u_xlat7.xyz * float3(0.5, 0.5, 0.5);
    u_xlat5.xyz = u_xlat3.xyz + float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat2.xyz = u_xlat2.xyz / u_xlat5.xyz;
    u_xlat2.x = min(abs(u_xlat2.y), abs(u_xlat2.x));
    u_xlat2.x = min(abs(u_xlat2.z), u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat1.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, u_xlat7.xyz);
    u_xlat1 = (-u_xlat4) + u_xlat1;
    u_xlat7.x = (-FGlobals._FinalBlendParameters.x) + FGlobals._FinalBlendParameters.y;
    u_xlat0.x = fma(u_xlat0.x, u_xlat7.x, FGlobals._FinalBlendParameters.x);
    u_xlat0.x = max(u_xlat0.x, FGlobals._FinalBlendParameters.y);
    u_xlat0.x = min(u_xlat0.x, FGlobals._FinalBlendParameters.x);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat4);
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = min(u_xlat0, float4(65472.0, 65472.0, 65472.0, 65472.0));
    output.SV_Target0 = u_xlat0;
    output.SV_Target1 = u_xlat0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float4 _CameraDepthTexture_TexelSize;
    float2 _Jitter;
    float4 _FinalBlendParameters;
    float _Sharpness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_HistoryTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _HistoryTex [[ texture(1) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(2) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    constexpr sampler sampler_LinearClamp(filter::linear,address::clamp_to_edge);
    float4 u_xlat0;
    half2 u_xlat16_0;
    float4 u_xlat1;
    float4 u_xlat2;
    half3 u_xlat16_2;
    half4 u_xlat10_2;
    float3 u_xlat3;
    half4 u_xlat10_3;
    float4 u_xlat4;
    half4 u_xlat10_4;
    float3 u_xlat5;
    half4 u_xlat16_5;
    float4 u_xlat6;
    half4 u_xlat16_6;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat14;
    half u_xlat16_14;
    bool u_xlatb14;
    float u_xlat21;
    bool u_xlatb21;
    u_xlat0.xy = input.TEXCOORD1.xy + (-FGlobals._CameraDepthTexture_TexelSize.xy);
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat0.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat1.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy).x;
    u_xlatb21 = u_xlat0.z>=u_xlat1.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat0.x = float(-1.0);
    u_xlat0.y = float(-1.0);
    u_xlat1.x = float(0.0);
    u_xlat1.y = float(0.0);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.yyz);
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = float(1.0);
    u_xlat1.y = float(-1.0);
    u_xlat2 = fma(FGlobals._CameraDepthTexture_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD1.xyxy);
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = min(u_xlat2, float4(FGlobals._RenderViewportScaleFactor));
    u_xlat1.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.z = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat2.zw).x;
    u_xlatb21 = u_xlat1.z>=u_xlat0.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-u_xlat0.yyz) + u_xlat1.xyz;
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat2.x = float(-1.0);
    u_xlat2.y = float(1.0);
    u_xlatb21 = u_xlat2.z>=u_xlat0.z;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = fma(float3(u_xlat21), u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1.xy = input.TEXCOORD1.xy + FGlobals._CameraDepthTexture_TexelSize.xy;
    u_xlat1.xy = max(u_xlat1.xy, float2(0.0, 0.0));
    u_xlat1.xy = min(u_xlat1.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat21 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat1.xy).x;
    u_xlatb14 = u_xlat21>=u_xlat0.z;
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat1.xy = (-u_xlat0.xy) + float2(1.0, 1.0);
    u_xlat0.xy = fma(u_xlat14.xx, u_xlat1.xy, u_xlat0.xy);
    u_xlat0.xy = fma(u_xlat0.xy, FGlobals._CameraDepthTexture_TexelSize.xy, input.TEXCOORD1.xy);
    u_xlat16_0.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat16_14 = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat0.xy = (-float2(u_xlat16_0.xy)) + input.TEXCOORD1.xy;
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat1 = float4(_HistoryTex.sample(sampler_HistoryTex, u_xlat0.xy));
    u_xlat16_0.x = sqrt(u_xlat16_14);
    u_xlat16_7 = u_xlat16_0.x * half(100.0);
    u_xlat0.x = float(u_xlat16_0.x) * FGlobals._FinalBlendParameters.z;
    u_xlat16_7 = min(u_xlat16_7, half(1.0));
    u_xlat16_7 = fma(u_xlat16_7, half(-3.75), half(4.0));
    u_xlat14.xy = input.TEXCOORD1.xy + (-FGlobals._Jitter.xyxx.xy);
    u_xlat14.xy = max(u_xlat14.xy, float2(0.0, 0.0));
    u_xlat14.xy = min(u_xlat14.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat2.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(0.5, 0.5), u_xlat14.xy);
    u_xlat2.xy = max(u_xlat2.xy, float2(0.0, 0.0));
    u_xlat2.xy = min(u_xlat2.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_2 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat2.xy));
    u_xlat3.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.5, 0.5), u_xlat14.xy);
    u_xlat10_4 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat14.xy));
    u_xlat14.xy = max(u_xlat3.xy, float2(0.0, 0.0));
    u_xlat14.xy = min(u_xlat14.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_3 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat14.xy));
    u_xlat16_5 = half4(float4(u_xlat10_2) + float4(u_xlat10_3));
    u_xlat16_6 = half4(float4(u_xlat10_4) + float4(u_xlat10_4));
    u_xlat16_5 = fma(u_xlat16_5, half4(4.0, 4.0, 4.0, 4.0), (-u_xlat16_6));
    u_xlat16_6 = half4(fma((-float4(u_xlat16_5)), float4(0.166666999, 0.166666999, 0.166666999, 0.166666999), float4(u_xlat10_4)));
    u_xlat6 = float4(u_xlat16_6) * float4(FGlobals._Sharpness);
    u_xlat4 = fma(u_xlat6, float4(2.71828198, 2.71828198, 2.71828198, 2.71828198), float4(u_xlat10_4));
    u_xlat4 = max(u_xlat4, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat4 = min(u_xlat4, float4(65472.0, 65472.0, 65472.0, 65472.0));
    u_xlat5.xyz = u_xlat4.xyz + float3(u_xlat16_5.xyz);
    u_xlat5.xyz = u_xlat5.xyz * float3(0.142857, 0.142857, 0.142857);
    u_xlat14.x = dot(u_xlat5.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat21 = dot(u_xlat4.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat14.x = (-u_xlat21) + u_xlat14.x;
    u_xlat16_5.xyz = half3(min(float3(u_xlat10_2.xyz), float3(u_xlat10_3.xyz)));
    u_xlat16_2.xyz = half3(max(float3(u_xlat10_2.xyz), float3(u_xlat10_3.xyz)));
    u_xlat2.xyz = fma(float3(u_xlat16_7), abs(u_xlat14.xxx), float3(u_xlat16_2.xyz));
    u_xlat7.xyz = fma((-float3(u_xlat16_7)), abs(u_xlat14.xxx), float3(u_xlat16_5.xyz));
    u_xlat3.xyz = (-u_xlat7.xyz) + u_xlat2.xyz;
    u_xlat7.xyz = u_xlat7.xyz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = fma((-u_xlat7.xyz), float3(0.5, 0.5, 0.5), u_xlat1.xyz);
    u_xlat7.xyz = u_xlat7.xyz * float3(0.5, 0.5, 0.5);
    u_xlat5.xyz = u_xlat3.xyz + float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat2.xyz = u_xlat2.xyz / u_xlat5.xyz;
    u_xlat2.x = min(abs(u_xlat2.y), abs(u_xlat2.x));
    u_xlat2.x = min(abs(u_xlat2.z), u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat1.xyz = fma(u_xlat3.xyz, u_xlat2.xxx, u_xlat7.xyz);
    u_xlat1 = (-u_xlat4) + u_xlat1;
    u_xlat7.x = (-FGlobals._FinalBlendParameters.x) + FGlobals._FinalBlendParameters.y;
    u_xlat0.x = fma(u_xlat0.x, u_xlat7.x, FGlobals._FinalBlendParameters.x);
    u_xlat0.x = max(u_xlat0.x, FGlobals._FinalBlendParameters.y);
    u_xlat0.x = min(u_xlat0.x, FGlobals._FinalBlendParameters.x);
    u_xlat0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat4);
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = min(u_xlat0, float4(65472.0, 65472.0, 65472.0, 65472.0));
    output.SV_Target0 = u_xlat0;
    output.SV_Target1 = u_xlat0;
    return output;
}
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 117925
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float2 _Jitter;
    float4 _FinalBlendParameters;
    float _Sharpness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_HistoryTex [[ sampler (0) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _HistoryTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    constexpr sampler sampler_LinearClamp(filter::linear,address::clamp_to_edge);
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat10_0;
    float2 u_xlat1;
    half2 u_xlat16_1;
    half4 u_xlat10_1;
    float4 u_xlat2;
    half4 u_xlat10_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_13;
    float u_xlat18;
    float u_xlat19;
    u_xlat0.xy = input.TEXCOORD1.xy + (-FGlobals._Jitter.xyxx.xy);
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat12.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(0.5, 0.5), u_xlat0.xy);
    u_xlat12.xy = max(u_xlat12.xy, float2(0.0, 0.0));
    u_xlat12.xy = min(u_xlat12.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_1 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat12.xy));
    u_xlat12.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.5, 0.5), u_xlat0.xy);
    u_xlat10_2 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat0.xy));
    u_xlat0.xy = max(u_xlat12.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_0 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat0.xy));
    u_xlat16_3 = half4(float4(u_xlat10_0) + float4(u_xlat10_1));
    u_xlat16_4 = half4(float4(u_xlat10_2) + float4(u_xlat10_2));
    u_xlat16_3 = fma(u_xlat16_3, half4(4.0, 4.0, 4.0, 4.0), (-u_xlat16_4));
    u_xlat16_4 = half4(fma((-float4(u_xlat16_3)), float4(0.166666999, 0.166666999, 0.166666999, 0.166666999), float4(u_xlat10_2)));
    u_xlat4 = float4(u_xlat16_4) * float4(FGlobals._Sharpness);
    u_xlat2 = fma(u_xlat4, float4(2.71828198, 2.71828198, 2.71828198, 2.71828198), float4(u_xlat10_2));
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = min(u_xlat2, float4(65472.0, 65472.0, 65472.0, 65472.0));
    u_xlat3.xyz = u_xlat2.xyz + float3(u_xlat16_3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * float3(0.142857, 0.142857, 0.142857);
    u_xlat18 = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat19 = dot(u_xlat2.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat18 = u_xlat18 + (-u_xlat19);
    u_xlat16_3.xyz = half3(min(float3(u_xlat10_1.xyz), float3(u_xlat10_0.xyz)));
    u_xlat16_0.xyz = half3(max(float3(u_xlat10_0.xyz), float3(u_xlat10_1.xyz)));
    u_xlat16_1.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD1.xy).xy;
    u_xlat16_13 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat1.xy = (-float2(u_xlat16_1.xy)) + input.TEXCOORD1.xy;
    u_xlat1.xy = max(u_xlat1.xy, float2(0.0, 0.0));
    u_xlat1.xy = min(u_xlat1.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat4 = float4(_HistoryTex.sample(sampler_HistoryTex, u_xlat1.xy));
    u_xlat16_1.x = sqrt(u_xlat16_13);
    u_xlat16_7 = u_xlat16_1.x * half(100.0);
    u_xlat1.x = float(u_xlat16_1.x) * FGlobals._FinalBlendParameters.z;
    u_xlat16_7 = min(u_xlat16_7, half(1.0));
    u_xlat16_7 = fma(u_xlat16_7, half(-3.75), half(4.0));
    u_xlat3.xyz = fma((-float3(u_xlat16_7)), abs(float3(u_xlat18)), float3(u_xlat16_3.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_7), abs(float3(u_xlat18)), float3(u_xlat16_0.xyz));
    u_xlat7.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat7.xyz = u_xlat7.xyz * float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = fma((-u_xlat0.xyz), float3(0.5, 0.5, 0.5), u_xlat4.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.5, 0.5, 0.5);
    u_xlat5.xyz = u_xlat3.xyz + float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
    u_xlat18 = min(abs(u_xlat7.y), abs(u_xlat7.x));
    u_xlat18 = min(abs(u_xlat7.z), u_xlat18);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat18), u_xlat0.xyz);
    u_xlat0 = (-u_xlat2) + u_xlat4;
    u_xlat7.x = (-FGlobals._FinalBlendParameters.x) + FGlobals._FinalBlendParameters.y;
    u_xlat1.x = fma(u_xlat1.x, u_xlat7.x, FGlobals._FinalBlendParameters.x);
    u_xlat1.x = max(u_xlat1.x, FGlobals._FinalBlendParameters.y);
    u_xlat1.x = min(u_xlat1.x, FGlobals._FinalBlendParameters.x);
    u_xlat0 = fma(u_xlat1.xxxx, u_xlat0, u_xlat2);
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = min(u_xlat0, float4(65472.0, 65472.0, 65472.0, 65472.0));
    output.SV_Target0 = u_xlat0;
    output.SV_Target1 = u_xlat0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float2 _Jitter;
    float4 _FinalBlendParameters;
    float _Sharpness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_HistoryTex [[ sampler (0) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _HistoryTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    constexpr sampler sampler_LinearClamp(filter::linear,address::clamp_to_edge);
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat10_0;
    float2 u_xlat1;
    half2 u_xlat16_1;
    half4 u_xlat10_1;
    float4 u_xlat2;
    half4 u_xlat10_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_13;
    float u_xlat18;
    float u_xlat19;
    u_xlat0.xy = input.TEXCOORD1.xy + (-FGlobals._Jitter.xyxx.xy);
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat12.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(0.5, 0.5), u_xlat0.xy);
    u_xlat12.xy = max(u_xlat12.xy, float2(0.0, 0.0));
    u_xlat12.xy = min(u_xlat12.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_1 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat12.xy));
    u_xlat12.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.5, 0.5), u_xlat0.xy);
    u_xlat10_2 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat0.xy));
    u_xlat0.xy = max(u_xlat12.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_0 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat0.xy));
    u_xlat16_3 = half4(float4(u_xlat10_0) + float4(u_xlat10_1));
    u_xlat16_4 = half4(float4(u_xlat10_2) + float4(u_xlat10_2));
    u_xlat16_3 = fma(u_xlat16_3, half4(4.0, 4.0, 4.0, 4.0), (-u_xlat16_4));
    u_xlat16_4 = half4(fma((-float4(u_xlat16_3)), float4(0.166666999, 0.166666999, 0.166666999, 0.166666999), float4(u_xlat10_2)));
    u_xlat4 = float4(u_xlat16_4) * float4(FGlobals._Sharpness);
    u_xlat2 = fma(u_xlat4, float4(2.71828198, 2.71828198, 2.71828198, 2.71828198), float4(u_xlat10_2));
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = min(u_xlat2, float4(65472.0, 65472.0, 65472.0, 65472.0));
    u_xlat3.xyz = u_xlat2.xyz + float3(u_xlat16_3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * float3(0.142857, 0.142857, 0.142857);
    u_xlat18 = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat19 = dot(u_xlat2.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat18 = u_xlat18 + (-u_xlat19);
    u_xlat16_3.xyz = half3(min(float3(u_xlat10_1.xyz), float3(u_xlat10_0.xyz)));
    u_xlat16_0.xyz = half3(max(float3(u_xlat10_0.xyz), float3(u_xlat10_1.xyz)));
    u_xlat16_1.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD1.xy).xy;
    u_xlat16_13 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat1.xy = (-float2(u_xlat16_1.xy)) + input.TEXCOORD1.xy;
    u_xlat1.xy = max(u_xlat1.xy, float2(0.0, 0.0));
    u_xlat1.xy = min(u_xlat1.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat4 = float4(_HistoryTex.sample(sampler_HistoryTex, u_xlat1.xy));
    u_xlat16_1.x = sqrt(u_xlat16_13);
    u_xlat16_7 = u_xlat16_1.x * half(100.0);
    u_xlat1.x = float(u_xlat16_1.x) * FGlobals._FinalBlendParameters.z;
    u_xlat16_7 = min(u_xlat16_7, half(1.0));
    u_xlat16_7 = fma(u_xlat16_7, half(-3.75), half(4.0));
    u_xlat3.xyz = fma((-float3(u_xlat16_7)), abs(float3(u_xlat18)), float3(u_xlat16_3.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_7), abs(float3(u_xlat18)), float3(u_xlat16_0.xyz));
    u_xlat7.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat7.xyz = u_xlat7.xyz * float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = fma((-u_xlat0.xyz), float3(0.5, 0.5, 0.5), u_xlat4.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.5, 0.5, 0.5);
    u_xlat5.xyz = u_xlat3.xyz + float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
    u_xlat18 = min(abs(u_xlat7.y), abs(u_xlat7.x));
    u_xlat18 = min(abs(u_xlat7.z), u_xlat18);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat18), u_xlat0.xyz);
    u_xlat0 = (-u_xlat2) + u_xlat4;
    u_xlat7.x = (-FGlobals._FinalBlendParameters.x) + FGlobals._FinalBlendParameters.y;
    u_xlat1.x = fma(u_xlat1.x, u_xlat7.x, FGlobals._FinalBlendParameters.x);
    u_xlat1.x = max(u_xlat1.x, FGlobals._FinalBlendParameters.y);
    u_xlat1.x = min(u_xlat1.x, FGlobals._FinalBlendParameters.x);
    u_xlat0 = fma(u_xlat1.xxxx, u_xlat0, u_xlat2);
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = min(u_xlat0, float4(65472.0, 65472.0, 65472.0, 65472.0));
    output.SV_Target0 = u_xlat0;
    output.SV_Target1 = u_xlat0;
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
    float _RenderViewportScaleFactor;
    float4 _MainTex_TexelSize;
    float2 _Jitter;
    float4 _FinalBlendParameters;
    float _Sharpness;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_HistoryTex [[ sampler (0) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _HistoryTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    constexpr sampler sampler_LinearClamp(filter::linear,address::clamp_to_edge);
    float4 u_xlat0;
    half3 u_xlat16_0;
    half4 u_xlat10_0;
    float2 u_xlat1;
    half2 u_xlat16_1;
    half4 u_xlat10_1;
    float4 u_xlat2;
    half4 u_xlat10_2;
    float3 u_xlat3;
    half4 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float3 u_xlat5;
    float3 u_xlat7;
    half u_xlat16_7;
    float2 u_xlat12;
    half u_xlat16_13;
    float u_xlat18;
    float u_xlat19;
    u_xlat0.xy = input.TEXCOORD1.xy + (-FGlobals._Jitter.xyxx.xy);
    u_xlat0.xy = max(u_xlat0.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat12.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(0.5, 0.5), u_xlat0.xy);
    u_xlat12.xy = max(u_xlat12.xy, float2(0.0, 0.0));
    u_xlat12.xy = min(u_xlat12.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_1 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat12.xy));
    u_xlat12.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.5, 0.5), u_xlat0.xy);
    u_xlat10_2 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat0.xy));
    u_xlat0.xy = max(u_xlat12.xy, float2(0.0, 0.0));
    u_xlat0.xy = min(u_xlat0.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat10_0 = half4(_MainTex.sample(sampler_LinearClamp, u_xlat0.xy));
    u_xlat16_3 = half4(float4(u_xlat10_0) + float4(u_xlat10_1));
    u_xlat16_4 = half4(float4(u_xlat10_2) + float4(u_xlat10_2));
    u_xlat16_3 = fma(u_xlat16_3, half4(4.0, 4.0, 4.0, 4.0), (-u_xlat16_4));
    u_xlat16_4 = half4(fma((-float4(u_xlat16_3)), float4(0.166666999, 0.166666999, 0.166666999, 0.166666999), float4(u_xlat10_2)));
    u_xlat4 = float4(u_xlat16_4) * float4(FGlobals._Sharpness);
    u_xlat2 = fma(u_xlat4, float4(2.71828198, 2.71828198, 2.71828198, 2.71828198), float4(u_xlat10_2));
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat2 = min(u_xlat2, float4(65472.0, 65472.0, 65472.0, 65472.0));
    u_xlat3.xyz = u_xlat2.xyz + float3(u_xlat16_3.xyz);
    u_xlat3.xyz = u_xlat3.xyz * float3(0.142857, 0.142857, 0.142857);
    u_xlat18 = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat19 = dot(u_xlat2.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat18 = u_xlat18 + (-u_xlat19);
    u_xlat16_3.xyz = half3(min(float3(u_xlat10_1.xyz), float3(u_xlat10_0.xyz)));
    u_xlat16_0.xyz = half3(max(float3(u_xlat10_0.xyz), float3(u_xlat10_1.xyz)));
    u_xlat16_1.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD1.xy).xy;
    u_xlat16_13 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat1.xy = (-float2(u_xlat16_1.xy)) + input.TEXCOORD1.xy;
    u_xlat1.xy = max(u_xlat1.xy, float2(0.0, 0.0));
    u_xlat1.xy = min(u_xlat1.xy, float2(FGlobals._RenderViewportScaleFactor));
    u_xlat4 = float4(_HistoryTex.sample(sampler_HistoryTex, u_xlat1.xy));
    u_xlat16_1.x = sqrt(u_xlat16_13);
    u_xlat16_7 = u_xlat16_1.x * half(100.0);
    u_xlat1.x = float(u_xlat16_1.x) * FGlobals._FinalBlendParameters.z;
    u_xlat16_7 = min(u_xlat16_7, half(1.0));
    u_xlat16_7 = fma(u_xlat16_7, half(-3.75), half(4.0));
    u_xlat3.xyz = fma((-float3(u_xlat16_7)), abs(float3(u_xlat18)), float3(u_xlat16_3.xyz));
    u_xlat0.xyz = fma(float3(u_xlat16_7), abs(float3(u_xlat18)), float3(u_xlat16_0.xyz));
    u_xlat7.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat7.xyz = u_xlat7.xyz * float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = fma((-u_xlat0.xyz), float3(0.5, 0.5, 0.5), u_xlat4.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.5, 0.5, 0.5);
    u_xlat5.xyz = u_xlat3.xyz + float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
    u_xlat18 = min(abs(u_xlat7.y), abs(u_xlat7.x));
    u_xlat18 = min(abs(u_xlat7.z), u_xlat18);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat4.xyz = fma(u_xlat3.xyz, float3(u_xlat18), u_xlat0.xyz);
    u_xlat0 = (-u_xlat2) + u_xlat4;
    u_xlat7.x = (-FGlobals._FinalBlendParameters.x) + FGlobals._FinalBlendParameters.y;
    u_xlat1.x = fma(u_xlat1.x, u_xlat7.x, FGlobals._FinalBlendParameters.x);
    u_xlat1.x = max(u_xlat1.x, FGlobals._FinalBlendParameters.y);
    u_xlat1.x = min(u_xlat1.x, FGlobals._FinalBlendParameters.x);
    u_xlat0 = fma(u_xlat1.xxxx, u_xlat0, u_xlat2);
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = min(u_xlat0, float4(65472.0, 65472.0, 65472.0, 65472.0));
    output.SV_Target0 = u_xlat0;
    output.SV_Target1 = u_xlat0;
    return output;
}
"
}
}
}
}
}
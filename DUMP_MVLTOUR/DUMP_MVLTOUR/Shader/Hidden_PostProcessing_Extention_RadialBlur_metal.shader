//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/RadialBlur" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 17024
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
    float4 _ScreenParams;
    float _BlurPower;
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
    float2 u_xlat0;
    half4 u_xlat16_0;
    float2 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float2 u_xlat8;
    float u_xlat12;
    u_xlat0.xy = (-input.TEXCOORD1.xy) + float2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = rsqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * FGlobals._BlurPower;
    u_xlat0.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = float2(0.5, 0.5) / FGlobals._ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = fma(u_xlat0.xy, u_xlat8.xx, input.TEXCOORD1.xy);
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 * half4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.189999998, 0.189999998, 0.189999998, 0.189999998), u_xlat16_1);
    u_xlat8.xy = fma(u_xlat0.xy, float2(2.0, 2.0), input.TEXCOORD1.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat8.xy);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.150000006, 0.150000006, 0.150000006, 0.150000006), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(3.0, 3.0, 4.0, 4.0), input.TEXCOORD1.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(5.0, 5.0, 6.0, 6.0), input.TEXCOORD1.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(7.0, 7.0, 8.0, 8.0), input.TEXCOORD1.xyxy);
    u_xlat0.xy = fma(u_xlat0.xy, float2(9.0, 9.0), input.TEXCOORD1.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993), u_xlat16_1);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978), float4(u_xlat16_1));
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
    float4 _ScreenParams;
    float _BlurPower;
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
    float2 u_xlat0;
    half4 u_xlat16_0;
    float2 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float2 u_xlat8;
    float u_xlat12;
    u_xlat0.xy = (-input.TEXCOORD1.xy) + float2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = rsqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * FGlobals._BlurPower;
    u_xlat0.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = float2(0.5, 0.5) / FGlobals._ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = fma(u_xlat0.xy, u_xlat8.xx, input.TEXCOORD1.xy);
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 * half4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.189999998, 0.189999998, 0.189999998, 0.189999998), u_xlat16_1);
    u_xlat8.xy = fma(u_xlat0.xy, float2(2.0, 2.0), input.TEXCOORD1.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat8.xy);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.150000006, 0.150000006, 0.150000006, 0.150000006), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(3.0, 3.0, 4.0, 4.0), input.TEXCOORD1.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(5.0, 5.0, 6.0, 6.0), input.TEXCOORD1.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(7.0, 7.0, 8.0, 8.0), input.TEXCOORD1.xyxy);
    u_xlat0.xy = fma(u_xlat0.xy, float2(9.0, 9.0), input.TEXCOORD1.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993), u_xlat16_1);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978), float4(u_xlat16_1));
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
    float4 _ScreenParams;
    float _BlurPower;
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
    float2 u_xlat0;
    half4 u_xlat16_0;
    float2 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    half4 u_xlat16_3;
    float2 u_xlat8;
    float u_xlat12;
    u_xlat0.xy = (-input.TEXCOORD1.xy) + float2(0.5, 0.5);
    u_xlat8.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat12 = rsqrt(u_xlat8.x);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * FGlobals._BlurPower;
    u_xlat0.xy = float2(u_xlat12) * u_xlat0.xy;
    u_xlat1.xy = float2(0.5, 0.5) / FGlobals._ScreenParams.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat1.xy = fma(u_xlat0.xy, u_xlat8.xx, input.TEXCOORD1.xy);
    u_xlat0.xy = u_xlat8.xx * u_xlat0.xy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.xy);
    u_xlat16_1 = u_xlat16_1 * half4(0.170000002, 0.170000002, 0.170000002, 0.170000002);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.189999998, 0.189999998, 0.189999998, 0.189999998), u_xlat16_1);
    u_xlat8.xy = fma(u_xlat0.xy, float2(2.0, 2.0), input.TEXCOORD1.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat8.xy);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.150000006, 0.150000006, 0.150000006, 0.150000006), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(3.0, 3.0, 4.0, 4.0), input.TEXCOORD1.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(5.0, 5.0, 6.0, 6.0), input.TEXCOORD1.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat16_1);
    u_xlat2 = fma(u_xlat0.xyxy, float4(7.0, 7.0, 8.0, 8.0), input.TEXCOORD1.xyxy);
    u_xlat0.xy = fma(u_xlat0.xy, float2(9.0, 9.0), input.TEXCOORD1.xy);
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.xy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat2.xy);
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.zw);
    u_xlat16_1 = fma(u_xlat16_3, half4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007), u_xlat16_1);
    u_xlat16_1 = fma(u_xlat16_2, half4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993), u_xlat16_1);
    output.SV_Target0 = fma(float4(u_xlat16_0), float4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978), float4(u_xlat16_1));
    return output;
}
"
}
}
}
}
}
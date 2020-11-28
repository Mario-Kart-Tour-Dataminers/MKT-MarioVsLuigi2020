//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/GrainBaker" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35488
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
    float _Phase;
    float3 _NoiseParameters;
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
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float2 u_xlat7;
    float u_xlat9;
    float u_xlat10;
    float3 u_xlat11;
    float2 u_xlat14;
    float2 u_xlat16;
    float u_xlat21;
    float u_xlat23;
    float u_xlat25;
    u_xlat0.y = fract(FGlobals._Phase);
    u_xlat1 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat0.yyyy);
    u_xlat2 = u_xlat1.zwzw + float4(-2.0, -2.0, -1.0, -2.0);
    u_xlat2.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.x = fma(u_xlat2.y, 2.0, u_xlat2.x);
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(-2.0);
    u_xlat0.w = float(-1.0);
    u_xlat3 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat0.xyyx);
    u_xlat4 = u_xlat0.yzyw + u_xlat3.xyxy;
    u_xlat5 = u_xlat0.zywy + u_xlat3.zwzw;
    u_xlat21 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat16.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat16.x = sin(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat21 = fract(u_xlat21);
    u_xlat2.x = u_xlat21 + u_xlat2.x;
    u_xlat4 = u_xlat1.zwzw + float4(-2.0, -1.0, -1.0, -1.0);
    u_xlat23 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat4.x = fract(u_xlat4.x);
    u_xlat23 = sin(u_xlat23);
    u_xlat16.y = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.zw = fract(u_xlat16.xy);
    u_xlat2.x = fma(u_xlat2.w, 2.0, u_xlat2.x);
    u_xlat2.w = fma(u_xlat4.x, 2.0, u_xlat2.w);
    u_xlat2.x = fma(u_xlat4.x, -12.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat2.z, 2.0, u_xlat2.x);
    u_xlat11.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.x = u_xlat2.x + u_xlat11.x;
    u_xlat2.x = fma(u_xlat11.y, 2.0, u_xlat2.x);
    u_xlat25 = dot(u_xlat1.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat11.z = fract(u_xlat25);
    u_xlat9 = fma(u_xlat21, 2.0, u_xlat2.y);
    u_xlat5 = u_xlat1.zwzw + float4(1.0, -2.0, 1.0, -1.0);
    u_xlat5.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat5.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat5.xy = sin(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat9 = u_xlat9 + u_xlat5.x;
    u_xlat21 = fma(u_xlat5.x, 2.0, u_xlat21);
    u_xlat9 = fma(u_xlat4.x, 2.0, u_xlat9);
    u_xlat4.x = fma(u_xlat2.z, 2.0, u_xlat4.x);
    u_xlat4.x = u_xlat5.y + u_xlat4.x;
    u_xlat4.x = fma(u_xlat11.y, 2.0, u_xlat4.x);
    u_xlat4.x = fma(u_xlat11.z, -12.0, u_xlat4.x);
    u_xlat9 = fma(u_xlat2.z, -12.0, u_xlat9);
    u_xlat2.y = fma(u_xlat5.y, 2.0, u_xlat9);
    u_xlat2.xy = u_xlat11.zy + u_xlat2.xy;
    u_xlat9 = fma(u_xlat11.z, 2.0, u_xlat2.y);
    u_xlat0.x = float(1.0);
    u_xlat0.z = float(2.0);
    u_xlat6 = u_xlat0.xyzy + u_xlat3.zwzw;
    u_xlat3 = u_xlat0.yxyz + u_xlat3.xyxy;
    u_xlat0.x = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.y = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat14.x = u_xlat0.x + u_xlat9;
    u_xlat14.x = u_xlat14.x * 0.0833333358;
    u_xlat14.x = fma(u_xlat2.x, 0.0416666679, u_xlat14.x);
    u_xlat6 = u_xlat1.zwzw + float4(2.0, -2.0, 2.0, -1.0);
    u_xlat2.x = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = fma(u_xlat2.z, 2.0, u_xlat21);
    u_xlat2.x = fma(u_xlat5.y, 2.0, u_xlat2.z);
    u_xlat21 = fma(u_xlat5.y, -12.0, u_xlat21);
    u_xlat21 = fma(u_xlat2.y, 2.0, u_xlat21);
    u_xlat2.xw = u_xlat2.yz + u_xlat2.xw;
    u_xlat2.x = fma(u_xlat11.z, 2.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat0.x, -12.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat0.y, 2.0, u_xlat2.x);
    u_xlat21 = u_xlat11.z + u_xlat21;
    u_xlat21 = fma(u_xlat0.x, 2.0, u_xlat21);
    u_xlat21 = u_xlat0.y + u_xlat21;
    u_xlat14.x = fma(u_xlat21, 0.0416666679, u_xlat14.x);
    u_xlat21 = fma(u_xlat11.x, 2.0, u_xlat2.w);
    u_xlat9 = fma(u_xlat11.y, 2.0, u_xlat11.x);
    u_xlat9 = u_xlat11.z + u_xlat9;
    u_xlat21 = fma(u_xlat11.y, -12.0, u_xlat21);
    u_xlat16.x = fma(u_xlat11.z, 2.0, u_xlat11.y);
    u_xlat16.x = u_xlat0.x + u_xlat16.x;
    u_xlat21 = fma(u_xlat11.z, 2.0, u_xlat21);
    u_xlat23 = fma(u_xlat0.x, 2.0, u_xlat11.z);
    u_xlat0.x = fma(u_xlat0.x, 2.0, u_xlat4.x);
    u_xlat7.x = u_xlat0.y + u_xlat23;
    u_xlat4 = u_xlat1.zwzw + float4(-2.0, 1.0, -1.0, 1.0);
    u_xlat23 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat4.x = fract(u_xlat4.x);
    u_xlat23 = sin(u_xlat23);
    u_xlat23 = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = fract(u_xlat23);
    u_xlat21 = u_xlat21 + u_xlat23;
    u_xlat9 = fma(u_xlat23, 2.0, u_xlat9);
    u_xlat9 = fma(u_xlat4.x, -12.0, u_xlat9);
    u_xlat21 = fma(u_xlat4.x, 2.0, u_xlat21);
    u_xlat23 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = sin(u_xlat23);
    u_xlat23 = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = fract(u_xlat23);
    u_xlat21 = u_xlat21 + u_xlat23;
    u_xlat14.x = fma(u_xlat21, 0.0833333358, u_xlat14.x);
    u_xlat0.x = u_xlat0.x + u_xlat4.x;
    u_xlat21 = fma(u_xlat4.x, 2.0, u_xlat16.x);
    u_xlat21 = fma(u_xlat23, -12.0, u_xlat21);
    u_xlat0.x = fma(u_xlat23, 2.0, u_xlat0.x);
    u_xlat4 = u_xlat1.zwzw + float4(1.0, 1.0, 2.0, 1.0);
    u_xlat16.x = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10 = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10 = sin(u_xlat10);
    u_xlat3.y = u_xlat10 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat16.x = sin(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat0.x = u_xlat0.x + u_xlat16.x;
    u_xlat0.x = fma(u_xlat0.x, 0.166666672, u_xlat14.x);
    u_xlat14.x = u_xlat23 + u_xlat2.x;
    u_xlat14.x = fma(u_xlat16.x, 2.0, u_xlat14.x);
    u_xlat14.x = u_xlat3.y + u_xlat14.x;
    u_xlat0.x = fma(u_xlat14.x, 0.0833333358, u_xlat0.x);
    u_xlat14.x = fma(u_xlat23, 2.0, u_xlat9);
    u_xlat7.x = fma(u_xlat23, 2.0, u_xlat7.x);
    u_xlat7.x = fma(u_xlat16.x, -12.0, u_xlat7.x);
    u_xlat14.y = fma(u_xlat16.x, 2.0, u_xlat21);
    u_xlat7.x = fma(u_xlat3.y, 2.0, u_xlat7.x);
    u_xlat2 = u_xlat1.zwzw + float4(-2.0, 2.0, -1.0, 2.0);
    u_xlat1 = u_xlat1 + float4(1.0, 2.0, 2.0, 2.0);
    u_xlat2.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat14.xy = u_xlat14.xy + u_xlat2.xy;
    u_xlat7.y = fma(u_xlat2.y, 2.0, u_xlat14.x);
    u_xlat21 = fma(u_xlat3.x, 2.0, u_xlat14.y);
    u_xlat7.xy = u_xlat3.xx + u_xlat7.xy;
    u_xlat0.x = fma(u_xlat7.y, 0.0416666679, u_xlat0.x);
    u_xlat14.x = dot(u_xlat1.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = dot(u_xlat1.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat14.x = sin(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat21 = u_xlat14.x + u_xlat21;
    u_xlat7.x = fma(u_xlat14.x, 2.0, u_xlat7.x);
    u_xlat7.x = u_xlat1.x + u_xlat7.x;
    u_xlat0.x = fma(u_xlat21, 0.0833333358, u_xlat0.x);
    u_xlat0.x = fma(u_xlat7.x, 0.0416666679, u_xlat0.x);
    output.SV_Target0.xyz = u_xlat0.xxx * float3(0.0625, 0.0625, 0.0625);
    output.SV_Target0.w = 1.0;
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
    float _Phase;
    float3 _NoiseParameters;
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
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float2 u_xlat7;
    float u_xlat9;
    float u_xlat10;
    float3 u_xlat11;
    float2 u_xlat14;
    float2 u_xlat16;
    float u_xlat21;
    float u_xlat23;
    float u_xlat25;
    u_xlat0.y = fract(FGlobals._Phase);
    u_xlat1 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat0.yyyy);
    u_xlat2 = u_xlat1.zwzw + float4(-2.0, -2.0, -1.0, -2.0);
    u_xlat2.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.x = fma(u_xlat2.y, 2.0, u_xlat2.x);
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(-2.0);
    u_xlat0.w = float(-1.0);
    u_xlat3 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat0.xyyx);
    u_xlat4 = u_xlat0.yzyw + u_xlat3.xyxy;
    u_xlat5 = u_xlat0.zywy + u_xlat3.zwzw;
    u_xlat21 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat16.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat16.x = sin(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat21 = fract(u_xlat21);
    u_xlat2.x = u_xlat21 + u_xlat2.x;
    u_xlat4 = u_xlat1.zwzw + float4(-2.0, -1.0, -1.0, -1.0);
    u_xlat23 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat4.x = fract(u_xlat4.x);
    u_xlat23 = sin(u_xlat23);
    u_xlat16.y = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.zw = fract(u_xlat16.xy);
    u_xlat2.x = fma(u_xlat2.w, 2.0, u_xlat2.x);
    u_xlat2.w = fma(u_xlat4.x, 2.0, u_xlat2.w);
    u_xlat2.x = fma(u_xlat4.x, -12.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat2.z, 2.0, u_xlat2.x);
    u_xlat11.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.x = u_xlat2.x + u_xlat11.x;
    u_xlat2.x = fma(u_xlat11.y, 2.0, u_xlat2.x);
    u_xlat25 = dot(u_xlat1.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat11.z = fract(u_xlat25);
    u_xlat9 = fma(u_xlat21, 2.0, u_xlat2.y);
    u_xlat5 = u_xlat1.zwzw + float4(1.0, -2.0, 1.0, -1.0);
    u_xlat5.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat5.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat5.xy = sin(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat9 = u_xlat9 + u_xlat5.x;
    u_xlat21 = fma(u_xlat5.x, 2.0, u_xlat21);
    u_xlat9 = fma(u_xlat4.x, 2.0, u_xlat9);
    u_xlat4.x = fma(u_xlat2.z, 2.0, u_xlat4.x);
    u_xlat4.x = u_xlat5.y + u_xlat4.x;
    u_xlat4.x = fma(u_xlat11.y, 2.0, u_xlat4.x);
    u_xlat4.x = fma(u_xlat11.z, -12.0, u_xlat4.x);
    u_xlat9 = fma(u_xlat2.z, -12.0, u_xlat9);
    u_xlat2.y = fma(u_xlat5.y, 2.0, u_xlat9);
    u_xlat2.xy = u_xlat11.zy + u_xlat2.xy;
    u_xlat9 = fma(u_xlat11.z, 2.0, u_xlat2.y);
    u_xlat0.x = float(1.0);
    u_xlat0.z = float(2.0);
    u_xlat6 = u_xlat0.xyzy + u_xlat3.zwzw;
    u_xlat3 = u_xlat0.yxyz + u_xlat3.xyxy;
    u_xlat0.x = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.y = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat14.x = u_xlat0.x + u_xlat9;
    u_xlat14.x = u_xlat14.x * 0.0833333358;
    u_xlat14.x = fma(u_xlat2.x, 0.0416666679, u_xlat14.x);
    u_xlat6 = u_xlat1.zwzw + float4(2.0, -2.0, 2.0, -1.0);
    u_xlat2.x = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = fma(u_xlat2.z, 2.0, u_xlat21);
    u_xlat2.x = fma(u_xlat5.y, 2.0, u_xlat2.z);
    u_xlat21 = fma(u_xlat5.y, -12.0, u_xlat21);
    u_xlat21 = fma(u_xlat2.y, 2.0, u_xlat21);
    u_xlat2.xw = u_xlat2.yz + u_xlat2.xw;
    u_xlat2.x = fma(u_xlat11.z, 2.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat0.x, -12.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat0.y, 2.0, u_xlat2.x);
    u_xlat21 = u_xlat11.z + u_xlat21;
    u_xlat21 = fma(u_xlat0.x, 2.0, u_xlat21);
    u_xlat21 = u_xlat0.y + u_xlat21;
    u_xlat14.x = fma(u_xlat21, 0.0416666679, u_xlat14.x);
    u_xlat21 = fma(u_xlat11.x, 2.0, u_xlat2.w);
    u_xlat9 = fma(u_xlat11.y, 2.0, u_xlat11.x);
    u_xlat9 = u_xlat11.z + u_xlat9;
    u_xlat21 = fma(u_xlat11.y, -12.0, u_xlat21);
    u_xlat16.x = fma(u_xlat11.z, 2.0, u_xlat11.y);
    u_xlat16.x = u_xlat0.x + u_xlat16.x;
    u_xlat21 = fma(u_xlat11.z, 2.0, u_xlat21);
    u_xlat23 = fma(u_xlat0.x, 2.0, u_xlat11.z);
    u_xlat0.x = fma(u_xlat0.x, 2.0, u_xlat4.x);
    u_xlat7.x = u_xlat0.y + u_xlat23;
    u_xlat4 = u_xlat1.zwzw + float4(-2.0, 1.0, -1.0, 1.0);
    u_xlat23 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat4.x = fract(u_xlat4.x);
    u_xlat23 = sin(u_xlat23);
    u_xlat23 = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = fract(u_xlat23);
    u_xlat21 = u_xlat21 + u_xlat23;
    u_xlat9 = fma(u_xlat23, 2.0, u_xlat9);
    u_xlat9 = fma(u_xlat4.x, -12.0, u_xlat9);
    u_xlat21 = fma(u_xlat4.x, 2.0, u_xlat21);
    u_xlat23 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = sin(u_xlat23);
    u_xlat23 = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = fract(u_xlat23);
    u_xlat21 = u_xlat21 + u_xlat23;
    u_xlat14.x = fma(u_xlat21, 0.0833333358, u_xlat14.x);
    u_xlat0.x = u_xlat0.x + u_xlat4.x;
    u_xlat21 = fma(u_xlat4.x, 2.0, u_xlat16.x);
    u_xlat21 = fma(u_xlat23, -12.0, u_xlat21);
    u_xlat0.x = fma(u_xlat23, 2.0, u_xlat0.x);
    u_xlat4 = u_xlat1.zwzw + float4(1.0, 1.0, 2.0, 1.0);
    u_xlat16.x = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10 = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10 = sin(u_xlat10);
    u_xlat3.y = u_xlat10 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat16.x = sin(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat0.x = u_xlat0.x + u_xlat16.x;
    u_xlat0.x = fma(u_xlat0.x, 0.166666672, u_xlat14.x);
    u_xlat14.x = u_xlat23 + u_xlat2.x;
    u_xlat14.x = fma(u_xlat16.x, 2.0, u_xlat14.x);
    u_xlat14.x = u_xlat3.y + u_xlat14.x;
    u_xlat0.x = fma(u_xlat14.x, 0.0833333358, u_xlat0.x);
    u_xlat14.x = fma(u_xlat23, 2.0, u_xlat9);
    u_xlat7.x = fma(u_xlat23, 2.0, u_xlat7.x);
    u_xlat7.x = fma(u_xlat16.x, -12.0, u_xlat7.x);
    u_xlat14.y = fma(u_xlat16.x, 2.0, u_xlat21);
    u_xlat7.x = fma(u_xlat3.y, 2.0, u_xlat7.x);
    u_xlat2 = u_xlat1.zwzw + float4(-2.0, 2.0, -1.0, 2.0);
    u_xlat1 = u_xlat1 + float4(1.0, 2.0, 2.0, 2.0);
    u_xlat2.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat14.xy = u_xlat14.xy + u_xlat2.xy;
    u_xlat7.y = fma(u_xlat2.y, 2.0, u_xlat14.x);
    u_xlat21 = fma(u_xlat3.x, 2.0, u_xlat14.y);
    u_xlat7.xy = u_xlat3.xx + u_xlat7.xy;
    u_xlat0.x = fma(u_xlat7.y, 0.0416666679, u_xlat0.x);
    u_xlat14.x = dot(u_xlat1.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = dot(u_xlat1.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat14.x = sin(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat21 = u_xlat14.x + u_xlat21;
    u_xlat7.x = fma(u_xlat14.x, 2.0, u_xlat7.x);
    u_xlat7.x = u_xlat1.x + u_xlat7.x;
    u_xlat0.x = fma(u_xlat21, 0.0833333358, u_xlat0.x);
    u_xlat0.x = fma(u_xlat7.x, 0.0416666679, u_xlat0.x);
    output.SV_Target0.xyz = u_xlat0.xxx * float3(0.0625, 0.0625, 0.0625);
    output.SV_Target0.w = 1.0;
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
    float _Phase;
    float3 _NoiseParameters;
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
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float2 u_xlat7;
    float u_xlat9;
    float u_xlat10;
    float3 u_xlat11;
    float2 u_xlat14;
    float2 u_xlat16;
    float u_xlat21;
    float u_xlat23;
    float u_xlat25;
    u_xlat0.y = fract(FGlobals._Phase);
    u_xlat1 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat0.yyyy);
    u_xlat2 = u_xlat1.zwzw + float4(-2.0, -2.0, -1.0, -2.0);
    u_xlat2.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.x = fma(u_xlat2.y, 2.0, u_xlat2.x);
    u_xlat0.x = float(0.0);
    u_xlat0.z = float(-2.0);
    u_xlat0.w = float(-1.0);
    u_xlat3 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat0.xyyx);
    u_xlat4 = u_xlat0.yzyw + u_xlat3.xyxy;
    u_xlat5 = u_xlat0.zywy + u_xlat3.zwzw;
    u_xlat21 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat16.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat16.x = sin(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat21 = fract(u_xlat21);
    u_xlat2.x = u_xlat21 + u_xlat2.x;
    u_xlat4 = u_xlat1.zwzw + float4(-2.0, -1.0, -1.0, -1.0);
    u_xlat23 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat4.x = fract(u_xlat4.x);
    u_xlat23 = sin(u_xlat23);
    u_xlat16.y = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.zw = fract(u_xlat16.xy);
    u_xlat2.x = fma(u_xlat2.w, 2.0, u_xlat2.x);
    u_xlat2.w = fma(u_xlat4.x, 2.0, u_xlat2.w);
    u_xlat2.x = fma(u_xlat4.x, -12.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat2.z, 2.0, u_xlat2.x);
    u_xlat11.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.x = u_xlat2.x + u_xlat11.x;
    u_xlat2.x = fma(u_xlat11.y, 2.0, u_xlat2.x);
    u_xlat25 = dot(u_xlat1.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat25 = sin(u_xlat25);
    u_xlat25 = u_xlat25 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat11.z = fract(u_xlat25);
    u_xlat9 = fma(u_xlat21, 2.0, u_xlat2.y);
    u_xlat5 = u_xlat1.zwzw + float4(1.0, -2.0, 1.0, -1.0);
    u_xlat5.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat5.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat5.xy = sin(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat9 = u_xlat9 + u_xlat5.x;
    u_xlat21 = fma(u_xlat5.x, 2.0, u_xlat21);
    u_xlat9 = fma(u_xlat4.x, 2.0, u_xlat9);
    u_xlat4.x = fma(u_xlat2.z, 2.0, u_xlat4.x);
    u_xlat4.x = u_xlat5.y + u_xlat4.x;
    u_xlat4.x = fma(u_xlat11.y, 2.0, u_xlat4.x);
    u_xlat4.x = fma(u_xlat11.z, -12.0, u_xlat4.x);
    u_xlat9 = fma(u_xlat2.z, -12.0, u_xlat9);
    u_xlat2.y = fma(u_xlat5.y, 2.0, u_xlat9);
    u_xlat2.xy = u_xlat11.zy + u_xlat2.xy;
    u_xlat9 = fma(u_xlat11.z, 2.0, u_xlat2.y);
    u_xlat0.x = float(1.0);
    u_xlat0.z = float(2.0);
    u_xlat6 = u_xlat0.xyzy + u_xlat3.zwzw;
    u_xlat3 = u_xlat0.yxyz + u_xlat3.xyxy;
    u_xlat0.x = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.y = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat14.x = u_xlat0.x + u_xlat9;
    u_xlat14.x = u_xlat14.x * 0.0833333358;
    u_xlat14.x = fma(u_xlat2.x, 0.0416666679, u_xlat14.x);
    u_xlat6 = u_xlat1.zwzw + float4(2.0, -2.0, 2.0, -1.0);
    u_xlat2.x = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = fma(u_xlat2.z, 2.0, u_xlat21);
    u_xlat2.x = fma(u_xlat5.y, 2.0, u_xlat2.z);
    u_xlat21 = fma(u_xlat5.y, -12.0, u_xlat21);
    u_xlat21 = fma(u_xlat2.y, 2.0, u_xlat21);
    u_xlat2.xw = u_xlat2.yz + u_xlat2.xw;
    u_xlat2.x = fma(u_xlat11.z, 2.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat0.x, -12.0, u_xlat2.x);
    u_xlat2.x = fma(u_xlat0.y, 2.0, u_xlat2.x);
    u_xlat21 = u_xlat11.z + u_xlat21;
    u_xlat21 = fma(u_xlat0.x, 2.0, u_xlat21);
    u_xlat21 = u_xlat0.y + u_xlat21;
    u_xlat14.x = fma(u_xlat21, 0.0416666679, u_xlat14.x);
    u_xlat21 = fma(u_xlat11.x, 2.0, u_xlat2.w);
    u_xlat9 = fma(u_xlat11.y, 2.0, u_xlat11.x);
    u_xlat9 = u_xlat11.z + u_xlat9;
    u_xlat21 = fma(u_xlat11.y, -12.0, u_xlat21);
    u_xlat16.x = fma(u_xlat11.z, 2.0, u_xlat11.y);
    u_xlat16.x = u_xlat0.x + u_xlat16.x;
    u_xlat21 = fma(u_xlat11.z, 2.0, u_xlat21);
    u_xlat23 = fma(u_xlat0.x, 2.0, u_xlat11.z);
    u_xlat0.x = fma(u_xlat0.x, 2.0, u_xlat4.x);
    u_xlat7.x = u_xlat0.y + u_xlat23;
    u_xlat4 = u_xlat1.zwzw + float4(-2.0, 1.0, -1.0, 1.0);
    u_xlat23 = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat4.x = fract(u_xlat4.x);
    u_xlat23 = sin(u_xlat23);
    u_xlat23 = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = fract(u_xlat23);
    u_xlat21 = u_xlat21 + u_xlat23;
    u_xlat9 = fma(u_xlat23, 2.0, u_xlat9);
    u_xlat9 = fma(u_xlat4.x, -12.0, u_xlat9);
    u_xlat21 = fma(u_xlat4.x, 2.0, u_xlat21);
    u_xlat23 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = sin(u_xlat23);
    u_xlat23 = u_xlat23 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23 = fract(u_xlat23);
    u_xlat21 = u_xlat21 + u_xlat23;
    u_xlat14.x = fma(u_xlat21, 0.0833333358, u_xlat14.x);
    u_xlat0.x = u_xlat0.x + u_xlat4.x;
    u_xlat21 = fma(u_xlat4.x, 2.0, u_xlat16.x);
    u_xlat21 = fma(u_xlat23, -12.0, u_xlat21);
    u_xlat0.x = fma(u_xlat23, 2.0, u_xlat0.x);
    u_xlat4 = u_xlat1.zwzw + float4(1.0, 1.0, 2.0, 1.0);
    u_xlat16.x = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10 = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10 = sin(u_xlat10);
    u_xlat3.y = u_xlat10 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat16.x = sin(u_xlat16.x);
    u_xlat16.x = u_xlat16.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat16.x = fract(u_xlat16.x);
    u_xlat0.x = u_xlat0.x + u_xlat16.x;
    u_xlat0.x = fma(u_xlat0.x, 0.166666672, u_xlat14.x);
    u_xlat14.x = u_xlat23 + u_xlat2.x;
    u_xlat14.x = fma(u_xlat16.x, 2.0, u_xlat14.x);
    u_xlat14.x = u_xlat3.y + u_xlat14.x;
    u_xlat0.x = fma(u_xlat14.x, 0.0833333358, u_xlat0.x);
    u_xlat14.x = fma(u_xlat23, 2.0, u_xlat9);
    u_xlat7.x = fma(u_xlat23, 2.0, u_xlat7.x);
    u_xlat7.x = fma(u_xlat16.x, -12.0, u_xlat7.x);
    u_xlat14.y = fma(u_xlat16.x, 2.0, u_xlat21);
    u_xlat7.x = fma(u_xlat3.y, 2.0, u_xlat7.x);
    u_xlat2 = u_xlat1.zwzw + float4(-2.0, 2.0, -1.0, 2.0);
    u_xlat1 = u_xlat1 + float4(1.0, 2.0, 2.0, 2.0);
    u_xlat2.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat14.xy = u_xlat14.xy + u_xlat2.xy;
    u_xlat7.y = fma(u_xlat2.y, 2.0, u_xlat14.x);
    u_xlat21 = fma(u_xlat3.x, 2.0, u_xlat14.y);
    u_xlat7.xy = u_xlat3.xx + u_xlat7.xy;
    u_xlat0.x = fma(u_xlat7.y, 0.0416666679, u_xlat0.x);
    u_xlat14.x = dot(u_xlat1.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = dot(u_xlat1.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat14.x = sin(u_xlat14.x);
    u_xlat14.x = u_xlat14.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat14.x = fract(u_xlat14.x);
    u_xlat21 = u_xlat14.x + u_xlat21;
    u_xlat7.x = fma(u_xlat14.x, 2.0, u_xlat7.x);
    u_xlat7.x = u_xlat1.x + u_xlat7.x;
    u_xlat0.x = fma(u_xlat21, 0.0833333358, u_xlat0.x);
    u_xlat0.x = fma(u_xlat7.x, 0.0416666679, u_xlat0.x);
    output.SV_Target0.xyz = u_xlat0.xxx * float3(0.0625, 0.0625, 0.0625);
    output.SV_Target0.w = 1.0;
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
  GpuProgramID 117371
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
    float _Phase;
    float3 _NoiseParameters;
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
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float4 u_xlat12;
    float4 u_xlat13;
    float4 u_xlat14;
    float4 u_xlat15;
    float4 u_xlat16;
    float3 u_xlat17;
    float3 u_xlat18;
    float u_xlat19;
    float3 u_xlat20;
    float3 u_xlat23;
    float u_xlat32;
    float2 u_xlat34;
    float2 u_xlat35;
    float u_xlat37;
    float2 u_xlat40;
    float2 u_xlat42;
    float u_xlat51;
    float u_xlat52;
    float u_xlat54;
    float u_xlat57;
    float u_xlat59;
    u_xlat0 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, -2.0, -1.0, -1.0));
    u_xlat1.x = fract(FGlobals._Phase);
    u_xlat2 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat0);
    u_xlat18.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-1.0, -2.0, 0.0, -2.0));
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat2);
    u_xlat52 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat18.z = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.xyz = fract(u_xlat18.xyz);
    u_xlat18.x = fma(u_xlat18.z, 2.0, u_xlat18.x);
    u_xlat18.z = fma(u_xlat3.x, 2.0, u_xlat18.z);
    u_xlat18.x = u_xlat3.x + u_xlat18.x;
    u_xlat4 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, -1.0, 0.0, -1.0));
    u_xlat5 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat4);
    u_xlat20.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat18.x = fma(u_xlat20.x, 2.0, u_xlat18.x);
    u_xlat20.x = fma(u_xlat18.y, 2.0, u_xlat20.x);
    u_xlat20.x = u_xlat20.y + u_xlat20.x;
    u_xlat18.x = fma(u_xlat18.y, -12.0, u_xlat18.x);
    u_xlat18.x = fma(u_xlat20.y, 2.0, u_xlat18.x);
    u_xlat5 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, 0.0, -1.0, 0.0));
    u_xlat6 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat5);
    u_xlat54 = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat6.x = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat6.x = fract(u_xlat6.x);
    u_xlat54 = sin(u_xlat54);
    u_xlat54 = u_xlat54 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat54 = fract(u_xlat54);
    u_xlat18.x = u_xlat18.x + u_xlat54;
    u_xlat18.x = fma(u_xlat6.x, 2.0, u_xlat18.x);
    u_xlat23.xyz = u_xlat1.xxx * float3(0.0700000003, 0.109999999, 0.129999995);
    u_xlat7.xy = fma(input.TEXCOORD1.xy, float2(128.0, 128.0), u_xlat23.zz);
    u_xlat8 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat23.xxyy);
    u_xlat23.x = dot(u_xlat7.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat23.x = sin(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.x = fract(u_xlat23.x);
    u_xlat7 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, -2.0, 1.0, -1.0));
    u_xlat9 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat7);
    u_xlat40.x = dot(u_xlat9.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat40.y = dot(u_xlat9.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat40.xy = sin(u_xlat40.xy);
    u_xlat40.xy = u_xlat40.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat23.yz = fract(u_xlat40.xy);
    u_xlat18.xz = u_xlat18.xz + u_xlat23.xy;
    u_xlat3.x = fma(u_xlat23.y, 2.0, u_xlat3.x);
    u_xlat52 = fma(u_xlat18.y, 2.0, u_xlat18.z);
    u_xlat35.x = fma(u_xlat20.y, 2.0, u_xlat18.y);
    u_xlat35.x = u_xlat23.z + u_xlat35.x;
    u_xlat35.x = fma(u_xlat6.x, 2.0, u_xlat35.x);
    u_xlat35.x = fma(u_xlat23.x, -12.0, u_xlat35.x);
    u_xlat52 = fma(u_xlat20.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.z, 2.0, u_xlat52);
    u_xlat52 = u_xlat6.x + u_xlat52;
    u_xlat52 = fma(u_xlat23.x, 2.0, u_xlat52);
    u_xlat9 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, 0.0, 2.0, -2.0));
    u_xlat10 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat9);
    u_xlat40.x = dot(u_xlat10.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10.x = dot(u_xlat10.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10.x = sin(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat3.x = u_xlat3.x + u_xlat10.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat37 = fma(u_xlat23.z, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat23.z, -12.0, u_xlat3.x);
    u_xlat40.x = sin(u_xlat40.x);
    u_xlat40.x = u_xlat40.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.y = fract(u_xlat40.x);
    u_xlat52 = u_xlat52 + u_xlat23.y;
    u_xlat52 = u_xlat52 * 0.0833333358;
    u_xlat18.x = fma(u_xlat18.x, 0.0416666679, u_xlat52);
    u_xlat10 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(2.0, -1.0, 2.0, 0.0));
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat10);
    u_xlat52 = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat57 = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat57 = sin(u_xlat57);
    u_xlat57 = u_xlat57 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.z = fract(u_xlat57);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat3.x = fma(u_xlat52, 2.0, u_xlat3.x);
    u_xlat52 = u_xlat52 + u_xlat37;
    u_xlat52 = fma(u_xlat23.x, 2.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.z, 2.0, u_xlat52);
    u_xlat3.x = u_xlat23.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat23.y, 2.0, u_xlat3.x);
    u_xlat3.x = u_xlat23.z + u_xlat3.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0416666679, u_xlat18.x);
    u_xlat3.x = fma(u_xlat54, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat6.x, 2.0, u_xlat54);
    u_xlat3.x = fma(u_xlat6.x, -12.0, u_xlat3.x);
    u_xlat20.y = fma(u_xlat23.x, 2.0, u_xlat6.x);
    u_xlat3.x = fma(u_xlat23.x, 2.0, u_xlat3.x);
    u_xlat20.z = fma(u_xlat23.y, 2.0, u_xlat23.x);
    u_xlat35.x = fma(u_xlat23.y, 2.0, u_xlat35.x);
    u_xlat20.xyz = u_xlat23.xyz + u_xlat20.xyz;
    u_xlat6 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, 1.0, -1.0, 1.0));
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat6);
    u_xlat11.x = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.y = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat3.x = u_xlat3.x + u_xlat11.x;
    u_xlat20.x = fma(u_xlat11.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat11.y, -12.0, u_xlat20.x);
    u_xlat3.x = fma(u_xlat11.y, 2.0, u_xlat3.x);
    u_xlat12 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(0.0, 1.0, 1.0, 1.0));
    u_xlat13 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat12);
    u_xlat11.x = dot(u_xlat13.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.z = dot(u_xlat13.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xz = sin(u_xlat11.xz);
    u_xlat11.xz = u_xlat11.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xz = fract(u_xlat11.xz);
    u_xlat3.x = u_xlat3.x + u_xlat11.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = u_xlat35.x + u_xlat11.y;
    u_xlat3.x = fma(u_xlat11.y, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat11.x, -12.0, u_xlat3.x);
    u_xlat3.x = fma(u_xlat11.z, 2.0, u_xlat3.x);
    u_xlat35.x = fma(u_xlat11.x, 2.0, u_xlat35.x);
    u_xlat35.x = u_xlat11.z + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.166666672, u_xlat18.x);
    u_xlat35.x = u_xlat52 + u_xlat11.x;
    u_xlat35.x = fma(u_xlat11.z, 2.0, u_xlat35.x);
    u_xlat13 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(2.0, 1.0, -2.0, 2.0));
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat13);
    u_xlat52 = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat35.x = u_xlat52 + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = fma(u_xlat11.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat11.x, 2.0, u_xlat20.z);
    u_xlat20.x = fma(u_xlat11.z, -12.0, u_xlat20.x);
    u_xlat35.y = fma(u_xlat52, 2.0, u_xlat20.x);
    u_xlat35.x = u_xlat37 + u_xlat35.x;
    u_xlat11 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-1.0, 2.0, 0.0, 2.0));
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat11);
    u_xlat20.x = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat35.x = fma(u_xlat20.x, 2.0, u_xlat35.x);
    u_xlat3.x = u_xlat20.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat35.xy = u_xlat35.xy + u_xlat20.yy;
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    u_xlat14 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, 2.0, 2.0, 2.0));
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat14);
    u_xlat35.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.x = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.x = sin(u_xlat20.x);
    u_xlat20.x = u_xlat20.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat20.x = fract(u_xlat20.x);
    u_xlat35.x = sin(u_xlat35.x);
    u_xlat35.x = u_xlat35.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat35.x = fract(u_xlat35.x);
    u_xlat3.x = u_xlat35.x + u_xlat3.x;
    u_xlat35.x = fma(u_xlat35.x, 2.0, u_xlat35.y);
    u_xlat35.x = u_xlat20.x + u_xlat35.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    output.SV_Target0.z = u_xlat18.x * 0.0625;
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat0);
    u_xlat0 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat0);
    u_xlat18.x = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.y = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat2);
    u_xlat2 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat2);
    u_xlat52 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat18.z = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.xyz = fract(u_xlat18.xyz);
    u_xlat18.x = fma(u_xlat18.z, 2.0, u_xlat18.x);
    u_xlat18.z = fma(u_xlat3.x, 2.0, u_xlat18.z);
    u_xlat18.x = u_xlat3.x + u_xlat18.x;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat4);
    u_xlat4 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat4);
    u_xlat20.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat18.x = fma(u_xlat20.x, 2.0, u_xlat18.x);
    u_xlat20.x = fma(u_xlat18.y, 2.0, u_xlat20.x);
    u_xlat20.x = u_xlat20.y + u_xlat20.x;
    u_xlat18.x = fma(u_xlat18.y, -12.0, u_xlat18.x);
    u_xlat18.x = fma(u_xlat20.y, 2.0, u_xlat18.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat5);
    u_xlat5 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat5);
    u_xlat54 = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat15.x = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat15.x = sin(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat15.x = fract(u_xlat15.x);
    u_xlat54 = sin(u_xlat54);
    u_xlat54 = u_xlat54 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat54 = fract(u_xlat54);
    u_xlat18.x = u_xlat18.x + u_xlat54;
    u_xlat18.x = fma(u_xlat15.x, 2.0, u_xlat18.x);
    u_xlat8.x = dot(u_xlat8.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.y = dot(u_xlat8.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xy = sin(u_xlat8.xy);
    u_xlat8.xy = u_xlat8.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xy = fract(u_xlat8.xy);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat7);
    u_xlat7 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat7);
    u_xlat42.x = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat42.y = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat42.xy = sin(u_xlat42.xy);
    u_xlat42.xy = u_xlat42.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.zw = fract(u_xlat42.xy);
    u_xlat18.xz = u_xlat18.xz + u_xlat8.xz;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat52 = fma(u_xlat18.y, 2.0, u_xlat18.z);
    u_xlat35.x = fma(u_xlat20.y, 2.0, u_xlat18.y);
    u_xlat35.x = u_xlat8.w + u_xlat35.x;
    u_xlat35.x = fma(u_xlat15.x, 2.0, u_xlat35.x);
    u_xlat35.x = fma(u_xlat8.x, -12.0, u_xlat35.x);
    u_xlat52 = fma(u_xlat20.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.w, 2.0, u_xlat52);
    u_xlat52 = u_xlat15.x + u_xlat52;
    u_xlat52 = fma(u_xlat8.x, 2.0, u_xlat52);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat9);
    u_xlat9 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat9);
    u_xlat42.x = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat32 = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat32 = sin(u_xlat32);
    u_xlat32 = u_xlat32 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat32 = fract(u_xlat32);
    u_xlat3.x = u_xlat3.x + u_xlat32;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat37 = fma(u_xlat8.w, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat8.w, -12.0, u_xlat3.x);
    u_xlat42.x = sin(u_xlat42.x);
    u_xlat42.x = u_xlat42.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat8.z = fract(u_xlat42.x);
    u_xlat52 = u_xlat52 + u_xlat8.z;
    u_xlat52 = u_xlat52 * 0.0833333358;
    u_xlat18.x = fma(u_xlat18.x, 0.0416666679, u_xlat52);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat10);
    u_xlat10 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat10);
    u_xlat52 = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat59 = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat59 = sin(u_xlat59);
    u_xlat59 = u_xlat59 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat8.w = fract(u_xlat59);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat3.x = fma(u_xlat52, 2.0, u_xlat3.x);
    u_xlat52 = u_xlat52 + u_xlat37;
    u_xlat52 = fma(u_xlat8.x, 2.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.z, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.w, 2.0, u_xlat52);
    u_xlat3.x = u_xlat8.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat3.x = u_xlat8.w + u_xlat3.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0416666679, u_xlat18.x);
    u_xlat3.x = fma(u_xlat54, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat15.x, 2.0, u_xlat54);
    u_xlat3.x = fma(u_xlat15.x, -12.0, u_xlat3.x);
    u_xlat20.y = fma(u_xlat8.x, 2.0, u_xlat15.x);
    u_xlat3.x = fma(u_xlat8.x, 2.0, u_xlat3.x);
    u_xlat20.z = fma(u_xlat8.z, 2.0, u_xlat8.x);
    u_xlat35.x = fma(u_xlat8.z, 2.0, u_xlat35.x);
    u_xlat20.xyz = u_xlat8.xzw + u_xlat20.xyz;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat6);
    u_xlat6 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat6);
    u_xlat8.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.z = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xz = sin(u_xlat8.xz);
    u_xlat8.xz = u_xlat8.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xz = fract(u_xlat8.xz);
    u_xlat3.x = u_xlat3.x + u_xlat8.x;
    u_xlat20.x = fma(u_xlat8.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat8.z, -12.0, u_xlat20.x);
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat12);
    u_xlat12 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat12);
    u_xlat8.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.w = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xw = sin(u_xlat8.xw);
    u_xlat8.xw = u_xlat8.xw * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xw = fract(u_xlat8.xw);
    u_xlat3.x = u_xlat3.x + u_xlat8.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = u_xlat35.x + u_xlat8.z;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat8.x, -12.0, u_xlat3.x);
    u_xlat3.x = fma(u_xlat8.w, 2.0, u_xlat3.x);
    u_xlat35.x = fma(u_xlat8.x, 2.0, u_xlat35.x);
    u_xlat35.x = u_xlat8.w + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.166666672, u_xlat18.x);
    u_xlat35.x = u_xlat52 + u_xlat8.x;
    u_xlat35.x = fma(u_xlat8.w, 2.0, u_xlat35.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat13);
    u_xlat13 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat13);
    u_xlat52 = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat35.x = u_xlat52 + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = fma(u_xlat8.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat8.x, 2.0, u_xlat20.z);
    u_xlat20.x = fma(u_xlat8.w, -12.0, u_xlat20.x);
    u_xlat35.y = fma(u_xlat52, 2.0, u_xlat20.x);
    u_xlat35.x = u_xlat37 + u_xlat35.x;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat11);
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat11);
    u_xlat20.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat35.x = fma(u_xlat20.x, 2.0, u_xlat35.x);
    u_xlat3.x = u_xlat20.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat35.xy = u_xlat35.xy + u_xlat20.yy;
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat14);
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat14);
    u_xlat1.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.z = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xz = sin(u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xz = fract(u_xlat1.xz);
    u_xlat3.x = u_xlat1.x + u_xlat3.x;
    u_xlat1.x = fma(u_xlat1.x, 2.0, u_xlat35.y);
    u_xlat1.x = u_xlat1.z + u_xlat1.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat1.x = fma(u_xlat1.x, 0.0416666679, u_xlat18.x);
    output.SV_Target0.x = u_xlat1.x * 0.0625;
    u_xlat0.x = dot(u_xlat0.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.y = dot(u_xlat0.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat34.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat34.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat34.xy = sin(u_xlat34.xy);
    u_xlat0.zw = u_xlat34.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat0 = fract(u_xlat0);
    u_xlat0.x = fma(u_xlat0.z, 2.0, u_xlat0.x);
    u_xlat34.x = fma(u_xlat0.w, 2.0, u_xlat0.z);
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat1.x = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.y = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat0.x = fma(u_xlat1.x, 2.0, u_xlat0.x);
    u_xlat1.x = fma(u_xlat0.y, 2.0, u_xlat1.x);
    u_xlat1.x = u_xlat1.y + u_xlat1.x;
    u_xlat0.x = fma(u_xlat0.y, -12.0, u_xlat0.x);
    u_xlat0.x = fma(u_xlat1.y, 2.0, u_xlat0.x);
    u_xlat35.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat35.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat35.xy = sin(u_xlat35.xy);
    u_xlat35.xy = u_xlat35.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat35.xy = fract(u_xlat35.xy);
    u_xlat0.x = u_xlat0.x + u_xlat35.x;
    u_xlat0.x = fma(u_xlat35.y, 2.0, u_xlat0.x);
    u_xlat0.x = u_xlat8.y + u_xlat0.x;
    u_xlat2.x = dot(u_xlat7.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat7.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat34.x = u_xlat34.x + u_xlat2.x;
    u_xlat34.y = fma(u_xlat2.x, 2.0, u_xlat0.w);
    u_xlat34.x = fma(u_xlat0.y, 2.0, u_xlat34.x);
    u_xlat17.x = fma(u_xlat1.y, 2.0, u_xlat0.y);
    u_xlat17.x = u_xlat2.y + u_xlat17.x;
    u_xlat17.x = fma(u_xlat35.y, 2.0, u_xlat17.x);
    u_xlat17.x = fma(u_xlat8.y, -12.0, u_xlat17.x);
    u_xlat34.x = fma(u_xlat1.y, -12.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.y, 2.0, u_xlat34.x);
    u_xlat34.x = u_xlat35.y + u_xlat34.x;
    u_xlat34.x = fma(u_xlat8.y, 2.0, u_xlat34.x);
    u_xlat2.x = dot(u_xlat9.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.z = dot(u_xlat9.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xz = sin(u_xlat2.xz);
    u_xlat2.xz = u_xlat2.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xz = fract(u_xlat2.xz);
    u_xlat34.xy = u_xlat34.xy + u_xlat2.xz;
    u_xlat51 = fma(u_xlat1.y, 2.0, u_xlat34.y);
    u_xlat18.x = fma(u_xlat2.y, 2.0, u_xlat1.y);
    u_xlat51 = fma(u_xlat2.y, -12.0, u_xlat51);
    u_xlat34.x = u_xlat34.x * 0.0833333358;
    u_xlat0.x = fma(u_xlat0.x, 0.0416666679, u_xlat34.x);
    u_xlat34.x = dot(u_xlat10.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = dot(u_xlat10.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.y = fract(u_xlat19);
    u_xlat34.x = sin(u_xlat34.x);
    u_xlat34.x = u_xlat34.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat34.x = fract(u_xlat34.x);
    u_xlat51 = fma(u_xlat34.x, 2.0, u_xlat51);
    u_xlat34.x = u_xlat34.x + u_xlat18.x;
    u_xlat34.x = fma(u_xlat8.y, 2.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.x, -12.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.y, 2.0, u_xlat34.x);
    u_xlat51 = u_xlat8.y + u_xlat51;
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat51);
    u_xlat51 = u_xlat2.y + u_xlat51;
    u_xlat0.x = fma(u_xlat51, 0.0416666679, u_xlat0.x);
    u_xlat51 = fma(u_xlat35.x, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat35.y, 2.0, u_xlat35.x);
    u_xlat1.x = u_xlat8.y + u_xlat1.x;
    u_xlat51 = fma(u_xlat35.y, -12.0, u_xlat51);
    u_xlat18.x = fma(u_xlat8.y, 2.0, u_xlat35.y);
    u_xlat51 = fma(u_xlat8.y, 2.0, u_xlat51);
    u_xlat18.y = fma(u_xlat2.x, 2.0, u_xlat8.y);
    u_xlat17.x = fma(u_xlat2.x, 2.0, u_xlat17.x);
    u_xlat18.xy = u_xlat2.xy + u_xlat18.xy;
    u_xlat52 = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.x = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat51 = u_xlat51 + u_xlat52;
    u_xlat1.x = fma(u_xlat52, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat2.x, -12.0, u_xlat1.x);
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat51);
    u_xlat52 = dot(u_xlat12.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = dot(u_xlat12.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat19 = fract(u_xlat19);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat51 = u_xlat51 + u_xlat52;
    u_xlat0.x = fma(u_xlat51, 0.0833333358, u_xlat0.x);
    u_xlat17.x = u_xlat17.x + u_xlat2.x;
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat18.x);
    u_xlat51 = fma(u_xlat52, -12.0, u_xlat51);
    u_xlat17.z = fma(u_xlat19, 2.0, u_xlat51);
    u_xlat17.x = fma(u_xlat52, 2.0, u_xlat17.x);
    u_xlat17.x = u_xlat19 + u_xlat17.x;
    u_xlat0.x = fma(u_xlat17.x, 0.166666672, u_xlat0.x);
    u_xlat17.x = u_xlat34.x + u_xlat52;
    u_xlat17.x = fma(u_xlat19, 2.0, u_xlat17.x);
    u_xlat34.x = dot(u_xlat13.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.x = dot(u_xlat13.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.x = sin(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat34.x = sin(u_xlat34.x);
    u_xlat34.x = u_xlat34.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat34.x = fract(u_xlat34.x);
    u_xlat17.x = u_xlat34.x + u_xlat17.x;
    u_xlat0.x = fma(u_xlat17.x, 0.0833333358, u_xlat0.x);
    u_xlat17.x = fma(u_xlat52, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat52, 2.0, u_xlat18.y);
    u_xlat1.x = fma(u_xlat19, -12.0, u_xlat1.x);
    u_xlat17.y = fma(u_xlat34.x, 2.0, u_xlat1.x);
    u_xlat17.x = u_xlat18.x + u_xlat17.x;
    u_xlat1.x = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.y = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat17.x = fma(u_xlat1.x, 2.0, u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xyz + u_xlat1.yyx;
    u_xlat51 = fma(u_xlat1.y, 2.0, u_xlat17.z);
    u_xlat0.x = fma(u_xlat17.x, 0.0416666679, u_xlat0.x);
    u_xlat17.x = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat17.x = sin(u_xlat17.x);
    u_xlat17.x = u_xlat17.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat17.x = fract(u_xlat17.x);
    u_xlat51 = u_xlat17.x + u_xlat51;
    u_xlat17.x = fma(u_xlat17.x, 2.0, u_xlat17.y);
    u_xlat17.x = u_xlat1.x + u_xlat17.x;
    u_xlat0.x = fma(u_xlat51, 0.0833333358, u_xlat0.x);
    u_xlat0.x = fma(u_xlat17.x, 0.0416666679, u_xlat0.x);
    output.SV_Target0.y = u_xlat0.x * 0.0625;
    output.SV_Target0.w = 1.0;
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
    float _Phase;
    float3 _NoiseParameters;
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
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float4 u_xlat12;
    float4 u_xlat13;
    float4 u_xlat14;
    float4 u_xlat15;
    float4 u_xlat16;
    float3 u_xlat17;
    float3 u_xlat18;
    float u_xlat19;
    float3 u_xlat20;
    float3 u_xlat23;
    float u_xlat32;
    float2 u_xlat34;
    float2 u_xlat35;
    float u_xlat37;
    float2 u_xlat40;
    float2 u_xlat42;
    float u_xlat51;
    float u_xlat52;
    float u_xlat54;
    float u_xlat57;
    float u_xlat59;
    u_xlat0 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, -2.0, -1.0, -1.0));
    u_xlat1.x = fract(FGlobals._Phase);
    u_xlat2 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat0);
    u_xlat18.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-1.0, -2.0, 0.0, -2.0));
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat2);
    u_xlat52 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat18.z = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.xyz = fract(u_xlat18.xyz);
    u_xlat18.x = fma(u_xlat18.z, 2.0, u_xlat18.x);
    u_xlat18.z = fma(u_xlat3.x, 2.0, u_xlat18.z);
    u_xlat18.x = u_xlat3.x + u_xlat18.x;
    u_xlat4 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, -1.0, 0.0, -1.0));
    u_xlat5 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat4);
    u_xlat20.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat18.x = fma(u_xlat20.x, 2.0, u_xlat18.x);
    u_xlat20.x = fma(u_xlat18.y, 2.0, u_xlat20.x);
    u_xlat20.x = u_xlat20.y + u_xlat20.x;
    u_xlat18.x = fma(u_xlat18.y, -12.0, u_xlat18.x);
    u_xlat18.x = fma(u_xlat20.y, 2.0, u_xlat18.x);
    u_xlat5 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, 0.0, -1.0, 0.0));
    u_xlat6 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat5);
    u_xlat54 = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat6.x = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat6.x = fract(u_xlat6.x);
    u_xlat54 = sin(u_xlat54);
    u_xlat54 = u_xlat54 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat54 = fract(u_xlat54);
    u_xlat18.x = u_xlat18.x + u_xlat54;
    u_xlat18.x = fma(u_xlat6.x, 2.0, u_xlat18.x);
    u_xlat23.xyz = u_xlat1.xxx * float3(0.0700000003, 0.109999999, 0.129999995);
    u_xlat7.xy = fma(input.TEXCOORD1.xy, float2(128.0, 128.0), u_xlat23.zz);
    u_xlat8 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat23.xxyy);
    u_xlat23.x = dot(u_xlat7.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat23.x = sin(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.x = fract(u_xlat23.x);
    u_xlat7 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, -2.0, 1.0, -1.0));
    u_xlat9 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat7);
    u_xlat40.x = dot(u_xlat9.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat40.y = dot(u_xlat9.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat40.xy = sin(u_xlat40.xy);
    u_xlat40.xy = u_xlat40.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat23.yz = fract(u_xlat40.xy);
    u_xlat18.xz = u_xlat18.xz + u_xlat23.xy;
    u_xlat3.x = fma(u_xlat23.y, 2.0, u_xlat3.x);
    u_xlat52 = fma(u_xlat18.y, 2.0, u_xlat18.z);
    u_xlat35.x = fma(u_xlat20.y, 2.0, u_xlat18.y);
    u_xlat35.x = u_xlat23.z + u_xlat35.x;
    u_xlat35.x = fma(u_xlat6.x, 2.0, u_xlat35.x);
    u_xlat35.x = fma(u_xlat23.x, -12.0, u_xlat35.x);
    u_xlat52 = fma(u_xlat20.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.z, 2.0, u_xlat52);
    u_xlat52 = u_xlat6.x + u_xlat52;
    u_xlat52 = fma(u_xlat23.x, 2.0, u_xlat52);
    u_xlat9 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, 0.0, 2.0, -2.0));
    u_xlat10 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat9);
    u_xlat40.x = dot(u_xlat10.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10.x = dot(u_xlat10.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10.x = sin(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat3.x = u_xlat3.x + u_xlat10.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat37 = fma(u_xlat23.z, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat23.z, -12.0, u_xlat3.x);
    u_xlat40.x = sin(u_xlat40.x);
    u_xlat40.x = u_xlat40.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.y = fract(u_xlat40.x);
    u_xlat52 = u_xlat52 + u_xlat23.y;
    u_xlat52 = u_xlat52 * 0.0833333358;
    u_xlat18.x = fma(u_xlat18.x, 0.0416666679, u_xlat52);
    u_xlat10 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(2.0, -1.0, 2.0, 0.0));
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat10);
    u_xlat52 = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat57 = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat57 = sin(u_xlat57);
    u_xlat57 = u_xlat57 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.z = fract(u_xlat57);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat3.x = fma(u_xlat52, 2.0, u_xlat3.x);
    u_xlat52 = u_xlat52 + u_xlat37;
    u_xlat52 = fma(u_xlat23.x, 2.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.z, 2.0, u_xlat52);
    u_xlat3.x = u_xlat23.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat23.y, 2.0, u_xlat3.x);
    u_xlat3.x = u_xlat23.z + u_xlat3.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0416666679, u_xlat18.x);
    u_xlat3.x = fma(u_xlat54, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat6.x, 2.0, u_xlat54);
    u_xlat3.x = fma(u_xlat6.x, -12.0, u_xlat3.x);
    u_xlat20.y = fma(u_xlat23.x, 2.0, u_xlat6.x);
    u_xlat3.x = fma(u_xlat23.x, 2.0, u_xlat3.x);
    u_xlat20.z = fma(u_xlat23.y, 2.0, u_xlat23.x);
    u_xlat35.x = fma(u_xlat23.y, 2.0, u_xlat35.x);
    u_xlat20.xyz = u_xlat23.xyz + u_xlat20.xyz;
    u_xlat6 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, 1.0, -1.0, 1.0));
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat6);
    u_xlat11.x = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.y = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat3.x = u_xlat3.x + u_xlat11.x;
    u_xlat20.x = fma(u_xlat11.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat11.y, -12.0, u_xlat20.x);
    u_xlat3.x = fma(u_xlat11.y, 2.0, u_xlat3.x);
    u_xlat12 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(0.0, 1.0, 1.0, 1.0));
    u_xlat13 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat12);
    u_xlat11.x = dot(u_xlat13.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.z = dot(u_xlat13.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xz = sin(u_xlat11.xz);
    u_xlat11.xz = u_xlat11.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xz = fract(u_xlat11.xz);
    u_xlat3.x = u_xlat3.x + u_xlat11.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = u_xlat35.x + u_xlat11.y;
    u_xlat3.x = fma(u_xlat11.y, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat11.x, -12.0, u_xlat3.x);
    u_xlat3.x = fma(u_xlat11.z, 2.0, u_xlat3.x);
    u_xlat35.x = fma(u_xlat11.x, 2.0, u_xlat35.x);
    u_xlat35.x = u_xlat11.z + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.166666672, u_xlat18.x);
    u_xlat35.x = u_xlat52 + u_xlat11.x;
    u_xlat35.x = fma(u_xlat11.z, 2.0, u_xlat35.x);
    u_xlat13 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(2.0, 1.0, -2.0, 2.0));
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat13);
    u_xlat52 = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat35.x = u_xlat52 + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = fma(u_xlat11.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat11.x, 2.0, u_xlat20.z);
    u_xlat20.x = fma(u_xlat11.z, -12.0, u_xlat20.x);
    u_xlat35.y = fma(u_xlat52, 2.0, u_xlat20.x);
    u_xlat35.x = u_xlat37 + u_xlat35.x;
    u_xlat11 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-1.0, 2.0, 0.0, 2.0));
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat11);
    u_xlat20.x = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat35.x = fma(u_xlat20.x, 2.0, u_xlat35.x);
    u_xlat3.x = u_xlat20.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat35.xy = u_xlat35.xy + u_xlat20.yy;
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    u_xlat14 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, 2.0, 2.0, 2.0));
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat14);
    u_xlat35.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.x = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.x = sin(u_xlat20.x);
    u_xlat20.x = u_xlat20.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat20.x = fract(u_xlat20.x);
    u_xlat35.x = sin(u_xlat35.x);
    u_xlat35.x = u_xlat35.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat35.x = fract(u_xlat35.x);
    u_xlat3.x = u_xlat35.x + u_xlat3.x;
    u_xlat35.x = fma(u_xlat35.x, 2.0, u_xlat35.y);
    u_xlat35.x = u_xlat20.x + u_xlat35.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    output.SV_Target0.z = u_xlat18.x * 0.0625;
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat0);
    u_xlat0 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat0);
    u_xlat18.x = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.y = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat2);
    u_xlat2 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat2);
    u_xlat52 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat18.z = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.xyz = fract(u_xlat18.xyz);
    u_xlat18.x = fma(u_xlat18.z, 2.0, u_xlat18.x);
    u_xlat18.z = fma(u_xlat3.x, 2.0, u_xlat18.z);
    u_xlat18.x = u_xlat3.x + u_xlat18.x;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat4);
    u_xlat4 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat4);
    u_xlat20.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat18.x = fma(u_xlat20.x, 2.0, u_xlat18.x);
    u_xlat20.x = fma(u_xlat18.y, 2.0, u_xlat20.x);
    u_xlat20.x = u_xlat20.y + u_xlat20.x;
    u_xlat18.x = fma(u_xlat18.y, -12.0, u_xlat18.x);
    u_xlat18.x = fma(u_xlat20.y, 2.0, u_xlat18.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat5);
    u_xlat5 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat5);
    u_xlat54 = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat15.x = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat15.x = sin(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat15.x = fract(u_xlat15.x);
    u_xlat54 = sin(u_xlat54);
    u_xlat54 = u_xlat54 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat54 = fract(u_xlat54);
    u_xlat18.x = u_xlat18.x + u_xlat54;
    u_xlat18.x = fma(u_xlat15.x, 2.0, u_xlat18.x);
    u_xlat8.x = dot(u_xlat8.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.y = dot(u_xlat8.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xy = sin(u_xlat8.xy);
    u_xlat8.xy = u_xlat8.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xy = fract(u_xlat8.xy);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat7);
    u_xlat7 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat7);
    u_xlat42.x = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat42.y = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat42.xy = sin(u_xlat42.xy);
    u_xlat42.xy = u_xlat42.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.zw = fract(u_xlat42.xy);
    u_xlat18.xz = u_xlat18.xz + u_xlat8.xz;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat52 = fma(u_xlat18.y, 2.0, u_xlat18.z);
    u_xlat35.x = fma(u_xlat20.y, 2.0, u_xlat18.y);
    u_xlat35.x = u_xlat8.w + u_xlat35.x;
    u_xlat35.x = fma(u_xlat15.x, 2.0, u_xlat35.x);
    u_xlat35.x = fma(u_xlat8.x, -12.0, u_xlat35.x);
    u_xlat52 = fma(u_xlat20.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.w, 2.0, u_xlat52);
    u_xlat52 = u_xlat15.x + u_xlat52;
    u_xlat52 = fma(u_xlat8.x, 2.0, u_xlat52);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat9);
    u_xlat9 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat9);
    u_xlat42.x = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat32 = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat32 = sin(u_xlat32);
    u_xlat32 = u_xlat32 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat32 = fract(u_xlat32);
    u_xlat3.x = u_xlat3.x + u_xlat32;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat37 = fma(u_xlat8.w, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat8.w, -12.0, u_xlat3.x);
    u_xlat42.x = sin(u_xlat42.x);
    u_xlat42.x = u_xlat42.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat8.z = fract(u_xlat42.x);
    u_xlat52 = u_xlat52 + u_xlat8.z;
    u_xlat52 = u_xlat52 * 0.0833333358;
    u_xlat18.x = fma(u_xlat18.x, 0.0416666679, u_xlat52);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat10);
    u_xlat10 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat10);
    u_xlat52 = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat59 = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat59 = sin(u_xlat59);
    u_xlat59 = u_xlat59 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat8.w = fract(u_xlat59);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat3.x = fma(u_xlat52, 2.0, u_xlat3.x);
    u_xlat52 = u_xlat52 + u_xlat37;
    u_xlat52 = fma(u_xlat8.x, 2.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.z, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.w, 2.0, u_xlat52);
    u_xlat3.x = u_xlat8.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat3.x = u_xlat8.w + u_xlat3.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0416666679, u_xlat18.x);
    u_xlat3.x = fma(u_xlat54, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat15.x, 2.0, u_xlat54);
    u_xlat3.x = fma(u_xlat15.x, -12.0, u_xlat3.x);
    u_xlat20.y = fma(u_xlat8.x, 2.0, u_xlat15.x);
    u_xlat3.x = fma(u_xlat8.x, 2.0, u_xlat3.x);
    u_xlat20.z = fma(u_xlat8.z, 2.0, u_xlat8.x);
    u_xlat35.x = fma(u_xlat8.z, 2.0, u_xlat35.x);
    u_xlat20.xyz = u_xlat8.xzw + u_xlat20.xyz;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat6);
    u_xlat6 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat6);
    u_xlat8.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.z = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xz = sin(u_xlat8.xz);
    u_xlat8.xz = u_xlat8.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xz = fract(u_xlat8.xz);
    u_xlat3.x = u_xlat3.x + u_xlat8.x;
    u_xlat20.x = fma(u_xlat8.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat8.z, -12.0, u_xlat20.x);
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat12);
    u_xlat12 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat12);
    u_xlat8.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.w = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xw = sin(u_xlat8.xw);
    u_xlat8.xw = u_xlat8.xw * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xw = fract(u_xlat8.xw);
    u_xlat3.x = u_xlat3.x + u_xlat8.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = u_xlat35.x + u_xlat8.z;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat8.x, -12.0, u_xlat3.x);
    u_xlat3.x = fma(u_xlat8.w, 2.0, u_xlat3.x);
    u_xlat35.x = fma(u_xlat8.x, 2.0, u_xlat35.x);
    u_xlat35.x = u_xlat8.w + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.166666672, u_xlat18.x);
    u_xlat35.x = u_xlat52 + u_xlat8.x;
    u_xlat35.x = fma(u_xlat8.w, 2.0, u_xlat35.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat13);
    u_xlat13 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat13);
    u_xlat52 = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat35.x = u_xlat52 + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = fma(u_xlat8.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat8.x, 2.0, u_xlat20.z);
    u_xlat20.x = fma(u_xlat8.w, -12.0, u_xlat20.x);
    u_xlat35.y = fma(u_xlat52, 2.0, u_xlat20.x);
    u_xlat35.x = u_xlat37 + u_xlat35.x;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat11);
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat11);
    u_xlat20.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat35.x = fma(u_xlat20.x, 2.0, u_xlat35.x);
    u_xlat3.x = u_xlat20.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat35.xy = u_xlat35.xy + u_xlat20.yy;
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat14);
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat14);
    u_xlat1.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.z = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xz = sin(u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xz = fract(u_xlat1.xz);
    u_xlat3.x = u_xlat1.x + u_xlat3.x;
    u_xlat1.x = fma(u_xlat1.x, 2.0, u_xlat35.y);
    u_xlat1.x = u_xlat1.z + u_xlat1.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat1.x = fma(u_xlat1.x, 0.0416666679, u_xlat18.x);
    output.SV_Target0.x = u_xlat1.x * 0.0625;
    u_xlat0.x = dot(u_xlat0.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.y = dot(u_xlat0.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat34.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat34.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat34.xy = sin(u_xlat34.xy);
    u_xlat0.zw = u_xlat34.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat0 = fract(u_xlat0);
    u_xlat0.x = fma(u_xlat0.z, 2.0, u_xlat0.x);
    u_xlat34.x = fma(u_xlat0.w, 2.0, u_xlat0.z);
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat1.x = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.y = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat0.x = fma(u_xlat1.x, 2.0, u_xlat0.x);
    u_xlat1.x = fma(u_xlat0.y, 2.0, u_xlat1.x);
    u_xlat1.x = u_xlat1.y + u_xlat1.x;
    u_xlat0.x = fma(u_xlat0.y, -12.0, u_xlat0.x);
    u_xlat0.x = fma(u_xlat1.y, 2.0, u_xlat0.x);
    u_xlat35.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat35.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat35.xy = sin(u_xlat35.xy);
    u_xlat35.xy = u_xlat35.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat35.xy = fract(u_xlat35.xy);
    u_xlat0.x = u_xlat0.x + u_xlat35.x;
    u_xlat0.x = fma(u_xlat35.y, 2.0, u_xlat0.x);
    u_xlat0.x = u_xlat8.y + u_xlat0.x;
    u_xlat2.x = dot(u_xlat7.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat7.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat34.x = u_xlat34.x + u_xlat2.x;
    u_xlat34.y = fma(u_xlat2.x, 2.0, u_xlat0.w);
    u_xlat34.x = fma(u_xlat0.y, 2.0, u_xlat34.x);
    u_xlat17.x = fma(u_xlat1.y, 2.0, u_xlat0.y);
    u_xlat17.x = u_xlat2.y + u_xlat17.x;
    u_xlat17.x = fma(u_xlat35.y, 2.0, u_xlat17.x);
    u_xlat17.x = fma(u_xlat8.y, -12.0, u_xlat17.x);
    u_xlat34.x = fma(u_xlat1.y, -12.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.y, 2.0, u_xlat34.x);
    u_xlat34.x = u_xlat35.y + u_xlat34.x;
    u_xlat34.x = fma(u_xlat8.y, 2.0, u_xlat34.x);
    u_xlat2.x = dot(u_xlat9.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.z = dot(u_xlat9.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xz = sin(u_xlat2.xz);
    u_xlat2.xz = u_xlat2.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xz = fract(u_xlat2.xz);
    u_xlat34.xy = u_xlat34.xy + u_xlat2.xz;
    u_xlat51 = fma(u_xlat1.y, 2.0, u_xlat34.y);
    u_xlat18.x = fma(u_xlat2.y, 2.0, u_xlat1.y);
    u_xlat51 = fma(u_xlat2.y, -12.0, u_xlat51);
    u_xlat34.x = u_xlat34.x * 0.0833333358;
    u_xlat0.x = fma(u_xlat0.x, 0.0416666679, u_xlat34.x);
    u_xlat34.x = dot(u_xlat10.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = dot(u_xlat10.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.y = fract(u_xlat19);
    u_xlat34.x = sin(u_xlat34.x);
    u_xlat34.x = u_xlat34.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat34.x = fract(u_xlat34.x);
    u_xlat51 = fma(u_xlat34.x, 2.0, u_xlat51);
    u_xlat34.x = u_xlat34.x + u_xlat18.x;
    u_xlat34.x = fma(u_xlat8.y, 2.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.x, -12.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.y, 2.0, u_xlat34.x);
    u_xlat51 = u_xlat8.y + u_xlat51;
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat51);
    u_xlat51 = u_xlat2.y + u_xlat51;
    u_xlat0.x = fma(u_xlat51, 0.0416666679, u_xlat0.x);
    u_xlat51 = fma(u_xlat35.x, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat35.y, 2.0, u_xlat35.x);
    u_xlat1.x = u_xlat8.y + u_xlat1.x;
    u_xlat51 = fma(u_xlat35.y, -12.0, u_xlat51);
    u_xlat18.x = fma(u_xlat8.y, 2.0, u_xlat35.y);
    u_xlat51 = fma(u_xlat8.y, 2.0, u_xlat51);
    u_xlat18.y = fma(u_xlat2.x, 2.0, u_xlat8.y);
    u_xlat17.x = fma(u_xlat2.x, 2.0, u_xlat17.x);
    u_xlat18.xy = u_xlat2.xy + u_xlat18.xy;
    u_xlat52 = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.x = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat51 = u_xlat51 + u_xlat52;
    u_xlat1.x = fma(u_xlat52, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat2.x, -12.0, u_xlat1.x);
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat51);
    u_xlat52 = dot(u_xlat12.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = dot(u_xlat12.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat19 = fract(u_xlat19);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat51 = u_xlat51 + u_xlat52;
    u_xlat0.x = fma(u_xlat51, 0.0833333358, u_xlat0.x);
    u_xlat17.x = u_xlat17.x + u_xlat2.x;
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat18.x);
    u_xlat51 = fma(u_xlat52, -12.0, u_xlat51);
    u_xlat17.z = fma(u_xlat19, 2.0, u_xlat51);
    u_xlat17.x = fma(u_xlat52, 2.0, u_xlat17.x);
    u_xlat17.x = u_xlat19 + u_xlat17.x;
    u_xlat0.x = fma(u_xlat17.x, 0.166666672, u_xlat0.x);
    u_xlat17.x = u_xlat34.x + u_xlat52;
    u_xlat17.x = fma(u_xlat19, 2.0, u_xlat17.x);
    u_xlat34.x = dot(u_xlat13.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.x = dot(u_xlat13.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.x = sin(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat34.x = sin(u_xlat34.x);
    u_xlat34.x = u_xlat34.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat34.x = fract(u_xlat34.x);
    u_xlat17.x = u_xlat34.x + u_xlat17.x;
    u_xlat0.x = fma(u_xlat17.x, 0.0833333358, u_xlat0.x);
    u_xlat17.x = fma(u_xlat52, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat52, 2.0, u_xlat18.y);
    u_xlat1.x = fma(u_xlat19, -12.0, u_xlat1.x);
    u_xlat17.y = fma(u_xlat34.x, 2.0, u_xlat1.x);
    u_xlat17.x = u_xlat18.x + u_xlat17.x;
    u_xlat1.x = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.y = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat17.x = fma(u_xlat1.x, 2.0, u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xyz + u_xlat1.yyx;
    u_xlat51 = fma(u_xlat1.y, 2.0, u_xlat17.z);
    u_xlat0.x = fma(u_xlat17.x, 0.0416666679, u_xlat0.x);
    u_xlat17.x = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat17.x = sin(u_xlat17.x);
    u_xlat17.x = u_xlat17.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat17.x = fract(u_xlat17.x);
    u_xlat51 = u_xlat17.x + u_xlat51;
    u_xlat17.x = fma(u_xlat17.x, 2.0, u_xlat17.y);
    u_xlat17.x = u_xlat1.x + u_xlat17.x;
    u_xlat0.x = fma(u_xlat51, 0.0833333358, u_xlat0.x);
    u_xlat0.x = fma(u_xlat17.x, 0.0416666679, u_xlat0.x);
    output.SV_Target0.y = u_xlat0.x * 0.0625;
    output.SV_Target0.w = 1.0;
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
    float _Phase;
    float3 _NoiseParameters;
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
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float4 u_xlat12;
    float4 u_xlat13;
    float4 u_xlat14;
    float4 u_xlat15;
    float4 u_xlat16;
    float3 u_xlat17;
    float3 u_xlat18;
    float u_xlat19;
    float3 u_xlat20;
    float3 u_xlat23;
    float u_xlat32;
    float2 u_xlat34;
    float2 u_xlat35;
    float u_xlat37;
    float2 u_xlat40;
    float2 u_xlat42;
    float u_xlat51;
    float u_xlat52;
    float u_xlat54;
    float u_xlat57;
    float u_xlat59;
    u_xlat0 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, -2.0, -1.0, -1.0));
    u_xlat1.x = fract(FGlobals._Phase);
    u_xlat2 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat0);
    u_xlat18.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-1.0, -2.0, 0.0, -2.0));
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat2);
    u_xlat52 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat18.z = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.xyz = fract(u_xlat18.xyz);
    u_xlat18.x = fma(u_xlat18.z, 2.0, u_xlat18.x);
    u_xlat18.z = fma(u_xlat3.x, 2.0, u_xlat18.z);
    u_xlat18.x = u_xlat3.x + u_xlat18.x;
    u_xlat4 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, -1.0, 0.0, -1.0));
    u_xlat5 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat4);
    u_xlat20.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat18.x = fma(u_xlat20.x, 2.0, u_xlat18.x);
    u_xlat20.x = fma(u_xlat18.y, 2.0, u_xlat20.x);
    u_xlat20.x = u_xlat20.y + u_xlat20.x;
    u_xlat18.x = fma(u_xlat18.y, -12.0, u_xlat18.x);
    u_xlat18.x = fma(u_xlat20.y, 2.0, u_xlat18.x);
    u_xlat5 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, 0.0, -1.0, 0.0));
    u_xlat6 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat5);
    u_xlat54 = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat6.x = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat6.x = sin(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat6.x = fract(u_xlat6.x);
    u_xlat54 = sin(u_xlat54);
    u_xlat54 = u_xlat54 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat54 = fract(u_xlat54);
    u_xlat18.x = u_xlat18.x + u_xlat54;
    u_xlat18.x = fma(u_xlat6.x, 2.0, u_xlat18.x);
    u_xlat23.xyz = u_xlat1.xxx * float3(0.0700000003, 0.109999999, 0.129999995);
    u_xlat7.xy = fma(input.TEXCOORD1.xy, float2(128.0, 128.0), u_xlat23.zz);
    u_xlat8 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), u_xlat23.xxyy);
    u_xlat23.x = dot(u_xlat7.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat23.x = sin(u_xlat23.x);
    u_xlat23.x = u_xlat23.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.x = fract(u_xlat23.x);
    u_xlat7 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, -2.0, 1.0, -1.0));
    u_xlat9 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat7);
    u_xlat40.x = dot(u_xlat9.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat40.y = dot(u_xlat9.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat40.xy = sin(u_xlat40.xy);
    u_xlat40.xy = u_xlat40.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat23.yz = fract(u_xlat40.xy);
    u_xlat18.xz = u_xlat18.xz + u_xlat23.xy;
    u_xlat3.x = fma(u_xlat23.y, 2.0, u_xlat3.x);
    u_xlat52 = fma(u_xlat18.y, 2.0, u_xlat18.z);
    u_xlat35.x = fma(u_xlat20.y, 2.0, u_xlat18.y);
    u_xlat35.x = u_xlat23.z + u_xlat35.x;
    u_xlat35.x = fma(u_xlat6.x, 2.0, u_xlat35.x);
    u_xlat35.x = fma(u_xlat23.x, -12.0, u_xlat35.x);
    u_xlat52 = fma(u_xlat20.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.z, 2.0, u_xlat52);
    u_xlat52 = u_xlat6.x + u_xlat52;
    u_xlat52 = fma(u_xlat23.x, 2.0, u_xlat52);
    u_xlat9 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, 0.0, 2.0, -2.0));
    u_xlat10 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat9);
    u_xlat40.x = dot(u_xlat10.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10.x = dot(u_xlat10.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat10.x = sin(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat3.x = u_xlat3.x + u_xlat10.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat37 = fma(u_xlat23.z, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat23.z, -12.0, u_xlat3.x);
    u_xlat40.x = sin(u_xlat40.x);
    u_xlat40.x = u_xlat40.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.y = fract(u_xlat40.x);
    u_xlat52 = u_xlat52 + u_xlat23.y;
    u_xlat52 = u_xlat52 * 0.0833333358;
    u_xlat18.x = fma(u_xlat18.x, 0.0416666679, u_xlat52);
    u_xlat10 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(2.0, -1.0, 2.0, 0.0));
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat10);
    u_xlat52 = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat57 = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat57 = sin(u_xlat57);
    u_xlat57 = u_xlat57 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat23.z = fract(u_xlat57);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat3.x = fma(u_xlat52, 2.0, u_xlat3.x);
    u_xlat52 = u_xlat52 + u_xlat37;
    u_xlat52 = fma(u_xlat23.x, 2.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat23.z, 2.0, u_xlat52);
    u_xlat3.x = u_xlat23.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat23.y, 2.0, u_xlat3.x);
    u_xlat3.x = u_xlat23.z + u_xlat3.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0416666679, u_xlat18.x);
    u_xlat3.x = fma(u_xlat54, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat6.x, 2.0, u_xlat54);
    u_xlat3.x = fma(u_xlat6.x, -12.0, u_xlat3.x);
    u_xlat20.y = fma(u_xlat23.x, 2.0, u_xlat6.x);
    u_xlat3.x = fma(u_xlat23.x, 2.0, u_xlat3.x);
    u_xlat20.z = fma(u_xlat23.y, 2.0, u_xlat23.x);
    u_xlat35.x = fma(u_xlat23.y, 2.0, u_xlat35.x);
    u_xlat20.xyz = u_xlat23.xyz + u_xlat20.xyz;
    u_xlat6 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-2.0, 1.0, -1.0, 1.0));
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat6);
    u_xlat11.x = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.y = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat3.x = u_xlat3.x + u_xlat11.x;
    u_xlat20.x = fma(u_xlat11.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat11.y, -12.0, u_xlat20.x);
    u_xlat3.x = fma(u_xlat11.y, 2.0, u_xlat3.x);
    u_xlat12 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(0.0, 1.0, 1.0, 1.0));
    u_xlat13 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat12);
    u_xlat11.x = dot(u_xlat13.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.z = dot(u_xlat13.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat11.xz = sin(u_xlat11.xz);
    u_xlat11.xz = u_xlat11.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat11.xz = fract(u_xlat11.xz);
    u_xlat3.x = u_xlat3.x + u_xlat11.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = u_xlat35.x + u_xlat11.y;
    u_xlat3.x = fma(u_xlat11.y, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat11.x, -12.0, u_xlat3.x);
    u_xlat3.x = fma(u_xlat11.z, 2.0, u_xlat3.x);
    u_xlat35.x = fma(u_xlat11.x, 2.0, u_xlat35.x);
    u_xlat35.x = u_xlat11.z + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.166666672, u_xlat18.x);
    u_xlat35.x = u_xlat52 + u_xlat11.x;
    u_xlat35.x = fma(u_xlat11.z, 2.0, u_xlat35.x);
    u_xlat13 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(2.0, 1.0, -2.0, 2.0));
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat13);
    u_xlat52 = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat35.x = u_xlat52 + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = fma(u_xlat11.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat11.x, 2.0, u_xlat20.z);
    u_xlat20.x = fma(u_xlat11.z, -12.0, u_xlat20.x);
    u_xlat35.y = fma(u_xlat52, 2.0, u_xlat20.x);
    u_xlat35.x = u_xlat37 + u_xlat35.x;
    u_xlat11 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(-1.0, 2.0, 0.0, 2.0));
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat11);
    u_xlat20.x = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat35.x = fma(u_xlat20.x, 2.0, u_xlat35.x);
    u_xlat3.x = u_xlat20.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat35.xy = u_xlat35.xy + u_xlat20.yy;
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    u_xlat14 = fma(input.TEXCOORD1.xyxy, float4(128.0, 128.0, 128.0, 128.0), float4(1.0, 2.0, 2.0, 2.0));
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.129999995, 0.129999995, 0.129999995, 0.129999995), u_xlat14);
    u_xlat35.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.x = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.x = sin(u_xlat20.x);
    u_xlat20.x = u_xlat20.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat20.x = fract(u_xlat20.x);
    u_xlat35.x = sin(u_xlat35.x);
    u_xlat35.x = u_xlat35.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat35.x = fract(u_xlat35.x);
    u_xlat3.x = u_xlat35.x + u_xlat3.x;
    u_xlat35.x = fma(u_xlat35.x, 2.0, u_xlat35.y);
    u_xlat35.x = u_xlat20.x + u_xlat35.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    output.SV_Target0.z = u_xlat18.x * 0.0625;
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat0);
    u_xlat0 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat0);
    u_xlat18.x = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.y = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat3 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat2);
    u_xlat2 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat2);
    u_xlat52 = dot(u_xlat3.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = dot(u_xlat3.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat3.x = fract(u_xlat3.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat18.z = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.xyz = fract(u_xlat18.xyz);
    u_xlat18.x = fma(u_xlat18.z, 2.0, u_xlat18.x);
    u_xlat18.z = fma(u_xlat3.x, 2.0, u_xlat18.z);
    u_xlat18.x = u_xlat3.x + u_xlat18.x;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat4);
    u_xlat4 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat4);
    u_xlat20.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat18.x = fma(u_xlat20.x, 2.0, u_xlat18.x);
    u_xlat20.x = fma(u_xlat18.y, 2.0, u_xlat20.x);
    u_xlat20.x = u_xlat20.y + u_xlat20.x;
    u_xlat18.x = fma(u_xlat18.y, -12.0, u_xlat18.x);
    u_xlat18.x = fma(u_xlat20.y, 2.0, u_xlat18.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat5);
    u_xlat5 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat5);
    u_xlat54 = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat15.x = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat15.x = sin(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat15.x = fract(u_xlat15.x);
    u_xlat54 = sin(u_xlat54);
    u_xlat54 = u_xlat54 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat54 = fract(u_xlat54);
    u_xlat18.x = u_xlat18.x + u_xlat54;
    u_xlat18.x = fma(u_xlat15.x, 2.0, u_xlat18.x);
    u_xlat8.x = dot(u_xlat8.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.y = dot(u_xlat8.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xy = sin(u_xlat8.xy);
    u_xlat8.xy = u_xlat8.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xy = fract(u_xlat8.xy);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat7);
    u_xlat7 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat7);
    u_xlat42.x = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat42.y = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat42.xy = sin(u_xlat42.xy);
    u_xlat42.xy = u_xlat42.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.zw = fract(u_xlat42.xy);
    u_xlat18.xz = u_xlat18.xz + u_xlat8.xz;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat52 = fma(u_xlat18.y, 2.0, u_xlat18.z);
    u_xlat35.x = fma(u_xlat20.y, 2.0, u_xlat18.y);
    u_xlat35.x = u_xlat8.w + u_xlat35.x;
    u_xlat35.x = fma(u_xlat15.x, 2.0, u_xlat35.x);
    u_xlat35.x = fma(u_xlat8.x, -12.0, u_xlat35.x);
    u_xlat52 = fma(u_xlat20.y, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.w, 2.0, u_xlat52);
    u_xlat52 = u_xlat15.x + u_xlat52;
    u_xlat52 = fma(u_xlat8.x, 2.0, u_xlat52);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat9);
    u_xlat9 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat9);
    u_xlat42.x = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat32 = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat32 = sin(u_xlat32);
    u_xlat32 = u_xlat32 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat32 = fract(u_xlat32);
    u_xlat3.x = u_xlat3.x + u_xlat32;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat37 = fma(u_xlat8.w, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat8.w, -12.0, u_xlat3.x);
    u_xlat42.x = sin(u_xlat42.x);
    u_xlat42.x = u_xlat42.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat8.z = fract(u_xlat42.x);
    u_xlat52 = u_xlat52 + u_xlat8.z;
    u_xlat52 = u_xlat52 * 0.0833333358;
    u_xlat18.x = fma(u_xlat18.x, 0.0416666679, u_xlat52);
    u_xlat16 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat10);
    u_xlat10 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat10);
    u_xlat52 = dot(u_xlat16.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat59 = dot(u_xlat16.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat59 = sin(u_xlat59);
    u_xlat59 = u_xlat59 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat8.w = fract(u_xlat59);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat3.x = fma(u_xlat52, 2.0, u_xlat3.x);
    u_xlat52 = u_xlat52 + u_xlat37;
    u_xlat52 = fma(u_xlat8.x, 2.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.z, -12.0, u_xlat52);
    u_xlat52 = fma(u_xlat8.w, 2.0, u_xlat52);
    u_xlat3.x = u_xlat8.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat3.x = u_xlat8.w + u_xlat3.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0416666679, u_xlat18.x);
    u_xlat3.x = fma(u_xlat54, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat15.x, 2.0, u_xlat54);
    u_xlat3.x = fma(u_xlat15.x, -12.0, u_xlat3.x);
    u_xlat20.y = fma(u_xlat8.x, 2.0, u_xlat15.x);
    u_xlat3.x = fma(u_xlat8.x, 2.0, u_xlat3.x);
    u_xlat20.z = fma(u_xlat8.z, 2.0, u_xlat8.x);
    u_xlat35.x = fma(u_xlat8.z, 2.0, u_xlat35.x);
    u_xlat20.xyz = u_xlat8.xzw + u_xlat20.xyz;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat6);
    u_xlat6 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat6);
    u_xlat8.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.z = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xz = sin(u_xlat8.xz);
    u_xlat8.xz = u_xlat8.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xz = fract(u_xlat8.xz);
    u_xlat3.x = u_xlat3.x + u_xlat8.x;
    u_xlat20.x = fma(u_xlat8.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat8.z, -12.0, u_xlat20.x);
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat3.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat12);
    u_xlat12 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat12);
    u_xlat8.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.w = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat8.xw = sin(u_xlat8.xw);
    u_xlat8.xw = u_xlat8.xw * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat8.xw = fract(u_xlat8.xw);
    u_xlat3.x = u_xlat3.x + u_xlat8.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = u_xlat35.x + u_xlat8.z;
    u_xlat3.x = fma(u_xlat8.z, 2.0, u_xlat20.y);
    u_xlat3.x = fma(u_xlat8.x, -12.0, u_xlat3.x);
    u_xlat3.x = fma(u_xlat8.w, 2.0, u_xlat3.x);
    u_xlat35.x = fma(u_xlat8.x, 2.0, u_xlat35.x);
    u_xlat35.x = u_xlat8.w + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.166666672, u_xlat18.x);
    u_xlat35.x = u_xlat52 + u_xlat8.x;
    u_xlat35.x = fma(u_xlat8.w, 2.0, u_xlat35.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat13);
    u_xlat13 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat13);
    u_xlat52 = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat37 = sin(u_xlat37);
    u_xlat37 = u_xlat37 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat37 = fract(u_xlat37);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat35.x = u_xlat52 + u_xlat35.x;
    u_xlat18.x = fma(u_xlat35.x, 0.0833333358, u_xlat18.x);
    u_xlat35.x = fma(u_xlat8.x, 2.0, u_xlat20.x);
    u_xlat20.x = fma(u_xlat8.x, 2.0, u_xlat20.z);
    u_xlat20.x = fma(u_xlat8.w, -12.0, u_xlat20.x);
    u_xlat35.y = fma(u_xlat52, 2.0, u_xlat20.x);
    u_xlat35.x = u_xlat37 + u_xlat35.x;
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat11);
    u_xlat11 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat11);
    u_xlat20.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.y = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat35.x = fma(u_xlat20.x, 2.0, u_xlat35.x);
    u_xlat3.x = u_xlat20.x + u_xlat3.x;
    u_xlat3.x = fma(u_xlat20.y, 2.0, u_xlat3.x);
    u_xlat35.xy = u_xlat35.xy + u_xlat20.yy;
    u_xlat18.x = fma(u_xlat35.x, 0.0416666679, u_xlat18.x);
    u_xlat15 = fma(u_xlat1.xxxx, float4(0.0700000003, 0.0700000003, 0.0700000003, 0.0700000003), u_xlat14);
    u_xlat14 = fma(u_xlat1.xxxx, float4(0.109999999, 0.109999999, 0.109999999, 0.109999999), u_xlat14);
    u_xlat1.x = dot(u_xlat15.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.z = dot(u_xlat15.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xz = sin(u_xlat1.xz);
    u_xlat1.xz = u_xlat1.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xz = fract(u_xlat1.xz);
    u_xlat3.x = u_xlat1.x + u_xlat3.x;
    u_xlat1.x = fma(u_xlat1.x, 2.0, u_xlat35.y);
    u_xlat1.x = u_xlat1.z + u_xlat1.x;
    u_xlat18.x = fma(u_xlat3.x, 0.0833333358, u_xlat18.x);
    u_xlat1.x = fma(u_xlat1.x, 0.0416666679, u_xlat18.x);
    output.SV_Target0.x = u_xlat1.x * 0.0625;
    u_xlat0.x = dot(u_xlat0.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.y = dot(u_xlat0.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat34.x = dot(u_xlat2.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat34.y = dot(u_xlat2.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat34.xy = sin(u_xlat34.xy);
    u_xlat0.zw = u_xlat34.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat0 = fract(u_xlat0);
    u_xlat0.x = fma(u_xlat0.z, 2.0, u_xlat0.x);
    u_xlat34.x = fma(u_xlat0.w, 2.0, u_xlat0.z);
    u_xlat0.x = u_xlat0.w + u_xlat0.x;
    u_xlat1.x = dot(u_xlat4.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.y = dot(u_xlat4.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat0.x = fma(u_xlat1.x, 2.0, u_xlat0.x);
    u_xlat1.x = fma(u_xlat0.y, 2.0, u_xlat1.x);
    u_xlat1.x = u_xlat1.y + u_xlat1.x;
    u_xlat0.x = fma(u_xlat0.y, -12.0, u_xlat0.x);
    u_xlat0.x = fma(u_xlat1.y, 2.0, u_xlat0.x);
    u_xlat35.x = dot(u_xlat5.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat35.y = dot(u_xlat5.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat35.xy = sin(u_xlat35.xy);
    u_xlat35.xy = u_xlat35.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat35.xy = fract(u_xlat35.xy);
    u_xlat0.x = u_xlat0.x + u_xlat35.x;
    u_xlat0.x = fma(u_xlat35.y, 2.0, u_xlat0.x);
    u_xlat0.x = u_xlat8.y + u_xlat0.x;
    u_xlat2.x = dot(u_xlat7.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.y = dot(u_xlat7.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat34.x = u_xlat34.x + u_xlat2.x;
    u_xlat34.y = fma(u_xlat2.x, 2.0, u_xlat0.w);
    u_xlat34.x = fma(u_xlat0.y, 2.0, u_xlat34.x);
    u_xlat17.x = fma(u_xlat1.y, 2.0, u_xlat0.y);
    u_xlat17.x = u_xlat2.y + u_xlat17.x;
    u_xlat17.x = fma(u_xlat35.y, 2.0, u_xlat17.x);
    u_xlat17.x = fma(u_xlat8.y, -12.0, u_xlat17.x);
    u_xlat34.x = fma(u_xlat1.y, -12.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.y, 2.0, u_xlat34.x);
    u_xlat34.x = u_xlat35.y + u_xlat34.x;
    u_xlat34.x = fma(u_xlat8.y, 2.0, u_xlat34.x);
    u_xlat2.x = dot(u_xlat9.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.z = dot(u_xlat9.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.xz = sin(u_xlat2.xz);
    u_xlat2.xz = u_xlat2.xz * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat2.xz = fract(u_xlat2.xz);
    u_xlat34.xy = u_xlat34.xy + u_xlat2.xz;
    u_xlat51 = fma(u_xlat1.y, 2.0, u_xlat34.y);
    u_xlat18.x = fma(u_xlat2.y, 2.0, u_xlat1.y);
    u_xlat51 = fma(u_xlat2.y, -12.0, u_xlat51);
    u_xlat34.x = u_xlat34.x * 0.0833333358;
    u_xlat0.x = fma(u_xlat0.x, 0.0416666679, u_xlat34.x);
    u_xlat34.x = dot(u_xlat10.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = dot(u_xlat10.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.y = fract(u_xlat19);
    u_xlat34.x = sin(u_xlat34.x);
    u_xlat34.x = u_xlat34.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat34.x = fract(u_xlat34.x);
    u_xlat51 = fma(u_xlat34.x, 2.0, u_xlat51);
    u_xlat34.x = u_xlat34.x + u_xlat18.x;
    u_xlat34.x = fma(u_xlat8.y, 2.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.x, -12.0, u_xlat34.x);
    u_xlat34.x = fma(u_xlat2.y, 2.0, u_xlat34.x);
    u_xlat51 = u_xlat8.y + u_xlat51;
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat51);
    u_xlat51 = u_xlat2.y + u_xlat51;
    u_xlat0.x = fma(u_xlat51, 0.0416666679, u_xlat0.x);
    u_xlat51 = fma(u_xlat35.x, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat35.y, 2.0, u_xlat35.x);
    u_xlat1.x = u_xlat8.y + u_xlat1.x;
    u_xlat51 = fma(u_xlat35.y, -12.0, u_xlat51);
    u_xlat18.x = fma(u_xlat8.y, 2.0, u_xlat35.y);
    u_xlat51 = fma(u_xlat8.y, 2.0, u_xlat51);
    u_xlat18.y = fma(u_xlat2.x, 2.0, u_xlat8.y);
    u_xlat17.x = fma(u_xlat2.x, 2.0, u_xlat17.x);
    u_xlat18.xy = u_xlat2.xy + u_xlat18.xy;
    u_xlat52 = dot(u_xlat6.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.x = dot(u_xlat6.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat51 = u_xlat51 + u_xlat52;
    u_xlat1.x = fma(u_xlat52, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat2.x, -12.0, u_xlat1.x);
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat51);
    u_xlat52 = dot(u_xlat12.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = dot(u_xlat12.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat19 = sin(u_xlat19);
    u_xlat19 = u_xlat19 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat19 = fract(u_xlat19);
    u_xlat52 = sin(u_xlat52);
    u_xlat52 = u_xlat52 * FGlobals._NoiseParameters.xxyz.w;
    u_xlat52 = fract(u_xlat52);
    u_xlat51 = u_xlat51 + u_xlat52;
    u_xlat0.x = fma(u_xlat51, 0.0833333358, u_xlat0.x);
    u_xlat17.x = u_xlat17.x + u_xlat2.x;
    u_xlat51 = fma(u_xlat2.x, 2.0, u_xlat18.x);
    u_xlat51 = fma(u_xlat52, -12.0, u_xlat51);
    u_xlat17.z = fma(u_xlat19, 2.0, u_xlat51);
    u_xlat17.x = fma(u_xlat52, 2.0, u_xlat17.x);
    u_xlat17.x = u_xlat19 + u_xlat17.x;
    u_xlat0.x = fma(u_xlat17.x, 0.166666672, u_xlat0.x);
    u_xlat17.x = u_xlat34.x + u_xlat52;
    u_xlat17.x = fma(u_xlat19, 2.0, u_xlat17.x);
    u_xlat34.x = dot(u_xlat13.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.x = dot(u_xlat13.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat18.x = sin(u_xlat18.x);
    u_xlat18.x = u_xlat18.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat18.x = fract(u_xlat18.x);
    u_xlat34.x = sin(u_xlat34.x);
    u_xlat34.x = u_xlat34.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat34.x = fract(u_xlat34.x);
    u_xlat17.x = u_xlat34.x + u_xlat17.x;
    u_xlat0.x = fma(u_xlat17.x, 0.0833333358, u_xlat0.x);
    u_xlat17.x = fma(u_xlat52, 2.0, u_xlat1.x);
    u_xlat1.x = fma(u_xlat52, 2.0, u_xlat18.y);
    u_xlat1.x = fma(u_xlat19, -12.0, u_xlat1.x);
    u_xlat17.y = fma(u_xlat34.x, 2.0, u_xlat1.x);
    u_xlat17.x = u_xlat18.x + u_xlat17.x;
    u_xlat1.x = dot(u_xlat11.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.y = dot(u_xlat11.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * FGlobals._NoiseParameters.xxyz.ww;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat17.x = fma(u_xlat1.x, 2.0, u_xlat17.x);
    u_xlat17.xyz = u_xlat17.xyz + u_xlat1.yyx;
    u_xlat51 = fma(u_xlat1.y, 2.0, u_xlat17.z);
    u_xlat0.x = fma(u_xlat17.x, 0.0416666679, u_xlat0.x);
    u_xlat17.x = dot(u_xlat14.xy, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = dot(u_xlat14.zw, FGlobals._NoiseParameters.xxyz.yz);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat17.x = sin(u_xlat17.x);
    u_xlat17.x = u_xlat17.x * FGlobals._NoiseParameters.xxyz.w;
    u_xlat17.x = fract(u_xlat17.x);
    u_xlat51 = u_xlat17.x + u_xlat51;
    u_xlat17.x = fma(u_xlat17.x, 2.0, u_xlat17.y);
    u_xlat17.x = u_xlat1.x + u_xlat17.x;
    u_xlat0.x = fma(u_xlat51, 0.0833333358, u_xlat0.x);
    u_xlat0.x = fma(u_xlat17.x, 0.0416666679, u_xlat0.x);
    output.SV_Target0.y = u_xlat0.x * 0.0625;
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
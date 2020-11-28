//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/SubpixelMorphologicalAntialiasing" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 58262
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.150000006, 0.150000006));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.150000006, 0.150000006));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.150000006, 0.150000006));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 122362
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.100000001, 0.100000001));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.100000001, 0.100000001));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.100000001, 0.100000001));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 185718
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-1.0, 0.0, 0.0, -1.0), u_xlat0.xyxy);
    output.TEXCOORD2 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
    output.TEXCOORD3 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-2.0, 0.0, 0.0, -2.0), u_xlat0.xyxy);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.100000001, 0.100000001));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.100000001, 0.100000001));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float2 u_xlat1;
    half3 u_xlat16_1;
    float2 u_xlat2;
    half3 u_xlat16_2;
    half3 u_xlat16_3;
    float2 u_xlat4;
    half3 u_xlat16_4;
    half3 u_xlat16_5;
    float2 u_xlat6;
    half u_xlat16_12;
    float2 u_xlat14;
    bool2 u_xlatb14;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    u_xlat16_0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_18 = max(abs(u_xlat16_2.y), abs(u_xlat16_2.x));
    u_xlat2.x = max(abs(float(u_xlat16_2.z)), float(u_xlat16_18));
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat2.y = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlatb14.xy = (u_xlat2.xy>=float2(0.100000001, 0.100000001));
    u_xlat14.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb14.xy));
    u_xlat18 = dot(u_xlat14.xy, float2(1.0, 1.0));
    u_xlatb18 = u_xlat18==0.0;
    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_4.xyz);
    u_xlat16_18 = max(abs(u_xlat16_4.y), abs(u_xlat16_4.x));
    u_xlat4.x = max(abs(float(u_xlat16_4.z)), float(u_xlat16_18));
    u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD2.zw).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_0.x = max(abs(u_xlat16_0.y), abs(u_xlat16_0.x));
    u_xlat4.y = max(abs(float(u_xlat16_0.z)), float(u_xlat16_0.x));
    u_xlat0.xy = max(u_xlat2.xy, u_xlat4.xy);
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_1.y), abs(u_xlat16_1.x));
    u_xlat1.x = max(abs(float(u_xlat16_1.z)), float(u_xlat16_12));
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD3.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_12 = max(abs(u_xlat16_3.y), abs(u_xlat16_3.x));
    u_xlat1.y = max(abs(float(u_xlat16_3.z)), float(u_xlat16_12));
    u_xlat0.xy = max(u_xlat0.xy, u_xlat1.xy);
    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat6.xy = u_xlat2.xy + u_xlat2.xy;
    u_xlatb0.xy = (u_xlat6.xy>=u_xlat0.xx);
    u_xlat0.xy = select(float2(0.0, 0.0), float2(1.0, 1.0), bool2(u_xlatb0.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat14.xy;
    output.SV_Target0.xy = u_xlat0.xy;
    output.SV_Target0.zw = float2(0.0, 0.0);
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
  GpuProgramID 210173
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-8.0, 8.0, -8.0, 8.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-8.0, 8.0, -8.0, 8.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-8.0, 8.0, -8.0, 8.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb8;
    float2 u_xlat9;
    bool u_xlatb9;
    half u_xlat16_12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb0.xy = (float2(0.0, 0.0)<u_xlat0.yx);
    if(u_xlatb0.x){
        u_xlat1.xy = input.TEXCOORD2.xy;
        u_xlat1.z = 1.0;
        u_xlat2.x = 0.0;
        while(true){
            u_xlatb0.x = input.TEXCOORD4.x<u_xlat1.x;
            u_xlatb8 = 0.828100026<u_xlat1.z;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            u_xlatb8 = u_xlat2.x==0.0;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            if(!u_xlatb0.x){break;}
            u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
            u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
            u_xlat1.z = u_xlat2.y;
        }
        u_xlat2.yz = u_xlat1.xz;
        u_xlat0.xz = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_0.x), u_xlat2.y);
        u_xlat1.y = input.TEXCOORD3.y;
        u_xlat0.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
        u_xlat2.xy = input.TEXCOORD2.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.x<input.TEXCOORD4.y;
            u_xlatb13 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.xz;
        u_xlat2.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_12), u_xlat3.y);
        u_xlat1.xw = fma(FGlobals._MainTex_TexelSize.zz, u_xlat1.xz, (-input.TEXCOORD1.xx));
        u_xlat1.xw = rint(u_xlat1.xw);
        u_xlat1.xw = sqrt(abs(u_xlat1.xw));
        u_xlat0.z = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
        u_xlat0.xz = u_xlat0.xz * float2(4.0, 4.0);
        u_xlat0.xz = rint(u_xlat0.xz);
        u_xlat0.xz = fma(u_xlat0.xz, float2(16.0, 16.0), u_xlat1.xw);
        u_xlat0.xz = fma(u_xlat0.xz, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xz = _AreaTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).xy;
        output.SV_Target0.xy = float2(u_xlat16_0.xz);
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    if(u_xlatb0.y){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb12 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb13 = 0.828100026<u_xlat0.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat1.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0.x), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb9 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            u_xlatb9 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat9.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat9.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_12), u_xlat3.y);
        u_xlat0.xw = fma(FGlobals._MainTex_TexelSize.ww, u_xlat0.xz, (-input.TEXCOORD1.yy));
        u_xlat0.xw = rint(u_xlat0.xw);
        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat4.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat4.xy = rint(u_xlat4.xy);
        u_xlat0.xy = fma(u_xlat4.xy, float2(16.0, 16.0), u_xlat0.xw);
        u_xlat0.xy = fma(u_xlat0.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xy = _AreaTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xy;
        output.SV_Target0.zw = float2(u_xlat16_0.xy);
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb8;
    float2 u_xlat9;
    bool u_xlatb9;
    half u_xlat16_12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb0.xy = (float2(0.0, 0.0)<u_xlat0.yx);
    if(u_xlatb0.x){
        u_xlat1.xy = input.TEXCOORD2.xy;
        u_xlat1.z = 1.0;
        u_xlat2.x = 0.0;
        while(true){
            u_xlatb0.x = input.TEXCOORD4.x<u_xlat1.x;
            u_xlatb8 = 0.828100026<u_xlat1.z;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            u_xlatb8 = u_xlat2.x==0.0;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            if(!u_xlatb0.x){break;}
            u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
            u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
            u_xlat1.z = u_xlat2.y;
        }
        u_xlat2.yz = u_xlat1.xz;
        u_xlat0.xz = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_0.x), u_xlat2.y);
        u_xlat1.y = input.TEXCOORD3.y;
        u_xlat0.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
        u_xlat2.xy = input.TEXCOORD2.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.x<input.TEXCOORD4.y;
            u_xlatb13 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.xz;
        u_xlat2.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_12), u_xlat3.y);
        u_xlat1.xw = fma(FGlobals._MainTex_TexelSize.zz, u_xlat1.xz, (-input.TEXCOORD1.xx));
        u_xlat1.xw = rint(u_xlat1.xw);
        u_xlat1.xw = sqrt(abs(u_xlat1.xw));
        u_xlat0.z = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
        u_xlat0.xz = u_xlat0.xz * float2(4.0, 4.0);
        u_xlat0.xz = rint(u_xlat0.xz);
        u_xlat0.xz = fma(u_xlat0.xz, float2(16.0, 16.0), u_xlat1.xw);
        u_xlat0.xz = fma(u_xlat0.xz, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xz = _AreaTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).xy;
        output.SV_Target0.xy = float2(u_xlat16_0.xz);
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    if(u_xlatb0.y){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb12 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb13 = 0.828100026<u_xlat0.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat1.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0.x), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb9 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            u_xlatb9 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat9.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat9.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_12), u_xlat3.y);
        u_xlat0.xw = fma(FGlobals._MainTex_TexelSize.ww, u_xlat0.xz, (-input.TEXCOORD1.yy));
        u_xlat0.xw = rint(u_xlat0.xw);
        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat4.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat4.xy = rint(u_xlat4.xy);
        u_xlat0.xy = fma(u_xlat4.xy, float2(16.0, 16.0), u_xlat0.xw);
        u_xlat0.xy = fma(u_xlat0.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xy = _AreaTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xy;
        output.SV_Target0.zw = float2(u_xlat16_0.xy);
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb8;
    float2 u_xlat9;
    bool u_xlatb9;
    half u_xlat16_12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb0.xy = (float2(0.0, 0.0)<u_xlat0.yx);
    if(u_xlatb0.x){
        u_xlat1.xy = input.TEXCOORD2.xy;
        u_xlat1.z = 1.0;
        u_xlat2.x = 0.0;
        while(true){
            u_xlatb0.x = input.TEXCOORD4.x<u_xlat1.x;
            u_xlatb8 = 0.828100026<u_xlat1.z;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            u_xlatb8 = u_xlat2.x==0.0;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            if(!u_xlatb0.x){break;}
            u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
            u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
            u_xlat1.z = u_xlat2.y;
        }
        u_xlat2.yz = u_xlat1.xz;
        u_xlat0.xz = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_0.x), u_xlat2.y);
        u_xlat1.y = input.TEXCOORD3.y;
        u_xlat0.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
        u_xlat2.xy = input.TEXCOORD2.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.x<input.TEXCOORD4.y;
            u_xlatb13 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.xz;
        u_xlat2.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_12), u_xlat3.y);
        u_xlat1.xw = fma(FGlobals._MainTex_TexelSize.zz, u_xlat1.xz, (-input.TEXCOORD1.xx));
        u_xlat1.xw = rint(u_xlat1.xw);
        u_xlat1.xw = sqrt(abs(u_xlat1.xw));
        u_xlat0.z = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
        u_xlat0.xz = u_xlat0.xz * float2(4.0, 4.0);
        u_xlat0.xz = rint(u_xlat0.xz);
        u_xlat0.xz = fma(u_xlat0.xz, float2(16.0, 16.0), u_xlat1.xw);
        u_xlat0.xz = fma(u_xlat0.xz, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xz = _AreaTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).xy;
        output.SV_Target0.xy = float2(u_xlat16_0.xz);
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    if(u_xlatb0.y){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb12 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb13 = 0.828100026<u_xlat0.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat1.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0.x), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb9 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            u_xlatb9 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat9.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat9.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_12), u_xlat3.y);
        u_xlat0.xw = fma(FGlobals._MainTex_TexelSize.ww, u_xlat0.xz, (-input.TEXCOORD1.yy));
        u_xlat0.xw = rint(u_xlat0.xw);
        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat4.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat4.xy = rint(u_xlat4.xy);
        u_xlat0.xy = fma(u_xlat4.xy, float2(16.0, 16.0), u_xlat0.xw);
        u_xlat0.xy = fma(u_xlat0.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xy = _AreaTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xy;
        output.SV_Target0.zw = float2(u_xlat16_0.xy);
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
  GpuProgramID 266226
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-16.0, 16.0, -16.0, 16.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-16.0, 16.0, -16.0, 16.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-16.0, 16.0, -16.0, 16.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb8;
    float2 u_xlat9;
    bool u_xlatb9;
    half u_xlat16_12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb0.xy = (float2(0.0, 0.0)<u_xlat0.yx);
    if(u_xlatb0.x){
        u_xlat1.xy = input.TEXCOORD2.xy;
        u_xlat1.z = 1.0;
        u_xlat2.x = 0.0;
        while(true){
            u_xlatb0.x = input.TEXCOORD4.x<u_xlat1.x;
            u_xlatb8 = 0.828100026<u_xlat1.z;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            u_xlatb8 = u_xlat2.x==0.0;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            if(!u_xlatb0.x){break;}
            u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
            u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
            u_xlat1.z = u_xlat2.y;
        }
        u_xlat2.yz = u_xlat1.xz;
        u_xlat0.xz = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_0.x), u_xlat2.y);
        u_xlat1.y = input.TEXCOORD3.y;
        u_xlat0.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
        u_xlat2.xy = input.TEXCOORD2.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.x<input.TEXCOORD4.y;
            u_xlatb13 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.xz;
        u_xlat2.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_12), u_xlat3.y);
        u_xlat1.xw = fma(FGlobals._MainTex_TexelSize.zz, u_xlat1.xz, (-input.TEXCOORD1.xx));
        u_xlat1.xw = rint(u_xlat1.xw);
        u_xlat1.xw = sqrt(abs(u_xlat1.xw));
        u_xlat0.z = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
        u_xlat0.xz = u_xlat0.xz * float2(4.0, 4.0);
        u_xlat0.xz = rint(u_xlat0.xz);
        u_xlat0.xz = fma(u_xlat0.xz, float2(16.0, 16.0), u_xlat1.xw);
        u_xlat0.xz = fma(u_xlat0.xz, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xz = _AreaTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).xy;
        output.SV_Target0.xy = float2(u_xlat16_0.xz);
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    if(u_xlatb0.y){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb12 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb13 = 0.828100026<u_xlat0.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat1.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0.x), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb9 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            u_xlatb9 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat9.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat9.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_12), u_xlat3.y);
        u_xlat0.xw = fma(FGlobals._MainTex_TexelSize.ww, u_xlat0.xz, (-input.TEXCOORD1.yy));
        u_xlat0.xw = rint(u_xlat0.xw);
        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat4.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat4.xy = rint(u_xlat4.xy);
        u_xlat0.xy = fma(u_xlat4.xy, float2(16.0, 16.0), u_xlat0.xw);
        u_xlat0.xy = fma(u_xlat0.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xy = _AreaTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xy;
        output.SV_Target0.zw = float2(u_xlat16_0.xy);
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb8;
    float2 u_xlat9;
    bool u_xlatb9;
    half u_xlat16_12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb0.xy = (float2(0.0, 0.0)<u_xlat0.yx);
    if(u_xlatb0.x){
        u_xlat1.xy = input.TEXCOORD2.xy;
        u_xlat1.z = 1.0;
        u_xlat2.x = 0.0;
        while(true){
            u_xlatb0.x = input.TEXCOORD4.x<u_xlat1.x;
            u_xlatb8 = 0.828100026<u_xlat1.z;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            u_xlatb8 = u_xlat2.x==0.0;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            if(!u_xlatb0.x){break;}
            u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
            u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
            u_xlat1.z = u_xlat2.y;
        }
        u_xlat2.yz = u_xlat1.xz;
        u_xlat0.xz = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_0.x), u_xlat2.y);
        u_xlat1.y = input.TEXCOORD3.y;
        u_xlat0.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
        u_xlat2.xy = input.TEXCOORD2.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.x<input.TEXCOORD4.y;
            u_xlatb13 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.xz;
        u_xlat2.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_12), u_xlat3.y);
        u_xlat1.xw = fma(FGlobals._MainTex_TexelSize.zz, u_xlat1.xz, (-input.TEXCOORD1.xx));
        u_xlat1.xw = rint(u_xlat1.xw);
        u_xlat1.xw = sqrt(abs(u_xlat1.xw));
        u_xlat0.z = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
        u_xlat0.xz = u_xlat0.xz * float2(4.0, 4.0);
        u_xlat0.xz = rint(u_xlat0.xz);
        u_xlat0.xz = fma(u_xlat0.xz, float2(16.0, 16.0), u_xlat1.xw);
        u_xlat0.xz = fma(u_xlat0.xz, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xz = _AreaTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).xy;
        output.SV_Target0.xy = float2(u_xlat16_0.xz);
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    if(u_xlatb0.y){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb12 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb13 = 0.828100026<u_xlat0.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat1.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0.x), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb9 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            u_xlatb9 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat9.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat9.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_12), u_xlat3.y);
        u_xlat0.xw = fma(FGlobals._MainTex_TexelSize.ww, u_xlat0.xz, (-input.TEXCOORD1.yy));
        u_xlat0.xw = rint(u_xlat0.xw);
        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat4.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat4.xy = rint(u_xlat4.xy);
        u_xlat0.xy = fma(u_xlat4.xy, float2(16.0, 16.0), u_xlat0.xw);
        u_xlat0.xy = fma(u_xlat0.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xy = _AreaTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xy;
        output.SV_Target0.zw = float2(u_xlat16_0.xy);
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half3 u_xlat16_0;
    bool2 u_xlatb0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb8;
    float2 u_xlat9;
    bool u_xlatb9;
    half u_xlat16_12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb0.xy = (float2(0.0, 0.0)<u_xlat0.yx);
    if(u_xlatb0.x){
        u_xlat1.xy = input.TEXCOORD2.xy;
        u_xlat1.z = 1.0;
        u_xlat2.x = 0.0;
        while(true){
            u_xlatb0.x = input.TEXCOORD4.x<u_xlat1.x;
            u_xlatb8 = 0.828100026<u_xlat1.z;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            u_xlatb8 = u_xlat2.x==0.0;
            u_xlatb0.x = u_xlatb8 && u_xlatb0.x;
            if(!u_xlatb0.x){break;}
            u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
            u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
            u_xlat1.z = u_xlat2.y;
        }
        u_xlat2.yz = u_xlat1.xz;
        u_xlat0.xz = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_0.x), u_xlat2.y);
        u_xlat1.y = input.TEXCOORD3.y;
        u_xlat0.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
        u_xlat2.xy = input.TEXCOORD2.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.x<input.TEXCOORD4.y;
            u_xlatb13 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.xz;
        u_xlat2.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_12), u_xlat3.y);
        u_xlat1.xw = fma(FGlobals._MainTex_TexelSize.zz, u_xlat1.xz, (-input.TEXCOORD1.xx));
        u_xlat1.xw = rint(u_xlat1.xw);
        u_xlat1.xw = sqrt(abs(u_xlat1.xw));
        u_xlat0.z = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
        u_xlat0.xz = u_xlat0.xz * float2(4.0, 4.0);
        u_xlat0.xz = rint(u_xlat0.xz);
        u_xlat0.xz = fma(u_xlat0.xz, float2(16.0, 16.0), u_xlat1.xw);
        u_xlat0.xz = fma(u_xlat0.xz, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xz = _AreaTex.sample(sampler_MainTex, u_xlat0.xz, level(0.0)).xy;
        output.SV_Target0.xy = float2(u_xlat16_0.xz);
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    if(u_xlatb0.y){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb12 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb13 = 0.828100026<u_xlat0.z;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            u_xlatb13 = u_xlat1.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb13;
            if(!u_xlatb12){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0.x = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0.x = fma(u_xlat16_0.x, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0.x), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb12 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb9 = 0.828100026<u_xlat2.z;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            u_xlatb9 = u_xlat3.x==0.0;
            u_xlatb12 = u_xlatb12 && u_xlatb9;
            if(!u_xlatb12){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat9.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_12 = _SearchTex.sample(sampler_MainTex, u_xlat9.xy, level(0.0)).w;
        u_xlat16_12 = fma(u_xlat16_12, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_12), u_xlat3.y);
        u_xlat0.xw = fma(FGlobals._MainTex_TexelSize.ww, u_xlat0.xz, (-input.TEXCOORD1.yy));
        u_xlat0.xw = rint(u_xlat0.xw);
        u_xlat0.xw = sqrt(abs(u_xlat0.xw));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat4.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat4.xy = rint(u_xlat4.xy);
        u_xlat0.xy = fma(u_xlat4.xy, float2(16.0, 16.0), u_xlat0.xw);
        u_xlat0.xy = fma(u_xlat0.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_0.xy = _AreaTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xy;
        output.SV_Target0.zw = float2(u_xlat16_0.xy);
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
  GpuProgramID 328378
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-32.0, 32.0, -32.0, 32.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-32.0, 32.0, -32.0, 32.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
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
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    output.TEXCOORD0.xy = fma(input.POSITION0.xy, float2(0.5, -0.5), float2(0.5, 0.5));
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD1.xy = u_xlat0.zw * VGlobals._MainTex_TexelSize.zw;
    u_xlat1 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-0.25, 1.25, -0.125, -0.125), u_xlat0.zzww);
    u_xlat0 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(-0.125, -0.25, -0.125, 1.25), u_xlat0);
    output.TEXCOORD2 = u_xlat1.xzyw;
    output.TEXCOORD3 = u_xlat0;
    u_xlat1.zw = u_xlat0.yw;
    output.TEXCOORD4 = fma(VGlobals._MainTex_TexelSize.xxyy, float4(-32.0, 32.0, -32.0, 32.0), u_xlat1);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half2 u_xlat16_1;
    float4 u_xlat2;
    half2 u_xlat16_2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    half2 u_xlat16_3;
    bool4 u_xlatb3;
    float4 u_xlat4;
    half2 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    bool u_xlatb6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    bool3 u_xlatb7;
    float3 u_xlat8;
    float2 u_xlat13;
    half u_xlat16_13;
    bool u_xlatb13;
    float2 u_xlat14;
    bool u_xlatb14;
    half2 u_xlat16_15;
    bool u_xlatb15;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    float u_xlat19;
    half u_xlat16_19;
    bool u_xlatb19;
    float u_xlat20;
    bool u_xlatb21;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb6 = 0.0<u_xlat0.y;
    if(u_xlatb6){
        u_xlatb6 = 0.0<u_xlat0.x;
        if(u_xlatb6){
            u_xlat1.xy = FGlobals._MainTex_TexelSize.xy * float2(-1.0, 1.0);
            u_xlat1.z = 1.0;
            u_xlat2.xy = input.TEXCOORD0.xy;
            u_xlat6.x = 0.0;
            u_xlat2.z = -1.0;
            u_xlat3.x = 1.0;
            while(true){
                u_xlatb18 = u_xlat2.z<7.0;
                u_xlatb19 = 0.899999976<u_xlat3.x;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                if(!u_xlatb18){break;}
                u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xyz;
                u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
                u_xlat3.x = dot(u_xlat6.yx, float2(0.5, 0.5));
            }
            u_xlatb6 = 0.899999976<u_xlat6.x;
            u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
            u_xlat1.x = u_xlat6.x + u_xlat2.z;
        } else {
            u_xlat1.x = 0.0;
            u_xlat3.x = 0.0;
        }
        u_xlat6.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, -1.0);
        u_xlat6.z = 1.0;
        u_xlat2.yz = input.TEXCOORD0.xy;
        u_xlat2.x = float(-1.0);
        u_xlat20 = float(1.0);
        while(true){
            u_xlatb15 = u_xlat2.x<7.0;
            u_xlatb21 = 0.899999976<u_xlat20;
            u_xlatb15 = u_xlatb21 && u_xlatb15;
            if(!u_xlatb15){break;}
            u_xlat2.xyz = u_xlat6.zxy + u_xlat2.xyz;
            u_xlat16_15.xy = _MainTex.sample(sampler_MainTex, u_xlat2.yz, level(0.0)).xy;
            u_xlat20 = dot(u_xlat16_15.xy, half2(0.5, 0.5));
        }
        u_xlat3.y = u_xlat20;
        u_xlat6.x = u_xlat1.x + u_xlat2.x;
        u_xlatb6 = 2.0<u_xlat6.x;
        if(u_xlatb6){
            u_xlat1.y = (-u_xlat1.x) + 0.25;
            u_xlat1.zw = fma(u_xlat2.xx, float2(1.0, -1.0), float2(0.0, -0.25));
            u_xlat2 = fma(u_xlat1.yxzw, FGlobals._MainTex_TexelSize.xyxy, input.TEXCOORD0.xyxy);
            u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0), int2(-1, 0)).xy);
            u_xlat16_7.xz = _MainTex.sample(sampler_MainTex, u_xlat2.zw, level(0.0), int2(1, 0)).xy;
            u_xlat6.z = float(u_xlat16_7.x);
            u_xlat2.xy = fma(u_xlat6.xz, float2(5.0, 5.0), float2(-3.75, -3.75));
            u_xlat6.xz = u_xlat6.xz * abs(u_xlat2.xy);
            u_xlat6.xz = rint(u_xlat6.xz);
            u_xlat8.x = rint(u_xlat6.y);
            u_xlat8.z = rint(float(u_xlat16_7.z));
            u_xlat6.xy = fma(u_xlat8.xz, float2(2.0, 2.0), u_xlat6.xz);
            u_xlatb7.xz = (u_xlat3.xy>=float2(0.899999976, 0.899999976));
            {
                float3 hlslcc_movcTemp = u_xlat6;
                hlslcc_movcTemp.x = (u_xlatb7.x) ? float(0.0) : u_xlat6.x;
                hlslcc_movcTemp.y = (u_xlatb7.z) ? float(0.0) : u_xlat6.y;
                u_xlat6 = hlslcc_movcTemp;
            }
            u_xlat6.xy = fma(u_xlat6.xy, float2(20.0, 20.0), u_xlat1.xz);
            u_xlat6.xy = fma(u_xlat6.xy, float2(0.00625000009, 0.0017857143), float2(0.503125012, 0.000892857148));
            u_xlat6.xy = float2(_AreaTex.sample(sampler_MainTex, u_xlat6.xy, level(0.0)).xy);
        } else {
            u_xlat6.x = float(0.0);
            u_xlat6.y = float(0.0);
        }
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.x, 0.25, input.TEXCOORD0.x);
        u_xlat1.xy = (-FGlobals._MainTex_TexelSize.xy);
        u_xlat1.z = 1.0;
        u_xlat8.x = u_xlat18;
        u_xlat8.y = input.TEXCOORD0.y;
        u_xlat2.x = float(1.0);
        u_xlat8.z = float(-1.0);
        while(true){
            u_xlatb19 = u_xlat8.z<7.0;
            u_xlatb3.x = 0.899999976<u_xlat2.x;
            u_xlatb19 = u_xlatb19 && u_xlatb3.x;
            if(!u_xlatb19){break;}
            u_xlat8.xyz = u_xlat1.xyz + u_xlat8.xyz;
            u_xlat16_3.xy = _MainTex.sample(sampler_MainTex, u_xlat8.xy, level(0.0)).xy;
            u_xlat16_19 = fma(u_xlat16_3.x, half(5.0), half(-3.75));
            u_xlat19 = abs(float(u_xlat16_19)) * float(u_xlat16_3.x);
            u_xlat4.x = rint(u_xlat19);
            u_xlat4.y = rint(float(u_xlat16_3.y));
            u_xlat2.x = dot(u_xlat4.xy, float2(0.5, 0.5));
        }
        u_xlat1.x = u_xlat8.z;
        u_xlat19 = float(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy, level(0.0), int2(1, 0)).x);
        u_xlatb19 = 0.0<u_xlat19;
        if(u_xlatb19){
            u_xlat3.xy = FGlobals._MainTex_TexelSize.xy;
            u_xlat3.z = 1.0;
            u_xlat4.x = u_xlat18;
            u_xlat4.y = input.TEXCOORD0.y;
            u_xlat4.z = -1.0;
            u_xlat2.y = float(1.0);
            u_xlat14.x = float(0.0);
            while(true){
                u_xlatb19 = u_xlat4.z<7.0;
                u_xlatb21 = 0.899999976<u_xlat2.y;
                u_xlatb19 = u_xlatb19 && u_xlatb21;
                if(!u_xlatb19){break;}
                u_xlat4.xyz = u_xlat3.xyz + u_xlat4.xyz;
                u_xlat16_5.xy = _MainTex.sample(sampler_MainTex, u_xlat4.xy, level(0.0)).xy;
                u_xlat16_19 = fma(u_xlat16_5.x, half(5.0), half(-3.75));
                u_xlat19 = abs(float(u_xlat16_19)) * float(u_xlat16_5.x);
                u_xlat14.y = rint(u_xlat19);
                u_xlat14.x = rint(float(u_xlat16_5.y));
                u_xlat2.y = dot(u_xlat14.yx, float2(0.5, 0.5));
            }
            u_xlatb18 = 0.899999976<u_xlat14.x;
            u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
            u_xlat1.z = u_xlat18 + u_xlat4.z;
        } else {
            u_xlat1.z = 0.0;
            u_xlat2.y = 0.0;
        }
        u_xlat18 = u_xlat1.z + u_xlat1.x;
        u_xlatb18 = 2.0<u_xlat18;
        if(u_xlatb18){
            u_xlat1.y = (-u_xlat1.x);
            u_xlat3 = fma(u_xlat1.yyzz, FGlobals._MainTex_TexelSize.xyxy, input.TEXCOORD0.xyxy);
            u_xlat4.x = float(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0), int2(-1, 0)).y);
            u_xlat4.z = float(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0), int2(0, -1)).x);
            u_xlat4.yw = float2(_MainTex.sample(sampler_MainTex, u_xlat3.zw, level(0.0), int2(1, 0)).yx);
            u_xlat7.xz = fma(u_xlat4.xy, float2(2.0, 2.0), u_xlat4.zw);
            u_xlatb2.xy = (u_xlat2.xy>=float2(0.899999976, 0.899999976));
            {
                float3 hlslcc_movcTemp = u_xlat7;
                hlslcc_movcTemp.x = (u_xlatb2.x) ? float(0.0) : u_xlat7.x;
                hlslcc_movcTemp.z = (u_xlatb2.y) ? float(0.0) : u_xlat7.z;
                u_xlat7 = hlslcc_movcTemp;
            }
            u_xlat1.xy = fma(u_xlat7.xz, float2(20.0, 20.0), u_xlat1.xz);
            u_xlat1.xy = fma(u_xlat1.xy, float2(0.00625000009, 0.0017857143), float2(0.503125012, 0.000892857148));
            u_xlat16_1.xy = _AreaTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy;
            u_xlat6.xy = u_xlat6.xy + float2(u_xlat16_1.yx);
        }
        u_xlatb18 = (-u_xlat6.y)==u_xlat6.x;
        if(u_xlatb18){
            u_xlat1.xy = input.TEXCOORD2.xy;
            u_xlat1.z = 1.0;
            u_xlat2.x = 0.0;
            while(true){
                u_xlatb18 = input.TEXCOORD4.x<u_xlat1.x;
                u_xlatb19 = 0.828100026<u_xlat1.z;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                u_xlatb19 = u_xlat2.x==0.0;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                if(!u_xlatb18){break;}
                u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
                u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
                u_xlat1.z = u_xlat2.y;
            }
            u_xlat2.yz = u_xlat1.xz;
            u_xlat1.xy = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
            u_xlat16_18 = _SearchTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).w;
            u_xlat16_18 = fma(u_xlat16_18, half(-2.00787401), half(3.25));
            u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_18), u_xlat2.y);
            u_xlat1.y = input.TEXCOORD3.y;
            u_xlat2.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
            u_xlat3.xy = input.TEXCOORD2.zw;
            u_xlat3.z = 1.0;
            u_xlat4.x = 0.0;
            while(true){
                u_xlatb18 = u_xlat3.x<input.TEXCOORD4.y;
                u_xlatb14 = 0.828100026<u_xlat3.z;
                u_xlatb18 = u_xlatb18 && u_xlatb14;
                u_xlatb14 = u_xlat4.x==0.0;
                u_xlatb18 = u_xlatb18 && u_xlatb14;
                if(!u_xlatb18){break;}
                u_xlat4.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0)).xy);
                u_xlat3.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat3.xy);
                u_xlat3.z = u_xlat4.y;
            }
            u_xlat4.yz = u_xlat3.xz;
            u_xlat14.xy = fma(u_xlat4.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
            u_xlat16_18 = _SearchTex.sample(sampler_MainTex, u_xlat14.xy, level(0.0)).w;
            u_xlat16_18 = fma(u_xlat16_18, half(-2.00787401), half(3.25));
            u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_18), u_xlat4.y);
            u_xlat3 = fma(FGlobals._MainTex_TexelSize.zzzz, u_xlat1.zxzx, (-input.TEXCOORD1.xxxx));
            u_xlat3 = rint(u_xlat3);
            u_xlat14.xy = sqrt(abs(u_xlat3.wz));
            u_xlat2.y = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
            u_xlat2.xy = u_xlat2.xy * float2(4.0, 4.0);
            u_xlat2.xy = rint(u_xlat2.xy);
            u_xlat2.xy = fma(u_xlat2.xy, float2(16.0, 16.0), u_xlat14.xy);
            u_xlat2.xy = fma(u_xlat2.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
            u_xlat16_2.xy = _AreaTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy;
            u_xlatb3 = (abs(u_xlat3)>=abs(u_xlat3.wzwz));
            u_xlat3 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 0.75, 0.75), bool4(u_xlatb3));
            u_xlat18 = u_xlat3.y + u_xlat3.x;
            u_xlat14.xy = u_xlat3.zw / float2(u_xlat18);
            u_xlat1.w = input.TEXCOORD0.y;
            u_xlat16_18 = _MainTex.sample(sampler_MainTex, u_xlat1.xw, level(0.0), int2(0, 1)).x;
            u_xlat18 = fma((-u_xlat14.x), float(u_xlat16_18), 1.0);
            u_xlat16_7.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0), int2(1, 1)).x;
            u_xlat3.x = fma((-u_xlat14.y), float(u_xlat16_7.x), u_xlat18);
            u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
            u_xlat16_18 = _MainTex.sample(sampler_MainTex, u_xlat1.xw, level(0.0), int2(0, -2)).x;
            u_xlat18 = fma((-u_xlat14.x), float(u_xlat16_18), 1.0);
            u_xlat16_1.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0), int2(1, -2)).x;
            u_xlat3.y = fma((-u_xlat14.y), float(u_xlat16_1.x), u_xlat18);
            u_xlat3.y = clamp(u_xlat3.y, 0.0f, 1.0f);
            output.SV_Target0.xy = float2(u_xlat16_2.xy) * u_xlat3.xy;
        } else {
            output.SV_Target0.xy = u_xlat6.xy;
            u_xlat0.x = 0.0;
        }
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    u_xlatb0 = 0.0<u_xlat0.x;
    if(u_xlatb0){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb18 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb19 = 0.828100026<u_xlat0.z;
            u_xlatb18 = u_xlatb18 && u_xlatb19;
            u_xlatb19 = u_xlat1.x==0.0;
            u_xlatb18 = u_xlatb18 && u_xlatb19;
            if(!u_xlatb18){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0 = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0 = fma(u_xlat16_0, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb13 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb19 = 0.828100026<u_xlat2.z;
            u_xlatb13 = u_xlatb19 && u_xlatb13;
            u_xlatb19 = u_xlat3.x==0.0;
            u_xlatb13 = u_xlatb19 && u_xlatb13;
            if(!u_xlatb13){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat13.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_13 = _SearchTex.sample(sampler_MainTex, u_xlat13.xy, level(0.0)).w;
        u_xlat16_13 = fma(u_xlat16_13, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_13), u_xlat3.y);
        u_xlat2 = fma(FGlobals._MainTex_TexelSize.wwww, u_xlat0.zxzx, (-input.TEXCOORD1.yyyy));
        u_xlat2 = rint(u_xlat2);
        u_xlat13.xy = sqrt(abs(u_xlat2.wz));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat1.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat1.xy = rint(u_xlat1.xy);
        u_xlat1.xy = fma(u_xlat1.xy, float2(16.0, 16.0), u_xlat13.xy);
        u_xlat1.xy = fma(u_xlat1.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_1.xy = _AreaTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy;
        u_xlatb2 = (abs(u_xlat2)>=abs(u_xlat2.wzwz));
        u_xlat2 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 0.75, 0.75), bool4(u_xlatb2));
        u_xlat6.x = u_xlat2.y + u_xlat2.x;
        u_xlat13.xy = u_xlat2.zw / u_xlat6.xx;
        u_xlat0.w = input.TEXCOORD0.x;
        u_xlat16_6 = _MainTex.sample(sampler_MainTex, u_xlat0.wx, level(0.0), int2(1, 0)).y;
        u_xlat6.x = fma((-u_xlat13.x), float(u_xlat16_6), 1.0);
        u_xlat16_2.x = _MainTex.sample(sampler_MainTex, u_xlat0.wz, level(0.0), int2(1, 1)).y;
        u_xlat14.x = fma((-u_xlat13.y), float(u_xlat16_2.x), u_xlat6.x);
        u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
        u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.wx, level(0.0), int2(-2, 0)).y;
        u_xlat0.x = fma((-u_xlat13.x), float(u_xlat16_0), 1.0);
        u_xlat16_6 = _MainTex.sample(sampler_MainTex, u_xlat0.wz, level(0.0), int2(-2, 1)).y;
        u_xlat14.y = fma((-u_xlat13.y), float(u_xlat16_6), u_xlat0.x);
        u_xlat14.y = clamp(u_xlat14.y, 0.0f, 1.0f);
        output.SV_Target0.zw = float2(u_xlat16_1.xy) * u_xlat14.xy;
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half2 u_xlat16_1;
    float4 u_xlat2;
    half2 u_xlat16_2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    half2 u_xlat16_3;
    bool4 u_xlatb3;
    float4 u_xlat4;
    half2 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    bool u_xlatb6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    bool3 u_xlatb7;
    float3 u_xlat8;
    float2 u_xlat13;
    half u_xlat16_13;
    bool u_xlatb13;
    float2 u_xlat14;
    bool u_xlatb14;
    half2 u_xlat16_15;
    bool u_xlatb15;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    float u_xlat19;
    half u_xlat16_19;
    bool u_xlatb19;
    float u_xlat20;
    bool u_xlatb21;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb6 = 0.0<u_xlat0.y;
    if(u_xlatb6){
        u_xlatb6 = 0.0<u_xlat0.x;
        if(u_xlatb6){
            u_xlat1.xy = FGlobals._MainTex_TexelSize.xy * float2(-1.0, 1.0);
            u_xlat1.z = 1.0;
            u_xlat2.xy = input.TEXCOORD0.xy;
            u_xlat6.x = 0.0;
            u_xlat2.z = -1.0;
            u_xlat3.x = 1.0;
            while(true){
                u_xlatb18 = u_xlat2.z<7.0;
                u_xlatb19 = 0.899999976<u_xlat3.x;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                if(!u_xlatb18){break;}
                u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xyz;
                u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
                u_xlat3.x = dot(u_xlat6.yx, float2(0.5, 0.5));
            }
            u_xlatb6 = 0.899999976<u_xlat6.x;
            u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
            u_xlat1.x = u_xlat6.x + u_xlat2.z;
        } else {
            u_xlat1.x = 0.0;
            u_xlat3.x = 0.0;
        }
        u_xlat6.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, -1.0);
        u_xlat6.z = 1.0;
        u_xlat2.yz = input.TEXCOORD0.xy;
        u_xlat2.x = float(-1.0);
        u_xlat20 = float(1.0);
        while(true){
            u_xlatb15 = u_xlat2.x<7.0;
            u_xlatb21 = 0.899999976<u_xlat20;
            u_xlatb15 = u_xlatb21 && u_xlatb15;
            if(!u_xlatb15){break;}
            u_xlat2.xyz = u_xlat6.zxy + u_xlat2.xyz;
            u_xlat16_15.xy = _MainTex.sample(sampler_MainTex, u_xlat2.yz, level(0.0)).xy;
            u_xlat20 = dot(u_xlat16_15.xy, half2(0.5, 0.5));
        }
        u_xlat3.y = u_xlat20;
        u_xlat6.x = u_xlat1.x + u_xlat2.x;
        u_xlatb6 = 2.0<u_xlat6.x;
        if(u_xlatb6){
            u_xlat1.y = (-u_xlat1.x) + 0.25;
            u_xlat1.zw = fma(u_xlat2.xx, float2(1.0, -1.0), float2(0.0, -0.25));
            u_xlat2 = fma(u_xlat1.yxzw, FGlobals._MainTex_TexelSize.xyxy, input.TEXCOORD0.xyxy);
            u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0), int2(-1, 0)).xy);
            u_xlat16_7.xz = _MainTex.sample(sampler_MainTex, u_xlat2.zw, level(0.0), int2(1, 0)).xy;
            u_xlat6.z = float(u_xlat16_7.x);
            u_xlat2.xy = fma(u_xlat6.xz, float2(5.0, 5.0), float2(-3.75, -3.75));
            u_xlat6.xz = u_xlat6.xz * abs(u_xlat2.xy);
            u_xlat6.xz = rint(u_xlat6.xz);
            u_xlat8.x = rint(u_xlat6.y);
            u_xlat8.z = rint(float(u_xlat16_7.z));
            u_xlat6.xy = fma(u_xlat8.xz, float2(2.0, 2.0), u_xlat6.xz);
            u_xlatb7.xz = (u_xlat3.xy>=float2(0.899999976, 0.899999976));
            {
                float3 hlslcc_movcTemp = u_xlat6;
                hlslcc_movcTemp.x = (u_xlatb7.x) ? float(0.0) : u_xlat6.x;
                hlslcc_movcTemp.y = (u_xlatb7.z) ? float(0.0) : u_xlat6.y;
                u_xlat6 = hlslcc_movcTemp;
            }
            u_xlat6.xy = fma(u_xlat6.xy, float2(20.0, 20.0), u_xlat1.xz);
            u_xlat6.xy = fma(u_xlat6.xy, float2(0.00625000009, 0.0017857143), float2(0.503125012, 0.000892857148));
            u_xlat6.xy = float2(_AreaTex.sample(sampler_MainTex, u_xlat6.xy, level(0.0)).xy);
        } else {
            u_xlat6.x = float(0.0);
            u_xlat6.y = float(0.0);
        }
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.x, 0.25, input.TEXCOORD0.x);
        u_xlat1.xy = (-FGlobals._MainTex_TexelSize.xy);
        u_xlat1.z = 1.0;
        u_xlat8.x = u_xlat18;
        u_xlat8.y = input.TEXCOORD0.y;
        u_xlat2.x = float(1.0);
        u_xlat8.z = float(-1.0);
        while(true){
            u_xlatb19 = u_xlat8.z<7.0;
            u_xlatb3.x = 0.899999976<u_xlat2.x;
            u_xlatb19 = u_xlatb19 && u_xlatb3.x;
            if(!u_xlatb19){break;}
            u_xlat8.xyz = u_xlat1.xyz + u_xlat8.xyz;
            u_xlat16_3.xy = _MainTex.sample(sampler_MainTex, u_xlat8.xy, level(0.0)).xy;
            u_xlat16_19 = fma(u_xlat16_3.x, half(5.0), half(-3.75));
            u_xlat19 = abs(float(u_xlat16_19)) * float(u_xlat16_3.x);
            u_xlat4.x = rint(u_xlat19);
            u_xlat4.y = rint(float(u_xlat16_3.y));
            u_xlat2.x = dot(u_xlat4.xy, float2(0.5, 0.5));
        }
        u_xlat1.x = u_xlat8.z;
        u_xlat19 = float(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy, level(0.0), int2(1, 0)).x);
        u_xlatb19 = 0.0<u_xlat19;
        if(u_xlatb19){
            u_xlat3.xy = FGlobals._MainTex_TexelSize.xy;
            u_xlat3.z = 1.0;
            u_xlat4.x = u_xlat18;
            u_xlat4.y = input.TEXCOORD0.y;
            u_xlat4.z = -1.0;
            u_xlat2.y = float(1.0);
            u_xlat14.x = float(0.0);
            while(true){
                u_xlatb19 = u_xlat4.z<7.0;
                u_xlatb21 = 0.899999976<u_xlat2.y;
                u_xlatb19 = u_xlatb19 && u_xlatb21;
                if(!u_xlatb19){break;}
                u_xlat4.xyz = u_xlat3.xyz + u_xlat4.xyz;
                u_xlat16_5.xy = _MainTex.sample(sampler_MainTex, u_xlat4.xy, level(0.0)).xy;
                u_xlat16_19 = fma(u_xlat16_5.x, half(5.0), half(-3.75));
                u_xlat19 = abs(float(u_xlat16_19)) * float(u_xlat16_5.x);
                u_xlat14.y = rint(u_xlat19);
                u_xlat14.x = rint(float(u_xlat16_5.y));
                u_xlat2.y = dot(u_xlat14.yx, float2(0.5, 0.5));
            }
            u_xlatb18 = 0.899999976<u_xlat14.x;
            u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
            u_xlat1.z = u_xlat18 + u_xlat4.z;
        } else {
            u_xlat1.z = 0.0;
            u_xlat2.y = 0.0;
        }
        u_xlat18 = u_xlat1.z + u_xlat1.x;
        u_xlatb18 = 2.0<u_xlat18;
        if(u_xlatb18){
            u_xlat1.y = (-u_xlat1.x);
            u_xlat3 = fma(u_xlat1.yyzz, FGlobals._MainTex_TexelSize.xyxy, input.TEXCOORD0.xyxy);
            u_xlat4.x = float(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0), int2(-1, 0)).y);
            u_xlat4.z = float(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0), int2(0, -1)).x);
            u_xlat4.yw = float2(_MainTex.sample(sampler_MainTex, u_xlat3.zw, level(0.0), int2(1, 0)).yx);
            u_xlat7.xz = fma(u_xlat4.xy, float2(2.0, 2.0), u_xlat4.zw);
            u_xlatb2.xy = (u_xlat2.xy>=float2(0.899999976, 0.899999976));
            {
                float3 hlslcc_movcTemp = u_xlat7;
                hlslcc_movcTemp.x = (u_xlatb2.x) ? float(0.0) : u_xlat7.x;
                hlslcc_movcTemp.z = (u_xlatb2.y) ? float(0.0) : u_xlat7.z;
                u_xlat7 = hlslcc_movcTemp;
            }
            u_xlat1.xy = fma(u_xlat7.xz, float2(20.0, 20.0), u_xlat1.xz);
            u_xlat1.xy = fma(u_xlat1.xy, float2(0.00625000009, 0.0017857143), float2(0.503125012, 0.000892857148));
            u_xlat16_1.xy = _AreaTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy;
            u_xlat6.xy = u_xlat6.xy + float2(u_xlat16_1.yx);
        }
        u_xlatb18 = (-u_xlat6.y)==u_xlat6.x;
        if(u_xlatb18){
            u_xlat1.xy = input.TEXCOORD2.xy;
            u_xlat1.z = 1.0;
            u_xlat2.x = 0.0;
            while(true){
                u_xlatb18 = input.TEXCOORD4.x<u_xlat1.x;
                u_xlatb19 = 0.828100026<u_xlat1.z;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                u_xlatb19 = u_xlat2.x==0.0;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                if(!u_xlatb18){break;}
                u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
                u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
                u_xlat1.z = u_xlat2.y;
            }
            u_xlat2.yz = u_xlat1.xz;
            u_xlat1.xy = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
            u_xlat16_18 = _SearchTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).w;
            u_xlat16_18 = fma(u_xlat16_18, half(-2.00787401), half(3.25));
            u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_18), u_xlat2.y);
            u_xlat1.y = input.TEXCOORD3.y;
            u_xlat2.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
            u_xlat3.xy = input.TEXCOORD2.zw;
            u_xlat3.z = 1.0;
            u_xlat4.x = 0.0;
            while(true){
                u_xlatb18 = u_xlat3.x<input.TEXCOORD4.y;
                u_xlatb14 = 0.828100026<u_xlat3.z;
                u_xlatb18 = u_xlatb18 && u_xlatb14;
                u_xlatb14 = u_xlat4.x==0.0;
                u_xlatb18 = u_xlatb18 && u_xlatb14;
                if(!u_xlatb18){break;}
                u_xlat4.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0)).xy);
                u_xlat3.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat3.xy);
                u_xlat3.z = u_xlat4.y;
            }
            u_xlat4.yz = u_xlat3.xz;
            u_xlat14.xy = fma(u_xlat4.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
            u_xlat16_18 = _SearchTex.sample(sampler_MainTex, u_xlat14.xy, level(0.0)).w;
            u_xlat16_18 = fma(u_xlat16_18, half(-2.00787401), half(3.25));
            u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_18), u_xlat4.y);
            u_xlat3 = fma(FGlobals._MainTex_TexelSize.zzzz, u_xlat1.zxzx, (-input.TEXCOORD1.xxxx));
            u_xlat3 = rint(u_xlat3);
            u_xlat14.xy = sqrt(abs(u_xlat3.wz));
            u_xlat2.y = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
            u_xlat2.xy = u_xlat2.xy * float2(4.0, 4.0);
            u_xlat2.xy = rint(u_xlat2.xy);
            u_xlat2.xy = fma(u_xlat2.xy, float2(16.0, 16.0), u_xlat14.xy);
            u_xlat2.xy = fma(u_xlat2.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
            u_xlat16_2.xy = _AreaTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy;
            u_xlatb3 = (abs(u_xlat3)>=abs(u_xlat3.wzwz));
            u_xlat3 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 0.75, 0.75), bool4(u_xlatb3));
            u_xlat18 = u_xlat3.y + u_xlat3.x;
            u_xlat14.xy = u_xlat3.zw / float2(u_xlat18);
            u_xlat1.w = input.TEXCOORD0.y;
            u_xlat16_18 = _MainTex.sample(sampler_MainTex, u_xlat1.xw, level(0.0), int2(0, 1)).x;
            u_xlat18 = fma((-u_xlat14.x), float(u_xlat16_18), 1.0);
            u_xlat16_7.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0), int2(1, 1)).x;
            u_xlat3.x = fma((-u_xlat14.y), float(u_xlat16_7.x), u_xlat18);
            u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
            u_xlat16_18 = _MainTex.sample(sampler_MainTex, u_xlat1.xw, level(0.0), int2(0, -2)).x;
            u_xlat18 = fma((-u_xlat14.x), float(u_xlat16_18), 1.0);
            u_xlat16_1.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0), int2(1, -2)).x;
            u_xlat3.y = fma((-u_xlat14.y), float(u_xlat16_1.x), u_xlat18);
            u_xlat3.y = clamp(u_xlat3.y, 0.0f, 1.0f);
            output.SV_Target0.xy = float2(u_xlat16_2.xy) * u_xlat3.xy;
        } else {
            output.SV_Target0.xy = u_xlat6.xy;
            u_xlat0.x = 0.0;
        }
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    u_xlatb0 = 0.0<u_xlat0.x;
    if(u_xlatb0){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb18 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb19 = 0.828100026<u_xlat0.z;
            u_xlatb18 = u_xlatb18 && u_xlatb19;
            u_xlatb19 = u_xlat1.x==0.0;
            u_xlatb18 = u_xlatb18 && u_xlatb19;
            if(!u_xlatb18){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0 = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0 = fma(u_xlat16_0, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb13 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb19 = 0.828100026<u_xlat2.z;
            u_xlatb13 = u_xlatb19 && u_xlatb13;
            u_xlatb19 = u_xlat3.x==0.0;
            u_xlatb13 = u_xlatb19 && u_xlatb13;
            if(!u_xlatb13){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat13.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_13 = _SearchTex.sample(sampler_MainTex, u_xlat13.xy, level(0.0)).w;
        u_xlat16_13 = fma(u_xlat16_13, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_13), u_xlat3.y);
        u_xlat2 = fma(FGlobals._MainTex_TexelSize.wwww, u_xlat0.zxzx, (-input.TEXCOORD1.yyyy));
        u_xlat2 = rint(u_xlat2);
        u_xlat13.xy = sqrt(abs(u_xlat2.wz));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat1.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat1.xy = rint(u_xlat1.xy);
        u_xlat1.xy = fma(u_xlat1.xy, float2(16.0, 16.0), u_xlat13.xy);
        u_xlat1.xy = fma(u_xlat1.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_1.xy = _AreaTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy;
        u_xlatb2 = (abs(u_xlat2)>=abs(u_xlat2.wzwz));
        u_xlat2 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 0.75, 0.75), bool4(u_xlatb2));
        u_xlat6.x = u_xlat2.y + u_xlat2.x;
        u_xlat13.xy = u_xlat2.zw / u_xlat6.xx;
        u_xlat0.w = input.TEXCOORD0.x;
        u_xlat16_6 = _MainTex.sample(sampler_MainTex, u_xlat0.wx, level(0.0), int2(1, 0)).y;
        u_xlat6.x = fma((-u_xlat13.x), float(u_xlat16_6), 1.0);
        u_xlat16_2.x = _MainTex.sample(sampler_MainTex, u_xlat0.wz, level(0.0), int2(1, 1)).y;
        u_xlat14.x = fma((-u_xlat13.y), float(u_xlat16_2.x), u_xlat6.x);
        u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
        u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.wx, level(0.0), int2(-2, 0)).y;
        u_xlat0.x = fma((-u_xlat13.x), float(u_xlat16_0), 1.0);
        u_xlat16_6 = _MainTex.sample(sampler_MainTex, u_xlat0.wz, level(0.0), int2(-2, 1)).y;
        u_xlat14.y = fma((-u_xlat13.y), float(u_xlat16_6), u_xlat0.x);
        u_xlat14.y = clamp(u_xlat14.y, 0.0f, 1.0f);
        output.SV_Target0.zw = float2(u_xlat16_1.xy) * u_xlat14.xy;
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _AreaTex [[ texture(1) ]] ,
    texture2d<half, access::sample > _SearchTex [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half2 u_xlat16_1;
    float4 u_xlat2;
    half2 u_xlat16_2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    half2 u_xlat16_3;
    bool4 u_xlatb3;
    float4 u_xlat4;
    half2 u_xlat16_5;
    float3 u_xlat6;
    half u_xlat16_6;
    bool u_xlatb6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    bool3 u_xlatb7;
    float3 u_xlat8;
    float2 u_xlat13;
    half u_xlat16_13;
    bool u_xlatb13;
    float2 u_xlat14;
    bool u_xlatb14;
    half2 u_xlat16_15;
    bool u_xlatb15;
    float u_xlat18;
    half u_xlat16_18;
    bool u_xlatb18;
    float u_xlat19;
    half u_xlat16_19;
    bool u_xlatb19;
    float u_xlat20;
    bool u_xlatb21;
    u_xlat0.xy = float2(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xy);
    u_xlatb6 = 0.0<u_xlat0.y;
    if(u_xlatb6){
        u_xlatb6 = 0.0<u_xlat0.x;
        if(u_xlatb6){
            u_xlat1.xy = FGlobals._MainTex_TexelSize.xy * float2(-1.0, 1.0);
            u_xlat1.z = 1.0;
            u_xlat2.xy = input.TEXCOORD0.xy;
            u_xlat6.x = 0.0;
            u_xlat2.z = -1.0;
            u_xlat3.x = 1.0;
            while(true){
                u_xlatb18 = u_xlat2.z<7.0;
                u_xlatb19 = 0.899999976<u_xlat3.x;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                if(!u_xlatb18){break;}
                u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xyz;
                u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
                u_xlat3.x = dot(u_xlat6.yx, float2(0.5, 0.5));
            }
            u_xlatb6 = 0.899999976<u_xlat6.x;
            u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
            u_xlat1.x = u_xlat6.x + u_xlat2.z;
        } else {
            u_xlat1.x = 0.0;
            u_xlat3.x = 0.0;
        }
        u_xlat6.xy = FGlobals._MainTex_TexelSize.xy * float2(1.0, -1.0);
        u_xlat6.z = 1.0;
        u_xlat2.yz = input.TEXCOORD0.xy;
        u_xlat2.x = float(-1.0);
        u_xlat20 = float(1.0);
        while(true){
            u_xlatb15 = u_xlat2.x<7.0;
            u_xlatb21 = 0.899999976<u_xlat20;
            u_xlatb15 = u_xlatb21 && u_xlatb15;
            if(!u_xlatb15){break;}
            u_xlat2.xyz = u_xlat6.zxy + u_xlat2.xyz;
            u_xlat16_15.xy = _MainTex.sample(sampler_MainTex, u_xlat2.yz, level(0.0)).xy;
            u_xlat20 = dot(u_xlat16_15.xy, half2(0.5, 0.5));
        }
        u_xlat3.y = u_xlat20;
        u_xlat6.x = u_xlat1.x + u_xlat2.x;
        u_xlatb6 = 2.0<u_xlat6.x;
        if(u_xlatb6){
            u_xlat1.y = (-u_xlat1.x) + 0.25;
            u_xlat1.zw = fma(u_xlat2.xx, float2(1.0, -1.0), float2(0.0, -0.25));
            u_xlat2 = fma(u_xlat1.yxzw, FGlobals._MainTex_TexelSize.xyxy, input.TEXCOORD0.xyxy);
            u_xlat6.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0), int2(-1, 0)).xy);
            u_xlat16_7.xz = _MainTex.sample(sampler_MainTex, u_xlat2.zw, level(0.0), int2(1, 0)).xy;
            u_xlat6.z = float(u_xlat16_7.x);
            u_xlat2.xy = fma(u_xlat6.xz, float2(5.0, 5.0), float2(-3.75, -3.75));
            u_xlat6.xz = u_xlat6.xz * abs(u_xlat2.xy);
            u_xlat6.xz = rint(u_xlat6.xz);
            u_xlat8.x = rint(u_xlat6.y);
            u_xlat8.z = rint(float(u_xlat16_7.z));
            u_xlat6.xy = fma(u_xlat8.xz, float2(2.0, 2.0), u_xlat6.xz);
            u_xlatb7.xz = (u_xlat3.xy>=float2(0.899999976, 0.899999976));
            {
                float3 hlslcc_movcTemp = u_xlat6;
                hlslcc_movcTemp.x = (u_xlatb7.x) ? float(0.0) : u_xlat6.x;
                hlslcc_movcTemp.y = (u_xlatb7.z) ? float(0.0) : u_xlat6.y;
                u_xlat6 = hlslcc_movcTemp;
            }
            u_xlat6.xy = fma(u_xlat6.xy, float2(20.0, 20.0), u_xlat1.xz);
            u_xlat6.xy = fma(u_xlat6.xy, float2(0.00625000009, 0.0017857143), float2(0.503125012, 0.000892857148));
            u_xlat6.xy = float2(_AreaTex.sample(sampler_MainTex, u_xlat6.xy, level(0.0)).xy);
        } else {
            u_xlat6.x = float(0.0);
            u_xlat6.y = float(0.0);
        }
        u_xlat18 = fma(FGlobals._MainTex_TexelSize.x, 0.25, input.TEXCOORD0.x);
        u_xlat1.xy = (-FGlobals._MainTex_TexelSize.xy);
        u_xlat1.z = 1.0;
        u_xlat8.x = u_xlat18;
        u_xlat8.y = input.TEXCOORD0.y;
        u_xlat2.x = float(1.0);
        u_xlat8.z = float(-1.0);
        while(true){
            u_xlatb19 = u_xlat8.z<7.0;
            u_xlatb3.x = 0.899999976<u_xlat2.x;
            u_xlatb19 = u_xlatb19 && u_xlatb3.x;
            if(!u_xlatb19){break;}
            u_xlat8.xyz = u_xlat1.xyz + u_xlat8.xyz;
            u_xlat16_3.xy = _MainTex.sample(sampler_MainTex, u_xlat8.xy, level(0.0)).xy;
            u_xlat16_19 = fma(u_xlat16_3.x, half(5.0), half(-3.75));
            u_xlat19 = abs(float(u_xlat16_19)) * float(u_xlat16_3.x);
            u_xlat4.x = rint(u_xlat19);
            u_xlat4.y = rint(float(u_xlat16_3.y));
            u_xlat2.x = dot(u_xlat4.xy, float2(0.5, 0.5));
        }
        u_xlat1.x = u_xlat8.z;
        u_xlat19 = float(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy, level(0.0), int2(1, 0)).x);
        u_xlatb19 = 0.0<u_xlat19;
        if(u_xlatb19){
            u_xlat3.xy = FGlobals._MainTex_TexelSize.xy;
            u_xlat3.z = 1.0;
            u_xlat4.x = u_xlat18;
            u_xlat4.y = input.TEXCOORD0.y;
            u_xlat4.z = -1.0;
            u_xlat2.y = float(1.0);
            u_xlat14.x = float(0.0);
            while(true){
                u_xlatb19 = u_xlat4.z<7.0;
                u_xlatb21 = 0.899999976<u_xlat2.y;
                u_xlatb19 = u_xlatb19 && u_xlatb21;
                if(!u_xlatb19){break;}
                u_xlat4.xyz = u_xlat3.xyz + u_xlat4.xyz;
                u_xlat16_5.xy = _MainTex.sample(sampler_MainTex, u_xlat4.xy, level(0.0)).xy;
                u_xlat16_19 = fma(u_xlat16_5.x, half(5.0), half(-3.75));
                u_xlat19 = abs(float(u_xlat16_19)) * float(u_xlat16_5.x);
                u_xlat14.y = rint(u_xlat19);
                u_xlat14.x = rint(float(u_xlat16_5.y));
                u_xlat2.y = dot(u_xlat14.yx, float2(0.5, 0.5));
            }
            u_xlatb18 = 0.899999976<u_xlat14.x;
            u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
            u_xlat1.z = u_xlat18 + u_xlat4.z;
        } else {
            u_xlat1.z = 0.0;
            u_xlat2.y = 0.0;
        }
        u_xlat18 = u_xlat1.z + u_xlat1.x;
        u_xlatb18 = 2.0<u_xlat18;
        if(u_xlatb18){
            u_xlat1.y = (-u_xlat1.x);
            u_xlat3 = fma(u_xlat1.yyzz, FGlobals._MainTex_TexelSize.xyxy, input.TEXCOORD0.xyxy);
            u_xlat4.x = float(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0), int2(-1, 0)).y);
            u_xlat4.z = float(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0), int2(0, -1)).x);
            u_xlat4.yw = float2(_MainTex.sample(sampler_MainTex, u_xlat3.zw, level(0.0), int2(1, 0)).yx);
            u_xlat7.xz = fma(u_xlat4.xy, float2(2.0, 2.0), u_xlat4.zw);
            u_xlatb2.xy = (u_xlat2.xy>=float2(0.899999976, 0.899999976));
            {
                float3 hlslcc_movcTemp = u_xlat7;
                hlslcc_movcTemp.x = (u_xlatb2.x) ? float(0.0) : u_xlat7.x;
                hlslcc_movcTemp.z = (u_xlatb2.y) ? float(0.0) : u_xlat7.z;
                u_xlat7 = hlslcc_movcTemp;
            }
            u_xlat1.xy = fma(u_xlat7.xz, float2(20.0, 20.0), u_xlat1.xz);
            u_xlat1.xy = fma(u_xlat1.xy, float2(0.00625000009, 0.0017857143), float2(0.503125012, 0.000892857148));
            u_xlat16_1.xy = _AreaTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy;
            u_xlat6.xy = u_xlat6.xy + float2(u_xlat16_1.yx);
        }
        u_xlatb18 = (-u_xlat6.y)==u_xlat6.x;
        if(u_xlatb18){
            u_xlat1.xy = input.TEXCOORD2.xy;
            u_xlat1.z = 1.0;
            u_xlat2.x = 0.0;
            while(true){
                u_xlatb18 = input.TEXCOORD4.x<u_xlat1.x;
                u_xlatb19 = 0.828100026<u_xlat1.z;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                u_xlatb19 = u_xlat2.x==0.0;
                u_xlatb18 = u_xlatb18 && u_xlatb19;
                if(!u_xlatb18){break;}
                u_xlat2.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy);
                u_xlat1.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-2.0, -0.0), u_xlat1.xy);
                u_xlat1.z = u_xlat2.y;
            }
            u_xlat2.yz = u_xlat1.xz;
            u_xlat1.xy = fma(u_xlat2.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
            u_xlat16_18 = _SearchTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).w;
            u_xlat16_18 = fma(u_xlat16_18, half(-2.00787401), half(3.25));
            u_xlat1.x = fma(FGlobals._MainTex_TexelSize.x, float(u_xlat16_18), u_xlat2.y);
            u_xlat1.y = input.TEXCOORD3.y;
            u_xlat2.x = float(_MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).x);
            u_xlat3.xy = input.TEXCOORD2.zw;
            u_xlat3.z = 1.0;
            u_xlat4.x = 0.0;
            while(true){
                u_xlatb18 = u_xlat3.x<input.TEXCOORD4.y;
                u_xlatb14 = 0.828100026<u_xlat3.z;
                u_xlatb18 = u_xlatb18 && u_xlatb14;
                u_xlatb14 = u_xlat4.x==0.0;
                u_xlatb18 = u_xlatb18 && u_xlatb14;
                if(!u_xlatb18){break;}
                u_xlat4.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0)).xy);
                u_xlat3.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(2.0, 0.0), u_xlat3.xy);
                u_xlat3.z = u_xlat4.y;
            }
            u_xlat4.yz = u_xlat3.xz;
            u_xlat14.xy = fma(u_xlat4.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
            u_xlat16_18 = _SearchTex.sample(sampler_MainTex, u_xlat14.xy, level(0.0)).w;
            u_xlat16_18 = fma(u_xlat16_18, half(-2.00787401), half(3.25));
            u_xlat1.z = fma((-FGlobals._MainTex_TexelSize.x), float(u_xlat16_18), u_xlat4.y);
            u_xlat3 = fma(FGlobals._MainTex_TexelSize.zzzz, u_xlat1.zxzx, (-input.TEXCOORD1.xxxx));
            u_xlat3 = rint(u_xlat3);
            u_xlat14.xy = sqrt(abs(u_xlat3.wz));
            u_xlat2.y = float(_MainTex.sample(sampler_MainTex, u_xlat1.zy, level(0.0), int2(1, 0)).x);
            u_xlat2.xy = u_xlat2.xy * float2(4.0, 4.0);
            u_xlat2.xy = rint(u_xlat2.xy);
            u_xlat2.xy = fma(u_xlat2.xy, float2(16.0, 16.0), u_xlat14.xy);
            u_xlat2.xy = fma(u_xlat2.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
            u_xlat16_2.xy = _AreaTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).xy;
            u_xlatb3 = (abs(u_xlat3)>=abs(u_xlat3.wzwz));
            u_xlat3 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 0.75, 0.75), bool4(u_xlatb3));
            u_xlat18 = u_xlat3.y + u_xlat3.x;
            u_xlat14.xy = u_xlat3.zw / float2(u_xlat18);
            u_xlat1.w = input.TEXCOORD0.y;
            u_xlat16_18 = _MainTex.sample(sampler_MainTex, u_xlat1.xw, level(0.0), int2(0, 1)).x;
            u_xlat18 = fma((-u_xlat14.x), float(u_xlat16_18), 1.0);
            u_xlat16_7.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0), int2(1, 1)).x;
            u_xlat3.x = fma((-u_xlat14.y), float(u_xlat16_7.x), u_xlat18);
            u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
            u_xlat16_18 = _MainTex.sample(sampler_MainTex, u_xlat1.xw, level(0.0), int2(0, -2)).x;
            u_xlat18 = fma((-u_xlat14.x), float(u_xlat16_18), 1.0);
            u_xlat16_1.x = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0), int2(1, -2)).x;
            u_xlat3.y = fma((-u_xlat14.y), float(u_xlat16_1.x), u_xlat18);
            u_xlat3.y = clamp(u_xlat3.y, 0.0f, 1.0f);
            output.SV_Target0.xy = float2(u_xlat16_2.xy) * u_xlat3.xy;
        } else {
            output.SV_Target0.xy = u_xlat6.xy;
            u_xlat0.x = 0.0;
        }
    } else {
        output.SV_Target0.xy = float2(0.0, 0.0);
    }
    u_xlatb0 = 0.0<u_xlat0.x;
    if(u_xlatb0){
        u_xlat0.xy = input.TEXCOORD3.xy;
        u_xlat0.z = 1.0;
        u_xlat1.x = 0.0;
        while(true){
            u_xlatb18 = input.TEXCOORD4.z<u_xlat0.y;
            u_xlatb19 = 0.828100026<u_xlat0.z;
            u_xlatb18 = u_xlatb18 && u_xlatb19;
            u_xlatb19 = u_xlat1.x==0.0;
            u_xlatb18 = u_xlatb18 && u_xlatb19;
            if(!u_xlatb18){break;}
            u_xlat1.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).yx);
            u_xlat0.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(-0.0, -2.0), u_xlat0.xy);
            u_xlat0.z = u_xlat1.y;
        }
        u_xlat1.yz = u_xlat0.yz;
        u_xlat0.xy = fma(u_xlat1.xz, float2(0.5, -2.0), float2(0.0078125, 2.03125));
        u_xlat16_0 = _SearchTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).w;
        u_xlat16_0 = fma(u_xlat16_0, half(-2.00787401), half(3.25));
        u_xlat0.x = fma(FGlobals._MainTex_TexelSize.y, float(u_xlat16_0), u_xlat1.y);
        u_xlat0.y = input.TEXCOORD2.x;
        u_xlat1.x = float(_MainTex.sample(sampler_MainTex, u_xlat0.yx, level(0.0)).y);
        u_xlat2.xy = input.TEXCOORD3.zw;
        u_xlat2.z = 1.0;
        u_xlat3.x = 0.0;
        while(true){
            u_xlatb13 = u_xlat2.y<input.TEXCOORD4.w;
            u_xlatb19 = 0.828100026<u_xlat2.z;
            u_xlatb13 = u_xlatb19 && u_xlatb13;
            u_xlatb19 = u_xlat3.x==0.0;
            u_xlatb13 = u_xlatb19 && u_xlatb13;
            if(!u_xlatb13){break;}
            u_xlat3.xy = float2(_MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0)).yx);
            u_xlat2.xy = fma(FGlobals._MainTex_TexelSize.xy, float2(0.0, 2.0), u_xlat2.xy);
            u_xlat2.z = u_xlat3.y;
        }
        u_xlat3.yz = u_xlat2.yz;
        u_xlat13.xy = fma(u_xlat3.xz, float2(0.5, -2.0), float2(0.5234375, 2.03125));
        u_xlat16_13 = _SearchTex.sample(sampler_MainTex, u_xlat13.xy, level(0.0)).w;
        u_xlat16_13 = fma(u_xlat16_13, half(-2.00787401), half(3.25));
        u_xlat0.z = fma((-FGlobals._MainTex_TexelSize.y), float(u_xlat16_13), u_xlat3.y);
        u_xlat2 = fma(FGlobals._MainTex_TexelSize.wwww, u_xlat0.zxzx, (-input.TEXCOORD1.yyyy));
        u_xlat2 = rint(u_xlat2);
        u_xlat13.xy = sqrt(abs(u_xlat2.wz));
        u_xlat1.y = float(_MainTex.sample(sampler_MainTex, u_xlat0.yz, level(0.0), int2(0, 1)).y);
        u_xlat1.xy = u_xlat1.xy * float2(4.0, 4.0);
        u_xlat1.xy = rint(u_xlat1.xy);
        u_xlat1.xy = fma(u_xlat1.xy, float2(16.0, 16.0), u_xlat13.xy);
        u_xlat1.xy = fma(u_xlat1.xy, float2(0.00625000009, 0.0017857143), float2(0.00312500005, 0.000892857148));
        u_xlat16_1.xy = _AreaTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0)).xy;
        u_xlatb2 = (abs(u_xlat2)>=abs(u_xlat2.wzwz));
        u_xlat2 = select(float4(0.0, 0.0, 0.0, 0.0), float4(1.0, 1.0, 0.75, 0.75), bool4(u_xlatb2));
        u_xlat6.x = u_xlat2.y + u_xlat2.x;
        u_xlat13.xy = u_xlat2.zw / u_xlat6.xx;
        u_xlat0.w = input.TEXCOORD0.x;
        u_xlat16_6 = _MainTex.sample(sampler_MainTex, u_xlat0.wx, level(0.0), int2(1, 0)).y;
        u_xlat6.x = fma((-u_xlat13.x), float(u_xlat16_6), 1.0);
        u_xlat16_2.x = _MainTex.sample(sampler_MainTex, u_xlat0.wz, level(0.0), int2(1, 1)).y;
        u_xlat14.x = fma((-u_xlat13.y), float(u_xlat16_2.x), u_xlat6.x);
        u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
        u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.wx, level(0.0), int2(-2, 0)).y;
        u_xlat0.x = fma((-u_xlat13.x), float(u_xlat16_0), 1.0);
        u_xlat16_6 = _MainTex.sample(sampler_MainTex, u_xlat0.wz, level(0.0), int2(-2, 1)).y;
        u_xlat14.y = fma((-u_xlat13.y), float(u_xlat16_6), u_xlat0.x);
        u_xlat14.y = clamp(u_xlat14.y, 0.0f, 1.0f);
        output.SV_Target0.zw = float2(u_xlat16_1.xy) * u_xlat14.xy;
    } else {
        output.SV_Target0.zw = float2(0.0, 0.0);
    }
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
  GpuProgramID 450130
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
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
    output.TEXCOORD0.xy = u_xlat0.xy;
    output.TEXCOORD1 = fma(VGlobals._MainTex_TexelSize.xyxy, float4(1.0, 0.0, 0.0, 1.0), u_xlat0.xyxy);
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BlendTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat6;
    u_xlat0.x = float(_BlendTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w);
    u_xlat0.y = float(_BlendTex.sample(sampler_MainTex, input.TEXCOORD1.zw).y);
    u_xlat0.zw = float2(_BlendTex.sample(sampler_MainTex, input.TEXCOORD0.xy).zx);
    u_xlat1.x = dot(u_xlat0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    if(u_xlatb1){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy, level(0.0)));
    } else {
        u_xlat1.xy = max(u_xlat0.zw, u_xlat0.xy);
        u_xlatb1 = u_xlat1.y<u_xlat1.x;
        u_xlat2.xz = select(float2(0.0, 0.0), u_xlat0.xz, bool2(bool2(u_xlatb1)));
        u_xlat2.yw = (bool(u_xlatb1)) ? float2(0.0, 0.0) : u_xlat0.yw;
        u_xlat0.x = (u_xlatb1) ? u_xlat0.x : u_xlat0.y;
        u_xlat0.y = (u_xlatb1) ? u_xlat0.z : u_xlat0.w;
        u_xlat6 = dot(u_xlat0.xy, float2(1.0, 1.0));
        u_xlat0.xy = u_xlat0.xy / float2(u_xlat6);
        u_xlat1 = FGlobals._MainTex_TexelSize.xyxy * float4(1.0, 1.0, -1.0, -1.0);
        u_xlat1 = fma(u_xlat2, u_xlat1, input.TEXCOORD0.xyxy);
        u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0));
        u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0));
        u_xlat1 = u_xlat0.yyyy * float4(u_xlat16_1);
        output.SV_Target0 = fma(u_xlat0.xxxx, float4(u_xlat16_2), u_xlat1);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BlendTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat6;
    u_xlat0.x = float(_BlendTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w);
    u_xlat0.y = float(_BlendTex.sample(sampler_MainTex, input.TEXCOORD1.zw).y);
    u_xlat0.zw = float2(_BlendTex.sample(sampler_MainTex, input.TEXCOORD0.xy).zx);
    u_xlat1.x = dot(u_xlat0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    if(u_xlatb1){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy, level(0.0)));
    } else {
        u_xlat1.xy = max(u_xlat0.zw, u_xlat0.xy);
        u_xlatb1 = u_xlat1.y<u_xlat1.x;
        u_xlat2.xz = select(float2(0.0, 0.0), u_xlat0.xz, bool2(bool2(u_xlatb1)));
        u_xlat2.yw = (bool(u_xlatb1)) ? float2(0.0, 0.0) : u_xlat0.yw;
        u_xlat0.x = (u_xlatb1) ? u_xlat0.x : u_xlat0.y;
        u_xlat0.y = (u_xlatb1) ? u_xlat0.z : u_xlat0.w;
        u_xlat6 = dot(u_xlat0.xy, float2(1.0, 1.0));
        u_xlat0.xy = u_xlat0.xy / float2(u_xlat6);
        u_xlat1 = FGlobals._MainTex_TexelSize.xyxy * float4(1.0, 1.0, -1.0, -1.0);
        u_xlat1 = fma(u_xlat2, u_xlat1, input.TEXCOORD0.xyxy);
        u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0));
        u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0));
        u_xlat1 = u_xlat0.yyyy * float4(u_xlat16_1);
        output.SV_Target0 = fma(u_xlat0.xxxx, float4(u_xlat16_2), u_xlat1);
    }
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
    float4 _MainTex_TexelSize;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _BlendTex [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    bool u_xlatb1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float u_xlat6;
    u_xlat0.x = float(_BlendTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w);
    u_xlat0.y = float(_BlendTex.sample(sampler_MainTex, input.TEXCOORD1.zw).y);
    u_xlat0.zw = float2(_BlendTex.sample(sampler_MainTex, input.TEXCOORD0.xy).zx);
    u_xlat1.x = dot(u_xlat0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
    if(u_xlatb1){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy, level(0.0)));
    } else {
        u_xlat1.xy = max(u_xlat0.zw, u_xlat0.xy);
        u_xlatb1 = u_xlat1.y<u_xlat1.x;
        u_xlat2.xz = select(float2(0.0, 0.0), u_xlat0.xz, bool2(bool2(u_xlatb1)));
        u_xlat2.yw = (bool(u_xlatb1)) ? float2(0.0, 0.0) : u_xlat0.yw;
        u_xlat0.x = (u_xlatb1) ? u_xlat0.x : u_xlat0.y;
        u_xlat0.y = (u_xlatb1) ? u_xlat0.z : u_xlat0.w;
        u_xlat6 = dot(u_xlat0.xy, float2(1.0, 1.0));
        u_xlat0.xy = u_xlat0.xy / float2(u_xlat6);
        u_xlat1 = FGlobals._MainTex_TexelSize.xyxy * float4(1.0, 1.0, -1.0, -1.0);
        u_xlat1 = fma(u_xlat2, u_xlat1, input.TEXCOORD0.xyxy);
        u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0));
        u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0));
        u_xlat1 = u_xlat0.yyyy * float4(u_xlat16_1);
        output.SV_Target0 = fma(u_xlat0.xxxx, float4(u_xlat16_2), u_xlat1);
    }
    return output;
}
"
}
}
}
}
}
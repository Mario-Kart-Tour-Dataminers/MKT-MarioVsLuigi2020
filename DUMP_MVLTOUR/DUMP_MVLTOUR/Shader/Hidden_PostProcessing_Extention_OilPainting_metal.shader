//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Extention/OilPainting" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 22138
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
    float4 _MainTex_TexelSize;
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
    half u_xlat16_0;
    float3 u_xlat1;
    int u_xlati1;
    float2 u_xlat2;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    bool u_xlatb5;
    uint u_xlatu6;
    int u_xlati8;
    float u_xlat9;
    int u_xlati9;
    float u_xlat10;
    int u_xlati12;
    float4 TempArray0[7];
    float4 TempArray1[7];
    TempArray0[0].x = 0.0;
    TempArray1[0].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[1].x = 0.0;
    TempArray1[1].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[2].x = 0.0;
    TempArray1[2].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[3].x = 0.0;
    TempArray1[3].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[4].x = 0.0;
    TempArray1[4].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[5].x = 0.0;
    TempArray1[5].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[6].x = 0.0;
    TempArray1[6].xyz = float3(0.0, 0.0, 0.0);
    u_xlat0.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(2.0, 2.0), input.TEXCOORD1.xy);
    u_xlati8 = int(0x0);
    u_xlati12 = int(0x0);
    u_xlati1 = 0x0;
    while(true){
        u_xlatb5 = u_xlati1>=0x19;
        if(u_xlatb5){break;}
        u_xlat5.x = float(u_xlati1);
        u_xlat5.x = u_xlat5.x * 0.200000003;
        u_xlat5.x = floor(u_xlat5.x);
        u_xlati9 = int(u_xlat5.x);
        u_xlati9 = u_xlati9 * int(0xfffffffbu) + u_xlati1;
        u_xlat5.y = float(u_xlati9);
        u_xlat2.xy = u_xlat5.yx * FGlobals._MainTex_TexelSize.xy;
        u_xlat5.xy = u_xlat0.xy + u_xlat2.xy;
        u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, u_xlat5.xy).xyz;
        u_xlat16_2 = u_xlat16_5.y + u_xlat16_5.x;
        u_xlat16_2 = u_xlat16_5.z + u_xlat16_2;
        u_xlat2.x = float(u_xlat16_2) * 2.33100009;
        u_xlat2.x = floor(u_xlat2.x);
        u_xlatu6 = uint(u_xlat2.x);
        u_xlat10 = TempArray0[int(u_xlatu6)].x;
        u_xlat10 = as_type<float>(as_type<int>(u_xlat10) + 0x1);
        TempArray0[int(u_xlatu6)].x = u_xlat10;
        u_xlat3.xyz = TempArray1[int(u_xlatu6)].xyz;
        u_xlat5.xyz = float3(u_xlat16_5.xyz) + u_xlat3.xyz;
        TempArray1[int(u_xlatu6)].xyz = u_xlat5.xyz;
        u_xlatb5 = u_xlati8<as_type<int>(u_xlat10);
        u_xlat9 = float(u_xlati12);
        u_xlat5.x = (u_xlatb5) ? u_xlat2.x : u_xlat9;
        u_xlati12 = int(u_xlat5.x);
        u_xlati8 = max(u_xlati8, as_type<int>(u_xlat10));
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat1.xyz = TempArray1[u_xlati12].xyz;
    u_xlat4 = float(u_xlati8);
    output.SV_Target0.xyz = u_xlat1.xyz / float3(u_xlat4);
    output.SV_Target0.w = float(u_xlat16_0);
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
    half u_xlat16_0;
    float3 u_xlat1;
    int u_xlati1;
    float2 u_xlat2;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    bool u_xlatb5;
    uint u_xlatu6;
    int u_xlati8;
    float u_xlat9;
    int u_xlati9;
    float u_xlat10;
    int u_xlati12;
    float4 TempArray0[7];
    float4 TempArray1[7];
    TempArray0[0].x = 0.0;
    TempArray1[0].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[1].x = 0.0;
    TempArray1[1].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[2].x = 0.0;
    TempArray1[2].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[3].x = 0.0;
    TempArray1[3].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[4].x = 0.0;
    TempArray1[4].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[5].x = 0.0;
    TempArray1[5].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[6].x = 0.0;
    TempArray1[6].xyz = float3(0.0, 0.0, 0.0);
    u_xlat0.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(2.0, 2.0), input.TEXCOORD1.xy);
    u_xlati8 = int(0x0);
    u_xlati12 = int(0x0);
    u_xlati1 = 0x0;
    while(true){
        u_xlatb5 = u_xlati1>=0x19;
        if(u_xlatb5){break;}
        u_xlat5.x = float(u_xlati1);
        u_xlat5.x = u_xlat5.x * 0.200000003;
        u_xlat5.x = floor(u_xlat5.x);
        u_xlati9 = int(u_xlat5.x);
        u_xlati9 = u_xlati9 * int(0xfffffffbu) + u_xlati1;
        u_xlat5.y = float(u_xlati9);
        u_xlat2.xy = u_xlat5.yx * FGlobals._MainTex_TexelSize.xy;
        u_xlat5.xy = u_xlat0.xy + u_xlat2.xy;
        u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, u_xlat5.xy).xyz;
        u_xlat16_2 = u_xlat16_5.y + u_xlat16_5.x;
        u_xlat16_2 = u_xlat16_5.z + u_xlat16_2;
        u_xlat2.x = float(u_xlat16_2) * 2.33100009;
        u_xlat2.x = floor(u_xlat2.x);
        u_xlatu6 = uint(u_xlat2.x);
        u_xlat10 = TempArray0[int(u_xlatu6)].x;
        u_xlat10 = as_type<float>(as_type<int>(u_xlat10) + 0x1);
        TempArray0[int(u_xlatu6)].x = u_xlat10;
        u_xlat3.xyz = TempArray1[int(u_xlatu6)].xyz;
        u_xlat5.xyz = float3(u_xlat16_5.xyz) + u_xlat3.xyz;
        TempArray1[int(u_xlatu6)].xyz = u_xlat5.xyz;
        u_xlatb5 = u_xlati8<as_type<int>(u_xlat10);
        u_xlat9 = float(u_xlati12);
        u_xlat5.x = (u_xlatb5) ? u_xlat2.x : u_xlat9;
        u_xlati12 = int(u_xlat5.x);
        u_xlati8 = max(u_xlati8, as_type<int>(u_xlat10));
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat1.xyz = TempArray1[u_xlati12].xyz;
    u_xlat4 = float(u_xlati8);
    output.SV_Target0.xyz = u_xlat1.xyz / float3(u_xlat4);
    output.SV_Target0.w = float(u_xlat16_0);
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
    half u_xlat16_0;
    float3 u_xlat1;
    int u_xlati1;
    float2 u_xlat2;
    half u_xlat16_2;
    float3 u_xlat3;
    float u_xlat4;
    float3 u_xlat5;
    half3 u_xlat16_5;
    bool u_xlatb5;
    uint u_xlatu6;
    int u_xlati8;
    float u_xlat9;
    int u_xlati9;
    float u_xlat10;
    int u_xlati12;
    float4 TempArray0[7];
    float4 TempArray1[7];
    TempArray0[0].x = 0.0;
    TempArray1[0].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[1].x = 0.0;
    TempArray1[1].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[2].x = 0.0;
    TempArray1[2].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[3].x = 0.0;
    TempArray1[3].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[4].x = 0.0;
    TempArray1[4].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[5].x = 0.0;
    TempArray1[5].xyz = float3(0.0, 0.0, 0.0);
    TempArray0[6].x = 0.0;
    TempArray1[6].xyz = float3(0.0, 0.0, 0.0);
    u_xlat0.xy = fma((-FGlobals._MainTex_TexelSize.xy), float2(2.0, 2.0), input.TEXCOORD1.xy);
    u_xlati8 = int(0x0);
    u_xlati12 = int(0x0);
    u_xlati1 = 0x0;
    while(true){
        u_xlatb5 = u_xlati1>=0x19;
        if(u_xlatb5){break;}
        u_xlat5.x = float(u_xlati1);
        u_xlat5.x = u_xlat5.x * 0.200000003;
        u_xlat5.x = floor(u_xlat5.x);
        u_xlati9 = int(u_xlat5.x);
        u_xlati9 = u_xlati9 * int(0xfffffffbu) + u_xlati1;
        u_xlat5.y = float(u_xlati9);
        u_xlat2.xy = u_xlat5.yx * FGlobals._MainTex_TexelSize.xy;
        u_xlat5.xy = u_xlat0.xy + u_xlat2.xy;
        u_xlat16_5.xyz = _MainTex.sample(sampler_MainTex, u_xlat5.xy).xyz;
        u_xlat16_2 = u_xlat16_5.y + u_xlat16_5.x;
        u_xlat16_2 = u_xlat16_5.z + u_xlat16_2;
        u_xlat2.x = float(u_xlat16_2) * 2.33100009;
        u_xlat2.x = floor(u_xlat2.x);
        u_xlatu6 = uint(u_xlat2.x);
        u_xlat10 = TempArray0[int(u_xlatu6)].x;
        u_xlat10 = as_type<float>(as_type<int>(u_xlat10) + 0x1);
        TempArray0[int(u_xlatu6)].x = u_xlat10;
        u_xlat3.xyz = TempArray1[int(u_xlatu6)].xyz;
        u_xlat5.xyz = float3(u_xlat16_5.xyz) + u_xlat3.xyz;
        TempArray1[int(u_xlatu6)].xyz = u_xlat5.xyz;
        u_xlatb5 = u_xlati8<as_type<int>(u_xlat10);
        u_xlat9 = float(u_xlati12);
        u_xlat5.x = (u_xlatb5) ? u_xlat2.x : u_xlat9;
        u_xlati12 = int(u_xlat5.x);
        u_xlati8 = max(u_xlati8, as_type<int>(u_xlat10));
        u_xlati1 = u_xlati1 + 0x1;
    }
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy).w;
    u_xlat1.xyz = TempArray1[u_xlati12].xyz;
    u_xlat4 = float(u_xlati8);
    output.SV_Target0.xyz = u_xlat1.xyz / float3(u_xlat4);
    output.SV_Target0.w = float(u_xlat16_0);
    return output;
}
"
}
}
}
}
}